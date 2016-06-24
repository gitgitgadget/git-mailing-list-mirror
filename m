Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8752018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbcFXTj2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:39:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:59931 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750876AbcFXTj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:39:27 -0400
Received: (qmail 31117 invoked by uid 102); 24 Jun 2016 19:39:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:39:26 -0400
Received: (qmail 22012 invoked by uid 107); 24 Jun 2016 19:39:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:39:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 15:39:24 -0400
Date:	Fri, 24 Jun 2016 15:39:24 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 0/4] portable signal-checking in tests
Message-ID: <20160624193924.GA6282@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
 <20160623232041.GA3668@sigill.intra.peff.net>
 <576D621F.1030000@kdbg.org>
 <20160624164603.GA13789@sigill.intra.peff.net>
 <576D684A.6030406@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <576D684A.6030406@kdbg.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 07:05:14PM +0200, Johannes Sixt wrote:

> Am 24.06.2016 um 18:46 schrieb Jeff King:
> > On Fri, Jun 24, 2016 at 06:38:55PM +0200, Johannes Sixt wrote:
> > > It's going to be 269 with ksh, and who-knows-what on Windows (due to lack of
> > > SIGPIPE - I haven't tested this, yet).
> > 
> > Thanks, I meant to ask about that. We do a workaround in t0005, but we
> > _don't_ do it in the new sigpipe handling for test_must_fail. Is the
> > latter just broken, too?
> 
> That's well possible. It is not prepared to see ksh's exit codes for
> signals.

I'm actually not convinced that old versions of ksh are viable for
running the test suite. mksh seems to use POSIX semantics, and I cannot
get through t0005 with ksh93, as it parses nested parentheses wrong. But
maybe there are other ksh variants that use the funny exit codes, but
are otherwise not too buggy.

I'd be more concerned with Windows. The SIGPIPE tests in t0005 are
already marked !MINGW, but other checks elsewhere are not. I know there
is no SIGPIPE on Windows, so it may be that some cases happen to work
because we end up in write_or_die(), which converts EPIPE into a 141
exit.

Anyway. Here's a series that I think makes things better, and it is not
too painful to do.

  [1/4]: tests: factor portable signal check out of t0005
  [2/4]: t0005: use test_match_signal as appropriate
  [3/4]: test_must_fail: use test_match_signal
  [4/4]: t/lib-git-daemon: use test_match_signal

-Peff
