Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06597C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A38221F1
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbhAMN3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:29:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:54712 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbhAMN3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 08:29:53 -0500
Received: (qmail 22481 invoked by uid 109); 13 Jan 2021 13:29:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 13:29:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29916 invoked by uid 111); 13 Jan 2021 13:29:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 08:29:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 08:29:12 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 01/10] pkt-line: use stack rather than static buffer in
 packet_write_gently()
Message-ID: <X/71qByO5jSceIFn@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <1155a45cf64afb237204429cd4ff2e74f5f7602a.1610465492.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1155a45cf64afb237204429cd4ff2e74f5f7602a.1610465492.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 03:31:23PM +0000, Jeff Hostetler via GitGitGadget wrote:

> Teach packet_write_gently() to use a stack buffer rather than a static
> buffer when composing the packet line message.  This helps get us ready
> for threaded operations.

Sounds like a good goal, but...

>  static int packet_write_gently(const int fd_out, const char *buf, size_t size)
>  {
> -	static char packet_write_buffer[LARGE_PACKET_MAX];
> +	char packet_write_buffer[LARGE_PACKET_MAX];
>  	size_t packet_size;

64k is awfully big for the stack, especially if you are thinking about
having threads. I know we've run into issues around that size before
(though I don't offhand recall whether there was any recursion
involved).

We might need to use thread-local storage here. Heap would also
obviously work, but I don't think we'd want a new allocation per write
(or maybe it wouldn't matter; we're making a syscall, so a malloc() may
not be that big a deal in terms of performance).

-Peff
