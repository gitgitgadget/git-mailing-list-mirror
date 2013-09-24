From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 5/5] diffcore-rename.c: use new hash map implementation
Date: Tue, 24 Sep 2013 11:54:09 +0200
Message-ID: <52416141.40907@gmail.com>
References: <522FAAC4.2080601@gmail.com> <52416058.90008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 24 11:54:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOPJv-00055a-M8
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 11:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931Ab3IXJyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 05:54:12 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:40164 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab3IXJyL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 05:54:11 -0400
Received: by mail-we0-f178.google.com with SMTP id u57so4364148wes.9
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=stpeFsNzTNHfbmSD/KLtqXYUBZXeGH1+Sfr78dwBDZg=;
        b=hi9PmNKS16sUvTytA0rLNuYWCqTLB+EXJYI83WIjuq6k56zQYq1+LH+1EbqesTptua
         c24z/1HE7GCku+yIF4P04SXLhzC93wsr4LyB01DYOQSd51x35CEaRnIawetC1qZLq710
         jSDgctjpquBaayGp2V7p1ikAaw4NegfNDIMR/TokIG1g7fsjPxCrfx6L9z+AS6wCrzxq
         3Wtv1dECo3bIO0PbXCBUdHmuUbnxSI5n7qaP3EzN44fZStwpOXzK/h6mvTAeWo/wzM4Q
         Uq0pK62OWT1KqIv0kUCpQOD7Um15mc1ID5/kfKqZoHH7fZj9KmSxmb14FxuqG1NNcdAQ
         LKGQ==
X-Received: by 10.180.183.51 with SMTP id ej19mr17468919wic.60.1380016449908;
        Tue, 24 Sep 2013 02:54:09 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ey4sm5793598wic.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 02:54:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <52416058.90008@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235295>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 diffcore-rename.c | 48 +++++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 82b7975..2e70d31 100644
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
+	hashmap_entry_init(&dst, hash_filespec(target), 0);
+	for (p = hashmap_get(srcs, &dst); p; p = hashmap_get_next(srcs, p)) {
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
+	hashmap_entry_init(entry, hash_filespec(filespec), 0);
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
1.8.4.5.gef01589.dirty
