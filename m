From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v3 05/11] diffcore-rename.c: use new hash map implementation
Date: Tue, 01 Oct 2013 11:37:19 +0200
Message-ID: <524A97CF.3040403@gmail.com>
References: <524A96FF.5090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 01 11:37:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQwOT-00056P-1W
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 11:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab3JAJhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 05:37:21 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:56444 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3JAJhU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 05:37:20 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so3305946eek.30
        for <git@vger.kernel.org>; Tue, 01 Oct 2013 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IPqE16YBBD697T2JheXQvwCh13jz6TKzaYWvlBu225Q=;
        b=HBRtQ99mFWKwgM6hyOQGv0LVq5wPQvK4BQaJu/k2IMif/OBAACsESxIO4DzPcKksEp
         A9Zu7JfqjULh6JJXj496F0yWcRVnlxzZo0+Ca+I+U9Ie2W9/V4YAvnITiZFs5VTDlmdx
         CT0meu/VnIM9ATnKqhY3nts4zw9NblXWUKak18T7nfWgXSNFeudk+pX0IasCf2NgkWYl
         ppHBOCqCehQHiBSpaXHvTsKiAYZovcsYWKFrsj3x5p4qCvqHXCDjmgigDRL7Lm20722W
         WDE9xCyhog6fF3FexsRerA2MiG2alqE2zkLL/Dt8QiN4/MXQwhSAxn7RheLrNgXLvY1K
         m5Og==
X-Received: by 10.15.44.199 with SMTP id z47mr1614460eev.64.1380620239814;
        Tue, 01 Oct 2013 02:37:19 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id x47sm11035285eea.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 02:37:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <524A96FF.5090604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235649>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 diffcore-rename.c | 48 +++++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 82b7975..c6bd776 100644
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
 	int i, renames;
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
+	hashmap_free(&file_table, free);
 
 	return renames;
 }
-- 
1.8.4.11.g4f52745.dirty
