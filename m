From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Use SHELL_PATH to fork commands in run_command.c:prepare_shell_cmd
Date: Mon, 26 Mar 2012 22:41:18 -0400
Message-ID: <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <20120326182427.GA10333@sigill.intra.peff.net>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 27 04:41:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCMM1-0000qK-7Q
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 04:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159Ab2C0Clo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 22:41:44 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:50418 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab2C0Cln (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 22:41:43 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:33710 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SCMLs-0001fC-Da; Mon, 26 Mar 2012 22:41:40 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SCMLs-0006zD-CI; Mon, 26 Mar 2012 22:41:40 -0400
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <20120326182427.GA10333@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193994>

The shell spawned in run-command.c:prepare_shell_cmd was hard coded to
"sh."  This was breaking "t7006-pager:command-specific pager" when the
"sh" found in the PATH happened to be a broken one such as Solaris'
/usr/bin/sh.  (The breakage in this case was due to ^ being
interpreted the same as | which was seeing two processes forked
instead of a single sed process.)

To allow the build system to supply a value that is deemed sane, thus
removing variation injected by the local user environment, define a
macro named SHELL_PATH (to match the variable of the same name in the
build system).  Use this macro instead of the literal "sh" when
preparing a set of arguments to be forked.  Set "sh" as the default
value of this macro if none is set through other means to preserve the
original behaviour.

The Makefile now sets EXTRA_CPPFLAGS to a value that includes a
definition of SHELL_PATH when building run_command.c.  This sees the
sane shell passed to run_command.c and used when forking external
commands.

Leveraging SANE_TOOL_PATH was considered here but had downsides that
may have made it an incomplete solution.  For example, some builds may
use bash as the shell and not want sh used at all.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 Makefile      |    2 ++
 run-command.c |    6 +++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index be1957a..344e2e0 100644
--- a/Makefile
+++ b/Makefile
@@ -1913,6 +1913,8 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
+run-command.o: EXTRA_CPPFLAGS = -DSHELL_PATH='"$(SHELL_PATH)"'
+
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
 	ln git$X $@ 2>/dev/null || \
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
