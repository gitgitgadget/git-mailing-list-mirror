From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] ignore SIG{INT,QUIT} when launching editor
Date: Fri, 30 Nov 2012 17:39:43 -0500
Message-ID: <20121130223943.GA27120@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Fox <pgf@foxharp.boston.ma.us>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 23:40:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeZFa-0006Qh-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 23:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab2K3Wjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 17:39:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47978 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441Ab2K3Wjp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 17:39:45 -0500
Received: (qmail 6858 invoked by uid 107); 30 Nov 2012 22:40:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 17:40:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 17:39:43 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210947>

This is a re-roll of the pf/editor-ignore-sigint series.

There are two changes from the original:

  1. We ignore both SIGINT and SIGQUIT for "least surprise" compared to
     system(3).

  2. We now use "code + 128" to look for signal death (instead of
     WTERMSIG), as per run-command's documentation on how it munges the
     code.

People mentioned some buggy editors which go into an infinite EIO loop
when their parent dies due to SIGQUIT. That should be a non-issue now,
as we will be ignoring SIGQUIT. And even if you could replicate it
(e.g., with another signal) those programs should be (and reportedly
have been) fixed. It is not git's job to babysit its child processes.

The patches are:

  [1/5]: run-command: drop silent_exec_failure arg from wait_or_whine
  [2/5]: launch_editor: refactor to use start/finish_command
  [3/5]: launch_editor: ignore terminal signals while editor has control
  [4/5]: run-command: do not warn about child death from terminal
  [5/5]: launch_editor: propagate signals from editor to git

Since this can be thought of as "act more like system(3)", I wondered
whether the signal-ignore logic should be moved into run-command, or
even used by default for blocking calls to run_command (which are
basically our version of system(3)). But it is detrimental in the common
case that the child is not taking control of the terminal, and is just
an implementation detail (e.g., we call "git update-ref" behind the
scenes, but the user does not know or care). If they hit ^C during such
a run and we are ignoring SIGINT, then either:

  1. we will notice the child died by signal and report an
     error in the subprocess rather than just dying; the end result is
     similar, but the error is unnecessarily confusing

  2. we do not bother to check the child's return code (because we do
     not care whether the child succeeded or not, like a "gc --auto");
     we end up totally ignoring the user's request to abort the
     operation

So I do not think we care about this behavior except for launching the
editor. And the signal-propagation behavior of 5/5 is really so weirdly
editor-specific (because it is about behaving well whether the child
blocks signals or not).

-Peff
