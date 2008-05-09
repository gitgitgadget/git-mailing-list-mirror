From: drafnel@gmail.com
Subject: [PATCH 2/2] builtin-tag.c: use valid_ident for checking tagger field
Date: Fri,  9 May 2008 00:03:36 -0500
Message-ID: <9526336.1210309346451.JavaMail.teamon@b304.teamon.com>
References: <1210309416-27787-1-git-send-email-author@example.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 07:20:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuL1W-0006DQ-8D
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 07:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYEIFTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 01:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYEIFTB
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 01:19:01 -0400
Received: from mailproxy04.teamon.com ([64.14.130.33]:30636 "EHLO
	b304.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752079AbYEIFSx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 01:18:53 -0400
X-Greylist: delayed 985 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 May 2008 01:18:51 EDT
Received: from b304.teamon.com (localhost [127.0.0.1])
	by b304.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m4952Qs03532;
	Fri, 9 May 2008 05:02:26 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
In-Reply-To: <1210309416-27787-1-git-send-email-author@example.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81600>

From: Brandon Casey <drafnel@gmail.com>

Use valid_ident function for validating the tagger field
in generated tags rather than a tag specific version.

Also update tests.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin-tag.c    |   39 +++++----------------------------------
 t/t3800-mktag.sh |   14 +++++++-------
 2 files changed, 12 insertions(+), 41 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 0f79d47..2dcb795 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -339,8 +339,7 @@ static int verify_tag_buffer(const char *buffer, size_t size)
 	int typelen;
 	char type[20];
 	unsigned char sha1[20];
-	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb;
-	size_t len;
+	const char *object, *type_line, *tag_line, *tagger_line, *rb;
 
 	if (size < 84)
 		return error("wanna fool me ? you obviously got the size wrong !");
@@ -396,42 +395,14 @@ static int verify_tag_buffer(const char *buffer, size_t size)
 		return error("char" PD_FMT ": could not find \"tagger \"",
 			tagger_line - buffer);
 
-	/*
-	 * Check for correct form for name and email
-	 * i.e. " <" followed by "> " on _this_ line
-	 * No angle brackets within the name or email address fields.
-	 * No spaces within the email address field.
-	 */
+	/* Validate the tagger identity field */
 	tagger_line += 7;
-	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
-		strpbrk(tagger_line, "<>\n") != lb+1 ||
-		strpbrk(lb+2, "><\n ") != rb)
+	rb = strchr(tagger_line, '\n');
+	if (!rb || !valid_ident(tagger_line, rb - tagger_line, 0))
 		return error("char" PD_FMT ": malformed tagger field",
 			tagger_line - buffer);
 
-	/* Check for author name, at least one character, space is acceptable */
-	if (lb == tagger_line)
-		return error("char" PD_FMT ": missing tagger name",
-			tagger_line - buffer);
-
-	/* timestamp, 1 or more digits followed by space */
-	tagger_line = rb + 2;
-	if (!(len = strspn(tagger_line, "0123456789")))
-		return error("char" PD_FMT ": missing tag timestamp",
-			tagger_line - buffer);
-	tagger_line += len;
-	if (*tagger_line != ' ')
-		return error("char" PD_FMT ": malformed tag timestamp",
-			tagger_line - buffer);
-	tagger_line++;
-
-	/* timezone, 5 digits [+-]hhmm, max. 1400 */
-	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
-	      strspn(tagger_line+1, "0123456789") == 4 &&
-	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
-		return error("char" PD_FMT ": malformed tag timezone",
-			tagger_line - buffer);
-	tagger_line += 6;
+	tagger_line = rb + 1;
 
 	/* Verify the blank line separating the header from the body */
 	if (*tagger_line != '\n')
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index df1fd6f..1f62c05 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -192,7 +192,7 @@ This is filler
 EOF
 
 check_verify_failure 'disallow missing tag author name' \
-	'^error: char77: missing tagger name$'
+	'^error: char77: malformed tagger field$'
 
 ############################################################
 # 14. disallow missing tag author name
@@ -250,7 +250,7 @@ tagger T A Gger <tagger@example.com>
 EOF
 
 check_verify_failure 'disallow missing tag timestamp' \
-	'^error: char107: missing tag timestamp$'
+	'^error: char77: malformed tagger field$'
 
 ############################################################
 # 18. detect invalid tag timestamp1
@@ -264,7 +264,7 @@ tagger T A Gger <tagger@example.com> Tue Mar 25 15:47:44 2008
 EOF
 
 check_verify_failure 'detect invalid tag timestamp1' \
-	'^error: char107: missing tag timestamp$'
+	'^error: char77: malformed tagger field$'
 
 ############################################################
 # 19. detect invalid tag timestamp2
@@ -278,7 +278,7 @@ tagger T A Gger <tagger@example.com> 2008-03-31T12:20:15-0500
 EOF
 
 check_verify_failure 'detect invalid tag timestamp2' \
-	'^error: char111: malformed tag timestamp$'
+	'^error: char77: malformed tagger field$'
 
 ############################################################
 # 20. detect invalid tag timezone1
@@ -292,7 +292,7 @@ tagger T A Gger <tagger@example.com> 1206478233 GMT
 EOF
 
 check_verify_failure 'detect invalid tag timezone1' \
-	'^error: char118: malformed tag timezone$'
+	'^error: char77: malformed tagger field$'
 
 ############################################################
 # 21. detect invalid tag timezone2
@@ -306,7 +306,7 @@ tagger T A Gger <tagger@example.com> 1206478233 +  30
 EOF
 
 check_verify_failure 'detect invalid tag timezone2' \
-	'^error: char118: malformed tag timezone$'
+	'^error: char77: malformed tagger field$'
 
 ############################################################
 # 22. detect invalid tag timezone3
@@ -320,7 +320,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -1430
 EOF
 
 check_verify_failure 'detect invalid tag timezone3' \
-	'^error: char118: malformed tag timezone$'
+	'^error: char77: malformed tagger field$'
 
 ############################################################
 # 23. detect invalid header entry
-- 
1.5.5.67.g9a49
