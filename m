From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] mktag.c: improve verification of tagger field and tests
Date: Tue, 25 Mar 2008 19:40:56 -0500
Message-ID: <47E99B98.1060506@nrlssc.navy.mil>
References: <1206490795-13247-1-git-send-email-casey@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 01:41:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeJi4-0007LB-5e
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 01:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757489AbYCZAlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 20:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757442AbYCZAlA
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 20:41:00 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52204 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757423AbYCZAk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 20:40:59 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2Q0evQv023250
	for <git@vger.kernel.org>; Tue, 25 Mar 2008 19:40:57 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Mar 2008 19:40:56 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1206490795-13247-1-git-send-email-casey@nrlssc.navy.mil>
X-OriginalArrivalTime: 26 Mar 2008 00:40:56.0858 (UTC) FILETIME=[0DFA47A0:01C88EDA]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--7.645600-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMDYzMC03MDg3?=
	=?us-ascii?B?NTItNzAwNjE4LTcxMDMyNi03MDc5OTctNzEwNzE4LTcwMDgzOS03?=
	=?us-ascii?B?MDczMjEtNzAwMDc0LTcwNzY1NC03MDAxNjAtNzAxNjA0LTcwNTE3?=
	=?us-ascii?B?OC03MDEyMDItNzA2ODkxLTcwMzE1Ny03MDYxNTktNzAyNzkxLTEx?=
	=?us-ascii?B?MzI3NS03MDA4NDYtNzEwNzg0LTcwMzk2OS03MDAwNzMtMTM5NjI5?=
	=?us-ascii?B?LTcwMTY5Mi03MDM3MjAtNzAzNjU3LTcwNjk4NC03MDM3ODgtNzEw?=
	=?us-ascii?B?OTg5LTcwMTgzNy03MDk1ODQtNzA2NDU0LTcwMDYyNC03MDA4MDIt?=
	=?us-ascii?B?MTg4MDE5LTcwMDQ3Ni03MDEyMjAtNzAxNDYxLTExMzIzOC03MDc4?=
	=?us-ascii?B?MDAtMTIxNjI0LTcwNjI5MC03MDAzNzMtMTIxNzA5LTcwMDI2NC03?=
	=?us-ascii?B?MDQ3NDctNzAwNTExLTcwMTQ1NS03MDMyODMtMTA1MjUwLTcwMzcy?=
	=?us-ascii?B?Mi0xODgxOTktODM2MTAxLTcwMDA1Ny03MDUyNjktNzAzOTM4LTcw?=
	=?us-ascii?B?MjU5OC03MDE1ODgtNzA4MjU3LTcwMjUyMC03MDE5MTQtMTA1MDQw?=
	=?us-ascii?B?LTcwMDk3MC0xMDU3MDAtMTQ4MDM5LTE0ODA1MS0yOTk5Nw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78237>

Since nearly its birth, git's tags have included a "tagger" field which
describe the name of tagger, email of tagger, and date and time of tagging.
But, this field was only loosely tested by git-mktag. Provide some thorough
testing for this field and also ensure that the tag header is separated
from the tag body by an empty line to reduce the convenience of creating
a flawed tag.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Well, since I looked at this code and used it in filter-branch, I figured I
should fix the verification code for the tagger field (even though it's
probably dieing soon).

I'm thinking this utility should be fairly strict about the format it accepts.

Some assumptions:
   -tagger field has form: A U Thor <author@example.com> SSSSSSSSS [[+]hhmm]
                           where the SSSS's are the time stamp and the time
                           zone is optional
   -author name must not be empty, but can be a single space
   -author email can be empty. i.e. '<>'
   -timestamp can have leading spaces
   -time zone can have leading spaces
   -no trailing spaces e.g. after the timezone field, or after the timestamp
    when timezone is not supplied

 Should leading spaces be accepted? The rest of git seems to handle them, I'm
 not sure if there was ever anything out there that would have created a tag
 with leading spaces. Possibly a fixed width printf of the timestamp?

 Should the timezone be optional? How about the prefixed +|-?

