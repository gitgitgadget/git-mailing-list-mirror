From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 8/8] grep: -W: don't extend context to trailing empty lines
Date: Sat, 28 May 2016 17:06:19 +0200
Message-ID: <5749B3EB.7090308@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <5749AF59.2070704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 17:06:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6fou-0006xN-6Z
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 17:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbcE1PG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 11:06:28 -0400
Received: from mout.web.de ([212.227.15.4]:56596 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044AbcE1PG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 11:06:27 -0400
Received: from [192.168.178.36] ([79.213.120.97]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Mbhen-1apyHJ2oy5-00J3jJ; Sat, 28 May 2016 17:06:20
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5749AF59.2070704@web.de>
X-Provags-ID: V03:K0:HalAc4uM1ih/v1jgckBcgGBf4XH4R5Kyf60gYypI4QpTHEXnHu5
 ODk+3Y8PPUw8o77+m/bBQ3W2GoJ3PPeF1jMkLYkOrtn+6z7cDDeN8wLloVREVMhGpD4i1mj
 bMtsJpcPw6vu11Nlb1LdxeUKjG2iaN7+V22zIPMD9Uwpc+WLxI1qRnD0WWpwsd1kJAc3pDx
 Y6wpGMo0WeFDScGd4Nurg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wlc71qRDiI8=:XijF5lj6b8Fdg2ynVFrSRF
 SmTU2NLRR03A3/Pc/JqEEJCkQ8IhCdxy3iUuVExkPb9SY48twcYCdsaMsyzVWBgz3b2gmCkVw
 XqTQwsPKb8yaJ/uozP9KRwml3P9nE6zstka+qVeGuVVbozHMbklJsnT/IJoWPYbdL1vD4iZcD
 bZSxpiBiZJZZWGMQ3EKCtFvvNKlXTOJXpieEcLxPdfTBOtN1dBI7jlqLe0GZNyBdol1ozMYdS
 EYA3d2SbBbEZ7YckAhcJqsByabPvsUPM7w8BcJ7zUodzrHMg0hbYmQX4UMO/PrwLgoGYJqwXH
 dXdRAjmF1iOXMPnK/A7+0LeI9WDHrejgVXre3vNbhkpPqhxuX3ziQpPy0n9ZHzhuWl43RSwnx
 CGzO8+Q7q/eRo1pLe5HG5Q0W+MZ8pU9FR5BRS19b6G9rBlTQSHXqkWHFhK/CaA9E8izprNso7
 zU2bCGi1vuufKjuz/kO+eQ83Eb9jd6U20CIbLF190SK9dWTDedt8DGGFWDdJ9LYfAdSu7T/K9
 KJUXQVYJZPI0gtYlF3kK+muhvxmaeEqwDla5GhFb8lt1at5CcnyphBdfdPYA/d7FO3wI6Pi2M
 PNkc2eCWc/vALr/3VPg69abflSYGnZVVISZy4bcZ5UfI1pDrXGb0AW8RT2KaGRoVNLMexStJv
 t6yR9l6sQE/FzmOyz0k+8cThoSbgUlIoLw2OISry/cSaLV7+4VPZcyH3+Lfyc3R9MAHeVZ+v9
 k6b1OPebfK8IpaljLpB7kEe/OzKC1qbYcJ5+D185vUvsVygCD1/dHxFhZ5NDGafSKcCeOa9G 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295826>

Empty lines between functions are shown by grep -W, as it considers them
to be part of the function preceding them.  They are not interesting in
most languages.  The previous patches stopped showing them for diff -W.

Stop showing empty lines trailing a function with grep -W.  Grep scans
the lines of a buffer from top to bottom and prints matching lines
immediately.  Thus we need to peek ahead in order to determine if an
empty line is part of a function body and worth showing or not.

Remember how far ahead we peeked in order to avoid having to do so
repeatedly when handling multiple consecutive empty lines.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 grep.c          | 28 ++++++++++++++++++++++++++--
 t/t7810-grep.sh |  2 +-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index ec6f7ff..1e15b62 100644
--- a/grep.c
+++ b/grep.c
@@ -1396,9 +1396,17 @@ static int fill_textconv_grep(struct userdiff_driver *driver,
 	return 0;
 }
 
+static int is_empty_line(const char *bol, const char *eol)
+{
+	while (bol < eol && isspace(*bol))
+		bol++;
+	return bol == eol;
+}
+
 static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int collect_hits)
 {
 	char *bol;
+	char *peek_bol = NULL;
 	unsigned long left;
 	unsigned lno = 1;
 	unsigned last_hit = 0;
@@ -1543,8 +1551,24 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 				show_function = 1;
 			goto next_line;
 		}
-		if (show_function && match_funcname(opt, gs, bol, eol))
-			show_function = 0;
+		if (show_function && (!peek_bol || peek_bol < bol)) {
+			unsigned long peek_left = left;
+			char *peek_eol = eol;
+
+			/*
+			 * Trailing empty lines are not interesting.
+			 * Peek past them to see if they belong to the
+			 * body of the current function.
+			 */
+			peek_bol = bol;
+			while (is_empty_line(peek_bol, peek_eol)) {
+				peek_bol = peek_eol + 1;
+				peek_eol = end_of_line(peek_bol, &peek_left);
+			}
+
+			if (match_funcname(opt, gs, peek_bol, peek_eol))
+				show_function = 0;
+		}
 		if (show_function ||
 		    (last_hit && lno <= last_hit + opt->post_context)) {
 			/* If the last hit is within the post context,
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 26912dc..960425a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -748,7 +748,7 @@ hello.c-#include <assert.h>
 hello.c:#include <stdio.h>
 EOF
 
-test_expect_failure 'grep -W shows no trailing empty lines' '
+test_expect_success 'grep -W shows no trailing empty lines' '
 	git grep -W stdio >actual &&
 	test_cmp expected actual
 '
-- 
2.8.3
