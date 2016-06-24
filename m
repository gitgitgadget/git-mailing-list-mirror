Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30801FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 21:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbcFXVFo (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 17:05:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:60078 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751462AbcFXVFo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 17:05:44 -0400
Received: (qmail 4113 invoked by uid 102); 24 Jun 2016 21:05:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 17:05:43 -0400
Received: (qmail 22974 invoked by uid 107); 24 Jun 2016 21:05:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 17:05:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 17:05:41 -0400
Date:	Fri, 24 Jun 2016 17:05:41 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 1/4] tests: factor portable signal check out of t0005
Message-ID: <20160624210541.GC6282@sigill.intra.peff.net>
References: <20160624193924.GA6282@sigill.intra.peff.net>
 <20160624194357.GA6441@sigill.intra.peff.net>
 <576D9D90.3070605@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <576D9D90.3070605@kdbg.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 10:52:32PM +0200, Johannes Sixt wrote:

> Am 24.06.2016 um 21:43 schrieb Jeff King:
> > In POSIX shells, a program which exits due to a signal
> > generally has an exit code of 128 plus the signal number.
> > However, some platforms do other things. ksh uses 256 plus
> > the signal number, and on Windows, all signals are just "3".
> 
> That's not true, see below.

I was worried about that. Git for Windows seems like a labyrinth of
bizarre special cases.

> > I didn't get into the weirdness of SIGPIPE on Windows here, but I think
> > this is probably a first step toward handling it better. E.g., it may be
> > that test_match_signal should respect 128 (or even any code) when we are
> > checking for SIGPIPE.
> 
> The Windows behavior is most closely described as having signal(SIGPIPE,
> SIG_IGN) at the very beginning of the program.

Right, but then we would get EPIPE. So what does git do in such cases?
I'd expect it generally to either hit the check_pipe() part of
write_or_die(), or to end up complaining via die() that the write didn't
go as expected.

> > +# Returns true if the numeric exit code in "$2" represents the expected signal
> > +# in "$1". Signals should be given numerically.
> > +test_match_signal () {
> > +	if test "$2" = "$((128 + $1))"
> > +	then
> > +		# POSIX
> > +		return 0
> > +	elif test "$2" = "$((256 + $1))"
> > +	then
> > +		# ksh
> > +		return 0
> > +	elif test "$2" = "3"; then
> > +		# Windows
> 
> You meant well here, but this is close to pointless as a general check. We
> check for this exit code in t0005 because there program termination happens
> via raise(), which on Window just calls exit(3). This exit code is not an
> indication that something related to SIGPIPE (or any signal) happened.
> 
> IMO there is too much danger to trigger a false positive if exit code 3 is
> treated special in this generality.

Yeah, I agree. But what _should_ it do? E.g., what happens to git-daemon
when it is killed via TERM?

-Peff
