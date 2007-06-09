From: Johan Herland <johan@herland.net>
Subject: [PATCH 13/21] Collect skipping of header field names and calculation
 of line lengths in one place
Date: Sat, 09 Jun 2007 02:18:16 +0200
Message-ID: <200706090218.16281.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwoey-0004TO-Rh
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969894AbXFIASU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969024AbXFIASU
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:18:20 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34847 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969117AbXFIAST (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:18:19 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903E6IZH00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:18:18 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000PNE6GCO20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:18:16 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC0098HE6GAH10@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:18:16 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49540>

For each of the parsed lines we at some point skip past its initial
identifier ("type ", "tag ", etc.). We also at some point calculate the
length of the remaining line. This patch moves these calculations into
one place. This provides _one_ place for all header lines where their
respective pointers start pointing at the header value (instead of the
start of the line), and their lengths are calculated.

Signed-off-by: Johan Herland <johan@herland.net>
---
 tag.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tag.c b/tag.c
index ac76ec0..9a6924f 100644
--- a/tag.c
+++ b/tag.c
@@ -118,12 +118,20 @@ int parse_and_verify_tag_buffer(struct tag *item,
 				tagger_line - data);
 	}
 
+	/*
+	 * Advance header field pointers past their initial identifier.
+	 * Calculate lengths of header fields.
+	 */
+	type_line += strlen("type ");
+	type_len   = tag_line - type_line - 1;
+	tag_line  += strlen("tag ");
+	tag_len    = tagger_line - tag_line - 1;
+
 	/* Get the actual type */
-	type_len = tag_line - type_line - strlen("type \n");
 	if (type_len >= sizeof(type))
 		return error("Tag object (@ char " PD_FMT "): "
-			"Type too long", type_line + 5 - data);
-	memcpy(type, type_line + 5, type_len);
+			"Type too long", type_line - data);
+	memcpy(type, type_line, type_len);
 	type[type_len] = '\0';
 
 	if (thorough_verify) {
@@ -136,7 +144,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 				sha1_to_hex(sha1));
 
 		/* Verify tag name: disallow control characters or spaces */
-		for (i = 4;;) {
+		for (i = 0;;) {
 			unsigned char c = tag_line[i++];
 			if (c == '\n')
 				break;
@@ -154,9 +162,8 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	}
 
 	if (item) {
-		tag_len = tagger_line - tag_line - strlen("tag \n");
 		item->tag = xmalloc(tag_len + 1);
-		memcpy(item->tag, tag_line + 4, tag_len);
+		memcpy(item->tag, tag_line, tag_len);
 		item->tag[tag_len] = '\0';
 
 		if (!strcmp(type, blob_type)) {
@@ -169,7 +176,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 			item->tagged = &lookup_tag(sha1)->object;
 		} else {
 			error("Tag object (@ char " PD_FMT "): "
-				"Unknown type '%s'", type_line + 5 - data, type);
+				"Unknown type '%s'", type_line - data, type);
 			item->tagged = NULL;
 		}
 
-- 
1.5.2
