From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 06/14] diffcore-rename.c: use new hash map implementation
Date: Thu, 14 Nov 2013 20:20:26 +0100
Message-ID: <5285227A.6020001@gmail.com>
References: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:20:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2Ss-0000oY-Ho
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189Ab3KNTU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:20:27 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:63091 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab3KNTUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:20:25 -0500
Received: by mail-wg0-f41.google.com with SMTP id n12so1177898wgh.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Vm1N3MlTsyIDsXSyoKHsV5ZuxpdSS8fok+UUr1AS2iQ=;
        b=l8b1kPapTP4qFykRL04vmlfSR6VTtfCeIRdCl837MI4YXc70y8OhYT6Jl9GPQFdQ+o
         25gK6FIuZo6+mupmc+yDD6petDtSl0RyERG8f1zzeGvYryFxuHOgfxM+ZxGsnMzSpUje
         359dIx3wW3jDaskIYZz4ruo48KZd4BckM4Thz2QBUJ/aKqjfUfS2ULi7Pw+VXgsZyobd
         MvoMWNZu5DrjzTnCbqQ0g21be+mLwFoqAzNlPQNIpTDm7X3qBK3IPkvHgCxqgRfCSqox
         7oJBHBiXW1Sz1n1MlKYuSrb6h82oEQ/8akQah85P+ciHEik4fr+44oLVmfj7sN1rjF6H
         6I4w==
X-Received: by 10.194.122.99 with SMTP id lr3mr3455264wjb.21.1384456824119;
        Thu, 14 Nov 2013 11:20:24 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ey4sm1557002wic.11.2013.11.14.11.20.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:20:23 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52851FB5.4050406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237867>

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-rename.c | 48 +++++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index cfeb408..9b4f068 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -4,7 +4,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "hash.h"
+#include "hashmap.h"
 #include "progress.h"
 
 /* Table of rename/copy destinations */
@@ -243,9 +243,9 @@ static int score_compare(const void *a_, const void *b_)
 }
 
 struct file_similarity {
+	struct hashmap_entry entry;
 	int index;
 	struct diff_filespec *filespec;
-	struct file_similarity *next;
 };
 
 static unsigned int hash_filespec(struct diff_filespec *filespec)
@@ -260,21 +260,22 @@ static unsigned int hash_filespec(struct diff_filespec *filespec)
 	return hash;
 }
 
-static int find_identical_files(struct hash_table *srcs,
+static int find_identical_files(struct hashmap *srcs,
 				int dst_index,
 				struct diff_options *options)
 {
 	int renames = 0;
 
 	struct diff_filespec *target = rename_dst[dst_index].two;
-	struct file_similarity *p, *best;
+	struct file_similarity *p, *best, dst;
 	int i = 100, best_score = -1;
 
 	/*
 	 * Find the best source match for specified destination.
 	 */
 	best = NULL;
-	for (p = lookup_hash(hash_filespec(target), srcs); p; p = p->next) {
+	hashmap_entry_init(&dst, hash_filespec(target));
+	for (p = hashmap_get(srcs, &dst, NULL); p; p = hashmap_get_next(srcs, p)) {
 		int score;
 		struct diff_filespec *source = p->filespec;
 
@@ -309,34 +310,15 @@ static int find_identical_files(struct hash_table *srcs,
 	return renames;
 }
 
-static int free_similarity_list(void *p, void *unused)
+static void insert_file_table(struct hashmap *table, int index, struct diff_filespec *filespec)
 {
-	while (p) {
-		struct file_similarity *entry = p;
-		p = entry->next;
-		free(entry);
-	}
-	return 0;
-}
-
-static void insert_file_table(struct hash_table *table, int index, struct diff_filespec *filespec)
-{
-	void **pos;
-	unsigned int hash;
 	struct file_similarity *entry = xmalloc(sizeof(*entry));
 
 	entry->index = index;
 	entry->filespec = filespec;
-	entry->next = NULL;
-
-	hash = hash_filespec(filespec);
-	pos = insert_hash(hash, entry, table);
 
-	/* We already had an entry there? */
-	if (pos) {
-		entry->next = *pos;
-		*pos = entry;
-	}
+	hashmap_entry_init(entry, hash_filespec(filespec));
+	hashmap_add(table, entry);
 }
 
 /*
@@ -349,11 +331,10 @@ static void insert_file_table(struct hash_table *table, int index, struct diff_f
 static int find_exact_renames(struct diff_options *options)
 {
 	int i, renames = 0;
-	struct hash_table file_table;
+	struct hashmap file_table;
 
 	/* Add all sources to the hash table */
-	init_hash(&file_table);
-	preallocate_hash(&file_table, rename_src_nr);
+	hashmap_init(&file_table, NULL, rename_src_nr);
 	for (i = 0; i < rename_src_nr; i++)
 		insert_file_table(&file_table, i, rename_src[i].p->one);
 
@@ -361,11 +342,8 @@ static int find_exact_renames(struct diff_options *options)
 	for (i = 0; i < rename_dst_nr; i++)
 		renames += find_identical_files(&file_table, i, options);
 
-	/* Free source file_similarity chains */
-	for_each_hash(&file_table, free_similarity_list, options);
-
-	/* .. and free the hash data structure */
-	free_hash(&file_table);
+	/* Free the hash data structure and entries */
+	hashmap_free(&file_table, 1);
 
 	return renames;
 }
-- 
1.8.5.rc0.333.g5394214
