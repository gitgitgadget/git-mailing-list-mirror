Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370061F461
	for <e@80x24.org>; Wed, 21 Aug 2019 23:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfHUXAh (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 19:00:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:51786 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730187AbfHUXAh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 19:00:37 -0400
Received: (qmail 24525 invoked by uid 109); 21 Aug 2019 23:00:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Aug 2019 23:00:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16107 invoked by uid 111); 21 Aug 2019 23:01:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Aug 2019 19:01:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Aug 2019 19:00:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Fully peel tags via for-each-ref?
Message-ID: <20190821230035.GA26107@sigill.intra.peff.net>
References: <CAGyf7-GBx3FSCQTipmkNBtnwMANg5A0FXiiPc2az0NiRLRT+xg@mail.gmail.com>
 <xmqq8srowfkv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8srowfkv.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 10:50:24PM -0700, Junio C Hamano wrote:

> Bryan Turner <bturner@atlassian.com> writes:
> 
> > Is there any way, with "git for-each-ref", to output the "fully"
> > peeled SHA of a tag's ultimate target, regardless of how many layers
> > must be traversed?
> 
> I do not think I wrote it to allow different degree of peeling, not
> because I wanted to explicitly forbid a use case for tags that tag
> another tag, but simply because I didn't think of anybody using it
> and didn't see need to support such tags.
> 
> If %(*<stuff>) does not peel fully (I do not recall what I did
> offhand), because all other things in Git (like $X~0, $X^{tree},
> etc.) fully peel the outer object until they get to what they want,
> it may even be OK to declare it a bug and "fix" the notation to
> fully peel tags.  I dunno.

Yeah, my first thought on reading Bryan's email was that this is so
inconsistent with the rest of Git as to be considered a bug.

There's this gem in ref-filter.c, which blames back to your 9f613ddd21
(Add git-for-each-ref: helper for language bindings, 2006-09-15):

          /*
           * NEEDSWORK: This derefs tag only once, which
           * is good to deal with chains of trust, but
           * is not consistent with what deref_tag() does
           * which peels the onion to the core.
           */
          return get_object(ref, 1, &obj, &oi_deref, err);

Which isn't to say it isn't useful to be able to do a single-layer peel,
but I can't think of another part of the system which does so (unless
you've asked to peel to a specific type, of course). I'm thinking
especially of the way upload-pack does its advertisement, with two
interesting implications:

  1. We store full peels in the packed-refs file[1], so we can show them
     in the advertisement without having to access the object. Doing:

       git upload-pack . </dev/null >/dev/null

     is much cheaper than:

       git for-each-ref \
         --format='%(objectname) %(refname)%0a%(*objectname) %(refname)^{}' \
	 >/dev/null

  2. When we switched for_each_alternate_ref to using peeled values, we
     stopped advertising peeled values for .push haves entirely. There's
     some discussion in a10a17877b (for_each_alternate_ref: replace
     transport code with for-each-ref, 2017-02-08), but if we _did_ want
     to show them, we'd probably want the fully peeled value to match
     the rest of the advertisement.

Given that it's not how the rest of Git works, I'd be surprised for
anybody to be relying on the shallow-peeling behavior of for-each-ref.
But if we did want to retain it, it might be worth adding a separate
syntax for a full peel. "%(**objectname)" or something?

-Peff

[1] Storing peeled values in the packed-refs file is itself a pretty
    horrible hack. It's really a property of the object itself, and
    we're just piggy-backing on the ref storage to make this cached
    metadata easily accessible. It would be more appropriate in an
    object metadata storage format similar to the commit-graph file.
    And then of course we could store both full or partial peels,
    depending on the format.
