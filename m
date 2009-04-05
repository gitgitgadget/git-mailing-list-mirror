From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v2 1/2] add --html-path to get the location of installed HTML docs
Date: Sun, 5 Apr 2009 04:15:16 +0200
Message-ID: <200904050415.16672.markus.heidelberg@web.de>
References: <200904050333.46453.markus.heidelberg@web.de> <200904050335.43453.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 04:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqHuk-0000hX-1V
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 04:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668AbZDECPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 22:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756650AbZDECPS
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 22:15:18 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35515 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756612AbZDECPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 22:15:16 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 77F70FC7F1C3;
	Sun,  5 Apr 2009 04:15:14 +0200 (CEST)
Received: from [89.59.94.8] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqHtC-0007lo-00; Sun, 05 Apr 2009 04:15:14 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200904050335.43453.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19uSuYEpXXfJ206XC5YKNOD0P0gJQJFYY9Ji202
	qQSEmOpZNzSXS8wVriNtI3uZ8Cmr9vmtBODPXhIr2Px1tVbdZ1
	XEzoVe7lIm+6/hawi0ZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115620>

This can be used in GUIs to open installed HTML documentation in the
browser.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

I've overseen a compiler warning due to a missing prototype. I've
removed git_html_path() and call system_path(GIT_HTML_PATH) directly
now. This wrapper is not necessary, initially I just followed the way of
how --exec-path calls git_exec_path().

 Documentation/git.txt                  |    6 +++++-
 Makefile                               |    1 +
 contrib/completion/git-completion.bash |    1 +
 git.c                                  |    5 ++++-
 perl/Git.pm                            |   12 +++++++++++-
 5 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7513c57..2ce5e6b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--exec-path[=GIT_EXEC_PATH]]
+'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]
     [-p|--paginate|--no-pager]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
     [--help] COMMAND [ARGS]
@@ -178,6 +178,10 @@ help ...`.
 	environment variable. If no path is given, 'git' will print
 	the current setting and then exit.
 
+--html-path::
+	Print the path to wherever your git HTML documentation is installed
+	and exit.
+
 -p::
 --paginate::
 	Pipe all output into 'less' (or if set, $PAGER).
diff --git a/Makefile b/Makefile
index 7867eac..bcf7cbb 100644
--- a/Makefile
+++ b/Makefile
@@ -1191,6 +1191,7 @@ strip: $(PROGRAMS) git$X
 
 git.o: git.c common-cmds.h GIT-CFLAGS
 	$(QUIET_CC)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
+		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 		$(ALL_CFLAGS) -c $(filter %.c,$^)
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e72ce24..fdc5a24 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1870,6 +1870,7 @@ _git ()
 			--bare
 			--version
 			--exec-path
+			--html-path
 			--work-tree=
 			--help
 			"
diff --git a/git.c b/git.c
index c2b181e..ff72e22 100644
--- a/git.c
+++ b/git.c
@@ -5,7 +5,7 @@
 #include "run-command.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
 const char git_more_info_string[] =
 	"See 'git help COMMAND' for more information on a specific command.";
@@ -75,6 +75,9 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 				puts(git_exec_path());
 				exit(0);
 			}
+		} else if (!strcmp(cmd, "--html-path")) {
+			puts(system_path(GIT_HTML_PATH));
+			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			use_pager = 1;
 		} else if (!strcmp(cmd, "--no-pager")) {
diff --git a/perl/Git.pm b/perl/Git.pm
index 7d7f2b1..291ff5b 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -56,7 +56,7 @@ require Exporter;
 @EXPORT_OK = qw(command command_oneline command_noisy
                 command_output_pipe command_input_pipe command_close_pipe
                 command_bidi_pipe command_close_bidi_pipe
-                version exec_path hash_object git_cmd_try
+                version exec_path html_path hash_object git_cmd_try
                 remote_refs
                 temp_acquire temp_release temp_reset temp_path);
 
@@ -492,6 +492,16 @@ C<git --exec-path>). Useful mostly only internally.
 sub exec_path { command_oneline('--exec-path') }
 
 
+=item html_path ()
+
+Return path to the Git html documentation (the same as
+C<git --html-path>). Useful mostly only internally.
+
+=cut
+
+sub html_path { command_oneline('--html-path') }
+
+
 =item repo_path ()
 
 Return path to the git repository. Must be called on a repository instance.
-- 
1.6.2.2.449.g1d936
