Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C25EC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE47D611CB
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhEENfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 09:35:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:45238 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230159AbhEENfr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 09:35:47 -0400
Received: (qmail 18256 invoked by uid 109); 5 May 2021 13:34:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 13:34:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9365 invoked by uid 111); 5 May 2021 13:34:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 09:34:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 09:34:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
Message-ID: <YJKe+ncDqrqq1i8P@coredump.intra.peff.net>
References: <20200404142131.GA679473@coredump.intra.peff.net>
 <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
 <xmqqwnsd3426.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnsd3426.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 06:47:29PM +0900, Junio C Hamano wrote:

> The patch makes sense to me, modulo that the way the variable
> "saved_errno" introduced by this patch is used and the way a
> variable with that name is typically used in our codebase are at
> odds.  I.e. we typically call a variable "saved_errno" when it is
> used in this pattern:
> 
>     if (a_syscall_whose_error_condition_we_care_about()) {
> 	int saved_errno = errno;
> 	perform_some_cleanup_operation_that_might_clobber_errno();
> 	return error_errno(..., saved_errno);
> 	/*
> 	 * or
> 	 * errno = saved_errno;
> 	 * return -1;
> 	 * and let the caller handle 'errno'
> 	 */
>     }
> 
> But since I do not think of a better name for this new variable that
> is not exactly used like so, let's queue it as-is.

I'd probably have just called it "err", but I think it is fine either
way. :)

The patch also looks good to me. I used to compile with -O3 occasionally
to fix warnings, but given the date on this commit, it seems I have not
done so in quite a while. (It reproduces on gcc 10 for me, which is not
surprising).

-Peff
