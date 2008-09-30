From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: [PATCH] git grep: Add "-Z/--null" option as in GNU's grep.
Date: Wed,  1 Oct 2008 01:13:10 +0200
Message-ID: <1222816390-9141-1-git-send-email-killekulla@rdrz.de>
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 01 01:21:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkoWf-0003YB-0q
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 01:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbYI3XTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 19:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbYI3XTy
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 19:19:54 -0400
Received: from rdrz.de ([217.160.107.209]:47746 "HELO rdrz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751558AbYI3XTx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 19:19:53 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Sep 2008 19:19:53 EDT
Received: (qmail 9198 invoked by uid 89); 30 Sep 2008 23:13:11 -0000
Received: from unknown (HELO localhost.localdomain) (killekulla@127.0.0.1)
  by localhost with SMTP; 30 Sep 2008 23:13:11 -0000
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97168>

Here's a trivial patch that adds "-Z" and "--null" options to "git
grep" equal to GNU's grep.
So things like 'git grep -l -Z "$FOO" | xargs -0 sed -i "s/$FOO/$BOO/"'
are more comfortable.

Signed-off-by: Raphael Zimmerer <killekulla@rdrz.de>
---
 Documentation/git-grep.txt |    6 ++++++
 builtin-grep.c             |    7 +++++++
 grep.c                     |   14 +++++++++++---
 grep.h                     |    1 +
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index fa4d133..9317377 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-F | --fixed-strings] [-n]
 	   [-l | --files-with-matches] [-L | --files-without-match]
+	   [-Z | --null]
 	   [-c | --count] [--all-match]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
@@ -94,6 +95,11 @@ OPTIONS
 	For better compatibility with 'git-diff', --name-only is a
 	synonym for --files-with-matches.
 
+-Z::
+--null::
+	Output \0 instead of the character that normally follows a
+	file name.
+
 -c::
 --count::
 	Instead of showing every matched line, show the number of
diff --git a/builtin-grep.c b/builtin-grep.c
index 3a51662..fb2abe4 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -295,6 +295,8 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 		push_arg("-l");
 	if (opt->unmatch_name_only)
 		push_arg("-L");
+	if (opt->null_following_name)
+		push_arg("-Z");
 	if (opt->count)
 		push_arg("-c");
 	if (opt->post_context || opt->pre_context) {
@@ -599,6 +601,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			opt.unmatch_name_only = 1;
 			continue;
 		}
+		if (!strcmp("-Z", arg) ||
+		    !strcmp("--null", arg)) {
+			opt.null_following_name = 1;
+			continue;
+		}
 		if (!strcmp("-c", arg) ||
 		    !strcmp("--count", arg)) {
 			opt.count = 1;
diff --git a/grep.c b/grep.c
index 7063511..2619dbf 100644
--- a/grep.c
+++ b/grep.c
@@ -239,6 +239,8 @@ static int word_char(char ch)
 static void show_line(struct grep_opt *opt, const char *bol, const char *eol,
 		      const char *name, unsigned lno, char sign)
 {
+	if (opt->null_following_name)
+		sign = 0;
 	if (opt->pathname)
 		printf("%s%c", name, sign);
 	if (opt->linenum)
@@ -246,6 +248,11 @@ static void show_line(struct grep_opt *opt, const char *bol, const char *eol,
 	printf("%.*s\n", (int)(eol-bol), bol);
 }
 
+static void show_name(struct grep_opt *opt, const char *name)
+{
+	printf("%s%c", name, opt->null_following_name ? 0 : '\n');
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
+		       opt->null_following_name ? 0 : ':', count);
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
1.5.6.3
