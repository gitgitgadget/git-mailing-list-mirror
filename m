From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH v2 3/4] stripspace: Implement --count-lines option
Date: Fri, 16 Oct 2015 17:16:44 +0200
Message-ID: <1445008605-16534-4-git-send-email-tklauser@distanz.ch>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 17:17:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn6kj-000388-Vr
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 17:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbbJPPQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 11:16:58 -0400
Received: from mail.zhinst.com ([212.126.164.98]:36623 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061AbbJPPQt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 11:16:49 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Fri, 16 Oct 2015 17:16:45 +0200
X-Mailer: git-send-email 2.6.1.148.g7927db1
In-Reply-To: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279744>

Implement the --count-lines options for git stripspace to be able to
omit calling:

  git stripspace --strip-comments < infile | wc -l

e.g. in git-rebase--interactive.sh. The above command can now be
replaced by:

  git stripspace --strip-comments --count-lines < infile

This will make it easier to port git-rebase--interactive.sh to C later
on.

Furthermore, add the corresponding documentation and tests.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---

Implements the small project idea from
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#implement_.27--count-lines.27_in_.27git_stripspace.27

 Documentation/git-stripspace.txt | 14 ++++++++++++--
 builtin/stripspace.c             | 18 +++++++++++++++---
 t/t0030-stripspace.sh            | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 60328d5..79900b8 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -9,8 +9,8 @@ git-stripspace - Remove unnecessary whitespace
 SYNOPSIS
 --------
 [verse]
-'git stripspace' [-s | --strip-comments] < input
-'git stripspace' [-c | --comment-lines] < input
+'git stripspace' [-s | --strip-comments] [--count-lines] < input
+'git stripspace' [-c | --comment-lines] [--count-lines] < input
 
 DESCRIPTION
 -----------
@@ -44,6 +44,10 @@ OPTIONS
 	be terminated with a newline. On empty lines, only the comment character
 	will be prepended.
 
+--count-lines::
+	Output the number of resulting lines after stripping. This is equivalent
+	to calling 'git stripspace | wc -l'.
+
 EXAMPLES
 --------
 
@@ -88,6 +92,12 @@ Use 'git stripspace --strip-comments' to obtain:
 |The end.$
 ---------
 
+Use 'git stripspace --count-lines' to obtain:
+
+---------
+5
+---------
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index ac1ab3d..487523f 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -14,8 +14,8 @@ static void comment_lines(struct strbuf *buf)
 }
 
 static const char * const stripspace_usage[] = {
-	N_("git stripspace [-s | --strip-comments] < input"),
-	N_("git stripspace [-c | --comment-lines] < input"),
+	N_("git stripspace [-s | --strip-comments] [--count-lines] < input"),
+	N_("git stripspace [-c | --comment-lines] [--count-lines] < input"),
 	NULL
 };
 
@@ -29,6 +29,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	enum stripspace_mode mode = STRIP_DEFAULT;
+	int count_lines = 0;
 
 	const struct option options[] = {
 		OPT_CMDMODE('s', "strip-comments", &mode,
@@ -37,6 +38,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('c', "comment-lines", &mode,
 			    N_("prepend comment character and blank to each line"),
 			    COMMENT_LINES),
+		OPT_BOOL(0, "count-lines", &count_lines, N_("print line count")),
 		OPT_END()
 	};
 
@@ -54,7 +56,17 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 	else
 		comment_lines(&buf);
 
-	write_or_die(1, buf.buf, buf.len);
+	if (!count_lines)
+		write_or_die(1, buf.buf, buf.len);
+	else {
+		size_t i, lines;
+
+		for (i = lines = 0; i < buf.len; i++) {
+			if (buf.buf[i] == '\n')
+				lines++;
+		}
+		printf("%zu\n", lines);
+	}
 	strbuf_release(&buf);
 	return 0;
 }
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 29e91d8..9c00cb9 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -438,4 +438,40 @@ test_expect_success 'avoid SP-HT sequence in commented line' '
 	test_cmp expect actual
 '
 
+test_expect_success '--count-lines with newline only' '
+	printf "0\n" >expect &&
+	printf "\n" | git stripspace --count-lines >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--count-lines with single line' '
+	printf "1\n" >expect &&
+	printf "foo\n" | git stripspace --count-lines >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--count-lines with single line preceeded by empty line' '
+	printf "1\n" >expect &&
+	printf "\nfoo" | git stripspace --count-lines >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--count-lines with single line followed by empty line' '
+	printf "1\n" >expect &&
+	printf "foo\n\n" | git stripspace --count-lines >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--count-lines with multiple lines and consecutive newlines' '
+	printf "5\n" >expect &&
+	printf "\none\n\n\nthree\nfour\nfive\n" | git stripspace --count-lines >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--count-lines combined with --strip-comments' '
+	printf "5\n" >expect &&
+	printf "\n# stripped\none\n#stripped\n\nthree\nfour\nfive\n" | git stripspace -s --count-lines >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.6.1.148.g7927db1
