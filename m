From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] run-command: do not warn about child death by SIGINT
Date: Sun, 11 Nov 2012 11:56:54 -0500
Message-ID: <20121111165654.GD19850@sigill.intra.peff.net>
References: <20121111163100.GB13188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:57:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXaqN-0004Bv-2t
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab2KKQ45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:56:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43970 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577Ab2KKQ45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:56:57 -0500
Received: (qmail 1150 invoked by uid 107); 11 Nov 2012 16:57:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 11:57:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 11:56:54 -0500
Content-Disposition: inline
In-Reply-To: <20121111163100.GB13188@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209406>

SIGINT is not generally an interesting signal to the user,
since it is typically caused by them hitting "^C" or
otherwise telling their terminal to send the signal.

Signed-off-by: Jeff King <peff@peff.net>
---
I thought about making this an optional parameter for run-command, but
it seems like everybody would want this (and most callsites will
complain about a failed command separately, anyway, so it is not like
errors would go unnoticed).

 run-command.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 3aae270..0527c61 100644
--- a/run-command.c
+++ b/run-command.c
@@ -242,7 +242,8 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 		error("waitpid is confused (%s)", argv0);
 	} else if (WIFSIGNALED(status)) {
 		code = WTERMSIG(status);
-		error("%s died of signal %d", argv0, code);
+		if (code != SIGINT)
+			error("%s died of signal %d", argv0, code);
 		/*
 		 * This return value is chosen so that code & 0xff
 		 * mimics the exit code that a POSIX shell would report for
-- 
1.8.0.207.gdf2154c
