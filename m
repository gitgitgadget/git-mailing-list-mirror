From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/5] git-tar-tree: add extended header helpers
Date: Fri, 6 May 2005 22:56:01 +0200
Message-ID: <20050506205601.GD19518@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 22:50:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU9mI-0000Zz-TW
	for gcvg-git@gmane.org; Fri, 06 May 2005 22:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVEFU5O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 16:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVEFU5O
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 16:57:14 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:26555 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261263AbVEFU4G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 16:56:06 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id F2EFC40A; Fri,  6 May 2005 22:56:01 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Introduce append_extended_header_prefix(), extended_header_len()
and append_extended_header().  These are helper functions that
make it easier to handle multiple entries in a pax extended
header.  append_log() is no longer needed and can go away.

---
commit 07b06da34d45be748f46ce4c8ffd3a2e0bba6191
tree bb298354f2340d064398c211af0a44cde2b7f48b
parent c0507f354f3637ce2fc6d8665685a7007e97002e
author Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115306031 +0200
committer Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1115306031 +0200

Index: tar-tree.c
===================================================================
--- c20d5f820ce6cd1763af5a3eccfe4d4cff1ac719/tar-tree.c  (mode:100644 sha1:a5b9fc937c6c54a8155dd8d28772ecb5ba5dd303)
+++ bb298354f2340d064398c211af0a44cde2b7f48b/tar-tree.c  (mode:100644 sha1:277c882acc4f487bfc90dee76b00dc88f99f3da3)
@@ -128,12 +128,6 @@
 	*p += 1;
 }
 
-static void append_long(char **p, long n)
-{
-	int len = sprintf(*p, "%ld", n);
-	*p += len;
-}
-
 static void append_path_prefix(char **buffer, struct path_prefix *prefix)
 {
 	if (!prefix)
@@ -175,6 +169,35 @@
 	return len;
 }
 
+static void append_extended_header_prefix(char **p, unsigned int size,
+                                          const char *keyword)
+{
+	int len = sprintf(*p, "%u %s=", size, keyword);
+	*p += len;
+}
+
+static unsigned int extended_header_len(const char *keyword,
+                                        unsigned int valuelen)
+{
+	/* "%u %s=%s\n" */
+	unsigned int len = 1 + 1 + strlen(keyword) + 1 + valuelen + 1;
+	if (len > 9)
+		len++;
+	if (len > 99)
+		len++;
+	return len;
+}
+
+static void append_extended_header(char **p, const char *keyword,
+                                   const char *value, unsigned int len)
+{
+	unsigned int size = extended_header_len(keyword, len);
+	append_extended_header_prefix(p, size, keyword);
+	memcpy(*p, value, len);
+	*p += len;
+	append_char(p, '\n');
+}
+
 static void write_header(const char *, char, const char *, struct path_prefix *,
                          const char *, unsigned int, unsigned long);
 
@@ -185,18 +208,16 @@
                                   const char *path, unsigned int namelen)
 {
 	char *p;
-	unsigned int size = 1 + 6 + namelen + 1;
-	if (size > 9)
-		size++;
-	if (size > 99)
-		size++;
+	unsigned int pathlen, size;
+
+	size = pathlen = extended_header_len("path", namelen);
 	if (size > RECORDSIZE)
 		die("tar-tree: extended header too big, wtf?");
 	write_header(NULL, TYPEFLAG_EXT_HEADER, NULL, NULL, headerfilename,
 	             0100600, size);
+
 	p = get_record();
-	append_long(&p, size);
-	append_string(&p, " path=");
+	append_extended_header_prefix(&p, pathlen, "path");
 	append_path(&p, is_dir, basepath, prefix, path);
 	append_char(&p, '\n');
 	write_if_needed();
@@ -205,13 +226,14 @@
 static void write_global_extended_header(const char *sha1)
 {
 	char *p;
+	unsigned int size;
+
+	size = extended_header_len("comment", 40);
 	write_header(NULL, TYPEFLAG_GLOBAL_HEADER, NULL, NULL,
-	             "pax_global_header", 0100600, 52);
+	             "pax_global_header", 0100600, size);
+
 	p = get_record();
-	append_long(&p, 52);	/* 2 + 9 + 40 + 1 */
-	append_string(&p, " comment=");
-	append_string(&p, sha1_to_hex(sha1));
-	append_char(&p, '\n');
+	append_extended_header(&p, "comment", sha1_to_hex(sha1), 40);
 	write_if_needed();
 }
 



!-------------------------------------------------------------flip-


