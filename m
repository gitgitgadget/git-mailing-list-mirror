From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Remove redundant code, eliminate one static variable
Date: Sat, 24 May 2008 01:43:55 +0300
Message-ID: <20080523224355.GA16878@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 00:44:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzg0I-0007UG-PV
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 00:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbYEWWn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 18:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbYEWWn6
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 18:43:58 -0400
Received: from zakalwe.fi ([80.83.5.154]:46847 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbYEWWn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 18:43:57 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id C7A682BBF0; Sat, 24 May 2008 01:43:55 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82765>

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 sha1_file.c |   44 +++++++++++++++++---------------------------
 1 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3516777..e8751d0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -176,21 +176,22 @@ char *sha1_file_name(const unsigned char *sha1)
 	return base;
 }
 
-char *sha1_pack_name(const unsigned char *sha1)
+static char *sha1_get_pack_name(const unsigned char *sha1,
+				char **name, char **base)
 {
 	static const char hex[] = "0123456789abcdef";
-	static char *name, *base, *buf;
+	char *buf;
 	int i;
 
-	if (!base) {
+	if (!*base) {
 		const char *sha1_file_directory = get_object_directory();
 		int len = strlen(sha1_file_directory);
-		base = xmalloc(len + 60);
-		sprintf(base, "%s/pack/pack-1234567890123456789012345678901234567890.pack", sha1_file_directory);
-		name = base + len + 11;
+		*base = xmalloc(len + 60);
+		sprintf(*base, "%s/pack/pack-1234567890123456789012345678901234567890.pack", sha1_file_directory);
+		*name = *base + len + 11;
 	}
 
-	buf = name;
+	buf = *name;
 
 	for (i = 0; i < 20; i++) {
 		unsigned int val = *sha1++;
@@ -198,32 +199,21 @@ char *sha1_pack_name(const unsigned char *sha1)
 		*buf++ = hex[val & 0xf];
 	}
 
-	return base;
+	return *base;
 }
 
-char *sha1_pack_index_name(const unsigned char *sha1)
+char *sha1_pack_name(const unsigned char *sha1)
 {
-	static const char hex[] = "0123456789abcdef";
-	static char *name, *base, *buf;
-	int i;
-
-	if (!base) {
-		const char *sha1_file_directory = get_object_directory();
-		int len = strlen(sha1_file_directory);
-		base = xmalloc(len + 60);
-		sprintf(base, "%s/pack/pack-1234567890123456789012345678901234567890.idx", sha1_file_directory);
-		name = base + len + 11;
-	}
+	static char *name, *base;
 
-	buf = name;
+	return sha1_get_pack_name(sha1, &name, &base);
+}
 
-	for (i = 0; i < 20; i++) {
-		unsigned int val = *sha1++;
-		*buf++ = hex[val >> 4];
-		*buf++ = hex[val & 0xf];
-	}
+char *sha1_pack_index_name(const unsigned char *sha1)
+{
+	static char *name, *base;
 
-	return base;
+	return sha1_get_pack_name(sha1, &name, &base);
 }
 
 struct alternate_object_database *alt_odb_list;
-- 
1.5.5.1.1.ga5e5c
