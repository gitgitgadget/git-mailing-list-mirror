From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] column: Fix an incorrect parse of the 'nodense' option token
Date: Sat, 11 Feb 2012 18:41:17 +0000
Message-ID: <4F36B64D.4030000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 19:43:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwHui-0005fk-V3
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 19:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432Ab2BKSml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 13:42:41 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:51868 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300Ab2BKSmk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 13:42:40 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1RwHuA-0003hh-mw; Sat, 11 Feb 2012 18:42:39 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190528>


The parse_option() function always saw the 'nodense' token as
'dense', since it stripped the 'no' off the input argument string
earlier when checking for the presence of the 'color' token.

In order to fix the parse, we use local variables (within the loop)
initialised to the function input arguments instead, which allows
each token check to be independent.

Also, add some 'nodense' tests to t/t9002-column.sh.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Nguyen,

While writing the earlier "column: Fix some compiler and sparse warnings"
patch a few days ago, I had a feeling that a bug lurked in the parse_option()
code, but I just could not put my finger on the problem; so I just sent
what I had.

This morning I suddenly realised what was bothering me ... As a first
step, I duplicated the 'dense' tests in t9002-column.sh and changed the
'dense' token to 'nodense' and the tests still passed!

Note that the code supports the 'nocolor' token, but it is not documented
in config.txt.

If I understand correctly (and it's quite possible that I don't!), the
'nodense' token has the same meaning as the absence of the 'dense' token
(and I assume a similar comment applies to the '[no]color' tokens). If that
is the case, then maybe a better solution would be to simply remove the
'nodense' and 'nocolor' tokens. I will leave it to you to decide which
solution is more appropriate.

ATB,
Ramsay Jones

 column.c          |   13 +++++++------
 t/t9002-column.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/column.c b/column.c
index 98328cf..6df7640 100644
--- a/column.c
+++ b/column.c
@@ -313,19 +313,20 @@ static int parse_option(const char *arg, int len,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(opts); i++) {
-		int set = 1, name_len;
+		int set = 1, arg_len = len, name_len;
+		const char *arg_str = arg;
 
 		if (opts[i].type == OPTION) {
-			if (len > 2 && !strncmp(arg, "no", 2)) {
-				arg += 2;
-				len -= 2;
+			if (arg_len > 2 && !strncmp(arg_str, "no", 2)) {
+				arg_str += 2;
+				arg_len -= 2;
 				set = 0;
 			}
 		}
 
 		name_len = strlen(opts[i].name);
-		if (len != name_len ||
-		    strncmp(arg, opts[i].name, name_len))
+		if (arg_len != name_len ||
+		    strncmp(arg_str, opts[i].name, name_len))
 			continue;
 
 		switch (opts[i].type) {
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index 23d340e..fe7a30e 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -71,6 +71,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success '20 columns, nodense' '
+	cat >expected <<\EOF &&
+one    seven
+two    eight
+three  nine
+four   ten
+five   eleven
+six
+EOF
+	git column --mode=column,nodense < lista > actual &&
+	test_cmp expected actual
+'
+
 test_expect_success '20 columns, dense' '
 	cat >expected <<\EOF &&
 one   five  nine
@@ -121,6 +134,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success '20 columns, row first, nodense' '
+	cat >expected <<\EOF &&
+one    two
+three  four
+five   six
+seven  eight
+nine   ten
+eleven
+EOF
+	git column --mode=row,nodense <lista >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success '20 columns, row first, dense' '
 	cat >expected <<\EOF &&
 one   two    three
-- 
1.7.9
