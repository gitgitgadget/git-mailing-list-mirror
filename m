From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Portability: returning void
Date: Tue, 29 Mar 2011 20:16:53 -0400
Message-ID: <20110330001653.GA1161@sigill.intra.peff.net>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 02:17:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4j5r-0003Na-JK
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 02:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740Ab1C3AQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 20:16:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60746
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986Ab1C3AQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 20:16:57 -0400
Received: (qmail 3180 invoked by uid 107); 30 Mar 2011 00:17:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 20:17:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 20:16:53 -0400
Content-Disposition: inline
In-Reply-To: <20110329234955.GB14578@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170341>

On Tue, Mar 29, 2011 at 06:49:55PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > The problem is that the sleeps hang around for 100 seconds, and they are
> > connected to the test script's stdout. It works to run "./t0081-*"
> > because bash sees the SIGCHLD and knows the script is done. But the
> > prove program actually ignore the SIGCHLD and waits until stdout and
> > stderr on the child are closed.
> 
> Strange.  Why would prove tell its children to ignore SIGCHLD and
> SIGTERM?

No, you misunderstand. It is prove itself that ignores the SIGCHLD. It
is stuck in the loop in TAP::Parser::Iterator::Process::_next. It has
gotten SIGCHLD, but it keeps blocking waiting to get EOF on the child's
stdout.

> > Double-weird is that if you "strace" the prove process, it will still
> > hang. But if you "strace -f", it _won't_ hang.
> 
> Well, it hangs for me. :)  The strangest aspect is that after 100
> seconds, all is well again, which suggests that there's more happening
> than an unreaped process.

Doesn't that point to an unreaped process? After 100 seconds the sleep
process closes, prove gets EOF, and it completes. Lowering the "100" to
"1" caused a 1-second hang for me.

> | 19398 18:31:12 exit_group(0)            = ?
> | 19397 18:31:12 <... select resumed> )   = ? ERESTARTNOHAND (To be restarted)
> | 19397 18:31:12 --- SIGCHLD (Child exited) @ 0 (0) ---
> | 19397 18:31:12 select(8, [4 6], NULL, NULL, NULL <unfinished ...>
> 
> The test script exits, but "prove" is stuck in select and does not
> want to start reaping yet.  So presumably the test script's children
> are adopted by init.  We wait around 13 seconds, and then:

Right, prove is stuck in the select. You can see it even got SIGCHLD
above, and if you check your process list, you will probably see the
defunct bash process. But instead of realizing its child has died, it
insists on waiting until the pipe is closed. Nothing has to be adopted
by init. There are simply still processes with the pipe open.

> | 19424 18:31:25 <... nanosleep resumed> NULL) = 0
> | 19424 18:31:25 close(1)                 = 0
> | 19424 18:31:25 close(2)                 = 0
> | 19424 18:31:25 exit_group(0)            = ?
> | 19422 18:31:25 <... wait4 resumed> 0x7fff65d1ee6c, 0, NULL) = ? ERESTARTSYS (To be restarted)
> | 19422 18:31:25 --- SIGTERM (Terminated) @ 0 (0) ---
> 
> The first sleep wakes up and dies.  The corresponding subshell
> wakes up, reaps the child, and finally accepts SIGTERM.

Hrm. That's different than what happens on my system. On my system, the
bash process is _already_ dead during the whole procedure, and it is
just the stray sleeps that keep prove waiting.

Maybe different bash versions? Mine is 4.1.5(1) (from debian unstable,
bash_4.1-3).

> | 19397 18:31:26 <... select resumed> )   = 2 (in [4 6])
> | 19397 18:31:26 read(4, "", 65536)       = 0
> | 19397 18:31:26 read(6, "", 65536)       = 0
> | 19397 18:31:26 wait4(19398, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 19398
> 
> Now "prove" wakes up again.

Right, because the pipe is finally closed.

Did you try my 5>/dev/null patch? With it, I get no hang at all.

-Peff
