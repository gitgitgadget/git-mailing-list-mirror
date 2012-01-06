From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Fri, 6 Jan 2012 10:52:04 -0500
Message-ID: <20120106155204.GA17355@sigill.intra.peff.net>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
 <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
 <20120105000713.GA24220@ecki.lan>
 <20120105025559.GB7326@sigill.intra.peff.net>
 <20120105160612.GA27251@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jan 06 16:52:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjC5W-0001iI-FH
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 16:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384Ab2AFPwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 10:52:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58738
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758750Ab2AFPwI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 10:52:08 -0500
Received: (qmail 6429 invoked by uid 107); 6 Jan 2012 15:58:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Jan 2012 10:58:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2012 10:52:04 -0500
Content-Disposition: inline
In-Reply-To: <20120105160612.GA27251@ecki.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188033>

On Thu, Jan 05, 2012 at 05:06:15PM +0100, Clemens Buchacher wrote:

> On Wed, Jan 04, 2012 at 09:55:59PM -0500, Jeff King wrote:
> > 
> > It so happens that I have just the patch you need. I've been meaning to
> > go over it again and submit it:
> > 
> >   run-command: optionally kill children on exit
> >   https://github.com/peff/git/commit/5523d7ebf2a0386c9c61d7bfbc21375041df4989
> 
> Thanks, looks great. But if I add this on top (to enable this for
> "git daemon"), then t0001 kills my entire X session. Not sure yet
> what's going.

Yikes. Thanks for noticing.

What happens is we have a failure case in start_command, set pid to -1,
and then fall through to the end of the function. So we end up marking
"-1" for cleanup, which attempts to kill all processes.

I never noticed it because it can only happen when fork() fails, or when
a child process signals an exec failure (which happens all the time with
aliases, but could not be triggered until your patch).

The fix is to move the recording of the PID up to a spot where we are
certain that it's a real PID. Fixup patch is below, and I'll push a new
version out to my github repo.

-Peff

diff --git a/run-command.c b/run-command.c
index aeb9c6e..614b722 100644
--- a/run-command.c
+++ b/run-command.c
@@ -353,6 +353,8 @@ fail_pipe:
 	if (cmd->pid < 0)
 		error("cannot fork() for %s: %s", cmd->argv[0],
 			strerror(failed_errno = errno));
+	else if (cmd->clean_on_exit)
+		mark_child_for_cleanup(cmd->pid);
 
 	/*
 	 * Wait for child's execvp. If the execvp succeeds (or if fork()
@@ -374,8 +376,6 @@ fail_pipe:
 	}
 	close(notify_pipe[0]);
 
-	if (cmd->clean_on_exit)
-		mark_child_for_cleanup(cmd->pid);
 }
 #else
 {
