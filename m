Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1C0ECAAD5
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiH3S4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiH3S4S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:56:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36887760F7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:56:17 -0700 (PDT)
Received: (qmail 7400 invoked by uid 109); 30 Aug 2022 18:56:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Aug 2022 18:56:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27815 invoked by uid 111); 30 Aug 2022 18:56:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Aug 2022 14:56:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Aug 2022 14:56:15 -0400
From:   Jeff King <peff@peff.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: curiosities with tempfile.active
Message-ID: <Yw5dT6I7QKkfuQAF@coredump.intra.peff.net>
References: <YwXw2ytUlrXSSRh7@coredump.intra.peff.net>
 <526a174e-b179-c284-a21c-7afe0a0b4df2@web.de>
 <YwoV9/xAcWTRbUBG@coredump.intra.peff.net>
 <CAPx1Gvddmk8cfWGg7M8gJ=rxnoTgQRgQNX95BgYcQk1N3VUi8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx1Gvddmk8cfWGg7M8gJ=rxnoTgQRgQNX95BgYcQk1N3VUi8A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2022 at 02:47:45PM -0700, Chris Torek wrote:

> On Sat, Aug 27, 2022 at 6:05 AM Jeff King <peff@peff.net> wrote:
> > Yeah, I saw that. It's a bit vague, and if the call returns ENOSYS or
> > EISDIR, that would be perfectly fine. It's the "what happens on the
> > implementations that do support it..." part that I'm more worried about. :)
> 
> The history here is that pre-4.2BSD, Unix systems had no mkdir
> system call. You used mknod() to make a truly empty directory and
> the link() to create the "." and ".." entries within it, and all three of
> these operations were restricted to the super-user.  There was no
> rmdir either, so again, unlink() as the super-user was permitted to
> do the job (with three calls to unlink the "." and ".." entries first and
> then remove the directory).
> 
> Unlinking a directory when it still contains "." leaves the link count
> at 1 and there's no GC, so it sits around occupying an inode.

Thanks, that matches the sense of unease I had in the back of my mind. I
seem to recall that maybe older versions of SunOS exhibited this, but
that feels like a lifetime ago. At any rate, we should avoid that
unlink() call, and René's patch neatly does so.

-Peff
