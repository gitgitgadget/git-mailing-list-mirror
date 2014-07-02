From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v1 3/4] hashmap: add simplified hashmap_get_from_hash() API
Date: Thu, 03 Jul 2014 00:22:11 +0200
Message-ID: <53B48613.60509@gmail.com>
References: <53B48540.5070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 00:22:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2SvW-0002qo-Ux
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 00:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbaGBWWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 18:22:15 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:64327 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965AbaGBWWM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 18:22:12 -0400
Received: by mail-we0-f171.google.com with SMTP id q58so12030447wes.30
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=CCKWJKcx8oXUbciIbcHX/orsiU70XTNLYbgvr05G3I8=;
        b=DfHof3GFUiFepexj8x75Srm6Zem7yzP93JP0bml+1FHgoUJc5aCheOwR8it0C/94ZX
         twNz1C/6mhrHCs/P/Z4CRPycsNp5IxSXxAgE1Avy5ft62Qi0t1knBbtmctfYEpXCY4bi
         wgAWq83jCqiB1fc/5Ea1z5uvWtnh6bAgnolNXE1V6UgnvVAHqmM07H29F9CC2OMypOMw
         O4iCws/eTvD1txXkrtnw7oHrXtmHbNtG3o3r/Cjy6SI9DeebeeWmnoTlAnyR8qRhHjHJ
         AeyidpART2SFX9A89rz6EjQFLuLXRL/dvK0yAT+SuSxFsFR5BEgiOTSYJUzohLLBREW0
         HjRA==
X-Received: by 10.194.89.138 with SMTP id bo10mr740696wjb.22.1404339730842;
        Wed, 02 Jul 2014 15:22:10 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id a13sm57802456wjs.12.2014.07.02.15.22.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 15:22:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B48540.5070600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252848>

Hashmap entries are typically looked up by just a key. The hashmap_get()
API expects an initialized entry structure instead, to support compound
keys. This flexibility is currently only needed by find_dir_entry() in
name-hash.c (and compat/win32/fscache.c in the msysgit fork). All other
(currently five) call sites of hashmap_get() have to set up a near emtpy
entry structure, resulting in duplicate code like this:

  struct hashmap_entry keyentry;
  hashmap_entry_init(&keyentry, hash(key));
  return hashmap_get(map, &keyentry, key);

Add a hashmap_get_from_hash() API that allows hashmap lookups by just
specifying the key and its hash code, i.e.:

  return hashmap_get_from_hash(map, hash(key), key);

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/technical/api-hashmap.txt | 14 ++++++++++++++
 builtin/describe.c                      |  4 +---
 diffcore-rename.c                       |  7 +++----
 hashmap.h                               |  8 ++++++++
 name-hash.c                             |  5 ++---
 test-hashmap.c                          | 11 +++--------
 6 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index dc21a7c..f9215d6 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -118,6 +118,20 @@ hashmap_entry) that has at least been initialized with the proper hash code
 If an entry with matching hash code is found, `key` and `keydata` are passed
 to `hashmap_cmp_fn` to decide whether the entry matches the key.
 
+`void *hashmap_get_from_hash(const struct hashmap *map, unsigned int hash, const void *keydata)`::
+
+	Returns the hashmap entry for the specified hash code and key data,
+	or NULL if not found.
++
+`map` is the hashmap structure.
++
+`hash` is the hash code of the entry to look up.
++
+If an entry with matching hash code is found, `keydata` is passed to
+`hashmap_cmp_fn` to decide whether the entry matches the key. The
+`entry_or_key` parameter points to a bogus hashmap_entry structure that
+should not be used in the comparison.
+
 `void *hashmap_get_next(const struct hashmap *map, const void *entry)`::
 
 	Returns the next equal hashmap entry, or NULL if not found. This can be
diff --git a/builtin/describe.c b/builtin/describe.c
index 57e84c8..ee6a3b9 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -58,9 +58,7 @@ static int commit_name_cmp(const struct commit_name *cn1,
 
 static inline struct commit_name *find_commit_name(const unsigned char *peeled)
 {
-	struct commit_name key;
-	hashmap_entry_init(&key, sha1hash(peeled));
-	return hashmap_get(&names, &key, peeled);
+	return hashmap_get_from_hash(&names, sha1hash(peeled), peeled);
 }
 
 static int replace_name(struct commit_name *e,
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6fa97d4..2e44a37 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -257,15 +257,14 @@ static int find_identical_files(struct hashmap *srcs,
 	int renames = 0;
 
 	struct diff_filespec *target = rename_dst[dst_index].two;
-	struct file_similarity *p, *best, dst;
+	struct file_similarity *p, *best = NULL;
 	int i = 100, best_score = -1;
 
 	/*
 	 * Find the best source match for specified destination.
 	 */
-	best = NULL;
-	hashmap_entry_init(&dst, hash_filespec(target));
-	for (p = hashmap_get(srcs, &dst, NULL); p; p = hashmap_get_next(srcs, p)) {
+	p = hashmap_get_from_hash(srcs, hash_filespec(target), NULL);
+	for (; p; p = hashmap_get_next(srcs, p)) {
 		int score;
 		struct diff_filespec *source = p->filespec;
 
diff --git a/hashmap.h b/hashmap.h
index ed5425a..12f0668 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -68,6 +68,14 @@ extern void *hashmap_put(struct hashmap *map, void *entry);
 extern void *hashmap_remove(struct hashmap *map, const void *key,
 		const void *keydata);
 
+static inline void *hashmap_get_from_hash(const struct hashmap *map,
+		unsigned int hash, const void *keydata)
+{
+	struct hashmap_entry key;
+	hashmap_entry_init(&key, hash);
+	return hashmap_get(map, &key, keydata);
+}
+
 /* hashmap_iter functions */
 
 extern void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter);
diff --git a/name-hash.c b/name-hash.c
index 49fd508..702cd05 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -213,12 +213,11 @@ struct cache_entry *index_dir_exists(struct index_state *istate, const char *nam
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
 	struct cache_entry *ce;
-	struct hashmap_entry key;
 
 	lazy_init_name_hash(istate);
 
-	hashmap_entry_init(&key, memihash(name, namelen));
-	ce = hashmap_get(&istate->name_hash, &key, NULL);
+	ce = hashmap_get_from_hash(&istate->name_hash,
+				   memihash(name, namelen), NULL);
 	while (ce) {
 		if (same_name(ce, name, namelen, icase))
 			return ce;
diff --git a/test-hashmap.c b/test-hashmap.c
index f5183fb..3c9f67b 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -115,9 +115,8 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 
 		for (j = 0; j < rounds; j++) {
 			for (i = 0; i < TEST_SIZE; i++) {
-				struct hashmap_entry key;
-				hashmap_entry_init(&key, hashes[i]);
-				hashmap_get(&map, &key, entries[i]->key);
+				hashmap_get_from_hash(&map, hashes[i],
+						      entries[i]->key);
 			}
 		}
 
@@ -199,12 +198,8 @@ int main(int argc, char *argv[])
 
 		} else if (!strcmp("get", cmd) && l1) {
 
-			/* setup static key */
-			struct hashmap_entry key;
-			hashmap_entry_init(&key, hash);
-
 			/* lookup entry in hashmap */
-			entry = hashmap_get(&map, &key, p1);
+			entry = hashmap_get_from_hash(&map, hash, p1);
 
 			/* print result */
 			if (!entry)
-- 
1.9.4.msysgit.0.dirty
