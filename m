From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH] grep: fix match highlighting for combined patterns with context lines
Date: Tue, 21 Oct 2014 16:56:03 +1100
Message-ID: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 07:57:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgSRY-00054D-I5
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 07:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbaJUF5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 01:57:13 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:42776 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbaJUF5M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 01:57:12 -0400
Received: by mail-pa0-f41.google.com with SMTP id eu11so674273pac.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2014 22:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mf4ZRb6l4BOIyVBQmCjdfNupdWJwBBXsUqghFNA/CJE=;
        b=fYDvSMutyZy8+p4Ho1PWlHZnUMI7aGJrawAtDKTLTVI3nS3RjElMc4Ox6G7tUkDeoP
         /asDk1MSZX7VmTjeGagJ+Fd+VQW1JJNaS6vYuAhQ2MSaYGnoZ2ZJPSEVHMgCs9gB9h09
         K8S6NpDrLj+KFf2016sjV2vkz5he1de8hAf0FgX8241BBfErojLDEFlAhK+RUScl7Ri6
         v0AvDC64zDTBxF+bunlBJPhBnczbdS8/BK06dPdjU4D5p9PNtjxYBBn6W/jSM8koL/U5
         +FlhnIqLiFEowJmNcUu8JcxqkI6wvBnMEj8T3sk3ghZTDENcCM9SM50BrI09fotrdqjs
         ZoXg==
X-Received: by 10.66.154.10 with SMTP id vk10mr32059677pab.21.1413871031798;
        Mon, 20 Oct 2014 22:57:11 -0700 (PDT)
Received: from localhost.localdomain (202-129-81-152.perm.iinet.net.au. [202.129.81.152])
        by mx.google.com with ESMTPSA id qj2sm10690050pbc.78.2014.10.20.22.57.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 22:57:08 -0700 (PDT)
X-Mailer: git-send-email 2.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git grep is run with combined patterns such as '-e p1 --and -e p2'
and surrounding context lines are requested, the output contains
incorrectly highlighted matches.

Consider the following output (highlighted matches are surrounded by '*'
characters):
    $ cat testfile
    foo a
    foo b
    foo bar
    baz bar foo
    bar x
    bar y
    $ git grep -n -C2 -e foo --and -e bar testfile
    testfile-1-*foo* a
    testfile-2-*foo* b
    testfile:3:*foo* *bar*
    testfile:4:baz *bar* *foo*
    testfile-5-*bar* x
    testfile-6-*bar* y

Lines 1, 2, 5 and 6 do not match the combined patterns, they only
contain incorrectly highlighted 'false positives'.

Modify the show_line() function in grep.c to highlight matches only on
lines that match the combined pattern. Do not highlight matches on lines
that provide only context or contain only the function name of the match.

The output of the same command after the change:
    $ git grep -n -C2 -e foo --and -e bar testfile
    testfile-1-foo a
    testfile-2-foo b
    testfile:3:*foo* *bar*
    testfile:4:baz *bar* *foo*
    testfile-5-bar x
    testfile-6-bar y

Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
---
 grep.c          |  7 +++--
 t/t7810-grep.sh | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 4dc31ea..3c4d68e 100644
--- a/grep.c
+++ b/grep.c
@@ -1121,9 +1121,12 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		enum grep_context ctx = GREP_CONTEXT_BODY;
 		int ch = *eol;
 		int eflags = 0;
+		char *match_color = NULL;
 
-		if (sign == ':')
+		if (sign == ':') {
 			line_color = opt->color_selected;
+			match_color = opt->color_match;
+		}
 		else if (sign == '-')
 			line_color = opt->color_context;
 		else if (sign == '=')
@@ -1136,7 +1139,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 			output_color(opt, bol, match.rm_so, line_color);
 			output_color(opt, bol + match.rm_so,
 				     match.rm_eo - match.rm_so,
-				     opt->color_match);
+				     match_color);
 			bol += match.rm_eo;
 			rest -= match.rm_eo;
 			eflags = REG_NOTBOL;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 40615de..b0d6b6f 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1202,4 +1202,94 @@ test_expect_success LIBPCRE 'grep -P "^ "' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+space-line without leading space1
+space: line <RED>with <RESET>leading space1
+space: line <RED>with <RESET>leading <RED>space2<RESET>
+space: line <RED>with <RESET>leading space3
+space:line without leading <RED>space2<RESET>
+EOF
+
+test_expect_success 'grep --color -e A -e B with context' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.match		red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=always -C2 -e "with " -e space2  space |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+space-line without leading space1
+space- line with leading space1
+space: line <RED>with <RESET>leading <RED>space2<RESET>
+space- line with leading space3
+space-line without leading space2
+EOF
+
+test_expect_success 'grep --color -e A --and -e B with context' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.match		red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=always -C2 -e "with " --and -e space2  space |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+space-line without leading space1
+space: line <RED>with <RESET>leading space1
+space- line with leading space2
+space: line <RED>with <RESET>leading space3
+space-line without leading space2
+EOF
+
+test_expect_success 'grep --color -e A --and --not -e B with context' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.match		red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=always -C2 -e "with " --and --not -e space2  space |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+hello.c-#include <stdio.h>
+hello.c=int main(int argc, const char **argv)
+hello.c-{
+hello.c:	pr<RED>int<RESET>f("<RED>Hello<RESET> world.\n");
+hello.c-	return 0;
+hello.c-	/* char ?? */
+hello.c-}
+EOF
+
+test_expect_success 'grep --color -e A --and -e B -p with context' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.match		red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=always -p -C3 -e int --and -e Hello --no-index hello.c |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.1.1
