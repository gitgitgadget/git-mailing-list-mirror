From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 7/8] name-hash: allow dir hashing even when !ignore_case
Date: Sat,  6 Sep 2014 19:57:05 +0200
Message-ID: <4d43fca586637dcb02b2b19c8d8a6dcfe368e059.1409860234.git.tr@thomasrast.ch>
References: <cover.1409860234.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 19:57:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQKFA-0005v0-PG
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 19:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbaIFR5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 13:57:30 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:40789 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbaIFR53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 13:57:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id D83324D6686;
	Sat,  6 Sep 2014 19:57:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id tpkurKCVD2h1; Sat,  6 Sep 2014 19:57:20 +0200 (CEST)
Received: from linux.local (unknown [65.50.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 495114D66AD;
	Sat,  6 Sep 2014 19:57:19 +0200 (CEST)
X-Mailer: git-send-email 2.1.0.72.g9b94086
In-Reply-To: <cover.1409860234.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256598>

The directory hash (for fast checks if the index already has a
directory) was only used in ignore_case mode and so depended on that
flag.

Make it generally available on request.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 cache.h     |  2 ++
 name-hash.c | 13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 4d5b76c..c54b2e1 100644
--- a/cache.h
+++ b/cache.h
@@ -306,6 +306,7 @@ struct index_state {
 	struct split_index *split_index;
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
+		 has_dir_hash : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
@@ -315,6 +316,7 @@ struct index_state {
 extern struct index_state the_index;
 
 /* Name hashing */
+extern void init_name_hash(struct index_state *istate, int force_dir_hash);
 extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
 extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
 extern void free_name_hash(struct index_state *istate);
diff --git a/name-hash.c b/name-hash.c
index 702cd05..22e3ec6 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -106,7 +106,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	hashmap_entry_init(ce, memihash(ce->name, ce_namelen(ce)));
 	hashmap_add(&istate->name_hash, ce);
 
-	if (ignore_case)
+	if (istate->has_dir_hash)
 		add_dir_entry(istate, ce);
 }
 
@@ -121,7 +121,7 @@ static int cache_entry_cmp(const struct cache_entry *ce1,
 	return remove ? !(ce1 == ce2) : 0;
 }
 
-static void lazy_init_name_hash(struct index_state *istate)
+void init_name_hash(struct index_state *istate, int force_dir_hash)
 {
 	int nr;
 
@@ -130,6 +130,9 @@ static void lazy_init_name_hash(struct index_state *istate)
 	hashmap_init(&istate->name_hash, (hashmap_cmp_fn) cache_entry_cmp,
 			istate->cache_nr);
 	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp, 0);
+
+	istate->has_dir_hash = force_dir_hash || ignore_case;
+
 	for (nr = 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized = 1;
@@ -148,7 +151,7 @@ void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
 	ce->ce_flags &= ~CE_HASHED;
 	hashmap_remove(&istate->name_hash, ce, ce);
 
-	if (ignore_case)
+	if (istate->has_dir_hash)
 		remove_dir_entry(istate, ce);
 }
 
@@ -193,7 +196,7 @@ struct cache_entry *index_dir_exists(struct index_state *istate, const char *nam
 	struct cache_entry *ce;
 	struct dir_entry *dir;
 
-	lazy_init_name_hash(istate);
+	init_name_hash(istate, 0);
 	dir = find_dir_entry(istate, name, namelen);
 	if (dir && dir->nr)
 		return dir->ce;
@@ -214,7 +217,7 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 {
 	struct cache_entry *ce;
 
-	lazy_init_name_hash(istate);
+	init_name_hash(istate, 0);
 
 	ce = hashmap_get_from_hash(&istate->name_hash,
 				   memihash(name, namelen), NULL);
-- 
2.1.0.72.g9b94086
