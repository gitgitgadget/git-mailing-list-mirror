Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5E52018A
	for <e@80x24.org>; Fri, 24 Jun 2016 15:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbcFXPbZ (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 11:31:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:59727 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750972AbcFXPbY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 11:31:24 -0400
Received: (qmail 20573 invoked by uid 102); 24 Jun 2016 15:31:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 11:31:23 -0400
Received: (qmail 20131 invoked by uid 107); 24 Jun 2016 15:31:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 11:31:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 11:31:21 -0400
Date:	Fri, 24 Jun 2016 11:31:21 -0400
From:	Jeff King <peff@peff.net>
To:	Lukas Fleischer <lfleischer@lfos.de>
Cc:	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] Refactor recv_sideband()
Message-ID: <20160624153121.GA2494@sigill.intra.peff.net>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <20160614210038.31465-1-lfleischer@lfos.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160614210038.31465-1-lfleischer@lfos.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 14, 2016 at 11:00:38PM +0200, Lukas Fleischer wrote:

> Improve the readability of recv_sideband() significantly by replacing
> fragile buffer manipulations with string buffers and more sophisticated
> format strings. Note that each line is printed using a single write()
> syscall to avoid garbled output when multiple processes write to stderr
> in parallel, see 9ac13ec (atomic write for sideband remote messages,
> 2006-10-11) for details.
> 
> Also, reorganize the overall control flow, remove some superfluous
> variables and replace a custom implementation of strpbrk() with a call
> to the standard C library function.

I happened to be looking at the color-printing code yesterday, and was
reminded that on Windows, fprintf is responsible for converting ANSI
codes into colors the terminal can show:

  $ git grep -A2 IMPORTANT color.h
  color.h: * IMPORTANT: Due to the way these color codes are emulated on Windows,
  color.h- * write them only using printf(), fprintf(), and fputs(). In particular,
  color.h- * do not use puts() or write().

Your patch converts some fprintf calls to write. What does this mean
on Windows for:

  1. Remote servers which send ANSI codes and expect them to look
     reasonable (this might be a losing proposition already, as the
     server won't know anything about the user's terminal, or whether
     output is going to a file).

  2. The use of ANSI_SUFFIX in this function, which uses a similar
     escape code.

-Peff
