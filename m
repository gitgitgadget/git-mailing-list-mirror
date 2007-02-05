From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Add cache_sha1_file() interface.
Date: Sun, 04 Feb 2007 21:51:23 -0800
Message-ID: <7v8xfdp2xw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 06:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDwlE-00008j-R1
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 06:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbXBEFvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 00:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbXBEFvZ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 00:51:25 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:63456 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752639AbXBEFvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 00:51:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070205055125.YXLM1302.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 5 Feb 2007 00:51:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KhrP1W00V1kojtg0000000; Mon, 05 Feb 2007 00:51:24 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38727>

The new interface allows an application to temporarily hash a
small number of objects and pretend that they are available in
the object store without actually writing them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 cache.h     |    1 +
 sha1_file.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 38a9bc0..8775088 100644
--- a/cache.h
+++ b/cache.h
@@ -257,6 +257,7 @@ extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, uns
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int hash_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int cache_sha1_file(void *, unsigned long, const char *, unsigned char *);
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
diff --git a/sha1_file.c b/sha1_file.c
index 1526a28..6a7a5b5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1505,10 +1505,67 @@ static void *read_packed_sha1(const unsigned char *sha1, char *type, unsigned lo
 		return unpack_entry(e.p, e.offset, type, size);
 }
 
+/*
+ * This is meant to hold a *small* number of objects that you would
+ * want read_sha1_file() to be able to return, but yet you do not want
+ * to write them into the object store (e.g. a browse-only
+ * application).
+ */
+static struct cached_object {
+	unsigned char sha1[20];
+	const char *type;
+	void *buf;
+	unsigned long size;
+} *cached_objects;
+static int cached_object_nr, cached_object_alloc;
+
+static struct cached_object *find_cached_object(const unsigned char *sha1)
+{
+	int i;
+	struct cached_object *co = cached_objects;
+
+	for (i = 0; i < cached_object_nr; i++, co++) {
+		if (!hashcmp(co->sha1, sha1))
+			return co;
+	}
+	return NULL;
+}
+
+int cache_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *sha1)
+{
+	struct cached_object *co;
+
+	hash_sha1_file(buf, len, type, sha1);
+	if (has_sha1_file(sha1) || find_cached_object(sha1))
+		return 0;
+	if (cached_object_alloc <= cached_object_nr) {
+		cached_object_alloc = alloc_nr(cached_object_alloc);
+		cached_objects = xrealloc(cached_objects,
+					  sizeof(*cached_objects) *
+					  cached_object_alloc);
+	}
+	co = &cached_objects[cached_object_nr++];
+	co->size = len;
+	co->type = strdup(type);
+	hashcpy(co->sha1, sha1);
+	return 0;
+}
+
 void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
 {
 	unsigned long mapsize;
 	void *map, *buf;
+	struct cached_object *co;
+
+	co = find_cached_object(sha1);
+	if (co) {
+		buf = xmalloc(co->size + 1);
+		memcpy(buf, co->buf, co->size);
+		((char*)buf)[co->size] = 0;
+		strcpy(type, co->type);
+		*size = co->size;
+		return buf;
+	}
 
 	buf = read_packed_sha1(sha1, type, size);
 	if (buf)
-- 
1.5.0.rc3.58.g79812
