From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/4] Make tag names (i.e. the tag object's "tag" line) optional
Date: Sun, 10 Jun 2007 13:49:33 +0200
Message-ID: <200706101349.33280.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net>
 <200706101347.57023.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 13:49:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxLvT-000413-RL
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 13:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbXFJLtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 07:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbXFJLtm
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 07:49:42 -0400
Received: from smtp.getmail.no ([84.208.20.33]:45539 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbXFJLtl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 07:49:41 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00B0K4USWL00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:49:40 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF0053A4UL4X30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:49:33 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00KG34UL86E0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:49:33 +0200 (CEST)
In-reply-to: <200706101347.57023.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49713>

The tag line is now optional. If not given in the tag object data, it
defaults to the empty string ("") in the parsed tag object.

Also includes selftest tweaks to make them work with optional tag names.

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c          |   37 ++++++++++++++++++++-----------------
 t/t3800-mktag.sh |   16 +++++++++-------
 tag.c            |   18 ++++++++++++------
 tag.h            |    2 +-
 4 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/mktag.c b/mktag.c
index 070bc96..5e80d3d 100644
--- a/mktag.c
+++ b/mktag.c
@@ -2,16 +2,15 @@
 #include "tag.h"
 
 /*
- * A signature file has a very simple fixed format: four lines
- * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
+ * A signature file has a very simple format: 3-4 lines
+ * of "object <sha1>" + "type <typename>" + "tag <tagname>" (optional) +
  * "tagger <committer>", followed by a blank line, a free-form tag
  * message and a signature block that git itself doesn't care about,
  * but that can be verified with gpg or similar.
  *
- * The first three lines are guaranteed to be at least 63 bytes:
- * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
- * shortest possible type-line, and "tag .\n" at 6 bytes is the
- * shortest single-character-tag line.
+ * The first two lines are guaranteed to be at least 57 bytes:
+ * "object <sha1>\n" is 48 bytes and "type tag\n" at 9 bytes is the
+ * shortest possible type-line.
  *
  * We also artificially limit the size of the full object to 8kB.
  * Just because I'm a lazy bastard, and if you can't fit a signature
@@ -52,7 +51,7 @@ static int verify_tag(char *buffer, unsigned long size)
 	unsigned char sha1[20];
 	const char *object, *type_line, *tag_line, *tagger_line;
 
-	if (size < 64)
+	if (size < 58)
 		return error("wanna fool me ? you obviously got the size wrong !");
 
 	buffer[size] = 0;
@@ -75,8 +74,6 @@ static int verify_tag(char *buffer, unsigned long size)
 	if (!tag_line)
 		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - buffer);
 	tag_line++;
-	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return error("char" PD_FMT ": no \"tag \" found", tag_line - buffer);
 
 	/* Get the actual type */
 	typelen = tag_line - type_line - strlen("type \n");
@@ -91,14 +88,20 @@ static int verify_tag(char *buffer, unsigned long size)
 		return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
 
 	/* Verify the tag-name: we don't allow control characters or spaces in it */
-	tag_line += 4;
-	for (;;) {
-		unsigned char c = *tag_line++;
-		if (c == '\n')
-			break;
-		if (c > ' ')
-			continue;
-		return error("char" PD_FMT ": could not verify tag name", tag_line - buffer);
+	if (!memcmp(tag_line, "tag ", 4)) {
+		if (tag_line[4] == '\n')
+			return error("char" PD_FMT ": no \"tag \" found",
+					tag_line - buffer);
+		tag_line += 4;
+		for (;;) {
+			unsigned char c = *tag_line++;
+			if (c == '\n')
+				break;
+			if (c > ' ')
+				continue;
+			return error("char" PD_FMT ": could not verify tag name",
+					tag_line - buffer);
+		}
 	}
 
 	/* Verify the tagger line */
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 7c7e433..ca90662 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -100,13 +100,14 @@ check_verify_failure '"type" line eol check'
 #  6. tag line label check #1
 
 cat >tag.sig <<EOF
-object 779e9b33986b1c2670fff52c5067603117b3e895
-type tag
+object $head
+type commit
 xxx mytag
+tagger a
 EOF
 
 cat >expect.pat <<EOF
-^error: char57: no "tag " found$
+^error: char60: could not find "tagger"$
 EOF
 
 check_verify_failure '"tag" line label check #1'
@@ -115,13 +116,14 @@ check_verify_failure '"tag" line label check #1'
 #  7. tag line label check #2
 
 cat >tag.sig <<EOF
-object 779e9b33986b1c2670fff52c5067603117b3e895
-type taggggggggggggggggggggggggggggggg
+object $head
+type commit
 tag
+tagger a
 EOF
 
 cat >expect.pat <<EOF
-^error: char87: no "tag " found$
+^error: char60: could not find "tagger"$
 EOF
 
 check_verify_failure '"tag" line label check #2'
@@ -130,7 +132,7 @@ check_verify_failure '"tag" line label check #2'
 #  8. type line type-name length check
 
 cat >tag.sig <<EOF
-object 779e9b33986b1c2670fff52c5067603117b3e895
+object $head
 type taggggggggggggggggggggggggggggggg
 tag mytag
 EOF
diff --git a/tag.c b/tag.c
index bbacd59..a7a3454 100644
--- a/tag.c
+++ b/tag.c
@@ -44,7 +44,7 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
                 return 0;
         item->object.parsed = 1;
 
-	if (size < 64)
+	if (size < 58)
 		return -1;
 	if (memcmp("object ", data, 7) || get_sha1_hex((char *) data + 7, sha1))
 		return -1;
@@ -54,13 +54,17 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 		return -1;
 
 	tag_line = strchr(type_line, '\n');
-	if (!tag_line || memcmp("tag ", ++tag_line, 4))
+	if (!tag_line)
 		return -1;
 
-	sig_line = strchr(tag_line, '\n');
-	if (!sig_line)
-		return -1;
-	sig_line++;
+	if (!memcmp("tag ", ++tag_line, 4)) {
+		sig_line = strchr(tag_line, '\n');
+		if (!sig_line)
+			return -1;
+		sig_line++;
+	}
+	else
+		sig_line = tag_line;
 
 	typelen = tag_line - type_line - strlen("type \n");
 	if (typelen >= 20)
@@ -68,6 +72,8 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 	memcpy(type, type_line + 5, typelen);
 	type[typelen] = '\0';
 	taglen = sig_line - tag_line - strlen("tag \n");
+	if (taglen < 0) /* missing tag name */
+		taglen = 0;
 	item->tag = xmalloc(taglen + 1);
 	memcpy(item->tag, tag_line + 4, taglen);
 	item->tag[taglen] = '\0';
diff --git a/tag.h b/tag.h
index 7a0cb00..7e0abbe 100644
--- a/tag.h
+++ b/tag.h
@@ -8,7 +8,7 @@ extern const char *tag_type;
 struct tag {
 	struct object object;
 	struct object *tagged;
-	char *tag;
+	char *tag;       /* optional, may be empty ("") */
 	char *signature; /* not actually implemented */
 };
 
-- 
1.5.2.1.144.gabc40
