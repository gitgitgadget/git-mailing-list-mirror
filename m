Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699BF2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 18:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbcGASQ2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 14:16:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:39241 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751036AbcGASQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 14:16:27 -0400
Received: (qmail 22955 invoked by uid 102); 1 Jul 2016 18:16:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 14:16:28 -0400
Received: (qmail 20505 invoked by uid 107); 1 Jul 2016 18:16:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 14:16:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 14:16:24 -0400
Date:	Fri, 1 Jul 2016 14:16:24 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/9] Report bugs consistently
Message-ID: <20160701181624.GB16695@sigill.intra.peff.net>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
 <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
 <xmqqfurv3ejz.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1606301041380.12947@virtualbox>
 <20160630092333.GB24964@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607011548560.12947@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607011548560.12947@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 01, 2016 at 03:51:33PM +0200, Johannes Schindelin wrote:

> > > If the idea is to make it easier to find, I would wager a guess that
> > > 'die("BUG:' would be just as good a search term. Even better, I think,
> > > because 'BUG' would also match comments.
> > 
> > I have been tempted to switch to BUG(), because it would make it easy to
> > call abort() and get a coredump (and therefore a stack trace).
> 
> Please keep in mind that abort() does not produce stackdumps with MinGW.
> So at least Windows developers would not be better off.

It doesn't in Linux either. But you can use the core file to get a
backtrace. Do you not get cores at all in Windows? Yuck. :)

> Heh. I still find myself using that good old trick where I set a variable,
> loop while it is set and print out the pid, waiting for a debugger to
> attach and re-set that variable.

That's a new one to me. Gross. :)

Usually I can coax git into running "gdbserver ... git foo" instead of
git foo" via config. But sometimes the values are hard-coded (for
instance, the way we call pack-objects, which I recently made a bit more
flexible).

> > The other thing BUG() would get us is that we could turn it into a macro
> > (on systems with vararg macros) and report things like __FILE__ and
> > __LINE__.  In practice, though our BUG messages are unique enough that
> > there is no problem finding the source.
> 
> That would be very nice *also* for error() messages. But I guess we cannot
> have it, vararg macros being a feature rather than a standard.

It is a standard, it's just C99, which we've been rather slow to
embrace.

However we have prior art in the trace code. If your system supports
variadic macros, then we define the macros to pass the file/line info.
Otherwise, we skip the macros, and those names point directly to
functions.

So it would not be too hard to implement. I've never bothered, though,
because in my experience the interesting thing is almost never "on what
line was error() called", but rather "what line called the function that
called error()". I.e., the stack trace.

I looked a while ago at trying to auto-generate stack traces in git
using something like GNU's backtrace (obviously not portable, but it's a
start). My conclusion was that the simplest thing is to just generate a
core and run "gdb -ex bt" on it.

-Peff
