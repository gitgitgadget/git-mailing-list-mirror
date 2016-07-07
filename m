Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C500D20705
	for <e@80x24.org>; Thu,  7 Jul 2016 20:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbcGGUi0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:38:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:41641 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752095AbcGGUiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:38:25 -0400
Received: (qmail 6226 invoked by uid 102); 7 Jul 2016 20:38:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jul 2016 16:38:25 -0400
Received: (qmail 7619 invoked by uid 107); 7 Jul 2016 20:38:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jul 2016 16:38:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2016 16:38:22 -0400
Date:	Thu, 7 Jul 2016 16:38:22 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes-merge: use O_EXCL to avoid overwriting existing
 files
Message-ID: <20160707203822.GB11804@sigill.intra.peff.net>
References: <577EB6BE.6090504@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <577EB6BE.6090504@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 07, 2016 at 10:08:30PM +0200, René Scharfe wrote:

> Use the open(2) flag O_EXCL to ensure the file doesn't already exist
> instead of (racily) calling stat(2) through file_exists().  While at it
> switch to xopen() to reduce code duplication and get more consistent
> error messages.

This is definitely an improvement, as it behaves the same except for the
TOCTOU race. But not being very familiar with the notes-merge code, I
have to wonder if this is a system of a larger design issue.

Why do we care that the file exists? Should we instead be using the
lockfile code to get exclusive access to it? That would also switch us
to doing the write-to-tempfile-and-rename dance, but that seems like it
would be a good thing. If we hit a write() error in the code now, we
leave a partially-written file in the notes worktree.

I dunno. From my cursory reading of the code, it seems like we'd never
really expect this file_exists() to trigger in the first place, so
perhaps it's not worth thinking too hard about it.

-Peff