-brandon


 mktag.c          |   70 +++++++++++++++++++++++++----
 t/t3800-mktag.sh |  129 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 185 insertions(+), 14 deletions(-)

diff --git a/mktag.c b/mktag.c
index b05260c..49f4ca1 100644
--- a/mktag.c
+++ b/mktag.c
@@ -8,10 +8,11 @@
  * message and a signature block that git itself doesn't care about,
  * but that can be verified with gpg or similar.
  *
- * The first three lines are guaranteed to be at least 63 bytes:
+ * The first four lines are guaranteed to be at least 77 bytes:
  * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
- * shortest possible type-line, and "tag .\n" at 6 bytes is the
- * shortest single-character-tag line.
+ * shortest possible type-line, "tag .\n" at 6 bytes is the shortest
+ * single-character-tag line, and "tagger . <> 0\n" at 14 bytes is
+ * the shortest possible tagger-line.
  */
 
 /*
@@ -43,9 +44,9 @@ static int verify_tag(char *buffer, unsigned long size)
 	int typelen;
 	char type[20];
 	unsigned char sha1[20];
-	const char *object, *type_line, *tag_line, *tagger_line;
+	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb;
 
-	if (size < 64)
+	if (size < 78)
 		return error("wanna fool me ? you obviously got the size wrong !");
 
 	buffer[size] = 0;
@@ -96,12 +97,63 @@ static int verify_tag(char *buffer, unsigned long size)
 
 	/* Verify the tagger line */
 	tagger_line = tag_line;
+	if (memcmp(tagger_line, "tagger ", 7) || (tagger_line[7] == '\n'))
+		return error("char" PD_FMT ": could not find \"tagger \"",
+			tagger_line - buffer);
+
+	/*
+	 * Check for correct form for name and email
+	 * i.e. " <" followed by "> " on _this_ line
+	 */
+	tagger_line += 7;
+	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb, "> ")) ||
+		strchr(tagger_line, '\n') < rb)
+		return error("char" PD_FMT ": malformed tagger",
+			tagger_line - buffer);
+
+	/* Check for author name, at least one character, space is acceptable */
+	if (lb == tagger_line)
+		return error("char" PD_FMT ": missing tagger name",
+			tagger_line - buffer);
+
+	/* timestamp */
+	tagger_line = rb + 2;
+	while (*tagger_line == ' ')
+		tagger_line++;
+	if (*tagger_line == '\n')
+		return error("char" PD_FMT ": missing tag timestamp",
+			tagger_line - buffer);
+	for (;;) {
+		unsigned char c = *tagger_line++;
+		if (c == ' ' || c == '\n')
+			break;
+		if (c >= '0' && c <= '9')
+			continue;
+		return error("char" PD_FMT ": malformed tag timestamp",
+			tagger_line - buffer);
+	}
 
-	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
-		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - buffer);
+	/* optional timezone, 4 digits hhmm with optional leading +|- */
+	if (tagger_line[-1] != '\n') {
+		while (*tagger_line == ' ')
+			tagger_line++;
+		if ((*tagger_line == '+' || *tagger_line == '-') &&
+			tagger_line[1] != '\n')
+			tagger_line++;
+		if (!(tagger_line[0] >= '0' && tagger_line[0] <= '9' &&
+		      tagger_line[1] >= '0' && tagger_line[1] <= '9' &&
+		      tagger_line[2] >= '0' && tagger_line[2] <= '5' &&
+		      tagger_line[3] >= '0' && tagger_line[3] <= '9' &&
+		      tagger_line[4] == '\n'))
+			return error("char" PD_FMT ": malformed tag timezone",
+				tagger_line - buffer);
+		tagger_line += 5;
+	}
 
