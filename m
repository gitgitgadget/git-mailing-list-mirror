From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH v3] blame: Add option to show author email instead of name
Date: Thu, 21 Oct 2010 13:49:22 -0700
Message-ID: <1287694162-71279-1-git-send-email-kevin@sb.org>
References: <20101021203210.GA12685@burratino>
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 22:49:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P924y-00014l-LI
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757506Ab0JUUtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:49:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59232 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0JUUte (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 16:49:34 -0400
Received: by pwj3 with SMTP id 3so92561pwj.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:49:33 -0700 (PDT)
Received: by 10.142.188.5 with SMTP id l5mr915934wff.404.1287694173694;
        Thu, 21 Oct 2010 13:49:33 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id w14sm3039865wfd.18.2010.10.21.13.49.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 13:49:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.220.g19a98
In-Reply-To: <20101021203210.GA12685@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159565>

Add a new option -e (or --show-email) to git-blame that will display
the author's email instead of name on each line.

Note that this option is supported on git-annotate, but there are no
tests ensuring this, nor is it documented. The support in git-annotate
only exists because the tests for git-blame require the -c option
and thus are really tests for git-annotate. This may change at a future
date.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
The only change here is the commit message, as requested by Jonathan Nieder.

 Documentation/git-blame.txt |    6 +++++-
 builtin/blame.c             |   28 ++++++++++++++++++++++------
 t/annotate-tests.sh         |   12 ++++++------
 t/t8002-blame.sh            |    5 +++++
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index a27f439..c71671b 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -8,7 +8,7 @@ git-blame - Show what revision and author last modified each line of a file
 SYNOPSIS
 --------
 [verse]
-'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [--incremental] [-L n,m]
+'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental] [-L n,m]
 	    [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
 	    [<rev> | --contents <file> | --reverse <rev>] [--] <file>
 
@@ -65,6 +65,10 @@ include::blame-options.txt[]
 -s::
 	Suppress the author name and timestamp from the output.
 
+-e::
+--show-email::
+	Show the author email instead of author name (Default: off).
+
 -w::
 	Ignore whitespace when comparing the parent's version and
 	the child's to find where the lines came from.
diff --git a/builtin/blame.c b/builtin/blame.c
index 1015354..df45e5c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1606,6 +1606,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 #define OUTPUT_SHOW_NUMBER	040
 #define OUTPUT_SHOW_SCORE      0100
 #define OUTPUT_NO_AUTHOR       0200
+#define OUTPUT_SHOW_EMAIL	0400
 
 static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 {
@@ -1671,12 +1672,17 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 		}
 
 		printf("%.*s", length, hex);
-		if (opt & OUTPUT_ANNOTATE_COMPAT)
-			printf("\t(%10s\t%10s\t%d)", ci.author,
+		if (opt & OUTPUT_ANNOTATE_COMPAT) {
+			const char *name;
+			if (opt & OUTPUT_SHOW_EMAIL)
+				name = ci.author_mail;
+			else
+				name = ci.author;
+			printf("\t(%10s\t%10s\t%d)", name,
 			       format_time(ci.author_time, ci.author_tz,
 					   show_raw_time),
 			       ent->lno + 1 + cnt);
-		else {
+		} else {
 			if (opt & OUTPUT_SHOW_SCORE)
 				printf(" %*d %02d",
 				       max_score_digits, ent->score,
@@ -1689,9 +1695,15 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 				       ent->s_lno + 1 + cnt);
 
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
-				int pad = longest_author - utf8_strwidth(ci.author);
+				const char *name;
+				int pad;
+				if (opt & OUTPUT_SHOW_EMAIL)
+					name = ci.author_mail;
+				else
+					name = ci.author;
+				pad = longest_author - utf8_strwidth(name);
 				printf(" (%s%*s %10s",
-				       ci.author, pad, "",
+				       name, pad, "",
 				       format_time(ci.author_time,
 						   ci.author_tz,
 						   show_raw_time));
@@ -1829,7 +1841,10 @@ static void find_alignment(struct scoreboard *sb, int *option)
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
 			suspect->commit->object.flags |= METAINFO_SHOWN;
 			get_commit_info(suspect->commit, &ci, 1);
-			num = utf8_strwidth(ci.author);
+			if (*option & OUTPUT_SHOW_EMAIL)
+				num = utf8_strwidth(ci.author_mail);
+			else
+				num = utf8_strwidth(ci.author);
 			if (longest_author < num)
 				longest_author = num;
 		}
@@ -2278,6 +2293,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('t', NULL, &output_option, "Show raw timestamp (Default: off)", OUTPUT_RAW_TIMESTAMP),
 		OPT_BIT('l', NULL, &output_option, "Show long commit SHA1 (Default: off)", OUTPUT_LONG_OBJECT_NAME),
 		OPT_BIT('s', NULL, &output_option, "Suppress author name and timestamp (Default: off)", OUTPUT_NO_AUTHOR),
+		OPT_BIT('e', "show-email", &output_option, "Show author email instead of name (Default: off)", OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, "Ignore whitespace differences", XDF_IGNORE_WHITESPACE),
 		OPT_STRING('S', NULL, &revs_file, "file", "Use revisions from <file> instead of calling git-rev-list"),
 		OPT_STRING(0, "contents", &contents_from, "file", "Use <file>'s contents as the final image"),
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 141b60c..e0e5b8a 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -39,7 +39,7 @@ test_expect_success \
     'echo "1A quick brown fox jumps over the" >file &&
      echo "lazy dog" >>file &&
      git add file
-     GIT_AUTHOR_NAME="A" git commit -a -m "Initial."'
+     GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" git commit -a -m "Initial."'
 
 test_expect_success \
     'check all lines blamed on A' \
@@ -49,7 +49,7 @@ test_expect_success \
     'Setup new lines blamed on B' \
     'echo "2A quick brown fox jumps over the" >>file &&
      echo "lazy dog" >> file &&
-     GIT_AUTHOR_NAME="B" git commit -a -m "Second."'
+     GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" git commit -a -m "Second."'
 
 test_expect_success \
     'Two lines blamed on A, two on B' \
@@ -60,7 +60,7 @@ test_expect_success \
     'git checkout -b branch1 master &&
      echo "3A slow green fox jumps into the" >> file &&
      echo "well." >> file &&
-     GIT_AUTHOR_NAME="B1" git commit -a -m "Branch1-1"'
+     GIT_AUTHOR_NAME="B1" GIT_AUTHOR_EMAIL="B1@test.git" git commit -a -m "Branch1-1"'
 
 test_expect_success \
     'Two lines blamed on A, two on B, two on B1' \
@@ -71,7 +71,7 @@ test_expect_success \
     'git checkout -b branch2 master &&
      sed -e "s/2A quick brown/4A quick brown lazy dog/" < file > file.new &&
      mv file.new file &&
-     GIT_AUTHOR_NAME="B2" git commit -a -m "Branch2-1"'
+     GIT_AUTHOR_NAME="B2" GIT_AUTHOR_EMAIL="B2@test.git" git commit -a -m "Branch2-1"'
 
 test_expect_success \
     'Two lines blamed on A, one on B, one on B2' \
@@ -105,7 +105,7 @@ test_expect_success \
 test_expect_success \
     'an incomplete line added' \
     'echo "incomplete" | tr -d "\\012" >>file &&
-    GIT_AUTHOR_NAME="C" git commit -a -m "Incomplete"'
+    GIT_AUTHOR_NAME="C" GIT_AUTHOR_EMAIL="C@test.git" git commit -a -m "Incomplete"'
 
 test_expect_success \
     'With incomplete lines.' \
@@ -119,7 +119,7 @@ test_expect_success \
 	echo
     } | sed -e "s/^3A/99/" -e "/^1A/d" -e "/^incomplete/d" > file &&
     echo "incomplete" | tr -d "\\012" >>file &&
-    GIT_AUTHOR_NAME="D" git commit -a -m "edit"'
+    GIT_AUTHOR_NAME="D" GIT_AUTHOR_EMAIL="D@test.git" git commit -a -m "edit"'
 
 test_expect_success \
     'some edit' \
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 597cf04..d3a51e1 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -6,4 +6,9 @@ test_description='git blame'
 PROG='git blame -c'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
+PROG='git blame -c -e'
+test_expect_success 'Blame --show-email works' '
+    check_count "<A@test.git>" 1 "<B@test.git>" 1 "<B1@test.git>" 1 "<B2@test.git>" 1 "<author@example.com>" 1 "<C@test.git>" 1 "<D@test.git>" 1
+'
+
 test_done
-- 
1.7.3.1.220.g19a98
