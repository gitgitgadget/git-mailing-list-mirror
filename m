From: Jeff King <peff@peff.net>
Subject: Re: [RFC] allowing hooks to ignore input?
Date: Thu, 18 Sep 2014 07:14:12 -0400
Message-ID: <20140918111412.GB13481@peff.net>
References: <xmqqzje48nh4.fsf@gitster.dls.corp.google.com>
 <5413FE06.1020901@kdbg.org>
 <xmqq7g1319rz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 13:14:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUZfH-0003az-60
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 13:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550AbaIRLOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 07:14:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:49779 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755886AbaIRLOO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 07:14:14 -0400
Received: (qmail 4179 invoked by uid 102); 18 Sep 2014 11:14:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Sep 2014 06:14:15 -0500
Received: (qmail 20988 invoked by uid 107); 18 Sep 2014 11:14:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Sep 2014 07:14:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Sep 2014 07:14:12 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g1319rz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257257>

On Tue, Sep 16, 2014 at 03:27:12PM -0700, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > I think this is a good move. Hooks are written by users, who sometimes
> > are not clueful enough.
> 
> Thanks for a sanity check.  I do not think it is about cluefulness
> in this particular case.  A rule that is not meaningfully enforced
> by reliably failing offenders is a rule that is hard to follow if a
> clueful user wanted to.

This looks good to me. Here's a real-world example of somebody getting
bitten by this (I _thought_ we had dealt with it then, but apparently
not):

  http://article.gmane.org/gmane.comp.version-control.git/186287

> This round comes with a test, but depending on the size of your pipe
> buffer and context switching race, an unpatched Git may pass it
> (reducing the test_seq number down to say 199 would certainly make
> it pass without the fix most of the time).

I took a look at your test. Having worked on racy sigpipe tests
recently, I think the only way to guarantee failure is to make sure you
fill up the pipe buffer. My experiments showed this was typically 64K on
a variety of Linux systems, but I think can be bumped up at runtime.

When working on the sanitized_signals() test, we decided to just pick an
arbitrarily high number like 1MB and use that (ideally you would send
infinite data until you get SIGPIPE, but the failure mode for your test
is then that it doesn't finish :-/).

You have things much harder and much easier here. Harder, in that you
can only convince git to send ~100 bytes per ref, so you would need a
lot of refs (and thus it's expensive to over-compensate). But easier, in
that you do not need to _reliably_ catch SIGPIPE. You only need to catch
it often enough that somebody notices if the rest is broken, not catch
it every time to ensure success.

So I think it is OK as-is. You should be generating ~91K of ref data
(refname + two sha1s + spaces and newline), and I can't imagine many
systems have a pipe buffer bigger than 64K. If they do, the only
downside is that those systems might only intermittently catch a
regression.

-Peff
