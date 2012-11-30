From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] run-command: do not warn about child death from terminal
Date: Fri, 30 Nov 2012 17:41:38 -0500
Message-ID: <20121130224138.GD23772@sigill.intra.peff.net>
References: <20121130223943.GA27120@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Fox <pgf@foxharp.boston.ma.us>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 23:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeZHQ-0000Iq-VA
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 23:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab2K3Wll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 17:41:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47999 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487Ab2K3Wll (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 17:41:41 -0500
Received: (qmail 7024 invoked by uid 107); 30 Nov 2012 22:42:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 17:42:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 17:41:38 -0500
Content-Disposition: inline
In-Reply-To: <20121130223943.GA27120@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210951>

SIGINT and SIGQUIT are not generally interesting signals to
the user, since they are typically caused by them hitting "^C"
or otherwise telling their terminal to send the signal.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 3aae270..757f263 100644
--- a/run-command.c
+++ b/run-command.c
@@ -242,7 +242,8 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 		error("waitpid is confused (%s)", argv0);
 	} else if (WIFSIGNALED(status)) {
 		code = WTERMSIG(status);
-		error("%s died of signal %d", argv0, code);
+		if (code != SIGINT && code != SIGQUIT)
+			error("%s died of signal %d", argv0, code);
 		/*
 		 * This return value is chosen so that code & 0xff
 		 * mimics the exit code that a POSIX shell would report for
-- 
1.8.0.1.620.g558b0aa
