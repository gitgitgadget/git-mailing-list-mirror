From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH/RFC 4/5] diffcore-rename.c: simplify finding exact renames
Date: Wed, 11 Sep 2013 01:30:08 +0200
Message-ID: <522FAB80.9020406@gmail.com>
References: <522FAAC4.2080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 11 01:30:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJXNw-00026T-9z
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 01:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab3IJXaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 19:30:10 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:32898 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab3IJXaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 19:30:09 -0400
Received: by mail-ea0-f170.google.com with SMTP id h14so4345739eak.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 16:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=CdhdpohcL/jcjnlJ892wjzIY7/xtRaEsZvrcUlAmNfw=;
        b=KocHIaBnmiqXSSt3feqHW3iOJMXjBFonJaH2P1PfvCUZ75TIAVxhQyOzUdwmeIWr43
         wFhLbClvrkbuepPla3WyfyzeCAAl8lbgj6925QbaubFQ+czA2KdajqUxqO9uAfwDOubC
         bv5YKVOmSjmY1CdnLhQyPLKIoRRkL77a2KL8pMO91e8gcIKVwsCSuCrXlp7bYLK+atPi
         WEPh2iBRm5hoFyeQukQbFtqHspgS5z8JX7+l4nEezfEJnViQI51uRAINCVEujOQ0lQ+H
         9lFvJkBhSU42fBl19+MbEn0mGE+EQgxu0tcEjmreQPNfddKrbvhyxedlAbW8kxS8e17N
         hDsA==
X-Received: by 10.14.174.195 with SMTP id x43mr16551536eel.47.1378855807902;
        Tue, 10 Sep 2013 16:30:07 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id j7sm35446670eeo.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 16:30:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <522FAAC4.2080601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234512>

The find_exact_renames function currently only uses the hash table for
grouping, i.e.:

1. add sources
2. add destinations
3. iterate all buckets, per bucket:
4. split sources from destinations
5. iterate destinations, per destination:
6. iterate sources to find best match

This can be simplified by utilizing the lookup functionality of the hash
table, i.e.:

1. add sources
2. iterate destinations, per destination:
3. lookup sources matching the current destination
4. iterate sources to find best match

This saves several iterations and file_similarity allocations for the
destinations.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 diffcore-rename.c | 75 +++++++++++++++----------------------------------------
 1 file changed, 20 insertions(+), 55 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 008a60c..82b7975 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -243,7 +243,7 @@ static int score_compare(const void *a_, const void *b_)
 }
 
 struct file_similarity {
-	int src_dst, index;
+	int index;
 	struct diff_filespec *filespec;
 	struct file_similarity *next;
 };
@@ -260,25 +260,21 @@ static unsigned int hash_filespec(struct diff_filespec *filespec)
 	return hash;
 }
 
-static int find_identical_files(struct file_similarity *src,
-				struct file_similarity *dst,
+static int find_identical_files(struct hash_table *srcs,
+				int dst_index,
 				struct diff_options *options)
 {
 	int renames = 0;
 
-	/*
-	 * Walk over all the destinations ...
-	 */
-	do {
-	struct diff_filespec *target = dst->filespec;
+	struct diff_filespec *target = rename_dst[dst_index].two;
 	struct file_similarity *p, *best;
 	int i = 100, best_score = -1;
 
 	/*
-	 * .. to find the best source match
+	 * Find the best source match for specified destination.
 	 */
 	best = NULL;
-	for (p = src; p; p = p->next) {
+	for (p = lookup_hash(hash_filespec(target), srcs); p; p = p->next) {
 		int score;
 		struct diff_filespec *source = p->filespec;
 
@@ -307,61 +303,28 @@ static int find_identical_files(struct file_similarity *src,
 			break;
 	}
 	if (best) {
-		record_rename_pair(dst->index, best->index, MAX_SCORE);
+		record_rename_pair(dst_index, best->index, MAX_SCORE);
 		renames++;
 	}
-	} while ((dst = dst->next) != NULL);
 	return renames;
 }
 
-static void free_similarity_list(struct file_similarity *p)
+static int free_similarity_list(void *p, void *unused)
 {
 	while (p) {
 		struct file_similarity *entry = p;
-		p = p->next;
+		p = entry->next;
 		free(entry);
 	}
+	return 0;
 }
 
-static int find_same_files(void *ptr, void *data)
-{
-	int ret;
-	struct file_similarity *p = ptr;
-	struct file_similarity *src = NULL, *dst = NULL;
-	struct diff_options *options = data;
-
-	/* Split the hash list up into sources and destinations */
-	do {
-		struct file_similarity *entry = p;
-		p = p->next;
-		if (entry->src_dst < 0) {
-			entry->next = src;
-			src = entry;
-		} else {
-			entry->next = dst;
-			dst = entry;
-		}
-	} while (p);
-
-	/*
-	 * If we have both sources *and* destinations, see if
-	 * we can match them up
-	 */
-	ret = (src && dst) ? find_identical_files(src, dst, options) : 0;
-
-	/* Free the hashes and return the number of renames found */
-	free_similarity_list(src);
-	free_similarity_list(dst);
-	return ret;
-}
-
-static void insert_file_table(struct hash_table *table, int src_dst, int index, struct diff_filespec *filespec)
+static void insert_file_table(struct hash_table *table, int index, struct diff_filespec *filespec)
 {
 	void **pos;
 	unsigned int hash;
 	struct file_similarity *entry = xmalloc(sizeof(*entry));
 
-	entry->src_dst = src_dst;
 	entry->index = index;
 	entry->filespec = filespec;
 	entry->next = NULL;
@@ -385,24 +348,26 @@ static void insert_file_table(struct hash_table *table, int src_dst, int index,
  */
 static int find_exact_renames(struct diff_options *options)
 {
-	int i;
+	int i, renames;
 	struct hash_table file_table;
 
+	/* Add all sources to the hash table */
 	init_hash(&file_table);
-	preallocate_hash(&file_table, rename_src_nr + rename_dst_nr);
+	preallocate_hash(&file_table, rename_src_nr);
 	for (i = 0; i < rename_src_nr; i++)
-		insert_file_table(&file_table, -1, i, rename_src[i].p->one);
+		insert_file_table(&file_table, i, rename_src[i].p->one);
 
+	/* Walk the destinations and find best source match */
 	for (i = 0; i < rename_dst_nr; i++)
-		insert_file_table(&file_table, 1, i, rename_dst[i].two);
+		renames += find_identical_files(&file_table, i, options);
 
-	/* Find the renames */
-	i = for_each_hash(&file_table, find_same_files, options);
+	/* Free source file_similarity chains */
+	for_each_hash(&file_table, free_similarity_list, options);
 
 	/* .. and free the hash data structure */
 	free_hash(&file_table);
 
-	return i;
+	return renames;
 }
 
 #define NUM_CANDIDATE_PER_DST 4
-- 
1.8.4.8243.gbcbdefd
