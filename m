From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] add get_sha1_with_mode
Date: Mon, 23 Apr 2007 22:55:05 +0200
Message-ID: <11773617051833-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 22:55:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg5Z5-0001fS-07
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 22:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbXDWUzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 16:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbXDWUzK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 16:55:10 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55521 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbXDWUzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 16:55:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id B119B6836F02;
	Mon, 23 Apr 2007 22:55:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDGhSsOhJhq6; Mon, 23 Apr 2007 22:55:06 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id F18B76836F00; Mon, 23 Apr 2007 22:55:05 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45360>

get_sha1_with_mode basically behaves as get_sha1. It has an additional
parameter for storing the mode of the object.

If the mode can not be determined, it stores S_IFINVALID.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 cache.h     |    1 +
 sha1_name.c |   11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index b1adbe7..23e8f24 100644
--- a/cache.h
+++ b/cache.h
@@ -342,6 +342,7 @@ static inline unsigned int hexval(unsigned int c)
 #define DEFAULT_ABBREV 7
 
 extern int get_sha1(const char *str, unsigned char *sha1);
+extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/sha1_name.c b/sha1_name.c
index b0b12bb..55f25a2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -643,11 +643,17 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
  */
 int get_sha1(const char *name, unsigned char *sha1)
 {
-	int ret, bracket_depth;
 	unsigned unused;
+	return get_sha1_with_mode(name, sha1, &unused);
+}
+
+int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
+{
+	int ret, bracket_depth;
 	int namelen = strlen(name);
 	const char *cp;
 
+	*mode = S_IFINVALID;
 	prepare_alt_odb();
 	ret = get_sha1_1(name, namelen, sha1);
 	if (!ret)
@@ -685,6 +691,7 @@ int get_sha1(const char *name, unsigned char *sha1)
 				break;
 			if (ce_stage(ce) == stage) {
 				hashcpy(sha1, ce->sha1);
+				*mode = ntohl(ce->ce_mode);
 				return 0;
 			}
 			pos++;
@@ -703,7 +710,7 @@ int get_sha1(const char *name, unsigned char *sha1)
 		unsigned char tree_sha1[20];
 		if (!get_sha1_1(name, cp-name, tree_sha1))
 			return get_tree_entry(tree_sha1, cp+1, sha1,
-					      &unused);
+					      mode);
 	}
 	return ret;
 }
-- 
1.5.1.1.199.g1a18-dirty
