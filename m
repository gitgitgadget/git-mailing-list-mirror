From: Johan Herland <johan@herland.net>
Subject: [PATCH 06/21] Refactor tag name verification loop to use index 'i'
 instead of incrementing pointer 'tag_line'
Date: Sat, 09 Jun 2007 02:15:05 +0200
Message-ID: <200706090215.05318.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:15:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwobp-0003zr-GR
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969879AbXFIAPL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969777AbXFIAPL
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:15:11 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33089 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969752AbXFIAPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:15:09 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903E18NP00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:15:08 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000LOE15CO20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:15:05 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC009OFE15AH00@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:15:05 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49533>

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/mktag.c b/mktag.c
index 4dbefab..2e70504 100644
--- a/mktag.c
+++ b/mktag.c
@@ -81,19 +81,22 @@ static int verify_tag(char *data, unsigned long size)
 	memcpy(type, type_line + 5, type_len);
 	type[type_len] = '\0';
 
-	/* Verify that the object matches */
-	if (verify_object(sha1, type))
-		return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
-
-	/* Verify the tag-name: we don't allow control characters or spaces in it */
-	tag_line += 4;
-	for (;;) {
-		unsigned char c = *tag_line++;
-		if (c == '\n')
-			break;
-		if (c > ' ')
-			continue;
-		return error("char" PD_FMT ": could not verify tag name", tag_line - data);
+	{
+		unsigned long i;
+
+		/* Verify that the object matches */
+		if (verify_object(sha1, type))
+			return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
+
+		/* Verify the tag-name: we don't allow control characters or spaces in it */
+		for (i = 4;;) {
+			unsigned char c = tag_line[i++];
+			if (c == '\n')
+				break;
+			if (c > ' ')
+				continue;
+			return error("char" PD_FMT ": could not verify tag name", tag_line + i - data);
+		}
 	}
 
 	/* TODO: check for committer info + blank line? */
-- 
1.5.2
