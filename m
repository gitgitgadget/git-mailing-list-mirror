From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v3 08/11] name-hash.c: use new hash map implementation for
 cache entries
Date: Tue, 01 Oct 2013 11:39:03 +0200
Message-ID: <524A9837.7040308@gmail.com>
References: <524A96FF.5090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 01 11:39:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQwQA-0006Mw-FX
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 11:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab3JAJjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 05:39:06 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:65180 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab3JAJjE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 05:39:04 -0400
Received: by mail-ee0-f48.google.com with SMTP id l10so3263897eei.21
        for <git@vger.kernel.org>; Tue, 01 Oct 2013 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xR0F/pK7BLTGIVGCYCrVqE+VO7F3r63bIOsNWOqe9YY=;
        b=gcEygnqxV29FNqZ6VEFT22TsKM7HTfqeuc6e/+dgHsjK9hJGqkDjz5BTST7RPqS/Tj
         KwCcUQBBbV9t3yAur8hzEmnUHTCgymYr52TkKQWbgcfmiDBJsERAJxyJP9y45Q89hPfh
         GayLoJ7lQgXs2qFAUgkyHBzTfjqPJ5lP+M8zvhKba0DHrczSUfj7EZx0coh1b+DN/WUH
         7amR64/UkCh/pp2kW5DnZ3CHXU1UyWFOlq1AnjgAl1kUxIm00X+4VRZRBxnMNMMzQgVM
         XRl2f6+wIw4wJ5Wb1TmqLVNcyUAVtXThLn4+KeIpPTPDkJdk4jJshtywqmtk7PtJcb8v
         XkFg==
X-Received: by 10.15.33.132 with SMTP id c4mr45226156eev.2.1380620343415;
        Tue, 01 Oct 2013 02:39:03 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id n48sm11055312eeg.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 02:39:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <524A96FF.5090604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235652>

Note: the "ce->next = NULL;" in unpack-trees.c::do_add_entry can safely be
removed, as ce->next (now ce->ent.next) is always properly initialized in
name-hash.c::hash_index_entry.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 cache.h        |  8 +++++---
 name-hash.c    | 24 ++++++++----------------
 unpack-trees.c |  1 -
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/cache.h b/cache.h
index bf6e2f0..46309c6 100644
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
 
@@ -201,7 +201,9 @@ static inline void copy_cache_entry(struct cache_entry *dst,
 	unsigned int state = dst->ce_flags & CE_STATE_MASK;
 
 	/* Don't copy hash chain and name */
-	memcpy(dst, src, offsetof(struct cache_entry, next));
+	memcpy(&dst->ce_stat_data, &src->ce_stat_data,
+			offsetof(struct cache_entry, name) -
+			offsetof(struct cache_entry, ce_stat_data));
 
 	/* Restore the hash state */
 	dst->ce_flags = (dst->ce_flags & ~CE_STATE_MASK) | state;
@@ -276,7 +278,7 @@ struct index_state {
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
-	struct hash_table name_hash;
+	struct hashmap name_hash;
 	struct hashmap dir_hash;
 };
 
diff --git a/name-hash.c b/name-hash.c
index ce54fb3..4879ce4 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -99,19 +99,11 @@ static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
 
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
@@ -123,8 +115,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 
 	if (istate->name_hash_initialized)
 		return;
-	if (istate->cache_nr)
-		preallocate_hash(&istate->name_hash, istate->cache_nr);
+	hashmap_init(&istate->name_hash, NULL, istate->cache_nr);
 	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp, 0);
 	for (nr = 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
@@ -198,18 +189,19 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 
 struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
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
 
 	/*
@@ -243,6 +235,6 @@ void free_name_hash(struct index_state *istate)
 		return;
 	istate->name_hash_initialized = 0;
 
-	free_hash(&istate->name_hash);
+	hashmap_free(&istate->name_hash, NULL);
 	hashmap_free(&istate->dir_hash, free);
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index bf01717..9c108a2 100644
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
1.8.4.11.g4f52745.dirty
