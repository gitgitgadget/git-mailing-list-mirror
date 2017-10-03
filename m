Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6562A20365
	for <e@80x24.org>; Tue,  3 Oct 2017 09:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbdJCJcB (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 05:32:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:58826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751195AbdJCJcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 05:32:00 -0400
Received: (qmail 16533 invoked by uid 109); 3 Oct 2017 09:32:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:32:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6199 invoked by uid 111); 3 Oct 2017 09:31:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 05:31:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 05:31:58 -0400
Date:   Tue, 3 Oct 2017 05:31:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20171003093157.gq7za2fwcqsouire@sigill.intra.peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20171002230017.GT19555@aiede.mtv.corp.google.com>
 <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
 <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
 <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 02:15:15AM -0400, Jeff King wrote:

> The two reasonable paths forward to me are:
> 
>   1. Do nothing. Putting "color.ui = always" in your on-disk config is a
>      bad idea, and the right fix is to stop doing it.
> 
>   2. Make "always" a synonym for "auto". This has the advantage over (1)
>      that you can't shoot yourself in the foot with it (so the expanded
>      foot-shooting capabilities of 4c7f1819b don't matter). The
>      disadvantage is that you can no longer do:
> 
>        git -c color.ui=always foo >not-a-tty
> 
>      to ask for color in all sub-programs of "foo". I have no idea if
>      anybody cares. I came up with that example in 4c7f1819b as the most
>      plausible reason somebody might actually care about "always", but
>      I've never used it myself.
> 
>      And there _is_ a way to get the same thing, which is:
> 
>        GIT_PAGER_IN_USE=1 git foo >not-a-tty
> 
>      I.e., stay in "auto" but make the claim that "auto" really ought to
>      be showing color because the output is going to be consumed
>      eventually by a human.  While it looks a bit funny in my made-up
>      example above (because the variables says "pager" but we're not
>      actually piping to a pager directly), I think this is the most
>      plausible reason that an actual program might want to override the
>      auto-color decision.

I've got a series mostly done for option 2. It actually touches quite a
few of the test scripts, since we use "-c color.ui=always" to test
color output. Normally having to touch the test suite a lot gives me
pause that we're breaking something for real users, but I think in this
case the test suite is doing something that normal users simply don't.

A variant of 2 (let's call it 2a) is to convert "always" to "auto"
_only_ for on-disk config, allowing "-c" to still work. This dull the
test-suite pain, but there are still several test scripts which use
test_config and need updating. And it introduces a weird inconsistency
that I'd just as soon skip.

If we buy into the idea that "color.ui=always" is actually a useful
construct to put in your on-disk config (and I'm not sure that I do),
then our options are basically:

  3. Go back to the earlier behavior, which i what Junio's 2-patch
     revert series does. That has two issues though:

       - after patch 2, for-each-ref still respects color.ui=always,
	 even though it's plumbing. This is maybe-OK because we don't
	 generate colors unless somebody puts %C() codes into their
	 format.

       - plumbing like diff-tree still doesn't respect color.ui=never

  4. Read color.ui everywhere, but downgrade "always" to "auto" in
     plumbing commands (which would have to mark themselves as such by
     setting a global). This again falls into the "inconsistent and hard
     to explain" category, though I think it at least behaves as people
     would generally want. Except for people who really do want:

       git -c color.always=true foo >file

     to produce color when "foo" is a script that uses diff plumbing
     under the hood. I don't think that _can_ be solved, since from the
     plumbing perspective this is the same as the buggy add--interactive
     case.

I still lean towards option 2 (kill off "always"), but I'm trying to
consider the full range of options.

-Peff
