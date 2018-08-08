Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48CBA1F46C
	for <e@80x24.org>; Wed,  8 Aug 2018 23:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbeHIBgf (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 21:36:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:47754 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727530AbeHIBgf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 21:36:35 -0400
Received: (qmail 18458 invoked by uid 109); 8 Aug 2018 23:14:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Aug 2018 23:14:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4359 invoked by uid 111); 8 Aug 2018 23:14:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 Aug 2018 19:14:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2018 19:14:41 -0400
Date:   Wed, 8 Aug 2018 19:14:41 -0400
From:   Jeff King <peff@peff.net>
To:     Tacitus Aedifex <aedifex@SDF.ORG>
Cc:     git@vger.kernel.org, henning.schild@siemens.com,
        mastahyeti@gmail.com
Subject: Re: abstracting commit signing/verify to support other signing
 schemes
Message-ID: <20180808231440.GB21882@sigill.intra.peff.net>
References: <20180803213834.GB7619@SDF.ORG>
 <20180803220746.GA5404@sigill.intra.peff.net>
 <20180806202424.GA2315@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180806202424.GA2315@SDF.ORG>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06, 2018 at 08:24:25PM +0000, Tacitus Aedifex wrote:

> the older patch set suggested the idea of using PEM strings to match up the
> signature payload with a certain signing tool.  i can't tell if they mean
> the 'pre-ecapsulation boundary' (e.g. '-----BEGIN FOO-----') or if they mean
> the encapsulated headers; both as defined in RFC 1421 [0].

It was the pre-encapsulation boundary (we didn't use that word, but it
was definitely the "-----BEGIN" line ;) ).

And that was the sticking point: there was an open question of what
support for something like signify would look like exactly, and what the
matching rules would need to be. My thought was to allow multiple
matching types, and "PEM type" (by which I meant that pre-encapsulation
boundary) would be the first such type.

But that got punted on, since we didn't have a real-world example to
look at, and we really only cared about gpgsm in the near-term anyway.
And that obviously does PEM. So the gpg.* tools all require PEM, but if
we add a generic signingtool config, it doesn't have to.

> the newer patch set looks specifically at the pre-encapsulation boundary to
> switch behaviors. that works assuming that the signing tools all understand
> PEM. in the case of signify, it doesn't, so the driver code in git will have
> to translate to/from PEM.

Right. It might be fine to encapsulate it, though I prefer not inventing
new micro-formats if we can avoid it.

There actually _is_ an interesting micro-format already in Git, which is
that commit signatures (not tags) are held in the "gpgsig" header of the
commit. Which would be an awkward name for storing a non-gpg tool. We
may want to live with that for historical reasons, or we could switch to
a more generic name.

The actual PEM detection is for tags, where the signature is in the tag
body itself.

In either case, we could use some object header to indicate the
signature type (on the other hand, it could be possible to have multiple
signatures of different types).

> i suggest that we switch to a standard format for all signatures that is
> similar to the commit message format with colon ':' separated fields
> followed by a payload.  the colon separated fields would specify the signing
> tool used to generate the signature and the tool specific data followed by
> the signature blob like so:
> 
>  signing-tool: gpg
>  gpg-keyid: 0123456789ABCDEF
>  -----BEGIN PGP SIGNATURE-----
>  <base64 encoded signature>
>  -----END PGP SIGNATURE-----
> 
> by adopting this format, git will be fully abstracted from the underlying
> signing tool and the user can specify multiple signing tools in their config
> and git will be able to map the signature to the tool when verifying (e.g.
> git log --show-signature).

One problem with that for the signatures in tag bodies is that
"signing-tool: gpg" looks like something a human might right (as opposed
to the PEM boundary, which is a bit more obvious).

If we're going to make up a micro-format, it may be simpler to just have
something PEM-like in the first place, and shove signify into that.

> > So _if_ we knew what it would take to support signify, we could
> > potentially adjust what's going into 2.19 in order to skip straight to
> > the more generic interface. But on the OTOH, it may not be worth
> > rushing, and there is already a vague plan of how the gpg.<tool>.*
> > config would interact with a more generic config.
> 
> there's no rush, but i would prefer that the newer patch set get changed to
> use the more generic 'signingtool.<tool>.*' instead of 'gpg.<tool>.*'. if
> you all agree, i'll follow up with a patch to change that part of what is
> going into 2.19.

I'm on the fence for that myself. The best way to get people to comment
would be to make a patch, and cc people involved in the earlier
discussions.

-Peff
