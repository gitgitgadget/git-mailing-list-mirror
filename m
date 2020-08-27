Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D6AC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260642080C
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgH0EV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:21:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:42190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgH0EV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 00:21:59 -0400
Received: (qmail 13148 invoked by uid 109); 27 Aug 2020 04:21:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2020 04:21:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22350 invoked by uid 111); 27 Aug 2020 04:21:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2020 00:21:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Aug 2020 00:21:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] run_command: teach API users to use embedded 'args' more
Message-ID: <20200827042157.GC3346457@coredump.intra.peff.net>
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
 <20200826194650.4031087-1-gitster@pobox.com>
 <20200826194650.4031087-3-gitster@pobox.com>
 <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
 <xmqqmu2ht58g.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmu2ht58g.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 26, 2020 at 03:25:03PM -0700, Junio C Hamano wrote:

> The child_process structure has an embedded strvec for formulating
> the command line argument list these days, but code that predates
> the wide use of it prepared a separate char *argv[] array and
> manually set the child_process.argv pointer point at it.
> 
> Teach these old-style code to lose the separate argv[] array.

I think the result is much nicer and less error-prone (especially the
ones that pre-size the array with NULLs and fill in the components
later). It incurs a few extra mallocs at run-time, but on top of an
execve(), that's a drop in the bucket.

I've actually considered dropping child_process.argv entirely. Having
two separate ways to do the same thing gives the potential for
confusion. But I never dug into whether any existing callers would be
made worse for it (I kind of doubt it, though; worst case they can use
strvec_pushv). There are still several left after this patch, it seems.

Likewise for child_process.env_array.

-Peff
