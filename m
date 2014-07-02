From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v1 1/4] hashmap: factor out getting an int hash code from
 a, SHA1
Date: Thu, 03 Jul 2014 00:20:20 +0200
Message-ID: <53B485A4.20609@gmail.com>
References: <53B48540.5070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 00:20:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2StL-00011W-NY
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 00:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208AbaGBWUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 18:20:34 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:33289 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbaGBWUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 18:20:21 -0400
Received: by mail-we0-f169.google.com with SMTP id t60so11951902wes.28
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=cD6x45Uij9OxgbNtJ1YnayYL3W+DlPojNArscYgIRhc=;
        b=iy3hB5djluPVEw2ONhETNpX7lDktOElhyIYqqGKLnYkUgF7ipen/pK20ZIkMomNsYp
         yfDisjeEVTFVmSP4HZ8FlMjcldjnTw6Vc9mU+wkIfHM4Boz9xj7KpFIf+fMZEbuNxhC4
         RhK6bX8tDd2t0JjzS+XJ4fuadZxpSAMj0sEgBektTX0oLo1sNWAk9hVwVXPCTK8N5cQm
         ZckLG3qSzzzQioo7Mfh/h17x7OZDmglqvaAmhIo2jgypVTLGIBaZdEpCq2iqv9C4qSCQ
         NusgTNViPlY70I8ooTkFwZe95HY9bVTVUgrlfYlWQ8E2p/xKJqOg6BkYott21tzKct8v
         vsBw==
X-Received: by 10.180.206.109 with SMTP id ln13mr6846212wic.17.1404339619794;
        Wed, 02 Jul 2014 15:20:19 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id gi15sm57786499wjc.20.2014.07.02.15.20.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 15:20:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B48540.5070600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252846>

Copying the first bytes of a SHA1 is duplicated in six places, however,
the implications (wrong byte order on little-endian systems) is documented
only once.

Add a properly documented API for this.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/technical/api-hashmap.txt |  9 +++++++++
 builtin/describe.c                      | 11 ++---------
 decorate.c                              |  5 +----
 diffcore-rename.c                       |  4 +---
 hashmap.h                               | 11 +++++++++++
 khash.h                                 | 11 ++---------
 object.c                                | 13 +------------
 pack-objects.c                          |  5 ++---
 8 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index b977ae8..4689968 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -58,6 +58,15 @@ Functions
 +
 `strihash` and `memihash` are case insensitive versions.
 
+`unsigned int sha1hash(const unsigned char *sha1)`::
+
+	Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
+	for use in hash tables. Cryptographic hashes are supposed to have
+	uniform distribution, so in contrast to `memhash()`, this just copies
+	the first `sizeof(int)` bytes without shuffling any bits. Note that
+	the results will be different on big-endian and little-endian
+	platforms, so they should not be stored or transferred over the net!
+
 `void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function, size_t initial_size)`::
 
 	Initializes a hashmap structure.
diff --git a/builtin/describe.c b/builtin/describe.c
index 24d740c..57e84c8 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -56,17 +56,10 @@ static int commit_name_cmp(const struct commit_name *cn1,
 	return hashcmp(cn1->peeled, peeled ? peeled : cn2->peeled);
 }
 
-static inline unsigned int hash_sha1(const unsigned char *sha1)
-{
-	unsigned int hash;
-	memcpy(&hash, sha1, sizeof(hash));
-	return hash;
-}
-
 static inline struct commit_name *find_commit_name(const unsigned char *peeled)
 {
 	struct commit_name key;
-	hashmap_entry_init(&key, hash_sha1(peeled));
+	hashmap_entry_init(&key, sha1hash(peeled));
 	return hashmap_get(&names, &key, peeled);
 }
 
