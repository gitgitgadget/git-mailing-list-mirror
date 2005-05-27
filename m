From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 07/12] Clean up diff_setup() to make it more extensible.
Date: Fri, 27 May 2005 15:54:37 -0700
Message-ID: <7vacmg46vm.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:53:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbnhE-0002Bc-Aq
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVE0Wy4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVE0Wy4
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:54:56 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:22237 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262649AbVE0Wyj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:54:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527225438.OUNR550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:54:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This changes the argument of diff_setup() from an integer that
says if we are feeding reversed diff to a bitmask, so that later
global options can be added more easily.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c |    6 +++---
diff-files.c |    6 +++---
diff-tree.c  |    6 +++---
diff.c       |    5 +++--
diff.h       |   12 +++++++-----
5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -5,7 +5,7 @@ static int cached_only = 0;
 static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int match_nonexisting = 0;
 static int detect_rename = 0;
-static int reverse_diff = 0;
+static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 
@@ -202,7 +202,7 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-R")) {
-			reverse_diff = 1;
+			diff_setup_opt |= DIFF_SETUP_REVERSE;
 			continue;
 		}
 		if (!strcmp(arg, "-S")) {
@@ -224,7 +224,7 @@ int main(int argc, const char **argv)
 		usage(diff_cache_usage);
 
 	/* The rest is for paths restriction. */
-	diff_setup(reverse_diff);
+	diff_setup(diff_setup_opt);
 
 	mark_merge_entries();
 
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -11,7 +11,7 @@ static const char *diff_files_usage =
 
 static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int detect_rename = 0;
-static int reverse_diff = 0;
+static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int silent = 0;
@@ -51,7 +51,7 @@ int main(int argc, const char **argv)
 		else if (!strcmp(argv[1], "-z"))
 			diff_output_format = DIFF_FORMAT_MACHINE;
 		else if (!strcmp(argv[1], "-R"))
-			reverse_diff = 1;
+			diff_setup_opt |= DIFF_SETUP_REVERSE;
 		else if (!strcmp(argv[1], "-S"))
 			pickaxe = argv[1] + 2;
 		else if (!strncmp(argv[1], "-M", 2)) {
@@ -75,7 +75,7 @@ int main(int argc, const char **argv)
 		exit(1);
 	}
 
-	diff_setup(reverse_diff);
+	diff_setup(diff_setup_opt);
 
 	for (i = 0; i < entries; i++) {
 		struct stat st;
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -10,7 +10,7 @@ static int show_tree_entry_in_recursive 
 static int read_stdin = 0;
 static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int detect_rename = 0;
-static int reverse_diff = 0;
+static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static const char *header = NULL;
@@ -255,7 +255,7 @@ static int diff_tree_sha1(const unsigned
 
 static void call_diff_setup(void)
 {
-	diff_setup(reverse_diff);
+	diff_setup(diff_setup_opt);
 }
 
 static int call_diff_flush(void)
@@ -497,7 +497,7 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-R")) {
-			reverse_diff = 1;
+			diff_setup_opt |= DIFF_SETUP_REVERSE;
 			continue;
 		}
 		if (!strcmp(arg, "-p")) {
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -492,9 +492,10 @@ static void run_diff(const char *name,
 		run_external_diff(pgm, name, other, one, two, xfrm_msg);
 }
 
-void diff_setup(int reverse_diff_)
+void diff_setup(int flags)
 {
-	reverse_diff = reverse_diff_;
+	if (flags & DIFF_SETUP_REVERSE)
+		reverse_diff = 1;
 }
 
 struct diff_queue_struct diff_queued_diff;
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -28,11 +28,8 @@ extern void diff_unmerge(const char *pat
 
 extern int diff_scoreopt_parse(const char *opt);
 
-#define DIFF_FORMAT_HUMAN	0
-#define DIFF_FORMAT_MACHINE	1
-#define DIFF_FORMAT_PATCH	2
-#define DIFF_FORMAT_NO_OUTPUT	3
-extern void diff_setup(int reverse);
+#define DIFF_SETUP_REVERSE      	1
+extern void diff_setup(int flags);
 
 #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
@@ -44,6 +41,11 @@ extern void diffcore_pathspec(const char
 
 extern int diff_queue_is_empty(void);
 
+#define DIFF_FORMAT_HUMAN	0
+#define DIFF_FORMAT_MACHINE	1
+#define DIFF_FORMAT_PATCH	2
+#define DIFF_FORMAT_NO_OUTPUT	3
+
 extern void diff_flush(int output_style, int resolve_rename_copy);
 
 #endif /* DIFF_H */
------------------------------------------------

