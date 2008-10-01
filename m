From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: [PATCH v2] git grep: Add "-z/--null" option as in GNU's grep.
Date: Wed,  1 Oct 2008 18:11:15 +0200
Message-ID: <1222877475-2699-1-git-send-email-killekulla@rdrz.de>
References: <1222816390-9141-1-git-send-email-killekulla@rdrz.de>
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	madcoder@debian.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 01 18:13:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl4JY-0003Au-Ni
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 18:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbYJAQLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 12:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200AbYJAQLS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 12:11:18 -0400
Received: from rdrz.de ([217.160.107.209]:41223 "HELO rdrz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752018AbYJAQLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 12:11:17 -0400
Received: (qmail 2740 invoked by uid 89); 1 Oct 2008 16:11:16 -0000
Received: from unknown (HELO localhost.localdomain) (killekulla@127.0.0.1)
  by localhost with SMTP; 1 Oct 2008 16:11:16 -0000
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222816390-9141-1-git-send-email-killekulla@rdrz.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97245>

Here's a trivial patch that adds "-z" and "--null" options to "git
grep". It was discussed on the mailing-list that git's "-z"
convention should be used instead of GNU grep's "-Z".
So things like 'git grep -l -z "$FOO" | xargs -0 sed -i "s/$FOO/$BOO/"'
do work now.

Signed-off-by: Raphael Zimmerer <killekulla@rdrz.de>
---

Changes from first patch:
    * "-Z" -> "-z"
    * use '\0' instead of 0
Regards
  Raphael

 Documentation/git-grep.txt |    6 ++++++
 builtin-grep.c             |    8 ++++++++
 grep.c                     |   14 +++++++++++---
 grep.h                     |    1 +
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index fa4d133..553da6c 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-F | --fixed-strings] [-n]
 	   [-l | --files-with-matches] [-L | --files-without-match]
+	   [-z | --null]
 	   [-c | --count] [--all-match]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
@@ -94,6 +95,11 @@ OPTIONS
 	For better compatibility with 'git-diff', --name-only is a
 	synonym for --files-with-matches.
 
+-z::
+--null::
+	Output \0 instead of the character that normally follows a
+	file name.
+
 -c::
 --count::
 	Instead of showing every matched line, show the number of
diff --git a/builtin-grep.c b/builtin-grep.c
index 3a51662..2241324 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -295,6 +295,9 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 		push_arg("-l");
 	if (opt->unmatch_name_only)
 		push_arg("-L");
+	if (opt->null_following_name)
+		// in GNU grep git's "-z" translates to "-Z"
+		push_arg("-Z");
 	if (opt->count)
 		push_arg("-c");
 	if (opt->post_context || opt->pre_context) {
@@ -599,6 +602,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			opt.unmatch_name_only = 1;
 			continue;
 		}
+		if (!strcmp("-z", arg) ||
+		    !strcmp("--null", arg)) {
+			opt.null_following_name = 1;
+			continue;
+		}
 		if (!strcmp("-c", arg) ||
 		    !strcmp("--count", arg)) {
 			opt.count = 1;
diff --git a/grep.c b/grep.c
index 7063511..e2c190a 100644
--- a/grep.c
+++ b/grep.c
@@ -239,6 +239,8 @@ static int word_char(char ch)
 static void show_line(struct grep_opt *opt, const char *bol, const char *eol,
 		      const char *name, unsigned lno, char sign)
 {
+	if (opt->null_following_name)
+		sign = '\0';
 	if (opt->pathname)
 		printf("%s%c", name, sign);
 	if (opt->linenum)
@@ -246,6 +248,11 @@ static void show_line(struct grep_opt *opt, const char *bol, const char *eol,
 	printf("%.*s\n", (int)(eol-bol), bol);
 }
 
+static void show_name(struct grep_opt *opt, const char *name)
+{
+	printf("%s%c", name, opt->null_following_name ? '\0' : '\n');
+}
+
 static int fixmatch(const char *pattern, char *line, regmatch_t *match)
 {
 	char *hit = strstr(line, pattern);
@@ -489,7 +496,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 				return 1;
 			}
 			if (opt->name_only) {
-				printf("%s\n", name);
+				show_name(opt, name);
 				return 1;
 			}
 			/* Hit at this line.  If we haven't shown the
@@ -555,7 +562,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		return 0;
 	if (opt->unmatch_name_only) {
 		/* We did not see any hit, so we want to show this */
-		printf("%s\n", name);
+		show_name(opt, name);
 		return 1;
 	}
 
@@ -565,7 +572,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	 * make it another option?  For now suppress them.
 	 */
 	if (opt->count && count)
-		printf("%s:%u\n", name, count);
+		printf("%s%c%u\n", name,
+		       opt->null_following_name ? '\0' : ':', count);
 	return !!last_hit;
 }
 
diff --git a/grep.h b/grep.h
index 59b3f87..45a222d 100644
--- a/grep.h
+++ b/grep.h
@@ -74,6 +74,7 @@ struct grep_opt {
 	unsigned extended:1;
 	unsigned relative:1;
 	unsigned pathname:1;
+	unsigned null_following_name:1;
 	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
-- 
1.5.6.5
