From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Use SHELL_PATH from build system in run_command.c:prepare_shell_cmd
Date: Wed, 28 Mar 2012 19:26:31 -0400
Message-ID: <1332977191-29069-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <20120328042215.GB30251@sigill.intra.peff.net>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: peff@peff.net, j.sixt@viscovery.net, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 29 01:27:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD2GU-0001Ik-PR
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 01:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933206Ab2C1X0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 19:26:50 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:55574 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914Ab2C1X0t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 19:26:49 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:36163 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SD2GG-0004fy-Rz; Wed, 28 Mar 2012 19:26:40 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SD2GG-0007ZN-Qg; Wed, 28 Mar 2012 19:26:40 -0400
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <20120328042215.GB30251@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194218>

During the testing of the 1.7.10 rc series on Solaris for OpenCSW, it
was discovered that t7006-pager was failing due to finding a bad "sh"
in PATH after a call to execvp("sh", ...).  This call was setup by
run_command.c:prepare_shell_cmd.

The SANE_TOOL_PATH in use at the time was lead by /opt/csw/gnu and
/opt/csw/bin as used by OpenCSW packages so that OpenCSW packaged GNU
tools are found instead of system versions.  A package named
schilyutils (Joerg Schilling's utilities) was installed on the build
system and it provided a version of the traditional Solaris
/usr/bin/sh, as /opt/csw/bin/sh.  This version of "sh" contains many
of the same problems as the traditional Solaris /usr/bin/sh.

The command-specific pager test failed due to the broken "sh" handling
^ as a pipe character.  It tried to fork two processes when it
encountered "sed s/^/foo:/" as the pager command.  This problem was
entirely dependent on the PATH of the user at runtime.

Possible fixes for this issue are:

1. Use the standard system() or popen() which both launch a POSIX
   shell on Solaris as long as _POSIX_SOURCE is defined.

2. The git wrapper could prepend SANE_TOOL_PATH to PATH for
   consistency with builtin commands.

3. The run_command.c:prepare_shell_command() could use the same
   SHELL_PATH that is in the #! line of all all scripts.

Option 1 would preclude opening a bidirectional pipe to a filter
script and would also break git for Windows as cmd.exe is spawned from
system() (cf. v1.7.5-rc0~144^2, "alias: use run_command api to execute
aliases, 2011-01-07).

Option 2 is voided by the same example that turned up this issue.
SANE_TOOL_PATH might also include 'insane' tools.

Option 3 is the best choice at this time.

After this patch, $GIT_PAGER is interpreted by the same shell in
scripted commands which use the git_pager function that uses "eval"
and builtins which use the run_command machinery.

The default shell used by commands will be /bin/sh if not overridden
by the build system.  (This allows for use of this code without the
build system, which was noted during the discussion as a good
quality.[1]) The build always system will pass the value of
SHELL_PATH, which default to /bin/sh as well.

[1] http://thread.gmane.org/gmane.comp.version-control.git/193866/focus=194018

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 Makefile      |    2 ++
 run-command.c |    6 +++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index be1957a..dea1f15 100644
--- a/Makefile
+++ b/Makefile
@@ -1913,6 +1913,8 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
+run-command.o: EXTRA_CPPFLAGS = -DSHELL_PATH='"$(SHELL_PATH_SQ)"'
+
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
 	ln git$X $@ 2>/dev/null || \
diff --git a/run-command.c b/run-command.c
index 1db8abf..2af3e0f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -4,6 +4,10 @@
 #include "sigchain.h"
 #include "argv-array.h"
 
+#ifndef SHELL_PATH
+# define SHELL_PATH "/bin/sh"
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
