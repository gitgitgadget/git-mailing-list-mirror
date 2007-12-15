From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Retire git-runstatus for real.
Date: Fri, 14 Dec 2007 22:21:40 -0800
Message-ID: <7vve70mqa3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 07:22:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3QPl-0000gl-On
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 07:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbXLOGV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 01:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbXLOGV7
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 01:21:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbXLOGV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 01:21:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EAB3C239D;
	Sat, 15 Dec 2007 01:21:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ED9E2391;
	Sat, 15 Dec 2007 01:21:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68378>

The command was removed from the builtin command list and there was no
way to invoke it, but the code was still there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-runstatus.txt |   68 ---------------------------------------
 Makefile                        |    2 +-
 builtin-runstatus.c             |   38 ---------------------
 command-list.txt                |    1 -
 4 files changed, 1 insertions(+), 108 deletions(-)
 delete mode 100644 Documentation/git-runstatus.txt
 delete mode 100644 builtin-runstatus.c

diff --git a/Documentation/git-runstatus.txt b/Documentation/git-runstatus.txt
deleted file mode 100644
index dee5d0d..0000000
--- a/Documentation/git-runstatus.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-git-runstatus(1)
-================
-
-NAME
-----
-git-runstatus - A helper for git-status and git-commit
-
-
-SYNOPSIS
---------
-'git-runstatus' [--color|--nocolor] [--amend] [--verbose] [--untracked]
-
-
-DESCRIPTION
------------
-Examines paths in the working tree that has changes unrecorded
-to the index file, and changes between the index file and the
-current HEAD commit.  The former paths are what you _could_
-commit by running 'git add' (or 'git rm' if you are deleting) before running 'git
-commit', and the latter paths are what you _would_ commit by
-running 'git commit'.
-
-If there is no path that is different between the index file and
-the current HEAD commit, the command exits with non-zero status.
-
-Note that this is _not_ the user level command you would want to
-run from the command line.  Use 'git-status' instead.
-
-
-OPTIONS
--------
---color::
-	Show colored status, highlighting modified file names.
-
---nocolor::
-	Turn off coloring.
-
---amend::
-	Show status based on HEAD^1, not HEAD, i.e. show what
-	'git-commit --amend' would do.
-
---verbose::
-	Show unified diff of all file changes.
-
---untracked::
-	Show files in untracked directories, too.  Without this
-	option only its name and a trailing slash are displayed
-	for each untracked directory.
-
-
-OUTPUT
-------
-The output from this command is designed to be used as a commit
-template comments, and all the output lines are prefixed with '#'.
-
-
-Author
-------
-Originally written by Linus Torvalds <torvalds@osdl.org> as part
-of git-commit, and later rewritten in C by Jeff King.
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 43d6197..b9fe40b 100644
--- a/Makefile
+++ b/Makefile
@@ -933,7 +933,7 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
-builtin-revert.o builtin-runstatus.o wt-status.o: wt-status.h
+builtin-revert.o wt-status.o: wt-status.h
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
diff --git a/builtin-runstatus.c b/builtin-runstatus.c
deleted file mode 100644
index 8d167a9..0000000
--- a/builtin-runstatus.c
+++ /dev/null
@@ -1,38 +0,0 @@
-#include "builtin.h"
-#include "cache.h"
-#include "wt-status.h"
-
-extern int wt_status_use_color;
-
-static const char runstatus_usage[] =
-"git-runstatus [--color|--nocolor] [--amend] [--verbose] [--untracked]";
-
-int cmd_runstatus(int argc, const char **argv, const char *prefix)
-{
-	struct wt_status s;
-	int i;
-
-	git_config(git_status_config);
-	wt_status_prepare(&s);
-	s.prefix = prefix;
-
-	for (i = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "--color"))
-			wt_status_use_color = 1;
-		else if (!strcmp(argv[i], "--nocolor"))
-			wt_status_use_color = 0;
-		else if (!strcmp(argv[i], "--amend")) {
-			s.amend = 1;
-			s.reference = "HEAD^1";
-		}
-		else if (!strcmp(argv[i], "--verbose"))
-			s.verbose = 1;
-		else if (!strcmp(argv[i], "--untracked"))
-			s.untracked = 1;
-		else
-			usage(runstatus_usage);
-	}
-
-	wt_status_print(&s);
-	return s.commitable ? 0 : 1;
-}
diff --git a/command-list.txt b/command-list.txt
index 28342da..6c2b1d8 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -98,7 +98,6 @@ git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
 git-rm                                  mainporcelain common
-git-runstatus                           ancillaryinterrogators
 git-send-email                          foreignscminterface
 git-send-pack                           synchingrepositories
 git-shell                               synchelpers
-- 
1.5.4.rc0.1096.gcd2a6
