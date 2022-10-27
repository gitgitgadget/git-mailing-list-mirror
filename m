Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0F5ECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 20:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbiJ0ULs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiJ0ULg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 16:11:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F289906
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 13:11:35 -0700 (PDT)
Received: (qmail 17974 invoked by uid 109); 27 Oct 2022 20:11:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Oct 2022 20:11:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24260 invoked by uid 111); 27 Oct 2022 20:11:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Oct 2022 16:11:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Oct 2022 16:11:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/8] run-command: remove run_command_v_*()
Message-ID: <Y1rl9arDRGay0CHm@coredump.intra.peff.net>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2022 at 06:30:36PM +0200, René Scharfe wrote:

> Replace the convenience functions run_command_v_opt() et. al. and use
> struct child_process and run_command() directly instead, for an overall
> code reduction and a simpler and more flexible API that allows creating
> argument lists without magic numbers and reduced risk of memory leaks.
> 
> This is a broken-out and polished version of the original scratch at
> https://lore.kernel.org/git/9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de/

I read through this and it all looks fine to me. I was a bit puzzled at
the layout of your series at first. In particular, the difference
between cases in patch 4 versus the later ones.

I think it is that in patch 4, these are all unambiguously positive
because we are getting rid of magic numbers (or magically-sized arrays).
Whereas in patches 5-8, there's nothing inherently wrong with the
call-sites; but as we get rid of the API wrappers, we convert them. So
they are collateral damage, so to speak, from the simplification of the
API.

That makes sense to me, though I could point out that most of the sites
cleaned up in patch 4 _could_ be converted to look like the ones that
are converted in 5-8. Obviously that doesn't make sense to do, knowing
that 5-8 are coming. But if the point in splitting it this way is to
show that we could stop at patch 4, cleaning up call sites but not
shrinking the run-command API, then I just want to point out that there
is another way to do those cleanups. :)

All that said, you will be unsurprised to hear that I am on board with
the direction of 5-8, so this all looks good to me. I'm just laying out
my thought process while reviewing.

I also think it would have been fine to just drop the whole API in one
patch (i.e., squashing 5-8), which makes the intermediate diffs a bit
shorter. But I do not mind at all having the cases broken out.

Thanks for cleaning this up.

-Peff
