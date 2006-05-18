From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "git rev-list" be a builtin
Date: Thu, 18 May 2006 14:19:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605181415090.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu May 18 23:19:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgpu5-0007wN-Gv
	for gcvg-git@gmane.org; Thu, 18 May 2006 23:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWERVT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 17:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWERVT0
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 17:19:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751328AbWERVTZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 17:19:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4ILJLtH000532
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 May 2006 14:19:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4ILJKLK002203;
	Thu, 18 May 2006 14:19:21 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20301>


This was surprisingly easy. The diff is truly minimal: rename "main()" to 
"cmd_rev_list()" in rev-list.c, and rename the whole file to reflect its 
new built-in status.

We should have done this long ago.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

[ NOTE! The diff is a git-only "git diff -M" with rename information, 
  because quite frankly, it's just a hell of a lot more readable that way. 
  But I thought I'd mention it explicitly, since it won't apply for 
  anybody who tries to apply it as a regular unified diff with "patch" ]

 Makefile                         |    6 +++---
 rev-list.c => builtin-rev-list.c |    3 ++-
 builtin.h                        |    1 +
 git.c                            |    1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 3a28580..281fa69 100644
--- a/Makefile
+++ b/Makefile
@@ -158,7 +158,7 @@ PROGRAMS = \
 	git-ls-files$X git-ls-tree$X git-mailinfo$X git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
 	git-peek-remote$X git-prune-packed$X git-read-tree$X \
-	git-receive-pack$X git-rev-list$X git-rev-parse$X \
+	git-receive-pack$X git-rev-parse$X \
 	git-send-pack$X git-show-branch$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
 	git-ssh-upload$X git-tar-tree$X git-unpack-file$X \
@@ -170,7 +170,7 @@ PROGRAMS = \
 
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
-	git-grep$X git-add$X
+	git-grep$X git-add$X git-rev-list$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -218,7 +218,7 @@ LIB_OBJS = \
 
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
-	builtin-grep.o builtin-add.o
+	builtin-grep.o builtin-add.o builtin-rev-list.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/rev-list.c b/builtin-rev-list.c
similarity index 99%
rename from rev-list.c
rename to builtin-rev-list.c
index 235ae4c..171f9d5 100644
--- a/rev-list.c
+++ b/builtin-rev-list.c
@@ -7,6 +7,7 @@ #include "blob.h"
 #include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
+#include "builtin.h"
 
 /* bits #0-15 in revision.h */
 
@@ -291,7 +292,7 @@ static void mark_edges_uninteresting(str
 	}
 }
 
-int main(int argc, const char **argv)
+int cmd_rev_list(int argc, const char **argv, char **envp)
 {
 	struct commit_list *list;
 	int i;
diff --git a/builtin.h b/builtin.h
index ccd0e31..a94d728 100644
--- a/builtin.h
+++ b/builtin.h
@@ -26,5 +26,6 @@ extern int cmd_count_objects(int argc, c
 extern int cmd_push(int argc, const char **argv, char **envp);
 extern int cmd_grep(int argc, const char **argv, char **envp);
 extern int cmd_add(int argc, const char **argv, char **envp);
+extern int cmd_rev_list(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 6a470cf..e2bba53 100644
--- a/git.c
+++ b/git.c
@@ -52,6 +52,7 @@ static void handle_internal_command(int 
 		{ "diff", cmd_diff },
 		{ "grep", cmd_grep },
 		{ "add", cmd_add },
+		{ "rev-list", cmd_rev_list },
 	};
 	int i;
 
 rename rev-list.c => builtin-rev-list.c (99%)
