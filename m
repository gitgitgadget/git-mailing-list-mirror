Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD2EC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84DA20809
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgIOVXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:23:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57594 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgIOVXn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 17:23:43 -0400
Received: (qmail 15637 invoked by uid 109); 15 Sep 2020 21:23:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Sep 2020 21:23:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22098 invoked by uid 111); 15 Sep 2020 21:23:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Sep 2020 17:23:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Sep 2020 17:23:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: sub-fetches discard --ipv4|6 option
Message-ID: <20200915212338.GA2868700@coredump.intra.peff.net>
References: <20200914121906.GD4705@pflmari>
 <20200914194951.GA2819729@coredump.intra.peff.net>
 <20200915115025.GA18984@pflmari>
 <20200915130506.GA2839276@coredump.intra.peff.net>
 <20200915140613.GB18984@pflmari>
 <20200915152730.GA2853972@coredump.intra.peff.net>
 <xmqq4kny2461.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kny2461.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 01:09:10PM -0700, Junio C Hamano wrote:

> > If you go that route, we have some "_F" macros that take flags. Probably
> > would make sense to add it more consistently, which lets you convert:
> >
> >   OPT_BOOL('f', "foo", &foo, "the foo option");
> >
> > into:
> >
> >   OPT_BOOL_F('f', "foo", &foo, "the foo option", PARSE_OPT_RECURSIVE);
> >
> > but could also be used for other flags.
> 
> What is this "recursive" about?  Does it have much in common with
> "passthru", or are they orthogonal?

I agree the name is not super-descriptive. And it's a bit odd that the
parse-options code itself would not care about it. It's simply a
convenient bit for the calling code to use (rather than try to manage a
separate array whose values correspond). It could be PARSE_OPT_USER1,
but that is probably too inscrutable. :)

It's sort-of similar to passthru, but not quite. The problem with
passthru is that it _always_ applies to the option. We never parse it as
an option itself, but rather always stick its canonicalized form into an
array of strings. But for the case we're talking about here, we don't
know ahead of time whether we want the passthru behavior or not. It
depends on whether we see an option like "--all" (which might even come
after us).

So I think the best you could do is:

  1. Keep two separate option lists, "parent" and "child". The parent
     list has "--all" in it. The child list has stuff like "--ipv6".

  2. Parse using the parent list with PARSE_OPT_KEEP_UNKNOWN. That lets
     you decide whether we're in a mode that is spawning child fetch
     processes.

  3. If we are spawning, then everything in the "child" option list
     becomes passthru. We could either mark them as such, or really, I
     guess we could just pass the remainder of argv on as-is (though it
     might be nice to diagnose a bogus config option once in the parent
     rather than in each child).

That would work OK. One downside is that PARSE_OPT_KEEP_UNKNOWN is
inherently flaky. It doesn't know if "--foo --bar" is two options, or
the option "--foo" with the value "--bar". You could solve that by leaving
dummy passthru options in the "parent" list, but now we're back to
having two copies.

I guess parse-options could provide a MAYBE_PASSTHRU flag. On the first
parse_options() call, it would skip over any such options, leaving them
in argv. On the second, the caller would tell it to actually parse them.

-Peff
