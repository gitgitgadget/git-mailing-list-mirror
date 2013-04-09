From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] transport-helper: report errors properly
Date: Tue, 9 Apr 2013 17:50:19 -0400
Message-ID: <20130409215018.GA28271@sigill.intra.peff.net>
References: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
 <87ip3v1j2a.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 09 23:50:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPgR6-00027y-Dx
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 23:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936607Ab3DIVu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 17:50:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36734 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936180Ab3DIVuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 17:50:24 -0400
Received: (qmail 28073 invoked by uid 107); 9 Apr 2013 21:52:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Apr 2013 17:52:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2013 17:50:19 -0400
Content-Disposition: inline
In-Reply-To: <87ip3v1j2a.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220641>

On Tue, Apr 09, 2013 at 11:38:05PM +0200, Thomas Rast wrote:

> Two out of six of these loops quit within 1 and 2 iterations,
> respectively, both with an error along the lines of:
> 
>   expecting success: 
>           (GIT_REMOTE_TESTGIT_FAILURE=1 &&
>           export GIT_REMOTE_TESTGIT_FAILURE &&
>           cd local &&
>           test_must_fail git push --all 2> error &&
>           cat error &&
>           grep -q "Reading from remote helper failed" error
>           )
> 
>   error: fast-export died of signal 13
>   fatal: Error while running fast-export
>   not ok 21 - proper failure checks for pushing
> 
> I haven't been able to reproduce outside of valgrind tests.  Is this an
> expected issue, caused by overrunning the sleep somehow?  If so, can you
> increase the sleep delay under valgrind so as to not cause intermittent
> failures in the test suite?

Yeah, I am not too surprised. The failing helper sleeps before exiting
so that fast-export puts all of its data into the pipe buffer before the
helper dies, and does not get SIGPIPE. But obviously the sleep is just
delaying the problem if your fast-export runs really slowly (which, if
you are running under valgrind, is a possibility).

The helper should instead just consume all of fast-export's input before
exiting, which accomplishes the same thing, finishes sooner in the
normal case, and doesn't race. And I think it also simulates a
reasonable real-world setup (a helper reads and converts the data, but
then dies while writing the output to disk, the network, or whatever).

I posted review comments, including that, and I'm assuming that Felipe
is going to re-roll at some point.

-Peff
