Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FB4C433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 09:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E1122240
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 09:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgJSJsz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 19 Oct 2020 05:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJSJsz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 05:48:55 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E29AC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 02:48:55 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id 89CEB3AB00C;
        Mon, 19 Oct 2020 09:48:54 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id 7CCA9160044;
        Mon, 19 Oct 2020 09:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id 6A558160071;
        Mon, 19 Oct 2020 09:48:54 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b5alW0NWhTo0; Mon, 19 Oct 2020 09:48:54 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id 75441160044;
        Mon, 19 Oct 2020 09:48:53 +0000 (UTC)
Date:   Mon, 19 Oct 2020 11:48:50 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] diff: add -I<regex> that ignores matching changes
Message-ID: <20201019094850.GB3717@larwa.hq.kempniu.pl>
References: <20201012091751.19594-1-michal@isc.org>
 <20201015072406.4506-1-michal@isc.org>
 <20201015072406.4506-3-michal@isc.org>
 <afd3b1cf-b883-6df5-bea5-28f8e06d8702@gmail.com>
 <xmqqeelycajx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeelycajx.fsf@gitster.c.googlers.com>
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First, thanks to Phillip for testing this.

> Yes, this is a good location to clear the diff_queue, which is
> per-invocation.  But diff_options->ignore_regex[] can and should be
> shared across multiple invocations of the diff machinery, as we are
> parsing upfront in the command line option parser just once to be
> used throughout the life of the program.  It is wrong to free them
> early like this.

Ugh, sorry, I am only now starting to see the big picture.

> I really hate to suggest this, one common API call made into the
> diff machinery from various consumers, when they are absolutely done
> with diff_options, is probably diff_result_code().  Its purpose is
> to collect bits computed to participate in the overall result into
> the final result code and anybody who ran one or more diff and wants
> to learn the outcome must call it, so it is unlikely that callers
> that matter are missing a call to finalize their uses of the diff
> machinery.  So if freeing .ignore_regex[] is really necessary, it
> could be used to tell us where to do so [*1*].
> 
> Unlike per-invocation resources that MUST be freed for repeated
> invocations of the diff machinery made in "git log" family,
> resources held for and repeatedly used during the entire session
> like this may not have to be freed, to be honest, though.

After reading your message, taking a closer look, and doing a few
Valgrind runs, I tend to agree that perhaps there is no need to free the
'ignore_regex' array after all - it does *not* get allocated repeatedly
during each invocation of the diff machinery and when Git exits, the OS
will reclaim any memory allocated by the process anyway.  On my laptop,
a Valgrind run done for a -DSUPPRESS_ANNOTATED_LEAKS build claims that
'ignore_regex' is one of 1,300+ memory blocks still reachable at exit
time, which amount to about 2.5 MB of memory in total.  Given this, it
feels slightly weird to single 'ignore_regex' out.

I will revert the diff_flush() changes in v4 unless somebody disagrees
with the above reasoning.

-- 
Best regards,
Michał Kępień
