From: Johan Herland <johan@herland.net>
Subject: [PATCH 12/21] Use prefixcmp() instead of memcmp() for cleaner code
 with less magic numbers
Date: Sat, 09 Jun 2007 02:17:49 +0200
Message-ID: <200706090217.49818.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:18:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwoep-0004Rk-EN
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S970132AbXFIARy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S970099AbXFIARy
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:17:54 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34603 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S970068AbXFIARx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:17:53 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903E5SZ200@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:17:52 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000P5E5QCO20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:17:50 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC0094CE5PAH10@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:17:50 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49539>

Signed-off-by: Johan Herland <johan@herland.net>
---
 tag.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tag.c b/tag.c
index c7c75b3..ac76ec0 100644
--- a/tag.c
+++ b/tag.c
@@ -51,6 +51,13 @@ static int verify_object(unsigned char *sha1, const char *expected_type)
 	return ret;
 }
 
+/*
+ * Perform parsing and verification of tag object data.
+ *
+ * The 'item' parameter may be set to NULL if only verification is desired.
+ *
+ * The given data _must_ be null-terminated.
+ */
 int parse_and_verify_tag_buffer(struct tag *item,
 		const char *data, const unsigned long size, int thorough_verify)
 {
@@ -75,7 +82,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 		return error("Tag object failed preliminary size check");
 
 	/* Verify object line */
-	if (memcmp(data, "object ", 7))
+	if (prefixcmp(data, "object "))
 		return error("Tag object (@ char 0): "
 			"Does not start with \"object \"");
 
@@ -84,7 +91,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 
 	/* Verify type line */
 	type_line = data + 48;
-	if (memcmp(type_line - 1, "\ntype ", 6))
+	if (prefixcmp(type_line - 1, "\ntype "))
 		return error("Tag object (@ char 47): "
 			"Could not find \"\\ntype \"");
 
@@ -94,7 +101,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 		return error("Tag object (@ char " PD_FMT "): "
 			"Could not find \"\\n\" after \"type\"",
 			type_line - data);
-	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
+	if (prefixcmp(tag_line, "tag ") || tag_line[4] == '\n')
 		return error("Tag object (@ char " PD_FMT "): "
 			"Could not find \"tag \"", tag_line - data);
 
@@ -105,7 +112,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 			"Could not find \"\\n\" after \"tag\"",
 			tag_line - data);
 	if (thorough_verify) {
-		if (memcmp(tagger_line, "tagger ", 7) || (tagger_line[7] == '\n'))
+		if (prefixcmp(tagger_line, "tagger ") || (tagger_line[7] == '\n'))
 			return error("Tag object (@ char " PD_FMT "): "
 				"Could not find \"tagger \"",
 				tagger_line - data);
-- 
1.5.2
