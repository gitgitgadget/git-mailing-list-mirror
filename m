From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/6] grep: print context hunk marks between files
Date: Thu, 02 Jul 2009 00:03:44 +0200
Message-ID: <4A4BDD40.5040302@lsrfire.ath.cx>
References: <4A4BDC65.80504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 02 00:04:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM7uP-0003CW-Mv
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 00:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbZGAWDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 18:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbZGAWDl
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 18:03:41 -0400
Received: from india601.server4you.de ([85.25.151.105]:55654 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbZGAWDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 18:03:41 -0400
Received: from [10.0.1.101] (p57B7FA76.dip.t-dialin.net [87.183.250.118])
	by india601.server4you.de (Postfix) with ESMTPSA id C65BB2F8068;
	Thu,  2 Jul 2009 00:03:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <4A4BDC65.80504@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122605>

Print a hunk mark before matches from a new file are shown, in addition
to the current behaviour of printing them if lines have been skipped.

The result is easier to read, as (presumably unrelated) matches from
different files are separated by a hunk mark.  GNU grep does the same.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-grep.c  |   11 +++++++++++
 grep.c          |    7 ++++++-
 grep.h          |    1 +
 t/t7002-grep.sh |   22 ++++++++++++++++++++++
 4 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 73fc922..48998af 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -278,6 +278,17 @@ static int flush_grep(struct grep_opt *opt,
 		argc -= 2;
 	}
 
+	if (opt->pre_context || opt->post_context) {
+		/*
+		 * grep handles hunk marks between files, but we need to
+		 * do that ourselves between multiple calls.
+		 */
+		if (opt->show_hunk_mark)
+			write_or_die(1, "--\n", 3);
+		else
+			opt->show_hunk_mark = 1;
+	}
+
 	status = exec_grep(argc, argv);
 
 	if (kept_0) {
diff --git a/grep.c b/grep.c
index 6ee80f7..4bca759 100644
--- a/grep.c
+++ b/grep.c
@@ -491,7 +491,12 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	int rest = eol - bol;
 
 	if (opt->pre_context || opt->post_context) {
-		if (opt->last_shown && lno > opt->last_shown + 1)
+		if (opt->last_shown == 0) {
+			if (opt->show_hunk_mark)
+				fputs("--\n", stdout);
+			else
+				opt->show_hunk_mark = 1;
+		} else if (lno > opt->last_shown + 1)
 			fputs("--\n", stdout);
 	}
 	opt->last_shown = lno;
diff --git a/grep.h b/grep.h
index 0883214..730ffd6 100644
--- a/grep.h
+++ b/grep.h
@@ -85,6 +85,7 @@ struct grep_opt {
 	unsigned pre_context;
 	unsigned post_context;
 	unsigned last_shown;
+	int show_hunk_mark;
 };
 
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 7868af8..155bfdb 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -155,6 +155,28 @@ test_expect_success 'grep -e A --and --not -e B' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+y:y yy
+--
+z:zzz
+EOF
+
+# Create 1024 file names that sort between "y" and "z" to make sure
+# the two files are handled by different calls to an external grep.
+# This depends on MAXARGS in builtin-grep.c being 1024 or less.
+c32="0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v"
+test_expect_success 'grep -C1, hunk mark between files' '
+	for a in $c32; do for b in $c32; do : >y-$a$b; done; done &&
+	git add y-?? &&
+	git grep -C1 "^[yz]" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -C1 --no-ext-grep, hunk mark between files' '
+	git grep -C1 --no-ext-grep "^[yz]" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log grep setup' '
 	echo a >>file &&
 	test_tick &&
-- 
1.6.3.3
