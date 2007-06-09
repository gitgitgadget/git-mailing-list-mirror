From: Johan Herland <johan@herland.net>
Subject: [PATCH 02/21] Return error messages when parsing fails.
Date: Sat, 09 Jun 2007 02:13:15 +0200
Message-ID: <200706090213.16031.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:13:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwoa2-0003i8-UK
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969612AbXFIANV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968858AbXFIANU
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:13:20 -0400
Received: from smtp.getmail.no ([84.208.20.33]:46703 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754930AbXFIANT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:13:19 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903DY6NI00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:13:18 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000KODY4ZK30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:13:16 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC009ENDY4AH00@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:13:16 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49528>

This patch brings the already similar tag.c:parse_tag_buffer() and
mktag.c:verify_tag() a little bit closer to eachother.

Signed-off-by: Johan Herland <johan@herland.net>
---
 tag.c |   39 ++++++++++++++++++++++++++++++---------
 1 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/tag.c b/tag.c
index bbacd59..954ed8a 100644
--- a/tag.c
+++ b/tag.c
@@ -35,6 +35,12 @@ struct tag *lookup_tag(const unsigned char *sha1)
 
 int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 {
+#ifdef NO_C99_FORMAT
+#define PD_FMT "%d"
+#else
+#define PD_FMT "%td"
+#endif
+
 	int typelen, taglen;
 	unsigned char sha1[20];
 	const char *type_line, *tag_line, *sig_line;
@@ -45,28 +51,41 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
         item->object.parsed = 1;
 
 	if (size < 64)
-		return -1;
-	if (memcmp("object ", data, 7) || get_sha1_hex((char *) data + 7, sha1))
-		return -1;
+		return error("failed preliminary size check");
 
+	/* Verify object line */
+	if (memcmp(data, "object ", 7))
+		return error("char%d: does not start with \"object \"", 0);
+
+	if (get_sha1_hex((char *) data + 7, sha1))
+		return error("char%d: could not get SHA1 hash", 7);
+
+	/* Verify type line */
 	type_line = (char *) data + 48;
-	if (memcmp("\ntype ", type_line-1, 6))
-		return -1;
+	if (memcmp(type_line - 1, "\ntype ", 6))
+		return error("char%d: could not find \"\\ntype \"", 47);
 
+	/* Verify tag-line */
 	tag_line = strchr(type_line, '\n');
-	if (!tag_line || memcmp("tag ", ++tag_line, 4))
-		return -1;
+	if (!tag_line)
+		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - (char *) data);
+	tag_line++;
+	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
+		return error("char" PD_FMT ": no \"tag \" found", tag_line - (char *) data);
 
 	sig_line = strchr(tag_line, '\n');
 	if (!sig_line)
 		return -1;
 	sig_line++;
 
+	/* Get the actual type */
 	typelen = tag_line - type_line - strlen("type \n");
-	if (typelen >= 20)
-		return -1;
+	if (typelen >= sizeof(type))
+		return error("char" PD_FMT ": type too long", type_line+5 - (char *) data);
+
 	memcpy(type, type_line + 5, typelen);
 	type[typelen] = '\0';
+
 	taglen = sig_line - tag_line - strlen("tag \n");
 	item->tag = xmalloc(taglen + 1);
 	memcpy(item->tag, tag_line + 4, taglen);
@@ -92,6 +111,8 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 	}
 
 	return 0;
+
+#undef PD_FMT
 }
 
 int parse_tag(struct tag *item)
-- 
1.5.2
