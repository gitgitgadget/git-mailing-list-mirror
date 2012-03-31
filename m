From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Use SHELL_PATH from build system in run_command.c:prepare_shell_cmd
Date: Fri, 30 Mar 2012 21:33:21 -0400
Message-ID: <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: peff@peff.net, j.sixt@viscovery.net, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 31 04:41:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDoFd-00056A-TG
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 04:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab2CaClI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 22:41:08 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:60942 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669Ab2CaClH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 22:41:07 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:37570 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SDnBz-0000w1-4R; Fri, 30 Mar 2012 21:33:23 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SDnBz-0001ge-3D; Fri, 30 Mar 2012 21:33:23 -0400
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <7vvclmoit6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194428>

During the testing of the 1.7.10 rc series on Solaris for OpenCSW, it
was discovered that t7006-pager was failing due to finding a bad "sh"
in PATH after a call to execvp("sh", ...).  This call was setup by
run_command.c:prepare_shell_cmd.

The PATH in use at the time saw /opt/csw/bin given precedence to
traditional Solaris paths such as /usr/bin and /usr/xpg4/bin.  A
package named schilyutils (Joerg Schilling's utilities) was installed
on the build system and it delivered a modified version of the
traditional Solaris /usr/bin/sh as /opt/csw/bin/sh.  This version of
sh suffers from many of the same problems as /usr/bin/sh.

The command-specific pager test failed due to the broken "sh" handling
^ as a pipe character.  It tried to fork two processes when it
encountered "sed s/^/foo:/" as the pager command.  This problem was
entirely dependent on the PATH of the user at runtime.

Possible fixes for this issue are:

1. Use the standard system() or popen() which both launch a POSIX
   shell on Solaris as long as _POSIX_SOURCE is defined.

2. The git wrapper could prepend SANE_TOOL_PATH to PATH thus forcing
   all unqualified commands run to use the known good tools on the
   system.

3. The run_command.c:prepare_shell_command() could use the same
   SHELL_PATH that is in the #! line of all all scripts and not rely
   on PATH to find the sh to run.

Option 1 would preclude opening a bidirectional pipe to a filter
script and would also break git for Windows as cmd.exe is spawned from
system() (cf. v1.7.5-rc0~144^2, "alias: use run_command api to execute
aliases, 2011-01-07).

Option 2 is not friendly to users as it would negate their ability to
use tools of their choice in many cases.  Alternately, injecting
SANE_TOOL_PATH such that it takes precedence over /bin and /usr/bin
(and anything with lower precedence than those paths) as
git-sh-setup.sh does would not solve the problem either as the user
environment could still allow a bad sh to be found.  (Many OpenCSW
users will have /opt/csw/bin leading their PATH and some subset would
have schilyutils installed.)

Option 3 allows us to use a known good shell while still honouring the
users' PATH for the utilities being run.  Thus, it solves the problem
while not negatively impacting either users or git's ability to run
external commands in convenient ways.  Essentially, the shell is a
special case of tool that should not rely on SANE_TOOL_PATH and must
be called explicitly.

With this patch applied, any code path leading to
run_command.c:prepare_shell_cmd can count on using the same sane shell
that all shell scripts in the git suite use.  Both the build system
and run_command.c will default this shell to /bin/sh unless
overridden.

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
