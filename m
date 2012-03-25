From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 1/2] run-command.c: Define SHELL_PATH macro for use in prepare_shell_cmd
Date: Sun, 25 Mar 2012 08:31:35 -0400
Message-ID: <1332678696-4001-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Sun Mar 25 14:31:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBmbs-0000Ki-CG
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 14:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990Ab2CYMbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 08:31:42 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:46325 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709Ab2CYMbl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 08:31:41 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:60893 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SBmbj-0002Ok-1P; Sun, 25 Mar 2012 08:31:39 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SBmbi-000133-T1; Sun, 25 Mar 2012 08:31:38 -0400
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193865>

The shell spawned in run-command.c:prepare_shell_cmd was hard coded to
'sh'.  Instead, make this a macro named SHELL_PATH so that it can be
overridden by the build system.  Use 'sh' as the default to preserve
original behaviour and ensure that a value is always set.

This avoids a situation where some commands were spawned using a
different shell than the one configured at build time.  Previously, it
was possible for things to be executed by a non-POSIX shell depending
on the user's PATH.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 run-command.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1db8abf..f005a31 100644
--- a/run-command.c
+++ b/run-command.c
@@ -4,6 +4,10 @@
 #include "sigchain.h"
 #include "argv-array.h"
 
+#ifndef SHELL_PATH
+# define SHELL_PATH "sh"
+#endif
+
 struct child_to_clean {
 	pid_t pid;
 	struct child_to_clean *next;
@@ -90,7 +94,7 @@ static const char **prepare_shell_cmd(const char **argv)
 		die("BUG: shell command is empty");
 
 	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
-		nargv[nargc++] = "sh";
+		nargv[nargc++] = SHELL_PATH;
 		nargv[nargc++] = "-c";
 
 		if (argc < 2)
-- 
1.7.5.4