-	/* TODO: check for committer info + blank line? */
-	/* Also, the minimum length is probably + "tagger .", or 63+8=71 */
+	/* Verify the blank line separating the header from the body */
+	if (*tagger_line != '\n')
+		return error("char" PD_FMT ": trailing garbage in tag header",
+			tagger_line - buffer);
 
 	/* The actual stuff afterwards we don't care about.. */
 	return 0;
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index bdc6e13..0098389 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -44,6 +44,8 @@ cat >tag.sig <<EOF
 xxxxxx 139e9b33986b1c2670fff52c5067603117b3e895
 type tag
 tag mytag
+tagger . <> 0
+
 EOF
 
 check_verify_failure '"object" line label check' '^error: char0: .*"object "$'
@@ -55,6 +57,8 @@ cat >tag.sig <<EOF
 object zz9e9b33986b1c2670fff52c5067603117b3e895
 type tag
 tag mytag
+tagger . <> 0
+
 EOF
 
 check_verify_failure '"object" line SHA1 check' '^error: char7: .*SHA1 hash$'
@@ -66,6 +70,8 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 xxxx tag
 tag mytag
+tagger . <> 0
+
 EOF
 
 check_verify_failure '"type" line label check' '^error: char47: .*"\\ntype "$'
@@ -85,6 +91,8 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type tag
 xxx mytag
+tagger . <> 0
+
 EOF
 
 check_verify_failure '"tag" line label check #1' \
@@ -121,6 +129,8 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type tagggg
 tag mytag
+tagger . <> 0
+
 EOF
 
 check_verify_failure 'verify object (SHA1/type) check' \
@@ -133,6 +143,8 @@ cat >tag.sig <<EOF
 object $head
 type commit
 tag my	tag
+tagger . <> 0
+
 EOF
 
 check_verify_failure 'verify tag-name check' \
@@ -145,10 +157,12 @@ cat >tag.sig <<EOF
 object $head
 type commit
 tag mytag
+
+This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #1' \
-	'^error: char70: could not find "tagger"$'
+	'^error: char70: could not find "tagger "$'
 
 ############################################################
 # 12. tagger line label check #2
@@ -158,19 +172,124 @@ object $head
 type commit
 tag mytag
 tagger
+
+This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #2' \
-	'^error: char70: could not find "tagger"$'
+	'^error: char70: could not find "tagger "$'
 
 ############################################################
-# 13. create valid tag
+# 13. detect missing tag author name
 
 cat >tag.sig <<EOF
 object $head
 type commit
 tag mytag
-tagger another@example.com
+tagger  <> 0
+
+This is filler
+EOF
+
+check_verify_failure 'detect missing tag author name' \
+	'^error: char77: missing tagger name$'
+
+############################################################
+# 14. detect missing tag author name
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <
+ > 0
+
+EOF
+
+check_verify_failure 'detect malformed tagger' \
+	'^error: char77: malformed tagger$'
+
+############################################################
+# 15. allow empty tag email
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <> 0
+
+EOF
+
+test_expect_success \
+    'allow empty tag email' \
+    'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
+
+############################################################
+# 16. detect missing tag timestamp
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 
+
+EOF
+
+check_verify_failure 'detect missing tag timestamp' \
+	'^error: char107: missing tag timestamp$'
+
+############################################################
+# 17. detect invalid tag timestamp
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> Tue Mar 25 15:47:44 2008
+
+EOF
+
+check_verify_failure 'detect invalid tag timestamp' \
+	'^error: char108: malformed tag timestamp$'
+
+############################################################
+# 18. detect invalid tag timezone
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 GMT
+
+EOF
+
+check_verify_failure 'detect invalid tag timezone' \
+	'^error: char118: malformed tag timezone$'
+
+############################################################
+# 19. detect invalid header entry
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 -0500
+this line should not be here
+
+EOF
+
+check_verify_failure 'detect invalid header entry' \
+	'^error: char124: trailing garbage in tag header$'
+
+############################################################
+# 20. create valid tag
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 -0500
+
 EOF
 
 test_expect_success \
@@ -178,7 +297,7 @@ test_expect_success \
     'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
 
 ############################################################
-# 14. check mytag
+# 21. check mytag
 
 test_expect_success \
     'check mytag' \
-- 
1.5.4.4.481.g5075
