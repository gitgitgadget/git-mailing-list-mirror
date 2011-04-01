From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 19:27:03 +0200
Message-ID: <201104011927.03366.j6t@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <AANLkTikF_xLTdY0BgaXmUXvBJTG3HD3by9zN59KwPii5@mail.gmail.com> <AANLkTin3+PzYcQEaaxgr9_5mgDGO5oiYDyBD_2tJqCTk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 01 19:27:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5i7v-0000Fj-5o
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 19:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758523Ab1DAR1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 13:27:09 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:15151 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758437Ab1DAR1I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 13:27:08 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D032EA7EBD;
	Fri,  1 Apr 2011 19:25:11 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AC7F219F5DA;
	Fri,  1 Apr 2011 19:27:03 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTin3+PzYcQEaaxgr9_5mgDGO5oiYDyBD_2tJqCTk@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170597>

On Freitag, 1. April 2011, Erik Faye-Lund wrote:
> On Fri, Apr 1, 2011 at 11:41 AM, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
> > On Thu, Mar 31, 2011 at 8:45 PM, Jeff King <peff@peff.net> wrote:
> >> =A0 =A0 =A0 =A0kill(async->pid, 15);
> >> =A0#else
> >> - =A0 =A0 =A0 /* no clue */
> >> + =A0 =A0 =A0 pthread_cancel(async->tid);
> >
> > My worry about terminating a thread that's currently holding a mute=
x
> > (implicitly through the CRT?) still applies though...
>
> OK, I've read up on thread-cancellation, and this code seems correct.
> pthread_cancel doesn't kill the thread right away, it just signals a
> cancellation-event, which is checked for at certain
> cancellation-points. A lot of the CRT functions are defined as
> cancellation points, so it'll be a matter for us Win32-guys to
> implement pthread_testcancel() and inject that into the
> function-wrappers of the CRT functions that are marked as
> cancellation-points.

That's not going to happen. We cannot implement pthread_cancel() on Win=
dows=20
because it would have to be able to interrupt blocking system calls.=20
(TerminateThread() is a no-no, given all the caveats about leaking syst=
em=20
resources that are mentioned in the manual.)

[OK, "cannot" is a hard word. It is possible in some way, I'm sure. But=
 that=20
would mean that we implement the equivalent of Cygwin or so...]

But if I understand correctly what Jeff wrote so far, then the pthreade=
d case=20
happens to work - by chance or by design, we don't know (yet). Perhaps =
we can=20
get away with

-	/* no clue */
+	/* pthread_cancel(async->tid); not necessary */

-- Hannes
