From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 09/14] name-hash.c: use new hash map implementation for
 cache entries
Date: Thu, 07 Nov 2013 15:39:14 +0100
Message-ID: <527BA612.1040003@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:39:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQk1-0000LY-PE
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab3KGOjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:39:23 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36041 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370Ab3KGOjV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:39:21 -0500
Received: by mail-wi0-f180.google.com with SMTP id ey11so704019wid.7
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sLBvQPMbzttQtfg0Q3WIOblWZTD0xGDGpPNqHSHDbrQ=;
        b=A44Xq/OHUB8jV7orSQkNProtLJ+jOa1B8orZtdnnk0xkYt7IVSD8jmjOqVnYXpay8H
         iwIr1jyM7EfFcwTPY0S3qiBaLIVmb3BaWOanONjLTQUKBi5gAD9o0pLOfeB9JoYW/frr
         CFO5doD5ZXcjh50+yEWcJmCXcPDbjm3rbqhEP2kg0Nta8NbO21t5wI44EHrz6fPAdksh
         qIxnFPYhYy/EtPJKMOW9GasL8rJPTdqP6mvhVepTvo6GcpWLdFRrk5D2AlgE+WTz9eCq
         VEccSb+v3ppBL2HaXucEAQbfp6m9I3As9zabOtwMS4pcRllDseeyK6zrxJdNOZQLyv7x
         hSjQ==
X-Received: by 10.180.80.163 with SMTP id s3mr2964998wix.51.1383835160379;
        Thu, 07 Nov 2013 06:39:20 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id hv5sm35609623wib.2.2013.11.07.06.39.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:39:19 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237404>

Note: the "ce->next = NULL;" in unpack-trees.c::do_add_entry can safely be
removed, as ce->next (now ce->ent.next) is always properly initialized in
name-hash.c::hash_index_entry.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h        |  8 +++++---
 name-hash.c    | 24 ++++++++----------------
 unpack-trees.c |  1 -
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/cache.h b/cache.h
index 84e9ad6..cedc7ae 100644
--- a/cache.h
+++ b/cache.h
@@ -131,12 +131,12 @@ struct stat_data {
 };
 
 struct cache_entry {
+	struct hashmap_entry ent;
 	struct stat_data ce_stat_data;
 	unsigned int ce_mode;
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
-	struct cache_entry *next;
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -203,7 +203,9 @@ static inline void copy_cache_entry(struct cache_entry *dst,
 	unsigned int state = dst->ce_flags & CE_STATE_MASK;
 
 	/* Don't copy hash chain and name */
-	memcpy(dst, src, offsetof(struct cache_entry, next));
+	memcpy(&dst->ce_stat_data, &src->ce_stat_data,
+			offsetof(struct cache_entry, name) -
+			offsetof(struct cache_entry, ce_stat_data));
 
 	/* Restore the hash state */
 	dst->ce_flags = (dst->ce_flags & ~CE_STATE_MASK) | state;
@@ -278,7 +280,7 @@ struct index_state {
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
-	struct hash_table name_hash;
+	struct hashmap name_hash;
 	struct hashmap dir_hash;
 };
 
diff --git a/name-hash.c b/name-hash.c
index 116f56d..1ec82a3 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -100,19 +100,11 @@ static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
 
 static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 {
-	void **pos;
-	unsigned int hash;
-
 	if (ce->ce_flags & CE_HASHED)
 		return;
 	ce->ce_flags |= CE_HASHED;
-	ce->next = NULL;
-	hash = memihash(ce->name, ce_namelen(ce));
-	pos = insert_hash(hash, ce, &istate->name_hash);
-	if (pos) {
-		ce->next = *pos;
-		*pos = ce;
-	}
+	hashmap_entry_init(ce, memihash(ce->name, ce_namelen(ce)));
+	hashmap_add(&istate->name_hash, ce);
 
 	if (ignore_case && !(ce->ce_flags & CE_UNHASHED))
 		add_dir_entry(istate, ce);
@@ -124,8 +116,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 
 	if (istate->name_hash_initialized)
 		return;
-	if (istate->cache_nr)
-		preallocate_hash(&istate->name_hash, istate->cache_nr);
+	hashmap_init(&istate->name_hash, NULL, istate->cache_nr);
 	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp, 0);
 	for (nr = 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
@@ -221,18 +212,19 @@ struct cache_entry *index_dir_exists(struct index_state *istate, const char *nam
 
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
-	unsigned int hash = memihash(name, namelen);
 	struct cache_entry *ce;
+	struct hashmap_entry key;
 
 	lazy_init_name_hash(istate);
-	ce = lookup_hash(hash, &istate->name_hash);
 
+	hashmap_entry_init(&key, memihash(name, namelen));
+	ce = hashmap_get(&istate->name_hash, &key, NULL);
 	while (ce) {
 		if (!(ce->ce_flags & CE_UNHASHED)) {
 			if (same_name(ce, name, namelen, icase))
 				return ce;
 		}
-		ce = ce->next;
+		ce = hashmap_get_next(&istate->name_hash, ce);
 	}
 	return NULL;
 }
@@ -250,6 +242,6 @@ void free_name_hash(struct index_state *istate)
 		return;
 	istate->name_hash_initialized = 0;
 
-	free_hash(&istate->name_hash);
+	hashmap_free(&istate->name_hash, NULL);
 	hashmap_free(&istate->dir_hash, free);
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index ad3e9a0..f8985d4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -110,7 +110,6 @@ static void do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 	if (set & CE_REMOVE)
 		set |= CE_WT_REMOVE;
 
-	ce->next = NULL;
 	ce->ce_flags = (ce->ce_flags & ~clear) | set;
 	add_index_entry(&o->result, ce,
 			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
-- 
1.8.4.msysgit.0.12.g88f5ed0
