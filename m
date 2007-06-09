From: Johan Herland <johan@herland.net>
Subject: [PATCH 14/21] Add proper parsing of "tagger" line,
 but only when thorough_verify is set
Date: Sat, 09 Jun 2007 02:18:41 +0200
Message-ID: <200706090218.41941.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:18:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwofJ-0004X8-3i
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S970099AbXFIASs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbXFIASs
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:18:48 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35090 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968173AbXFIASr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:18:47 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00A03E7A0H00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:18:46 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000RTE76CP20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:18:42 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC00FADE75RBG0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:18:42 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49541>

Be explicit about the fact that the "tagger" line is now considered a
mandatory part of the tag object. There are however old tags (from before
July 2005) that don't have a "tagger" line. We therefore consider the
"tagger" line _optional_ when parsing tags without thorough_verify set.

In practice this means that verification of a missing "tagger" line will
only fail when adding or fsck-ing tags.

Signed-off-by: Johan Herland <johan@herland.net>
---
 tag.c |   48 ++++++++++++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/tag.c b/tag.c
index 9a6924f..c373c86 100644
--- a/tag.c
+++ b/tag.c
@@ -69,8 +69,9 @@ int parse_and_verify_tag_buffer(struct tag *item,
 
 	unsigned char sha1[20];
 	char type[20];
-	const char *type_line, *tag_line, *tagger_line;
-	unsigned long type_len, tag_len;
+	const char   *type_line, *tag_line, *tagger_line;
+	unsigned long type_len,   tag_len,   tagger_len;
+	const char *header_end;
 
 	if (item) {
 		if (item->object.parsed)
@@ -81,7 +82,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	if (size < 64)
 		return error("Tag object failed preliminary size check");
 
-	/* Verify object line */
+	/* Verify mandatory object line */
 	if (prefixcmp(data, "object "))
 		return error("Tag object (@ char 0): "
 			"Does not start with \"object \"");
@@ -89,13 +90,13 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	if (get_sha1_hex(data + 7, sha1))
 		return error("Tag object (@ char 7): Could not get SHA1 hash");
 
-	/* Verify type line */
+	/* Verify mandatory type line */
 	type_line = data + 48;
 	if (prefixcmp(type_line - 1, "\ntype "))
 		return error("Tag object (@ char 47): "
 			"Could not find \"\\ntype \"");
 
-	/* Verify tag-line */
+	/* Verify mandatory tag line */
 	tag_line = strchr(type_line, '\n');
 	if (!tag_line++)
 		return error("Tag object (@ char " PD_FMT "): "
@@ -105,27 +106,46 @@ int parse_and_verify_tag_buffer(struct tag *item,
 		return error("Tag object (@ char " PD_FMT "): "
 			"Could not find \"tag \"", tag_line - data);
 
-	/* Verify the tagger line */
+	/*
+	 * Verify mandatory tagger line, but only when we're checking
+	 * thoroughly, i.e. on inserting a new tag, and on fsck.
+	 * There are existing tag objects without a tagger line (most
+	 * notably the "v0.99" tag in the main git repo), and we don't
+	 * want to fail parsing on these.
+	 */
 	tagger_line = strchr(tag_line, '\n');
 	if (!tagger_line++)
 		return error("Tag object (@ char " PD_FMT "): "
 			"Could not find \"\\n\" after \"tag\"",
 			tag_line - data);
-	if (thorough_verify) {
-		if (prefixcmp(tagger_line, "tagger ") || (tagger_line[7] == '\n'))
+	if (prefixcmp(tagger_line, "tagger ")) { /* no tagger given */
+		if (thorough_verify)
 			return error("Tag object (@ char " PD_FMT "): "
 				"Could not find \"tagger \"",
 				tagger_line - data);
+		header_end = tagger_line;
+	}
+	else {                                   /* tagger given */
+		header_end = strchr(tagger_line, '\n');
+		if (!header_end++)
+			return error("Tag object (@ char " PD_FMT "): "
+				"Could not find \"\\n\" after \"tagger\"",
+				tagger_line - data);
 	}
 
 	/*
 	 * Advance header field pointers past their initial identifier.
-	 * Calculate lengths of header fields.
+	 * Calculate lengths of header fields (0 for fields that are not given).
 	 */
-	type_line += strlen("type ");
-	type_len   = tag_line - type_line - 1;
-	tag_line  += strlen("tag ");
-	tag_len    = tagger_line - tag_line - 1;
+	type_line     += strlen("type ");
+	type_len       = tag_line > type_line ?
+			(tag_line - type_line) - 1 : 0;
+	tag_line      += strlen("tag ");
+	tag_len        = tagger_line > tag_line ?
+			(tagger_line - tag_line) - 1 : 0;
+	tagger_line   += strlen("tagger ");
+	tagger_len     = header_end > tagger_line ?
+			(header_end - tagger_line) - 1 : 0;
 
 	/* Get the actual type */
 	if (type_len >= sizeof(type))
@@ -155,7 +175,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 				tag_line + i - data);
 		}
 
-		/* Verify the tagger line */
+		/* Verify tagger line */
 		/* TODO: check for committer/tagger info */
 
 		/* The actual stuff afterwards we don't care about.. */
-- 
1.5.2
