From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] mktag.c: tweak validation of tagger field and adjust test
 script
Date: Mon, 31 Mar 2008 18:25:23 -0500
Message-ID: <47F172E3.7010104@nrlssc.navy.mil>
References: <47F10B75.8060901@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Carlos Rica <jasampler@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 01:27:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgTOt-00033P-SN
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 01:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbYCaXZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 19:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754753AbYCaXZu
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 19:25:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59179 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713AbYCaXZt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 19:25:49 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2VNPO1h022207;
	Mon, 31 Mar 2008 18:25:25 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 31 Mar 2008 18:25:24 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47F10B75.8060901@nrlssc.navy.mil>
X-OriginalArrivalTime: 31 Mar 2008 23:25:24.0216 (UTC) FILETIME=[7ECA7F80:01C89386]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15820001
X-TM-AS-Result: : Yes--11.837000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1NzA0Mi03MDQx?=
	=?us-ascii?B?NzktNzAwMzczLTcwODc5Ny0xMDY0MjAtNzAwMTUxLTcwMDk3MC03?=
	=?us-ascii?B?MDQ0MjEtNzAwNjE4LTcwMzY1Ny03MDUzNDItNzAxNzM4LTcwMDE2?=
	=?us-ascii?B?MC0xODgwMTktNzA2MjkwLTcwMDI2NC0xMjE2MjQtNzA0NzQ3LTcw?=
	=?us-ascii?B?MDUxMS03MDE0NTUtNzAzMjgzLTEwNTI1MC03MDA4NDYtMTg4MTk5?=
	=?us-ascii?B?LTcwMzk2OS03MDc4MDAtNzAzNzIyLTE4ODE5OC03MDgyNTctMTA1?=
	=?us-ascii?B?MDQwLTcwNzY1NC03MDA2MzAtNzAwNDc2LTcwMDA3My03MDA4Mzkt?=
	=?us-ascii?B?MTQ4MDM5LTE0ODA1MS0yOTk5Nw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78611>

Updates the verify_tag function to remove an unnecessary test, and add
additional testing for angle brackets in the name and email field, and
spaces in the email field. The timestamp and timezone sections are made
more straight forward by using strspn().

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 mktag.c          |   30 +++++++++---------
 t/t3800-mktag.sh |   88 ++++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 87 insertions(+), 31 deletions(-)

diff --git a/mktag.c b/mktag.c
index 8887080..4d7583f 100644
--- a/mktag.c
+++ b/mktag.c
@@ -45,6 +45,7 @@ static int verify_tag(char *buffer, unsigned long size)
 	char type[20];
 	unsigned char sha1[20];
 	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb;
+	size_t len;
 
 	if (size < 84)
 		return error("wanna fool me ? you obviously got the size wrong !");
@@ -98,18 +99,21 @@ static int verify_tag(char *buffer, unsigned long size)
 	/* Verify the tagger line */
 	tagger_line = tag_line;
 
-	if (memcmp(tagger_line, "tagger ", 7) || (tagger_line[7] == '\n'))
+	if (memcmp(tagger_line, "tagger ", 7))
 		return error("char" PD_FMT ": could not find \"tagger \"",
 			tagger_line - buffer);
 
 	/*
 	 * Check for correct form for name and email
 	 * i.e. " <" followed by "> " on _this_ line
+	 * No angle brackets within the name or email address fields.
+	 * No spaces within the email address field.
 	 */
 	tagger_line += 7;
 	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
-		strchr(tagger_line, '\n') < rb)
-		return error("char" PD_FMT ": malformed tagger",
+		strpbrk(tagger_line, "<>\n") != lb+1 ||
+		strpbrk(lb+2, "><\n ") != rb)
+		return error("char" PD_FMT ": malformed tagger field",
 			tagger_line - buffer);
 
 	/* Check for author name, at least one character, space is acceptable */
@@ -117,25 +121,20 @@ static int verify_tag(char *buffer, unsigned long size)
 		return error("char" PD_FMT ": missing tagger name",
 			tagger_line - buffer);
 
-	/* timestamp */
+	/* timestamp, 1 or more digits followed by space*/
 	tagger_line = rb + 2;
