Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E4181F858
	for <e@80x24.org>; Wed,  3 Aug 2016 17:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbcHCR67 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:58:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:53976 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756581AbcHCR66 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 13:58:58 -0400
Received: (qmail 9592 invoked by uid 102); 3 Aug 2016 17:58:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 13:58:57 -0400
Received: (qmail 3584 invoked by uid 107); 3 Aug 2016 17:59:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 13:59:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 13:58:54 -0400
Date:	Wed, 3 Aug 2016 13:58:54 -0400
From:	Jeff King <peff@peff.net>
To:	Santiago Torres <santiago@nyu.edu>
Cc:	Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
Message-ID: <20160803175854.vys3f7tpfhzeqzsu@sigill.intra.peff.net>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
 <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
 <20160803171124.yzm5xs67empuka7o@sigill.intra.peff.net>
 <20160803174459.knlmyx6txmggixzi@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803174459.knlmyx6txmggixzi@LykOS.localdomain>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 01:45:00PM -0400, Santiago Torres wrote:

> >   - if there is a chain of signatures, the attacker must follow the
> >     chain, but they can always withhold links from the end. So imagine a
> >     repository has held a sequence of signed states (A, B, C), that B
> >     has a bug, C has the fix, and I am at A. An attacker can serve me B
> >     and I cannot know without out-of-band information that it is not the
> >     correct tip (because until C was created, it _was_ the correct tip).
> 
> I think we address this by using the "nonce bag". We basically force the
> server to fork the user's history if it withholds changes from on group
> to the other. By doing so, the user's nonce can't be added to any other
> history. I don't think this is noticeable from start though.

OK, I think that is in the details I glossed over. ;)

If you are effectively preventing the server from showing different
states to different people, then at least that lets the "main"
developers notice problems (because at least one of them already saw "C"
because they wrote it).

> > I think git in general is quite weak in automatic tooling for
> > verifications. There are room for signatures in the data format and
> > tools for checking that the bytes haven't been touched, but there's
> > almost nothing to tell you that signatures make any sense, tools for
> > handling trust, etc.
> 
> Yes, from our previous interactions, it seems that git's philosophy
> focuses on providing the right information to users/tools and let those
> tools make the call of whether something is fishy. I don't think this is
> necessarily bad.

I think it's half philosophy (git strives for flexibility, and so aims
to provide low-level tooling that you can build on), and half that
nobody has bothered to implement a sane set of automatic checks.

There's definitely some low-hanging fruit there. I think we've discussed
things like checking that verifying refs/tags/v1.0.0 actually gets you a
tag that says "v1.0.0" in it. But I'd love to see a framework either
built into or on top of git that would implement sensible policies, and
make out-of-the-box verification easy to do. Then people might actually
use it. :)

> > I think your solution also had some mechanisms for adding trusted keys
> > as part of the hash chain. I'm not convinced that's something that
> > should be part of git's solution in particular, and not an out-of-band
> > thing handled as part of the PKI. Because it's really a group key
> > management problem, and applies to anything you might sign.
> 
> I see. What about, for example, having an official "overlay" on git for
> signing and verification of a repository? (e.g., similar to what
> monotone does). I see that other VCS's have a plugin mechanism, and they
> host official plugins.

In general, if something is more general than git, I'd like to see a
general tool address it, and then add support to git to make use of the
tool.

For group key management, I specifically was wondering if you could do
something like:

  - start with some seed GPG keys for the project

  - existing keys can sign or revoke certificates to add or remove other
    keys to/from the project; you could even require a threshold of
    signatures, etc.

  - those keys could be used for signing git pushes, but also for other
    things, like signing tarballs, used as encryption keys for sending
    for-developers-eyes-only security reports, etc

    You'd want a tool that asks not just "is this signed" but "is this
    signed _by a key that is valid for this project_".

And then git support would just consist of feeding signatures to
"gpg-group --project=..." instead of "gpg". Management of the group
would be out-of-band from git, which is in some ways good and in some
ways bad.

I think a naive implementation would be pretty easy, but I've glossed
over all of the chaining properties we've discussed. So whatever
mechanism you use to receive updates to the key-group would have all the
same problems (e.g., withholding revocations of compromised keys). It's
still orders of magnitude ahead of what's currently happening
day-to-day. :)

-Peff
