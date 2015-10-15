From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 2/3] stripspace: Implement --count-lines option
Date: Thu, 15 Oct 2015 14:18:43 +0200
Message-ID: <1444911524-14504-3-git-send-email-tklauser@distanz.ch>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 14:19:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmhV5-0001Yj-Iv
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 14:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbbJOMSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 08:18:51 -0400
Received: from mail.zhinst.com ([212.126.164.98]:35428 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbbJOMSs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 08:18:48 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Thu, 15 Oct 2015 14:18:44 +0200
X-Mailer: git-send-email 2.6.1.148.g7927db1
In-Reply-To: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279665>

As suggested in the small project ideas [1], implement a --count-lines
options for git stripspace to be able to omit calling

  git stripspace --strip-comments < infile | wc -l

e.g. in git-rebase--interactive.sh. The above command can now be
replaced by:

  git stripspace --strip-comments --count-lines < infile

This will also make it easier to port git-rebase--interactive.sh to C
later on.

Furthermore, add the corresponding documentation and tests.

[1] https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#implement_.27--count-lines.27_in_.27git_stripspace.27

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 Documentation/git-stripspace.txt | 13 ++++++++-
 builtin/stripspace.c             | 57 ++++++++++++++++++++++------------------
 strbuf.c                         | 12 ++++++---
 strbuf.h                         |  5 ++--
 t/t0030-stripspace.sh            | 36 +++++++++++++++++++++++++
 5 files changed, 92 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 60328d5..411e17c 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -9,7 +9,7 @@ git-stripspace - Remove unnecessary whitespace
 SYNOPSIS
 --------
 [verse]
-'git stripspace' [-s | --strip-comments] < input
+'git stripspace' [-s | --strip-comments] [-C | --count-lines] < input
 'git stripspace' [-c | --comment-lines] < input
 
 DESCRIPTION
@@ -44,6 +44,11 @@ OPTIONS
 	be terminated with a newline. On empty lines, only the comment character
 	will be prepended.
 
+-C::
+--count-lines::
+	Output the number of resulting lines after stripping. This is equivalent
+	to calling 'git stripspace | wc -l'.
+
 EXAMPLES
 --------
 
@@ -88,6 +93,12 @@ Use 'git stripspace --strip-comments' to obtain:
 |The end.$
 ---------
 
+Use 'git stripspace --count-lines' to obtain:
+
+---------
+|5$
+---------
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index f677093..7882edd 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "parse-options.h"
 #include "strbuf.h"
 
 static void comment_lines(struct strbuf *buf)
@@ -12,45 +13,51 @@ static void comment_lines(struct strbuf *buf)
 	free(msg);
 }
 
-static const char *usage_msg = "\n"
-"  git stripspace [-s | --strip-comments] < input\n"
-"  git stripspace [-c | --comment-lines] < input";
+static const char * const usage_msg[] = {
+	N_("git stripspace [-s | --strip-comments] [-C | --count-lines] < input"),
+	N_("git stripspace [-c | --comment-lines] < input"),
+	NULL
+};
 
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int strip_comments = 0;
-	enum { INVAL = 0, STRIP_SPACE = 1, COMMENT_LINES = 2 } mode = STRIP_SPACE;
-
-	if (argc == 2) {
-		if (!strcmp(argv[1], "-s") ||
-		    !strcmp(argv[1], "--strip-comments")) {
-			strip_comments = 1;
-		} else if (!strcmp(argv[1], "-c") ||
-			   !strcmp(argv[1], "--comment-lines")) {
-			mode = COMMENT_LINES;
-		} else {
-			mode = INVAL;
-		}
-	} else if (argc > 1) {
-		mode = INVAL;
-	}
+	int comment_mode = 0, count_lines = 0, strip_comments = 0;
+	size_t lines = 0;
+
+	const struct option options[] = {
+		OPT_BOOL('s', "strip-comments", &strip_comments,
+			 N_("skip and remove all lines starting with comment character")),
+		OPT_BOOL('c', "comment-lines", &comment_mode,
+			 N_("prepend comment character and blank to each line")),
+		OPT_BOOL('C', "count-lines", &count_lines, N_("print line count")),
+		OPT_END()
+	};
 
