From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] parse_tag_buffer: don't parse invalid tags
Date: Sun,  6 Jan 2008 20:03:10 +0100
Message-ID: <11996461912682-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 20:03:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBamZ-0006mk-HC
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 20:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbYAFTDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 14:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755189AbYAFTDO
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 14:03:14 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:36294 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbYAFTDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 14:03:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 745E4680BED1;
	Sun,  6 Jan 2008 20:03:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1kjCXOyVSmRJ; Sun,  6 Jan 2008 20:03:11 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 5A1A0680BEA0; Sun,  6 Jan 2008 20:03:11 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69738>

The current tag parsing code can access memory outside the tag buffer,
if \n are missing. This patch prevent this behaviour.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 tag.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tag.c b/tag.c
index f62bcdd..fa22ae6 100644
--- a/tag.c
+++ b/tag.c
@@ -39,6 +39,7 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 	unsigned char sha1[20];
 	const char *type_line, *tag_line, *sig_line;
 	char type[20];
+	const char* start = data;
 
         if (item->object.parsed)
                 return 0;
@@ -53,11 +54,11 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 	if (memcmp("\ntype ", type_line-1, 6))
 		return -1;
 
-	tag_line = strchr(type_line, '\n');
+	tag_line = memchr(type_line, '\n', size - (type_line - start));
 	if (!tag_line || memcmp("tag ", ++tag_line, 4))
 		return -1;
 
-	sig_line = strchr(tag_line, '\n');
+	sig_line = memchr(tag_line, '\n', size - (tag_line - start));
 	if (!sig_line)
 		return -1;
 	sig_line++;
-- 
1.4.4.4
