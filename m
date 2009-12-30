From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] run-command: optimize out useless shell calls
Date: Wed, 30 Dec 2009 05:55:36 -0500
Message-ID: <20091230105536.GC22959@coredump.intra.peff.net>
References: <20091230095634.GA16349@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 11:55:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPwDQ-0002qM-8b
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 11:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbZL3Kzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 05:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbZL3Kzk
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 05:55:40 -0500
Received: from peff.net ([208.65.91.99]:37832 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbZL3Kzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 05:55:39 -0500
Received: (qmail 5174 invoked by uid 107); 30 Dec 2009 11:00:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Dec 2009 06:00:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2009 05:55:36 -0500
Content-Disposition: inline
In-Reply-To: <20091230095634.GA16349@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135883>

If there are no metacharacters in the program to be run, we
can just skip running the shell entirely and directly exec
the program.

The metacharacter test is pulled verbatim from
launch_editor, which already implements this optimization.

Signed-off-by: Jeff King <peff@peff.net>
---
Something inside me feels wrong with a catch-known-metacharacter test
instead of an allow-known-good check. But this is the same test we have
been using with launch_editor for some time, so I decided not to mess
with it.

 run-command.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index dc65903..22e2777 100644
--- a/run-command.c
+++ b/run-command.c
@@ -28,15 +28,17 @@ static const char **prepare_shell_cmd(const char **argv)
 	if (argc < 1)
 		die("BUG: shell command is empty");
 
-	nargv[nargc++] = "sh";
-	nargv[nargc++] = "-c";
-
-	if (argc < 2)
-		nargv[nargc++] = argv[0];
-	else {
-		struct strbuf arg0 = STRBUF_INIT;
-		strbuf_addf(&arg0, "%s \"$@\"", argv[0]);
-		nargv[nargc++] = strbuf_detach(&arg0, NULL);
+	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
+		nargv[nargc++] = "sh";
+		nargv[nargc++] = "-c";
+
+		if (argc < 2)
+			nargv[nargc++] = argv[0];
+		else {
+			struct strbuf arg0 = STRBUF_INIT;
+			strbuf_addf(&arg0, "%s \"$@\"", argv[0]);
+			nargv[nargc++] = strbuf_detach(&arg0, NULL);
+		}
 	}
 
 	for (argc = 0; argv[argc]; argc++)
-- 
1.6.6.65.g050d2.dirty
