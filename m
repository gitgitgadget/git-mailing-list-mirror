From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 05/14] diffcore-rename.c: simplify finding exact renames
Date: Thu, 07 Nov 2013 15:36:45 +0100
Message-ID: <527BA57D.9070400@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:36:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQhT-0002Ib-Av
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab3KGOgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:36:44 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:56699 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab3KGOgn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:36:43 -0500
Received: by mail-wg0-f49.google.com with SMTP id x12so598835wgg.4
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XQZ923wID0gWsUTjOhxxmNhcUl82slrrGB27XDAtQUI=;
        b=SFkF0vXxqWz8Nw+fq8F1m9XKW/mifzLnuoyDBl5xCtoyxgIOGmrs5DWyPc2TL9dvsM
         HRsbEv3eqkMiSay2X8evcEHed7IgjlB7aEPpxd9mBeCqbu2VtfWT5d0FwsrteGlMIPLS
         p7PTbxlL1pInQFiDt7SVDtczOLQLDIB9f43/7nG0aElrtabG+r7c8nN5sv/zBguyM7uN
         M9qflddF0aKy/G3Xanp6o/CS+GYkRgMOTwnWs/Y4ygwWrPe7AcnG1Rt1foTPHNpAdaVj
         IHPtV2Pow8xeLH0sNmW74P9fzY5Lj8ey4XRs3KU7ZywDlvI3bU5YriiDze7KVislHJ5b
         7P0Q==
X-Received: by 10.180.37.134 with SMTP id y6mr2979639wij.48.1383835002080;
        Thu, 07 Nov 2013 06:36:42 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ey4sm7479719wic.11.2013.11.07.06.36.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:36:41 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237400>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-rename.c | 75 +++++++++++++++----------------------------------------
 1 file changed, 20 insertions(+), 55 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 008a60c..cfeb408 100644
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
+	int i, renames = 0;
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
1.8.4.msysgit.0.12.g88f5ed0
