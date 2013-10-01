From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v3 04/11] diffcore-rename.c: simplify finding exact renames
Date: Tue, 01 Oct 2013 11:36:48 +0200
Message-ID: <524A97B0.9040000@gmail.com>
References: <524A96FF.5090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 01 11:36:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQwNz-0004nA-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 11:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab3JAJgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 05:36:51 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:63063 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab3JAJgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 05:36:50 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so3223864eae.23
        for <git@vger.kernel.org>; Tue, 01 Oct 2013 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ej/QjkrEuHmyBHwmxEfMT2p771uuRyV6/EzhIL6hXk0=;
        b=foOYVNyjz/oVrrRToluQ9hD+qnx4YJcbSIr77vizoTclw6WeNi45dSL9lQLrQ87bK3
         M5I+sbZLZUv120Ev3FS9qrq8HXMUa9mLnqwwkliBB2z5SupZi+e2lSjhdfH8mIDLllQC
         QY/jzcWBCEEQhcwv42HmBzTmLz2epFY2DsDfz3fYqkT3XwOkY8BXVve4+G0LwM160YyS
         LeCzz4I0EbH3UTaVZRARb63Y/3Oiz4XWtg+NUTkmfpQ/F3Ex7mv4qTdssRUQJYB/cxzh
         ObZJGTH748OQNsiyCpEnjXPWc7wnssYEeUfEJjqI2yUO+/57c+H9vYe7S6+Yd5O3k6Hy
         KlRg==
X-Received: by 10.14.95.137 with SMTP id p9mr1575099eef.73.1380620209107;
        Tue, 01 Oct 2013 02:36:49 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id h45sm11118185eeg.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 02:36:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <524A96FF.5090604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235648>

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
1.8.4.11.g4f52745.dirty
