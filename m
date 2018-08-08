Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5011F405
	for <e@80x24.org>; Wed,  8 Aug 2018 23:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeHIB0t (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 21:26:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:47712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727530AbeHIB0t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 21:26:49 -0400
Received: (qmail 18076 invoked by uid 109); 8 Aug 2018 23:04:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Aug 2018 23:04:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4261 invoked by uid 111); 8 Aug 2018 23:05:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 Aug 2018 19:05:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2018 19:04:56 -0400
Date:   Wed, 8 Aug 2018 19:04:56 -0400
From:   Jeff King <peff@peff.net>
To:     Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>
Cc:     Santiago Torres <santiago@nyu.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180808230456.GA21882@sigill.intra.peff.net>
References: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
 <20180801001942.GC45452@genre.crustytoothpaste.net>
 <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
 <20180803133630.32oxubwttealvhxk@work-pc>
 <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
 <20180803160634.GA19944@sigill.intra.peff.net>
 <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 04, 2018 at 10:43:46AM +0200, Karel Kočí wrote:

> > I think the only sensible thing is to err on the conservative side, and
> > return non-zero if we saw _any_ invalid signature.
> > 
> > I will note, though, that just checking the exit code of `verify-tag`
> > isn't really that thorough. It shows that there was _a_ signature, but
> > we don't know:
> > 
> >   - if it was an identity the user would expect to be signing tags
> > 
> >   - if it even matches the refname we used to find the tag
> > 
> > So I'd argue that any real verification needs to either have a human in
> > the loop, or implement a custom policy based on reading the full output.
> > 
> > I know we (and you specifically Santiago) talked about this a while ago,
> > and we ended up providing ways to get more information out of
> > verify-tag, so that a tool could sit on top of that and implement more
> > project-specific policy. I don't know offhand of any reusable tools that
> > do so, though.
> 
> I think that it would be even legit to exit on first tag verification failure. If
> someone wants to really verify all tags then it can be done with simple for loop.
> git that way does not have to solve problem of error combination.

Yeah, I'd be fine with that.

> >   - if it was an identity the user would expect to be signing tags
> That can be done just by using trust levels.

I may be showing my PGP cluelessness here, but I thought trust levels
were about saying "to what degree do I think this uid matches this key".
Or are you proposing feeding gpg a fixed trust-db pre-seeded with keys
that are allowed to sign?

I suppose that would work, but:

  - is it much easier than just verifying the uid from gpg output
    against a trusted list?

  - it mixes authentication and authorization. I.e., you lose the
    ability to know about a case of "yes, this signature is valid by
    this person, but they are not an authorized tagger".

Definitely for some use cases that is fine (and easier still is to just
not even have disallowed keys in your keyring). But I don't think it's a
general solution.

> >   - if it even matches the refname we used to find the tag
> Can you explain this more? You mean that string (such as v1.1) used to lookup tag
> object is not verified as part of that object?

Yes. The signature is just over the tag object contents itself. That
object does contain a "tag" field, but it may or may not be the tag
you're expecting. Git _could_ confirm that when you looked up a tag via
refs/tags/v1.1 that the tag object we found has "tag v1.1" in it. But
that's not always possible (you might feed Git a resolved name, for
example).

> OK I thing that it was enough of abstract concepts from me. Let me explain you
> what am I trying to achieve. I am implementing feeds (in other words git
> repositories with packages) and package sources verification for OpenWRT. We
> (project Turris by CZ.NIC) are signing all our commits and all our tags. Now we
> are using small script that is verifying our repositories just before we run
> build. That is against keyring maintained on our server. I am trying to extend
> that to whole OpenWRT tree. That introduces problem of having a lot of keys and a
> lot of packages sharing same allowed keys. Fetching all allowed keys for every
> package from key servers is just slow because of that I have to share those
> between packages. In general there are two options. First one is to have cache of
> already fetched keys in armor format. Second one is to have one keyring and by
> setting all keys explicitly as never trusted with package given exception.
> Unfortunately first option can't be used because of one other request that is from
> our team. We don't want to be forced to update list of allowed contributors to our
> projects every time we have new colleague. Solution we come up with is to have
> central PGP key that signs our whole team and then verification is done by
> allowing GPG to fetch additional keys with max-cert-depth 1. That brings me to git
> verify-commit/tag that won't exit with zero code when signature is not trusted.

OK, that makes some sense (and I guess answers my "how would you use the
trustdb" question above).

> I have a solution for my problem (calling git verify-* twice and grep). That is
> not the point of this email nor this contribution. The point is that although
> GPG's behavior of exiting with 0 code when trust level is unknown is unexpected
> but in the end understandable, git's behavior of exiting with 0 code even if key
> is explicitly untrusted is just counterintuitive. I think that few people are
> still going to get nasty surprise when I consider that this change was introduced
> mid 2014 just after v2.4.0 and Ubuntu 14.04 lts (running even on part of our
> infrastructure) still contains version 1.9.1 and in that release it was
> acknowledging GPG exit code.

FWIW, I'm on board with returning non-zero in any case where gpg would.

-Peff
