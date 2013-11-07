From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 06/14] diffcore-rename.c: use new hash map implementation
Date: Thu, 07 Nov 2013 15:37:40 +0100
Message-ID: <527BA5B4.4080101@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:37:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQiM-0004Yr-L6
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab3KGOhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:37:40 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:58479 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab3KGOhi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:37:38 -0500
Received: by mail-bk0-f47.google.com with SMTP id d7so267514bkh.34
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jfuWUjzbxvgwv9mP1vd3AtY5xD7uSufgk5Ut2wnPTP4=;
        b=CkN5R6edVJHCG+xRdd2w0YHpV0HIiwofm3OwVFtcfaec42IEbg/xpsRIAZ+9L2sn41
         daf1X18+W7a8+ZinxRmbgkg8FRQumrxFYyy6ofUb3ffhOTsx9ZgjhRqnXUHB1U0p7CBL
         hnCsXKqjreDOJHsWa1GqWJYRU941v4AScKsm6mG2XFE7XgjWRIsAT7ho2VcidSzErtfs
         LoSL2ig1v6Hth2/hpMSVQa3WiVm7CO1epDttELsia56mvCkwKJkJI/i/QVlYdp4YhEni
         uj2Hjsi4SWHjBjajRstVdGc0j/NeyZM87DATKKMU7U1A6JpU4o8YIZ/OyoS/XiWg+t5C
         6q6g==
X-Received: by 10.204.197.207 with SMTP id el15mr69902bkb.72.1383835057523;
        Thu, 07 Nov 2013 06:37:37 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id pu8sm2563533bkb.9.2013.11.07.06.37.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:37:36 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237401>

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-rename.c | 48 +++++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index cfeb408..d996c6a 100644
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
+	hashmap_free(&file_table, free);
 
 	return renames;
 }
-- 
1.8.4.msysgit.0.12.g88f5ed0
