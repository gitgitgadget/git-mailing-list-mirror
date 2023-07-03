Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05585C001B0
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 20:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGCUZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCUZK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 16:25:10 -0400
Received: from haze.kloetzke.net (haze.kloetzke.net [IPv6:2a03:4000:13:91f:34ea:99ff:fed2:e113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04688E4E
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 13:25:07 -0700 (PDT)
Received: from localhost (p578ec94b.dip0.t-ipconnect.de [87.142.201.75])
        by haze.kloetzke.net (Postfix) with ESMTPSA id 279B5800B7;
        Mon,  3 Jul 2023 22:25:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=kloetzke.net; s=2020;
        t=1688415905; bh=Aa3XHLRPtuL547A0Ys4goFWhLjq7lolNf8tqIydznEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkDPhG346ehWrY+DKNMW9qzCk1YJ/QLN2QyqakkoG1E8OKh1BUIgZp5vqBlVunlsY
         teugNJJabAl8wZnH7tDxxDC1GmLQbjOqhdj+VlS6ZijXDmwA47I3sp5FuX+xBEt1dA
         uwq8NyZF3taw8t6wFqf99YMmWj+oerUr/XM3l4RqyTohiDVBRjRJPAMxjn+4WKCf9s
         nN6j+9CWrO3NPhfROxbV08TsobrIBj5N6wwwopA+QXjPh2/0vUZpjZZXnjkwef1mYI
         4v6avjyn5Ojfq3W6KlTkX88tYvCXIha3gtzplXLDxQdJsek+MDxDQcgshbEk4WbY6j
         oGR8Dpii6MqgA==
Date:   Mon, 3 Jul 2023 22:25:03 +0200
From:   Jan =?iso-8859-1?Q?Kl=F6tzke?= <jan@kloetzke.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Steve Kemp <steve@steve.org.uk>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] ref-filter: handle nested tags in --points-at option
Message-ID: <ZKMun/sl9rS/2gQC@thinkpad.fritz.box>
References: <20230701205703.1172505-1-jan@kloetzke.net>
 <20230702125611.GA1036686@coredump.intra.peff.net>
 <20230702220243.GA1534980@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230702220243.GA1534980@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Sun, Jul 02, 2023 at 06:02:43PM -0400 schrieb Jeff King:
> On Sun, Jul 02, 2023 at 08:56:11AM -0400, Jeff King wrote:
> 
> > My biggest question would be whether this introduces any performance
> > penalty for the more common cases (lightweight tags and single-level
> > annotated tags). The answer is "no", I think; we are already paying the
> > cost to parse every object to find out if it's a tag, and your new loop
> > only does an extra parse if we see a tag-of-tag. Good.
> 
> Reading more carefully, I think this does actually change the
> performance a bit, because we end up parsing the pointed-to commits, as
> well. So here's before and after your patch running "git for-each-ref
> --points-at=HEAD" on linux.git (785 refs, all but 3 are tags):
> 
>   Benchmark 1: ./git.old for-each-ref --points-at=HEAD
>     Time (mean ± σ):      11.4 ms ±   0.2 ms    [User: 6.5 ms, System: 4.9 ms]
>     Range (min … max):    11.0 ms …  12.3 ms    239 runs
>   
>   Benchmark 2: ./git.new for-each-ref --points-at=HEAD
>     Time (mean ± σ):      20.6 ms ±   0.5 ms    [User: 10.4 ms, System: 10.2 ms]
>     Range (min … max):    19.8 ms …  22.7 ms    133 runs
>   
>   Summary
>     './git.old for-each-ref --points-at=HEAD' ran
>       1.80 ± 0.06 times faster than './git.new for-each-ref --points-at=HEAD'
> 
> The absolute numbers are pretty small, but the percent change isn't
> great. I'll send some patches in a minute that can be applied on top to
> improve this case, as well as fix the other issues I pointed out in the
> existing code.

I have to admit I was not entirely sure about the performance
implications. The relative performance drop is indeed substantial.
Thanks for the thorough review and swiftly taking care of these!

-- Jan
