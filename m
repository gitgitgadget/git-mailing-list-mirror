From: Johan Herland <johan@herland.net>
Subject: [PATCH 15/21] Make tag names (i.e. the tag object's "tag" line)
 optional
Date: Sat, 09 Jun 2007 02:19:11 +0200
Message-ID: <200706090219.12011.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:19:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwofm-0004ct-Si
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031400AbXFIATR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbXFIATR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:19:17 -0400
Received: from smtp.getmail.no ([84.208.20.33]:49750 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S970215AbXFIATQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:19:16 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00A03E833L00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:19:15 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000RCE80ZK30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:19:12 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC009ECE80AH10@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:19:12 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49542>

The tag line is now optional. If not given in the tag object data, it
defaults to the empty string ("") in the parsed tag object.

The patch also adds a change to git-show; when asked to display a tag
object with no name (missing "tag" header), we will show the tag's sha1
instead of an empty string.

Finally the patch includes some tweaks to the selftests to make them work
with optional tag names.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-log.c    |    2 +-
 t/t3800-mktag.sh |    6 +++---
 tag.c            |   51 +++++++++++++++++++++++++++++----------------------
 tag.h            |    2 +-
 4 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 212cdfc..8a238c7 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -181,7 +181,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			printf("%stag %s%s\n\n",
 					diff_get_color(rev.diffopt.color_diff,
 						DIFF_COMMIT),
-					t->tag,
+					*(t->tag) ? t->tag : name,
 					diff_get_color(rev.diffopt.color_diff,
 						DIFF_RESET));
 			ret = show_object(o->sha1, 1);
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 3bce5e0..3381239 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -106,7 +106,7 @@ xxx mytag
 EOF
 
 cat >expect.pat <<EOF
-^error: .*char 57.*"tag ".*$
+^error: .*char 57.*$
 EOF
 
 check_verify_failure '"tag" line label check #1'
@@ -121,7 +121,7 @@ tag
 EOF
 
 cat >expect.pat <<EOF
-^error: .*char 87.*"tag ".*$
+^error: .*char 87.*$
 EOF
 
 check_verify_failure '"tag" line label check #2'
@@ -169,7 +169,7 @@ tagger a
 EOF
 
 cat >expect.pat <<EOF
-^error: .*char 67.*Could not verify tag name.*$
+^error: .*char 66.*Could not verify tag name.*$
 EOF
 
 check_verify_failure 'verify tag-name check'
diff --git a/tag.c b/tag.c
index c373c86..fb678d7 100644
--- a/tag.c
+++ b/tag.c
@@ -96,15 +96,21 @@ int parse_and_verify_tag_buffer(struct tag *item,
 		return error("Tag object (@ char 47): "
 			"Could not find \"\\ntype \"");
 
-	/* Verify mandatory tag line */
+	/* Verify optional tag line */
 	tag_line = strchr(type_line, '\n');
 	if (!tag_line++)
 		return error("Tag object (@ char " PD_FMT "): "
 			"Could not find \"\\n\" after \"type\"",
 			type_line - data);
-	if (prefixcmp(tag_line, "tag ") || tag_line[4] == '\n')
-		return error("Tag object (@ char " PD_FMT "): "
-			"Could not find \"tag \"", tag_line - data);
+	if (prefixcmp(tag_line, "tag ")) /* no tag name given */
+		tagger_line = tag_line;
+	else {                           /* tag name given */
+		tagger_line = strchr(tag_line, '\n');
+		if (!tagger_line++)
+			return error("Tag object (@ char " PD_FMT "): "
+				"Could not find \"\\n\" after \"tag\"",
+				tag_line - data);
+	}
 
 	/*
 	 * Verify mandatory tagger line, but only when we're checking
@@ -113,11 +119,6 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	 * notably the "v0.99" tag in the main git repo), and we don't
 	 * want to fail parsing on these.
 	 */
-	tagger_line = strchr(tag_line, '\n');
-	if (!tagger_line++)
-		return error("Tag object (@ char " PD_FMT "): "
-			"Could not find \"\\n\" after \"tag\"",
-			tag_line - data);
 	if (prefixcmp(tagger_line, "tagger ")) { /* no tagger given */
 		if (thorough_verify)
 			return error("Tag object (@ char " PD_FMT "): "
@@ -164,15 +165,15 @@ int parse_and_verify_tag_buffer(struct tag *item,
 				sha1_to_hex(sha1));
 
 		/* Verify tag name: disallow control characters or spaces */
-		for (i = 0;;) {
-			unsigned char c = tag_line[i++];
-			if (c == '\n')
-				break;
-			if (c > ' ')
-				continue;
-			return error("Tag object (@ char " PD_FMT "): "
-				"Could not verify tag name",
-				tag_line + i - data);
+		if (tag_len) { /* tag name was given */
+			for (i = 0; i < tag_len; ++i) {
+				unsigned char c = tag_line[i];
+				if (c > ' ' && c != 0x7f)
+					continue;
+				return error("Tag object (@ char " PD_FMT "): "
+					"Could not verify tag name",
+					tag_line + i - data);
+			}
 		}
 
 		/* Verify tagger line */
@@ -181,10 +182,16 @@ int parse_and_verify_tag_buffer(struct tag *item,
 		/* The actual stuff afterwards we don't care about.. */
 	}
 
-	if (item) {
-		item->tag = xmalloc(tag_len + 1);
-		memcpy(item->tag, tag_line, tag_len);
-		item->tag[tag_len] = '\0';
+	if (item) { /* Store parsed information into item */
+		if (tag_len) { /* optional tag name was given */
+			item->tag = xmalloc(tag_len + 1);
+			memcpy(item->tag, tag_line, tag_len);
+			item->tag[tag_len] = '\0';
+		}
+		else { /* optional tag name not given */
+			item->tag = xmalloc(1);
+			item->tag[0] = '\0';
+		}
 
 		if (!strcmp(type, blob_type)) {
 			item->tagged = &lookup_blob(sha1)->object;
diff --git a/tag.h b/tag.h
index f341b7f..2631911 100644
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
1.5.2
