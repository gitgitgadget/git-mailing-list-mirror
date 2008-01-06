From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] tree-walk: don't parse incorrect entries
Date: Sun,  6 Jan 2008 18:21:10 +0100
Message-ID: <11996400703010-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 18:21:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBZBt-0002LM-QB
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 18:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757137AbYAFRVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 12:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754922AbYAFRVN
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 12:21:13 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60185 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbYAFRVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 12:21:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 96AAF680BEA2;
	Sun,  6 Jan 2008 18:21:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oJhc0u-XiFXg; Sun,  6 Jan 2008 18:21:10 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 7C8E6680BEA0; Sun,  6 Jan 2008 18:21:10 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69734>

The current code can access memory outside of the tree
buffer in the case of malformed tree entries.

This patch prevent this by:
* The rest of the buffer must be at least 24 bytes
  (at least 1 byte mode, 1 blank, at least one byte path name,
   1 NUL, 20 bytes sha1).
* Check that the last NUL (21 bytes before the end) is present.
  This ensurse, that strlen and get_mode stay within the buffer.
* The mode may not be empty. We have only to reject a blank at the begin,
  as the rest is handled by if (c < '0' || c > '7').
* The blank is ensured by get_mode.
* The path must contain at least one character.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 tree-walk.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 8d4b673..10f21d7 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -7,6 +7,9 @@ static const char *get_mode(const char *str, unsigned int *modep)
 	unsigned char c;
 	unsigned int mode = 0;
 
+	if (*str == ' ')
+		return NULL;
+
 	while ((c = *str++) != ' ') {
 		if (c < '0' || c > '7')
 			return NULL;
@@ -16,13 +19,16 @@ static const char *get_mode(const char *str, unsigned int *modep)
 	return str;
 }
 
-static void decode_tree_entry(struct tree_desc *desc, const void *buf, unsigned long size)
+static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size)
 {
 	const char *path;
 	unsigned int mode, len;
 
+	if (size < 24 || buf[size - 21]) 
+		die("corrupt tree file");
+
 	path = get_mode(buf, &mode);
-	if (!path)
+	if (!path || !*path)
 		die("corrupt tree file");
 	len = strlen(path) + 1;
 
-- 
1.4.4.4
