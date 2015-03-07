From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 02/10] Define utility functions for object IDs.
Date: Sat,  7 Mar 2015 23:23:57 +0000
Message-ID: <1425770645-628957-3-git-send-email-sandals@crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 00:24:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUO57-0001cR-Tu
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 00:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbbCGXYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 18:24:20 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49821 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753003AbbCGXYQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 18:24:16 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2A6D728093;
	Sat,  7 Mar 2015 23:24:15 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265012>

There are several utility functions (hashcmp and friends) that are used
for comparing object IDs (SHA-1 values).  Using these functions, which
take pointers to unsigned char, with struct object_id requires tiresome
access to the sha1 member, which bloats code and violates the desired
encapsulation.  Provide wrappers around these functions for struct
object_id for neater, more maintainable code.  Use the new constants to
avoid the hard-coded 20s and 40s throughout the original functions.

These functions simply call the underlying pointer-to-unsigned-char
versions to ensure that any performance improvements will be passed
through to the new functions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I'm not very excited about having to put the #include in the middle of
cache.h.  The alternative, of course, is to move enum object_type up,
which I can do if necessary.  Another alternative is to simply move the
struct object_id definitions to cache.h instead of object.h, which might
be cleaner.

I'm interested in hearing opinions about the best way to go forward.

 cache.h | 37 +++++++++++++++++++++++++++++++++----
 hex.c   | 16 +++++++++++++---
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 761c570..f9addcc 100644
--- a/cache.h
+++ b/cache.h
@@ -368,6 +368,11 @@ static inline enum object_type object_type(unsigned int mode)
 		OBJ_BLOB;
 }
 
+/* This must go before the oid* functions, but after the declaration of enum
+ * object_type.
+ */
+#include "object.h"
+
 /* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
@@ -710,13 +715,13 @@ extern char *sha1_pack_name(const unsigned char *sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
-extern const unsigned char null_sha1[20];
+extern const unsigned char null_sha1[GIT_SHA1_RAWSZ];
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
 	int i;
 
-	for (i = 0; i < 20; i++, sha1++, sha2++) {
+	for (i = 0; i < GIT_SHA1_RAWSZ; i++, sha1++, sha2++) {
 		if (*sha1 != *sha2)
 			return *sha1 - *sha2;
 	}
@@ -724,20 +729,42 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 	return 0;
 }
 
+static inline int oidcmp(const struct object_id *o1, const struct object_id *o2)
+{
+	return hashcmp(o1->sha1, o2->sha1);
+}
+
 static inline int is_null_sha1(const unsigned char *sha1)
 {
 	return !hashcmp(sha1, null_sha1);
 }
 
+static inline int is_null_oid(const struct object_id *oid)
+{
+	return !hashcmp(oid->sha1, null_sha1);
+}
+
 static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
 {
-	memcpy(sha_dst, sha_src, 20);
+	memcpy(sha_dst, sha_src, GIT_SHA1_RAWSZ);
 }
+
+static inline void oidcpy(struct object_id *dst, const struct object_id *src)
+{
+	hashcpy(dst->sha1, src->sha1);
+}
+
 static inline void hashclr(unsigned char *hash)
 {
-	memset(hash, 0, 20);
+	memset(hash, 0, GIT_SHA1_RAWSZ);
 }
 
+static inline void oidclr(struct object_id *oid)
+{
+	hashclr(oid->sha1);
+}
+
+
 #define EMPTY_TREE_SHA1_HEX \
 	"4b825dc642cb6eb9a060e54bf8d69288fbee4904"
 #define EMPTY_TREE_SHA1_BIN_LITERAL \
@@ -944,8 +971,10 @@ extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
  * null-terminated string.
  */
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
+extern int get_oid_hex(const char *hex, struct object_id *sha1);
 
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
+extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
 extern int read_ref_full(const char *refname, int resolve_flags,
 			 unsigned char *sha1, int *flags);
 extern int read_ref(const char *refname, unsigned char *sha1);
diff --git a/hex.c b/hex.c
index cfd9d72..7e25a88 100644
--- a/hex.c
+++ b/hex.c
@@ -38,7 +38,7 @@ const signed char hexval_table[256] = {
 int get_sha1_hex(const char *hex, unsigned char *sha1)
 {
 	int i;
-	for (i = 0; i < 20; i++) {
+	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
 		unsigned int val;
 		/*
 		 * hex[1]=='\0' is caught when val is checked below,
@@ -56,15 +56,20 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 	return 0;
 }
 
+int get_oid_hex(const char *hex, struct object_id *oid)
+{
+	return get_sha1_hex(hex, oid->sha1);
+}
+
 char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
-	static char hexbuffer[4][41];
+	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
 	static const char hex[] = "0123456789abcdef";
 	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
 	int i;
 
-	for (i = 0; i < 20; i++) {
+	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
 		unsigned int val = *sha1++;
 		*buf++ = hex[val >> 4];
 		*buf++ = hex[val & 0xf];
@@ -73,3 +78,8 @@ char *sha1_to_hex(const unsigned char *sha1)
 
 	return buffer;
 }
+
+char *oid_to_hex(const struct object_id *oid)
+{
+	return sha1_to_hex(oid->sha1);
+}
-- 
2.2.1.209.g41e5f3a