-	if (mode == INVAL)
-		usage(usage_msg);
+	argc = parse_options(argc, argv, prefix, options, usage_msg,
+			     PARSE_OPT_KEEP_DASHDASH);
 
-	if (strip_comments || mode == COMMENT_LINES)
+	if (comment_mode && (count_lines || strip_comments))
+		usage_with_options(usage_msg, options);
+
+	if (strip_comments || comment_mode)
 		git_config(git_default_config, NULL);
 
 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die_errno("could not read the input");
 
-	if (mode == STRIP_SPACE)
-		strbuf_stripspace(&buf, strip_comments);
+	if (!comment_mode)
+		lines = strbuf_stripspace(&buf, strip_comments);
 	else
 		comment_lines(&buf);
 
-	write_or_die(1, buf.buf, buf.len);
+	if (!count_lines)
+		write_or_die(1, buf.buf, buf.len);
+	else {
+		struct strbuf tmp = STRBUF_INIT;
+		strbuf_addf(&tmp, "%zu\n", lines);
+		write_or_die(1, tmp.buf, tmp.len);
+	}
 	strbuf_release(&buf);
 	return 0;
 }
diff --git a/strbuf.c b/strbuf.c
index 9583875..45ea933 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -775,11 +775,13 @@ static size_t cleanup(char *line, size_t len)
  *
  * Enable skip_comments to skip every line starting with comment
  * character.
+ *
+ * Returns the number of lines in the resulting strbuf.
  */
-void strbuf_stripspace(struct strbuf *sb, int skip_comments)
+size_t strbuf_stripspace(struct strbuf *sb, int skip_comments)
 {
 	int empties = 0;
-	size_t i, j, len, newlen;
+	size_t i, j, len, newlen, lines = 0;
 	char *eol;
 
 	/* We may have to add a newline. */
@@ -797,15 +799,19 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
 
 		/* Not just an empty line? */
 		if (newlen) {
-			if (empties > 0 && j > 0)
+			if (empties > 0 && j > 0) {
 				sb->buf[j++] = '\n';
+				lines++;
+			}
 			empties = 0;
 			memmove(sb->buf + j, sb->buf + i, newlen);
 			sb->buf[newlen + j++] = '\n';
+			lines++;
 		} else {
 			empties++;
 		}
 	}
 
 	strbuf_setlen(sb, j);
+	return lines;
 }
diff --git a/strbuf.h b/strbuf.h
index 5397d91..7d33f39 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -416,9 +416,10 @@ extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
 
 /**
  * Strip whitespace from a buffer. The second parameter controls if
- * comments are considered contents to be removed or not.
+ * comments are considered contents to be removed or not. Returns the
+ * number of lines in the resulting buffer.
  */
-extern void strbuf_stripspace(struct strbuf *buf, int skip_comments);
+extern size_t strbuf_stripspace(struct strbuf *buf, int skip_comments);
 
 /**
  * Temporary alias until all topic branches have switched to use
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 29e91d8..5471a5a 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -438,4 +438,40 @@ test_expect_success 'avoid SP-HT sequence in commented line' '
 	test_cmp expect actual
 '
 
+test_expect_success '--count-lines with newline only' '
+	printf "0\n" >expect &&
+	printf "\n" | git stripspace -C >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--count-lines with single line' '
+	printf "1\n" >expect &&
+	printf "foo\n" | git stripspace -C >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--count-lines with single line preceeded by empty line' '
+	printf "1\n" >expect &&
+	printf "\nfoo" | git stripspace -C >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--count-lines with single line followed by empty line' '
+	printf "1\n" >expect &&
+	printf "foo\n\n" | git stripspace -C >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--count-lines with multiple lines and consecutive newlines' '
+	printf "5\n" >expect &&
+	printf "\none\n\n\nthree\nfour\nfive\n" | git stripspace -C >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--count-lines combined with --strip-comments' '
+	printf "5\n" >expect &&
+	printf "\n# stripped\none\n#stripped\n\nthree\nfour\nfive\n" | git stripspace -s -C >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.6.1.145.gb27dacc
