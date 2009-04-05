From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 1/2] add --html-path to get the location of installed HTML docs
Date: Sun, 5 Apr 2009 03:35:43 +0200
Message-ID: <200904050335.43453.markus.heidelberg@web.de>
References: <200904050333.46453.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 03:38:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqHJE-0003dh-Jg
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 03:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbZDEBfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 21:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbZDEBfo
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 21:35:44 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:56693 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbZDEBfn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 21:35:43 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 0513CFF6B504;
	Sun,  5 Apr 2009 03:35:41 +0200 (CEST)
Received: from [89.59.94.8] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqHGu-0007JY-00; Sun, 05 Apr 2009 03:35:40 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200904050333.46453.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/xoc7CYmya0zM3OlXySygzQVw71oLh8akrhyvi
	fZ97xNGa9VLJK7yn44gRa7aGv4DJfH3jaEgN7jx+MqV4StIX9o
	ifLKxfPucB1gF4yxBBCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115617>

This can be used in GUIs to open installed HTML documentation in the
browser.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/git.txt                  |    6 +++++-
 Makefile                               |    1 +
 contrib/completion/git-completion.bash |    1 +
 exec_cmd.c                             |    6 ++++++
 git.c                                  |    5 ++++-
 perl/Git.pm                            |   12 +++++++++++-
 6 files changed, 28 insertions(+), 3 deletions(-)

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
index 7867eac..28ccad9 100644
--- a/Makefile
+++ b/Makefile
@@ -1308,6 +1308,7 @@ git.o git.spec \
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
 		'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
+		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 		'-DBINDIR="$(bindir_relative_SQ)"' \
 		'-DPREFIX="$(prefix_SQ)"' \
 		$<
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
diff --git a/exec_cmd.c b/exec_cmd.c
index 408e4e5..25e0521 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -84,6 +84,12 @@ const char *git_exec_path(void)
 	return system_path(GIT_EXEC_PATH);
 }
 
+/* Returns the location to look for git HTML documentation. */
+const char *git_html_path(void)
+{
+	return system_path(GIT_HTML_PATH);
+}
+
 static void add_path(struct strbuf *out, const char *path)
 {
 	if (path && *path) {
diff --git a/git.c b/git.c
index c2b181e..ff934bd 100644
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
+			puts(git_html_path());
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
1.6.2.2.428.gea44ab
