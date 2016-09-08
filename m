Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1CE21F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 08:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936133AbcIHI1R (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 04:27:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:40075 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932881AbcIHI1R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 04:27:17 -0400
Received: (qmail 4340 invoked by uid 109); 8 Sep 2016 08:27:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 08:27:16 +0000
Received: (qmail 13133 invoked by uid 111); 8 Sep 2016 08:27:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 04:27:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 04:27:13 -0400
Date:   Thu, 8 Sep 2016 04:27:13 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t6026-merge-attr: wait for process to release trash
 directory
Message-ID: <20160908082713.sgzp2evbvzuthdb4@sigill.intra.peff.net>
References: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org>
 <20160906072707.goysliw32xgwmlol@sigill.intra.peff.net>
 <xmqq4m5rmu4i.fsf@gitster.mtv.corp.google.com>
 <20160907190004.dw3p6fxkdaubwuvu@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609081002490.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609081002490.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 10:05:58AM +0200, Johannes Schindelin wrote:

> > > Is fifo safe on Windows, though?
> > 
> > No clue. We seem to use mkfifo unconditionally in lib-daemon, but
> > perhaps people do not run that test on Windows. Other invocations seem
> > to be protected by the PIPE prerequisite. But...
> 
> AFAICT we do not use mkfifo on Windows. Let's see what t/test-lib.sh has
> to say about the matter:
> 
> 	test_lazy_prereq PIPE '
> 		# test whether the filesystem supports FIFOs
> 		case $(uname -s) in
> 		CYGWIN*|MINGW*)
> 			false
> 			;;
> 		*)
> 			rm -f testfifo && mkfifo testfifo
> 			;;
> 		esac
> 	'
> 
> So there you go.
> 
> The reason it is disabled is that Cygwin/MSYS2 do have a concept of a
> FIFO. But `git.exe` won't be able to access such a FIFO because it is
> emulated by the POSIX emulation layer, which Git cannot access.

Regarding my "unconditionally" above: coincidentally, I happened to be
looking in lib-git-daemon.sh about an hour ago and noticed that we do
indeed check "test_have_prereq PIPE" (just not near the mkfifo, of
course, because we are not in a test block).

It seems to have been added by a "Johannes Schindelin". Any relation?

So yeah. It definitely would be a bad idea to use a fifo in a test that
is already Windows-specific.

-Peff
