Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C7CECAAD2
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 13:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiH0NCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 09:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiH0NCt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 09:02:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D0E2CDDA
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 06:02:48 -0700 (PDT)
Received: (qmail 21966 invoked by uid 109); 27 Aug 2022 13:02:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Aug 2022 13:02:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19936 invoked by uid 111); 27 Aug 2022 13:02:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Aug 2022 09:02:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 27 Aug 2022 09:02:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: curiosities with tempfile.active
Message-ID: <YwoV9/xAcWTRbUBG@coredump.intra.peff.net>
References: <YwXw2ytUlrXSSRh7@coredump.intra.peff.net>
 <526a174e-b179-c284-a21c-7afe0a0b4df2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <526a174e-b179-c284-a21c-7afe0a0b4df2@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2022 at 12:46:29AM +0200, René Scharfe wrote:

> https://pubs.opengroup.org/onlinepubs/9699919799/functions/unlink.html
> says of the unlink(2) parameter: "The path argument shall not name a
> directory unless the process has appropriate privileges and the
> implementation supports using unlink() on directories."  So we better
> not do that..

Yeah, I saw that. It's a bit vague, and if the call returns ENOSYS or
EISDIR, that would be perfectly fine. It's the "what happens on the
implementations that do support it..." part that I'm more worried about. :)

That said...

> --- >8 ---
> Subject: [PATCH] tempfile: avoid directory cleanup race
> 
> The temporary directory created by mks_tempfile_dt() is deleted by first
> deleting the file within, then truncating the filename strbuf and
> passing the resulting string to rmdir(2).  When the cleanup routine is
> invoked concurrently by a signal handler we can end up passing the now
> truncated string to unlink(2), however, which could cause problems on
> some systems.
> 
> Avoid that issue by remembering the directory name separately.  This way
> the paths stay unchanged.  A signal handler can still race with normal
> cleanup, but deleting the same files and directories twice is harmless.

Right, I'm a little embarrassed I didn't immediately come up with this
same fix. This is definitely the right thing to do. The more we can
treat data from signal-handlers are write-once, the better.

There's a slight extra memory cost to store the directory name twice,
but it's a drop in the bucket overall.

>  tempfile.c | 14 ++++++--------
>  tempfile.h |  2 +-

The patch itself looks good to me.

-Peff
