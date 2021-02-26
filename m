Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5160C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 17:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD3D64E4D
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 17:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBZR4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 12:56:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:46216 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhBZRzz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 12:55:55 -0500
Received: (qmail 18302 invoked by uid 109); 26 Feb 2021 17:55:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 17:55:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23163 invoked by uid 111); 26 Feb 2021 17:55:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 12:55:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 12:55:11 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: Re: [PATCH] pack-revindex.c: don't close unopened file descriptors
Message-ID: <YDk1/y1CmsPYC88C@coredump.intra.peff.net>
References: <34c017296a7c5fe4a2ea70f8a0b2d8586b34a4dc.1614357030.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34c017296a7c5fe4a2ea70f8a0b2d8586b34a4dc.1614357030.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 26, 2021 at 11:31:02AM -0500, Taylor Blau wrote:

> When opening a reverse index, load_revindex_from_disk() jumps to the
> 'cleanup' label in case something goes wrong: the reverse index had the
> wrong size, an unrecognized version, or similar.
> 
> It also jumps to this label when the reverse index couldn't be opened in
> the first place, which will cause an error with the unguarded close()
> call in the label.
> 
> Guard this call with "if (fd >= 0)" to make sure that we have a valid
> file descriptor to close before attempting to close it.

Makes sense. Running close(-1) wasn't really hurting much in practice,
but it's cleaner not to do so.

This would go on top of tb/pack-revindex-on-disk.

> Dscho mentioned this to me privately when reviewing Coverity results for
> -rc0. This one is legitimate, and the fix is easy enough, too.

I'm excited that we might get Coverity results again. There were a lot
of false positives, but I found its signal-to-noise ratio higher than
almost every other static analysis tool I've looked at.

-Peff
