From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] Make fsck and fsck-objects be builtins.
Date: Mon, 29 Jan 2007 15:48:06 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrners5pm.3l6.mdw@metalzone.distorted.org.uk>
References: <20070127062826.GE14205@fieldses.org> <20070128002246.GA10179@moooo.ath.cx> <Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org> <20070128013452.GA11244@moooo.ath.cx> <Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org> <20070128233445.GD12125@fieldses.org> <Pine.LNX.4.64.0701281549070.3611@woody.linux-foundation.org> <7vsldubqof.fsf@assigned-by-dhcp.cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 29 16:48:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBYjv-0005h3-03
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 16:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXA2PsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 10:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXA2PsM
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 10:48:12 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:41420 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1750774AbXA2PsL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jan 2007 10:48:11 -0500
Received: (qmail 21634 invoked by uid 110); 29 Jan 2007 15:48:06 -0000
Received: (qmail 21618 invoked by uid 9); 29 Jan 2007 15:48:06 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1170085686 21616 172.29.199.2 (29 Jan 2007 15:48:06 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Mon, 29 Jan 2007 15:48:06 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38081>

The earlier change df391b192 to rename fsck-objects to fsck broke
fsck-objects.  This should fix it again.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---
 Makefile                 |    1 +
 fsck.c => builtin-fsck.c |    3 +--
 builtin.h                |    1 +
 git.c                    |    2 ++
 4 files changed, 5 insertions(+), 2 deletions(-)
 rename fsck.c => builtin-fsck.c (100%)

Without this, I get 

[metalzone ~/src/git]git fsck-objects
fatal: cannot handle fsck-objects internally

which isn't really very helpful.  I thought about hacking the makefile
to manufacture a hardlink from git-fsck-objects, but this just seemed so
much easier.  And we are slowly accumulating builtins, right? ;-)

diff --git a/Makefile b/Makefile
index 1552b2a..91bd665 100644
--- a/Makefile
+++ b/Makefile
@@ -284,6 +284,7 @@ BUILTIN_OBJS = \
 	builtin-diff-tree.o \
 	builtin-fmt-merge-msg.o \
 	builtin-for-each-ref.o \
+	builtin-fsck.o \
 	builtin-grep.o \
 	builtin-init-db.o \
 	builtin-log.o \
diff --git a/fsck.c b/builtin-fsck.c
similarity index 100%
rename from fsck.c
rename to builtin-fsck.c
index 558f0a6..fec1cbd 100644
--- a/fsck.c
+++ b/builtin-fsck.c
@@ -571,12 +571,11 @@ static int fsck_cache_tree(struct cache_tree *it)
 	return err;
 }
 
-int main(int argc, char **argv)
+int cmd_fsck(int argc, char **argv, const char *prefix)
 {
 	int i, heads;
 
 	track_object_refs = 1;
-	setup_git_directory();
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin.h b/builtin.h
index cfe5990..dd0e352 100644
--- a/builtin.h
+++ b/builtin.h
@@ -34,6 +34,7 @@ extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 extern int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
+extern int cmd_fsck(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index d21e5e5..fb03a54 100644
--- a/git.c
+++ b/git.c
@@ -235,6 +235,8 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 		{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
 		{ "format-patch", cmd_format_patch, RUN_SETUP },
+		{ "fsck", cmd_fsck, RUN_SETUP },
+		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP },
 		{ "help", cmd_help },
-- 
1.5.0.rc2.75.gdbaa0-dirty

-- [mdw]
