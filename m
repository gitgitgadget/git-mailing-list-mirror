From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 7/8] name-hash: allow dir hashing even when !ignore_case
Date: Sat, 22 Feb 2014 10:17:55 +0100
Message-ID: <38527c9f6ae31ad39d8f3dddfe5252a3527629ed.1393059605.git.tr@thomasrast.ch>
References: <cover.1393059605.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 10:18:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH8iv-0003R2-Ed
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 10:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbaBVJSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 04:18:10 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:34848 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbaBVJSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 04:18:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 69C404D64BD;
	Sat, 22 Feb 2014 10:18:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id O2-DIb2xRkXg; Sat, 22 Feb 2014 10:18:05 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 577A34D65EE;
	Sat, 22 Feb 2014 10:18:03 +0100 (CET)
X-Mailer: git-send-email 1.9.0.313.g3d0a325
In-Reply-To: <cover.1393059605.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242515>

The directory hash (for fast checks if the index already has a
directory) was only used in ignore_case mode and so depended on that
flag.

Make it generally available on request.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 cache.h     |  2 ++
 name-hash.c | 19 ++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index dc040fb..e162021 100644
--- a/cache.h
+++ b/cache.h
@@ -276,6 +276,7 @@ struct index_state {
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
+		 has_dir_hash : 1,
 		 initialized : 1;
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
@@ -284,6 +285,7 @@ struct index_state {
 extern struct index_state the_index;
 
 /* Name hashing */
+extern void init_name_hash(struct index_state *istate, int force_dir_hash);
 extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
 extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
 extern void free_name_hash(struct index_state *istate);
diff --git a/name-hash.c b/name-hash.c
index e5b6e1a..c8953be 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -141,16 +141,19 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		*pos = ce;
 	}
 
-	if (ignore_case && !(ce->ce_flags & CE_UNHASHED))
+	if (istate->has_dir_hash && !(ce->ce_flags & CE_UNHASHED))
 		add_dir_entry(istate, ce);
 }
 
-static void lazy_init_name_hash(struct index_state *istate)
+void init_name_hash(struct index_state *istate, int force_dir_hash)
 {
 	int nr;
 
 	if (istate->name_hash_initialized)
 		return;
+
+	istate->has_dir_hash = force_dir_hash || ignore_case;
+
 	if (istate->cache_nr)
 		preallocate_hash(&istate->name_hash, istate->cache_nr);
 	for (nr = 0; nr < istate->cache_nr; nr++)
@@ -161,7 +164,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 void add_name_hash(struct index_state *istate, struct cache_entry *ce)
 {
 	/* if already hashed, add reference to directory entries */
-	if (ignore_case && (ce->ce_flags & CE_STATE_MASK) == CE_STATE_MASK)
+	if (istate->has_dir_hash && (ce->ce_flags & CE_STATE_MASK) == CE_STATE_MASK)
 		add_dir_entry(istate, ce);
 
 	ce->ce_flags &= ~CE_UNHASHED;
@@ -181,7 +184,7 @@ void add_name_hash(struct index_state *istate, struct cache_entry *ce)
 void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
 {
 	/* if already hashed, release reference to directory entries */
-	if (ignore_case && (ce->ce_flags & CE_STATE_MASK) == CE_HASHED)
+	if (istate->has_dir_hash && (ce->ce_flags & CE_STATE_MASK) == CE_HASHED)
 		remove_dir_entry(istate, ce);
 
 	ce->ce_flags |= CE_UNHASHED;
@@ -228,7 +231,7 @@ struct cache_entry *index_dir_exists(struct index_state *istate, const char *nam
 	struct cache_entry *ce;
 	struct dir_entry *dir;
 
-	lazy_init_name_hash(istate);
+	init_name_hash(istate, 0);
 	dir = find_dir_entry(istate, name, namelen);
 	if (dir && dir->nr)
 		return dir->ce;
@@ -250,7 +253,7 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 	unsigned int hash = hash_name(name, namelen);
 	struct cache_entry *ce;
 
-	lazy_init_name_hash(istate);
+	init_name_hash(istate, 0);
 	ce = lookup_hash(hash, &istate->name_hash);
 
 	while (ce) {
@@ -286,9 +289,11 @@ void free_name_hash(struct index_state *istate)
 	if (!istate->name_hash_initialized)
 		return;
 	istate->name_hash_initialized = 0;
-	if (ignore_case)
+	if (istate->has_dir_hash) {
 		/* free directory entries */
 		for_each_hash(&istate->dir_hash, free_dir_entry, NULL);
+		istate->has_dir_hash = 0;
+	}
 
 	free_hash(&istate->name_hash);
 	free_hash(&istate->dir_hash);
-- 
1.9.0.313.g3d0a325