@@ -114,7 +107,7 @@ static void add_to_known_names(const char *path,
 		if (!e) {
 			e = xmalloc(sizeof(struct commit_name));
 			hashcpy(e->peeled, peeled);
-			hashmap_entry_init(e, hash_sha1(peeled));
+			hashmap_entry_init(e, sha1hash(peeled));
 			hashmap_add(&names, e);
 			e->path = NULL;
 		}
diff --git a/decorate.c b/decorate.c
index 7cb5d29..b2aac90 100644
--- a/decorate.c
+++ b/decorate.c
@@ -8,10 +8,7 @@
 
 static unsigned int hash_obj(const struct object *obj, unsigned int n)
 {
-	unsigned int hash;
-
-	memcpy(&hash, obj->sha1, sizeof(unsigned int));
-	return hash % n;
+	return sha1hash(obj->sha1) % n;
 }
 
 static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 749a35d..6fa97d4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -242,14 +242,12 @@ struct file_similarity {
 
 static unsigned int hash_filespec(struct diff_filespec *filespec)
 {
-	unsigned int hash;
 	if (!filespec->sha1_valid) {
 		if (diff_populate_filespec(filespec, 0))
 			return 0;
 		hash_sha1_file(filespec->data, filespec->size, "blob", filespec->sha1);
 	}
-	memcpy(&hash, filespec->sha1, sizeof(hash));
-	return hash;
+	return sha1hash(filespec->sha1);
 }
 
 static int find_identical_files(struct hashmap *srcs,
diff --git a/hashmap.h b/hashmap.h
index a816ad4..ed5425a 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -13,6 +13,17 @@ extern unsigned int strihash(const char *buf);
 extern unsigned int memhash(const void *buf, size_t len);
 extern unsigned int memihash(const void *buf, size_t len);
 
+static inline unsigned int sha1hash(const unsigned char *sha1)
+{
+	/*
+	 * Equivalent to 'return *(int *)sha1;', but safe on platforms that
+	 * don't support unaligned reads.
+	 */
+	unsigned int hash;
+	memcpy(&hash, sha1, sizeof(hash));
+	return hash;
+}
+
 /* data structures */
 
 struct hashmap_entry {
diff --git a/khash.h b/khash.h
index 57ff603..06c7906 100644
--- a/khash.h
+++ b/khash.h
@@ -320,19 +320,12 @@ static const double __ac_HASH_UPPER = 0.77;
 		code;												\
 	} }
 
-static inline khint_t __kh_oid_hash(const unsigned char *oid)
-{
-	khint_t hash;
-	memcpy(&hash, oid, sizeof(hash));
-	return hash;
-}
-
 #define __kh_oid_cmp(a, b) (hashcmp(a, b) == 0)
 
-KHASH_INIT(sha1, const unsigned char *, void *, 1, __kh_oid_hash, __kh_oid_cmp)
+KHASH_INIT(sha1, const unsigned char *, void *, 1, sha1hash, __kh_oid_cmp)
 typedef kh_sha1_t khash_sha1;
 
-KHASH_INIT(sha1_pos, const unsigned char *, int, 1, __kh_oid_hash, __kh_oid_cmp)
+KHASH_INIT(sha1_pos, const unsigned char *, int, 1, sha1hash, __kh_oid_cmp)
 typedef kh_sha1_pos_t khash_sha1_pos;
 
 #endif /* __AC_KHASH_H */
diff --git a/object.c b/object.c
index 57a0890..73acaea 100644
--- a/object.c
+++ b/object.c
@@ -50,18 +50,7 @@ int type_from_string(const char *str)
  */
 static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
 {
-	unsigned int hash;
-
-	/*
-	 * Since the sha1 is essentially random, we just take the
-	 * required number of bits directly from the first
-	 * sizeof(unsigned int) bytes of sha1.  First we have to copy
-	 * the bytes into a properly aligned integer.  If we cared
-	 * about getting consistent results across architectures, we
-	 * would have to call ntohl() here, too.
-	 */
-	memcpy(&hash, sha1, sizeof(unsigned int));
-	return hash & (n - 1);
+	return sha1hash(sha1) & (n - 1);
 }
 
 /*
diff --git a/pack-objects.c b/pack-objects.c
index 4f36c32..9992f3e 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -7,10 +7,9 @@ static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 					 const unsigned char *sha1,
 					 int *found)
 {
-	uint32_t i, hash, mask = (pdata->index_size - 1);
+	uint32_t i, mask = (pdata->index_size - 1);
 
-	memcpy(&hash, sha1, sizeof(uint32_t));
-	i = hash & mask;
+	i = sha1hash(sha1) & mask;
 
 	while (pdata->index[i] > 0) {
 		uint32_t pos = pdata->index[i] - 1;
-- 
1.9.4.msysgit.0.dirty
