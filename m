Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EBACE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 12:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjIYM3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 08:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjIYM33 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 08:29:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D66C0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 05:29:23 -0700 (PDT)
Received: (qmail 5148 invoked by uid 109); 25 Sep 2023 12:29:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Sep 2023 12:29:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12918 invoked by uid 111); 25 Sep 2023 12:29:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Sep 2023 08:29:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Sep 2023 08:29:21 -0400
From:   Jeff King <peff@peff.net>
To:     Max Amelchenko <maxamel2002@gmail.com>
Cc:     Aaron Schrab <aaron@schrab.com>, Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git clone command leaves orphaned ssh process
Message-ID: <20230925122921.GA2118294@coredump.intra.peff.net>
References: <CAN47KsV0E+XC2F+TVKXnnJnkATRp7eM7=-ZJFyZcoTz9SJmcHQ@mail.gmail.com>
 <ZP2DaQMA_aFvjQiR@debian.me>
 <CAN47KsUe=qicr4wZWd33EV+cciUr8ztP2veoOkcw0JBtvsBGjw@mail.gmail.com>
 <ZP4PO+HkbsbuKact@nand.local>
 <CAN47KsX5cpo5oD7PAwAQzjR4oocST6uSkJe2SzAYPxxqy7dGtg@mail.gmail.com>
 <20230912T004049Z.jiWw7xuK7fiT@pug.qqx.org>
 <20230912043345.GA1623696@coredump.intra.peff.net>
 <CAN47KsUDS0om6r6WwRZHLHdETHE+Lu=bj1skG1cAwvzEUaF81Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN47KsUDS0om6r6WwRZHLHdETHE+Lu=bj1skG1cAwvzEUaF81Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 24, 2023 at 01:25:08PM +0300, Max Amelchenko wrote:

> Thanks,
> Just wanted to clarify something. This will not be handled by AWS (we
> had a support ticket re. that case), since they do not interfere with
> the running processes on its infrastructure, and if there is a
> problematic process causing this overflowing in orphaned processes, it
> needs to be handled by that process.
> The question is, doesn't Git want to ensure a clean exit in all cases?
> This is a clear example of a non-clean exit.

Git does ensure a clean exit if we run the clone process to completion.
In your case we hit a fatal error midway through and are aborting. At
that point we do not care what the exit code of ssh is.

We _could_ set up a signal/atexit handler combo to call waitpid(), but
we would just be throwing away the result code. And that is a catch-all
I would rather see done by PID 1 than by git. It can serve all
processes, not just git. And it can do so more robustly, since git may
be killed without a chance to run cleanup code (e.g., signal 9).

-Peff
