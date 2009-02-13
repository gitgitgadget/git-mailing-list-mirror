From: Arjen Laarhoven <arjen@yaph.org>
Subject: [PATCH 1/2] Clean up use of ANSI color sequences
Date: Fri, 13 Feb 2009 22:53:40 +0100
Message-ID: <1234562021-2397-1-git-send-email-arjen@yaph.org>
References: <7vy6wbi7gm.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 22:55:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY60B-0008SH-JH
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 22:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbZBMVxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 16:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbZBMVxr
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 16:53:47 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:4059 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbZBMVxp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 16:53:45 -0500
Received: from localhost.localdomain (aragorndsl.demon.nl [82.161.19.32])
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id n1DLrfD8081945;
	Fri, 13 Feb 2009 22:53:41 +0100 (CET)
	(envelope-from arjen@yaph.org)
X-Mailer: git-send-email 1.6.2.rc0.186.g417c
In-Reply-To: <7vy6wbi7gm.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109776>

Remove the literal ANSI escape sequences and replace them by readable
constants.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 builtin-branch.c |   10 +++++-----
 color.c          |    8 +++-----
 color.h          |   10 ++++++++++
 diff.c           |   16 ++++++++--------
 pretty.c         |    8 ++++----
 wt-status.c      |   10 +++++-----
 6 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 56a1971..fe139e1 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -32,11 +32,11 @@ static unsigned char head_sha1[20];
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
-	"\033[m",	/* reset */
-	"",		/* PLAIN (normal) */
-	"\033[31m",	/* REMOTE (red) */
-	"",		/* LOCAL (normal) */
-	"\033[32m",	/* CURRENT (green) */
+	GIT_COLOR_RESET,
+	GIT_COLOR_NORMAL,	/* PLAIN */
+	GIT_COLOR_RED,		/* REMOTE */
+	GIT_COLOR_NORMAL,	/* LOCAL */
+	GIT_COLOR_GREEN,	/* CURRENT */
 };
 enum color_branch {
 	COLOR_BRANCH_RESET = 0,
diff --git a/color.c b/color.c
index db4dccf..62977f4 100644
--- a/color.c
+++ b/color.c
@@ -1,8 +1,6 @@
 #include "cache.h"
 #include "color.h"
 
-#define COLOR_RESET "\033[m"
-
 int git_use_color_default = 0;
 
 static int parse_color(const char *name, int len)
@@ -54,7 +52,7 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 	int bg = -2;
 
 	if (!strncasecmp(value, "reset", len)) {
-		strcpy(dst, "\033[m");
+		strcpy(dst, GIT_COLOR_RESET);
 		return;
 	}
 
@@ -175,7 +173,7 @@ static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
 		r += fprintf(fp, "%s", color);
 	r += vfprintf(fp, fmt, args);
 	if (*color)
-		r += fprintf(fp, "%s", COLOR_RESET);
+		r += fprintf(fp, "%s", GIT_COLOR_RESET);
 	if (trail)
 		r += fprintf(fp, "%s", trail);
 	return r;
@@ -217,7 +215,7 @@ int color_fwrite_lines(FILE *fp, const char *color,
 		char *p = memchr(buf, '\n', count);
 		if (p != buf && (fputs(color, fp) < 0 ||
 				fwrite(buf, p ? p - buf : count, 1, fp) != 1 ||
-				fputs(COLOR_RESET, fp) < 0))
+				fputs(GIT_COLOR_RESET, fp) < 0))
 			return -1;
 		if (!p)
 			return 0;
diff --git a/color.h b/color.h
index 5019df8..6846be1 100644
--- a/color.h
+++ b/color.h
@@ -4,6 +4,16 @@
 /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
 #define COLOR_MAXLEN 24
 
+#define GIT_COLOR_NORMAL	""
+#define GIT_COLOR_RESET		"\033[m"
+#define GIT_COLOR_BOLD		"\033[1m"
+#define GIT_COLOR_RED		"\033[31m"
+#define GIT_COLOR_GREEN		"\033[32m"
+#define GIT_COLOR_YELLOW	"\033[33m"
+#define GIT_COLOR_BLUE		"\033[34m"
+#define GIT_COLOR_CYAN		"\033[36m"
+#define GIT_COLOR_BG_RED	"\033[41m"
+
 /*
  * This variable stores the value of color.ui
  */
diff --git a/diff.c b/diff.c
index a5a540f..2513a54 100644
--- a/diff.c
+++ b/diff.c
@@ -30,14 +30,14 @@ int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 
 static char diff_colors[][COLOR_MAXLEN] = {
-	"\033[m",	/* reset */
-	"",		/* PLAIN (normal) */
-	"\033[1m",	/* METAINFO (bold) */
-	"\033[36m",	/* FRAGINFO (cyan) */
-	"\033[31m",	/* OLD (red) */
-	"\033[32m",	/* NEW (green) */
-	"\033[33m",	/* COMMIT (yellow) */
-	"\033[41m",	/* WHITESPACE (red background) */
+	GIT_COLOR_RESET,
+	GIT_COLOR_NORMAL,	/* PLAIN */
+	GIT_COLOR_BOLD,		/* METAINFO */
+	GIT_COLOR_CYAN,		/* FRAGINFO */
+	GIT_COLOR_RED,		/* OLD */
+	GIT_COLOR_GREEN,	/* NEW */
+	GIT_COLOR_YELLOW,	/* COMMIT */
+	GIT_COLOR_BG_RED,	/* WHITESPACE */
 };
 
 static void diff_filespec_load_driver(struct diff_filespec *one);
diff --git a/pretty.c b/pretty.c
index cc460b5..a8595f6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -567,16 +567,16 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 			return end - placeholder + 1;
 		}
 		if (!prefixcmp(placeholder + 1, "red")) {
-			strbuf_addstr(sb, "\033[31m");
+			strbuf_addstr(sb, COLOR_RED);
 			return 4;
 		} else if (!prefixcmp(placeholder + 1, "green")) {
-			strbuf_addstr(sb, "\033[32m");
+			strbuf_addstr(sb, COLOR_GREEN);
 			return 6;
 		} else if (!prefixcmp(placeholder + 1, "blue")) {
-			strbuf_addstr(sb, "\033[34m");
+			strbuf_addstr(sb, COLOR_BLUE);
 			return 5;
 		} else if (!prefixcmp(placeholder + 1, "reset")) {
-			strbuf_addstr(sb, "\033[m");
+			strbuf_addstr(sb, COLOR_RESET);
 			return 6;
 		} else
 			return 0;
diff --git a/wt-status.c b/wt-status.c
index 96ff2f8..dd87339 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -15,11 +15,11 @@ int wt_status_relative_paths = 1;
 int wt_status_use_color = -1;
 int wt_status_submodule_summary;
 static char wt_status_colors[][COLOR_MAXLEN] = {
-	"",         /* WT_STATUS_HEADER: normal */
-	"\033[32m", /* WT_STATUS_UPDATED: green */
-	"\033[31m", /* WT_STATUS_CHANGED: red */
-	"\033[31m", /* WT_STATUS_UNTRACKED: red */
-	"\033[31m", /* WT_STATUS_NOBRANCH: red */
+	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
+	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
+	GIT_COLOR_RED,    /* WT_STATUS_CHANGED */
+	GIT_COLOR_RED,    /* WT_STATUS_UNTRACKED */
+	GIT_COLOR_RED,    /* WT_STATUS_NOBRANCH */
 };
 
 enum untracked_status_type show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
-- 
1.6.2.rc0.186.g417c
