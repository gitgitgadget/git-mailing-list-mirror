Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F037C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E7920781
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgFWSkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:40:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:40662 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387459AbgFWSkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 14:40:13 -0400
Received: (qmail 12985 invoked by uid 109); 23 Jun 2020 18:40:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 18:40:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19577 invoked by uid 111); 23 Jun 2020 18:40:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 14:40:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 14:40:11 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/4] t: replace incorrect test_must_fail usage (part 5)
Message-ID: <20200623184011.GC1444619@coredump.intra.peff.net>
References: <cover.1592470068.git.liu.denton@gmail.com>
 <cover.1592907663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1592907663.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 06:28:01AM -0400, Denton Liu wrote:

> I've taken your suggestions and rerolled the last patch. Notably, I
> combined $before and $command into a single function and then passed in
> `test_must_fail` as the second argument if it's expected to fail. I also
> decided to use a helper function to reduce the duplication of the
> calling logic but it's still a little verbose because I opted to make
> use of argument passing over global variables where possible.
> 
> One thing that I'm leaning towards is completely removing $after. We can
> combine $after with $command like I did in the first few iterations of
> this series and just write it as:
> 
> 	git_test_thing () {
> 		# before...
> 		$2 git do-the-thing "$1" &&
> 		if test -n "$2"
> 		then
> 			return
> 		fi &&
> 		# after...
> 	}
> 
> but I'm also okay with leaving it as is.

Yeah, as soon as I saw "combined $before and $command", then I wondered
why we needed to split anything (since clearly we're passing
responsibility to handle must_fail to the callback function).

So I think we should either have the full before/command/after split, or
have a single callback function which understands that it has to respect
"$2" as a prefix).

I'm OK with either. I do like both of them better than the magic
$OVERWRITING_FAIL thing, but this series seems to be taking a lot more
energy than I think its outcome is worth. Let's resolve it somehow and
work on something more exciting. ;)

> Also, one problem that's present is that for tests that use
> test_submodule_switch() and test_submodule_forced_switch(), $command
> will be listed as git_test_func, which might make debugging more
> difficult. I think I'd prefer the version we currently have queued for
> this reason (and why I did the whole song and dance of $OVERWRITING_FAIL
> in the first place), but if you think that this is fine, I'm fine with
> this approach as well.

I agree it's not ideal, but I don't think it's too bad. There are lots
of tests that have output you can't just cut-and-paste due to code
generation, helper functions, etc.

-Peff