-	if (*tagger_line == ' ')
-		return error("char" PD_FMT ": malformed tag timestamp",
+	if (!(len = strspn(tagger_line, "0123456789")))
+		return error("char" PD_FMT ": missing tag timestamp",
 			tagger_line - buffer);
-	for (;;) {
-		unsigned char c = *tagger_line++;
-		if (c == ' ')
-			break;
-		if (isdigit(c))
-			continue;
+	tagger_line += len;
+	if (*tagger_line != ' ')
 		return error("char" PD_FMT ": malformed tag timestamp",
 			tagger_line - buffer);
-	}
+	tagger_line++;
 
 	/* timezone, 5 digits [+-]hhmm, max. 1400 */
 	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
-	      isdigit(tagger_line[1]) && isdigit(tagger_line[2]) &&
-	      isdigit(tagger_line[3]) && isdigit(tagger_line[4]) &&
+	      strspn(tagger_line+1, "0123456789") == 4 &&
 	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
 		return error("char" PD_FMT ": malformed tag timezone",
 			tagger_line - buffer);
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 8a27400..df1fd6f 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -180,7 +180,7 @@ check_verify_failure '"tagger" line label check #2' \
 	'^error: char70: could not find "tagger "$'
 
 ############################################################
-# 13. detect missing tag author name
+# 13. disallow missing tag author name
 
 cat >tag.sig <<EOF
 object $head
@@ -191,11 +191,11 @@ tagger  <> 0 +0000
 This is filler
 EOF
 
-check_verify_failure 'detect missing tag author name' \
+check_verify_failure 'disallow missing tag author name' \
 	'^error: char77: missing tagger name$'
 
 ############################################################
-# 14. detect missing tag author name
+# 14. disallow missing tag author name
 
 cat >tag.sig <<EOF
 object $head
@@ -206,8 +206,8 @@ tagger T A Gger <
 
 EOF
 
-check_verify_failure 'detect malformed tagger' \
-	'^error: char77: malformed tagger$'
+check_verify_failure 'disallow malformed tagger' \
+	'^error: char77: malformed tagger field$'
 
 ############################################################
 # 15. allow empty tag email
@@ -225,7 +225,21 @@ test_expect_success \
     'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
 
 ############################################################
-# 16. detect missing tag timestamp
+# 16. disallow spaces in tag email
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tag ger@example.com> 0 +0000
+
+EOF
+
+check_verify_failure 'disallow spaces in tag email' \
+	'^error: char77: malformed tagger field$'
+
+############################################################
+# 17. disallow missing tag timestamp
 
 cat >tag.sig <<EOF
 object $head
@@ -235,11 +249,11 @@ tagger T A Gger <tagger@example.com>
 
 EOF
 
-check_verify_failure 'detect missing tag timestamp' \
-	'^error: char107: malformed tag timestamp$'
+check_verify_failure 'disallow missing tag timestamp' \
+	'^error: char107: missing tag timestamp$'
 
 ############################################################
-# 17. detect invalid tag timestamp
+# 18. detect invalid tag timestamp1
 
 cat >tag.sig <<EOF
 object $head
@@ -249,11 +263,25 @@ tagger T A Gger <tagger@example.com> Tue Mar 25 15:47:44 2008
 
 EOF
 
-check_verify_failure 'detect invalid tag timestamp' \
-	'^error: char108: malformed tag timestamp$'
+check_verify_failure 'detect invalid tag timestamp1' \
+	'^error: char107: missing tag timestamp$'
 
 ############################################################
-# 18. detect invalid tag timezone
+# 19. detect invalid tag timestamp2
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 2008-03-31T12:20:15-0500
+
+EOF
+
+check_verify_failure 'detect invalid tag timestamp2' \
+	'^error: char111: malformed tag timestamp$'
+
+############################################################
+# 20. detect invalid tag timezone1
 
 cat >tag.sig <<EOF
 object $head
@@ -263,11 +291,39 @@ tagger T A Gger <tagger@example.com> 1206478233 GMT
 
 EOF
 
-check_verify_failure 'detect invalid tag timezone' \
+check_verify_failure 'detect invalid tag timezone1' \
+	'^error: char118: malformed tag timezone$'
+
+############################################################
+# 21. detect invalid tag timezone2
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 +  30
+
+EOF
+
+check_verify_failure 'detect invalid tag timezone2' \
+	'^error: char118: malformed tag timezone$'
+
+############################################################
+# 22. detect invalid tag timezone3
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 -1430
+
+EOF
+
+check_verify_failure 'detect invalid tag timezone3' \
 	'^error: char118: malformed tag timezone$'
 
 ############################################################
-# 19. detect invalid header entry
+# 23. detect invalid header entry
 
 cat >tag.sig <<EOF
 object $head
@@ -282,7 +338,7 @@ check_verify_failure 'detect invalid header entry' \
 	'^error: char124: trailing garbage in tag header$'
 
 ############################################################
-# 20. create valid tag
+# 24. create valid tag
 
 cat >tag.sig <<EOF
 object $head
@@ -297,7 +353,7 @@ test_expect_success \
     'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
 
 ############################################################
-# 21. check mytag
+# 25. check mytag
 
 test_expect_success \
     'check mytag' \
-- 
1.5.5.rc1.12.g660b9
