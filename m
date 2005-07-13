From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-diff-*: --name-only and --name-only-z.
Date: Wed, 13 Jul 2005 12:45:51 -0700
Message-ID: <7vfyuizdzk.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050712055218.GA18192@buici.com>
	<7v7jfwbfvj.fsf@assigned-by-dhcp.cox.net>
	<20050712155316.GA5841@buici.com>
	<pan.2005.07.12.16.16.45.990714@smurf.noris.de>
	<loom.20050712T224801-163@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 22:49:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dso9l-0007qu-8d
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVGMTuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 15:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVGMTsx
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 15:48:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:59862 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262721AbVGMTpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 15:45:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050713194549.NGC19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 15:45:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <loom.20050712T224801-163@post.gmane.org> (Junio C. Hamano's message of "Tue, 12 Jul 2005 20:51:17 +0000 (UTC)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Porcelain layers often want to find only names of changed files,
and even with diff-raw output format they end up having to pick
out only the filename.  Support --name-only (and --name-only-z
for xargs -0 and cpio -0 users that want to treat filenames with
embedded newlines sanely) flag to help them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff-cache.c  |    8 ++++++++
 diff-files.c  |    4 ++++
 diff-stages.c |    4 ++++
 diff-tree.c   |    8 ++++++++
 diff.c        |   13 ++++++++++++-
 diff.h        |    2 ++
 6 files changed, 38 insertions(+), 1 deletions(-)

ea3228b62de0838cd854ecf503f6f534b0b7e25c
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -223,6 +223,14 @@ int main(int argc, const char **argv)
 			diff_output_format = DIFF_FORMAT_MACHINE;
 			continue;
 		}
+		if (!strcmp(arg, "--name-only")) {
+			diff_output_format = DIFF_FORMAT_NAME;
+			continue;
+		}
+		if (!strcmp(arg, "--name-only-z")) {
+			diff_output_format = DIFF_FORMAT_NAME_Z;
+			continue;
+		}
 		if (!strcmp(arg, "-R")) {
 			diff_setup_opt |= DIFF_SETUP_REVERSE;
 			continue;
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -55,6 +55,10 @@ int main(int argc, const char **argv)
 			; /* no-op */
 		else if (!strcmp(argv[1], "-z"))
 			diff_output_format = DIFF_FORMAT_MACHINE;
+		else if (!strcmp(argv[1], "--name-only"))
+			diff_output_format = DIFF_FORMAT_NAME;
+		else if (!strcmp(argv[1], "--name-only-z"))
+			diff_output_format = DIFF_FORMAT_NAME_Z;
 		else if (!strcmp(argv[1], "-R"))
 			diff_setup_opt |= DIFF_SETUP_REVERSE;
 		else if (!strncmp(argv[1], "-S", 2))
diff --git a/diff-stages.c b/diff-stages.c
--- a/diff-stages.c
+++ b/diff-stages.c
@@ -87,6 +87,10 @@ int main(int ac, const char **av)
 			find_copies_harder = 1;
 		else if (!strcmp(arg, "-z"))
 			diff_output_format = DIFF_FORMAT_MACHINE;
+		else if (!strcmp(arg, "--name-only"))
+			diff_output_format = DIFF_FORMAT_NAME;
+		else if (!strcmp(arg, "--name-only-z"))
+			diff_output_format = DIFF_FORMAT_NAME_Z;
 		else if (!strcmp(arg, "-R"))
 			diff_setup_opt |= DIFF_SETUP_REVERSE;
 		else if (!strncmp(arg, "-S", 2))
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -480,6 +480,14 @@ int main(int argc, const char **argv)
 			find_copies_harder = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--name-only")) {
+			diff_output_format = DIFF_FORMAT_NAME;
+			continue;
+		}
+		if (!strcmp(arg, "--name-only-z")) {
+			diff_output_format = DIFF_FORMAT_NAME_Z;
+			continue;
+		}
 		if (!strcmp(arg, "-z")) {
 			diff_output_format = DIFF_FORMAT_MACHINE;
 			continue;
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -818,6 +818,12 @@ static void diff_flush_raw(struct diff_f
 	putchar(line_termination);
 }
 
+static void diff_flush_name(struct diff_filepair *p,
+			    int line_termination)
+{
+	printf("%s%c", p->two->path, line_termination);
+}
+
 int diff_unmodified_pair(struct diff_filepair *p)
 {
 	/* This function is written stricter than necessary to support
@@ -978,7 +984,8 @@ void diff_flush(int diff_output_style)
 	int line_termination = '\n';
 	int inter_name_termination = '\t';
 
-	if (diff_output_style == DIFF_FORMAT_MACHINE)
+	if (diff_output_style == DIFF_FORMAT_MACHINE ||
+	    diff_output_style == DIFF_FORMAT_NAME_Z)
 		line_termination = inter_name_termination = 0;
 
 	for (i = 0; i < q->nr; i++) {
@@ -997,6 +1004,10 @@ void diff_flush(int diff_output_style)
 			diff_flush_raw(p, line_termination,
 				       inter_name_termination);
 			break;
+		case DIFF_FORMAT_NAME:
+		case DIFF_FORMAT_NAME_Z:
+			diff_flush_name(p, line_termination);
+			break;
 		}
 	}
 	for (i = 0; i < q->nr; i++)
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -59,6 +59,8 @@ extern int diff_queue_is_empty(void);
 #define DIFF_FORMAT_MACHINE	1
 #define DIFF_FORMAT_PATCH	2
 #define DIFF_FORMAT_NO_OUTPUT	3
+#define DIFF_FORMAT_NAME	4
+#define DIFF_FORMAT_NAME_Z	5
 
 extern void diff_flush(int output_style);
 
