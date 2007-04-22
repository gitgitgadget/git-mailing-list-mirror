From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/5] add get_sha1_with_mode
Date: Sun, 22 Apr 2007 18:43:57 +0200
Message-ID: <11772602402479-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <1177260240326-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 18:44:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HffAt-0001Lv-NX
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 18:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161395AbXDVQo2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 12:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161468AbXDVQoI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 12:44:08 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:51155 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161395AbXDVQoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 12:44:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 4DC447833E05;
	Sun, 22 Apr 2007 18:44:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id obG8jhqQE4ZD; Sun, 22 Apr 2007 18:44:00 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 9689C7A522AF; Sun, 22 Apr 2007 18:44:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <1177260240326-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45248>

get_sha1_with_mode basically behaves as get_sha1. It has an additional
parameter for storing the mode of the object. This parameter may be NULL.
If the mode can not be determinded, it stores S_IFINVALID.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 cache.h     |    1 +
 sha1_name.c |   11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index d425c26..a9ae3f8 100644
--- a/cache.h
+++ b/cache.h
@@ -320,6 +320,7 @@ static inline unsigned int hexval(unsigned int c)
 #define DEFAULT_ABBREV 7
 
 extern int get_sha1(const char *str, unsigned char *sha1);
+extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/sha1_name.c b/sha1_name.c
index 267ea3f..1349c0a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -643,11 +643,18 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
  */
 int get_sha1(const char *name, unsigned char *sha1)
 {
+	return get_sha1_with_mode(name, sha1, NULL);
+}
+
+int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned* mode)
+{
 	int ret, bracket_depth;
 	unsigned unused;
 	int namelen = strlen(name);
 	const char *cp;
 
+	if (mode)
+		*mode = S_IFINVALID;
 	prepare_alt_odb();
 	ret = get_sha1_1(name, namelen, sha1);
 	if (!ret)
@@ -685,6 +692,8 @@ int get_sha1(const char *name, unsigned char *sha1)
 				break;
 			if (ce_stage(ce) == stage) {
 				hashcpy(sha1, ce->sha1);
+				if (mode)
+					*mode = ntohl(ce->ce_mode);
 				return 0;
 			}
 			pos++;
@@ -703,7 +712,7 @@ int get_sha1(const char *name, unsigned char *sha1)
 		unsigned char tree_sha1[20];
 		if (!get_sha1_1(name, cp-name, tree_sha1))
 			return get_tree_entry(tree_sha1, cp+1, sha1,
-					      &unused);
+					      mode ? mode : &unused);
 	}
 	return ret;
 }
-- 
1.5.1.1.206.g4a12-dirty
