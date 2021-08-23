Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF98C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFAC61361
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhHWQft (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:35:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:56716 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhHWQfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 12:35:48 -0400
Received: (qmail 12031 invoked by uid 109); 23 Aug 2021 16:35:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Aug 2021 16:35:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30237 invoked by uid 111); 23 Aug 2021 16:35:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Aug 2021 12:35:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Aug 2021 12:35:04 -0400
From:   Jeff King <peff@peff.net>
To:     Marvin =?utf-8?Q?H=C3=A4user?= <mhaeuser@posteo.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] send-email propagates "In-Reply-To"
Message-ID: <YSPOOGxTMEgStdjJ@coredump.intra.peff.net>
References: <4db7759c-2123-533b-9f89-954c07f5832a@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4db7759c-2123-533b-9f89-954c07f5832a@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 22, 2021 at 09:24:12AM +0000, Marvin Häuser wrote:

> "git send-email" propagates the "In-Reply-To" header of the last prior patch
> with such defined to subsequent patches which do not define such explicitly.
> I suspect this behaviour is incorrect as I could not find any documentation
> on this. I'm sorry if this behaviour is actually expected, and would be
> happy if someone could point me to the appropriate documentation. This was
> reproduced on Fedora 34 with git 2.33.0 and "--no-thread".
> 
> Steps to reproduce:
> 1. Create two patches, one of which has an "In-Reply-To" field
> ("patch-in-reply.patch") and one of which does not
> ("patch-no-in-reply.patch").
> 2. Run "git send-email --dry-run --no-thread patch-in-reply.patch
> patch-no-in-reply.patch"
> 2.1. Observe the emission of an "In-Reply-To" header for
> "patch-no-in-reply.patch" with no such header.
> 3. Run "git send-email --dry-run --no-thread patch-no-in-reply.patch
> patch-in-reply.patch"
> 3.1. Observe the omission of an "In-Reply-To" header for
> "patch-no-in-reply.patch" with no such header.
> 
> Expected behaviour:
> With no threading and no other sorts of explicitly defining the
> "In-Reply-To" header, I expect to always observe the behaviour of 3.1., and
> to not observe the behaviour of 2.1.

Yes, I think this is just a bug. If the user requested --no-thread, then
we should be sending each patch as it appears on disk, with no
modification to the in-reply-to header.

> The "issue" is "in_reply_to" is overwritten here [1], which is the main loop
> worker to process all files passed to send-email [2], but it is not restored
> for subsequent patches. Unless required otherwise (e.g. send-email
> threading), it should be restored to its default value for each patch I
> believe.

Right. Most of the values we parse are declared inside the process_file
function, and so start empty. $in_reply_to is special in that we need to
carry its value across multiple files, so we need to always handle it in
each loop iteration, whether we are setting it to a new value or
resetting it to null.

> I wrote a quick patch to adjust 2.1. to 3.1. [3]. I have no time right now
> to review the submission guidelines (and thus did not submit the patch
> "properly" yet), but I will try to get to that tonight or some time next
> week. If in the mean time you could provide any feedback on the behaviour or
> the patch, so that I can get things right the first time, that would be
> great!

Your patch looks like the right direction. Handling $references at the
same time is the right thing to do. The extra setting of $subject seems
weird, though.

We'd want to add a test to t/t9001-send-email.sh, too, I'd think.

-Peff
