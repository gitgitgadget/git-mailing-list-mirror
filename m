From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 02/10] Define utility functions for object IDs.
Date: Fri, 13 Mar 2015 23:39:28 +0000
Message-ID: <1426289976-568060-3-git-send-email-sandals@crustytoothpaste.net>
References: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 00:40:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWZCG-0000Q0-Cg
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 00:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbbCMXkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 19:40:43 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50110 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751831AbbCMXkK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2015 19:40:10 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DF6B128093;
	Fri, 13 Mar 2015 23:40:09 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265433>

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
 cache.h | 32 ++++++++++++++++++++++++++++----
 hex.c   | 16 +++++++++++++---
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 6582c35..95206a3 100644
--- a/cache.h
+++ b/cache.h
@@ -718,13 +718,13 @@ extern char *sha1_pack_name(const unsigned char *sha1);
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
@@ -732,20 +732,42 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 	return 0;
 }
 
+static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
+{
+	return hashcmp(oid1->hash, oid2->hash);
+}
+
 static inline int is_null_sha1(const unsigned char *sha1)
 {
 	return !hashcmp(sha1, null_sha1);
 }
 
+static inline int is_null_oid(const struct object_id *oid)
+{
+	return !hashcmp(oid->hash, null_sha1);
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
+	hashcpy(dst->hash, src->hash);
+}
+
 static inline void hashclr(unsigned char *hash)
 {
-	memset(hash, 0, 20);
+	memset(hash, 0, GIT_SHA1_RAWSZ);
 }
 
+static inline void oidclr(struct object_id *oid)
+{
+	hashclr(oid->hash);
+}
+
+
 #define EMPTY_TREE_SHA1_HEX \
 	"4b825dc642cb6eb9a060e54bf8d69288fbee4904"
 #define EMPTY_TREE_SHA1_BIN_LITERAL \
@@ -952,8 +974,10 @@ extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
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
index cfd9d72..899b74a 100644
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
+	return get_sha1_hex(hex, oid->hash);
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
+	return sha1_to_hex(oid->hash);
+}
-- 
2.2.1.209.g41e5f3a
