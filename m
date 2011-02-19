From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] for_each_hash: allow passing a 'void *data' pointer to
 callback
Date: Fri, 18 Feb 2011 20:25:11 -0800 (PST)
Message-ID: <alpine.LFD.2.02.1102182023120.4165@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 05:25:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqeNo-0000Uq-5g
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 05:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab1BSEZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 23:25:20 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:32877 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab1BSEZS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 23:25:18 -0500
Received: by yxt3 with SMTP id 3so1895301yxt.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 20:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:x-x-sender:to:subject
         :message-id:user-agent:mime-version:content-type;
        bh=6a1OVAxINOHJFLr5BkqZ8s14ZwyeS1CBRJHubZnrZh4=;
        b=Gv28qZ5Ick132jlUw7DW60getTa+V/eZ1i9DtaO7Az0RU1QVfdR0QOdMGnE7jZxQEI
         pudSzWYAD6Z6Pmc2slZujHwpLgbNiv+G1K4Q/oxmPVciCOU/Q++ajE9pdLUNa2Ox4GL+
         zBpu4KxtUYfgmH/nS0DznXHpNMAUOXPfCF27g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:x-x-sender:to:subject:message-id:user-agent
         :mime-version:content-type;
        b=cVwzW3Bno6D0cT/08iQbihtztwzKjs8RcStd7Jb4I78AmCkp+mrUr21c3qeo78Rzcg
         s2fVBwsqtQO3SAnRNN17HtRu2ueJYTHSWXMhqCgGajvfpx+318Us/B5sYA2NcQa6gG2f
         KM5DCTsfP2wx9ishttgXeh2s7s+ZjtpXZ7Umc=
Received: by 10.150.44.12 with SMTP id r12mr1695847ybr.428.1298089517771;
        Fri, 18 Feb 2011 20:25:17 -0800 (PST)
Received: from i5.linux-foundation.org (c-24-22-0-219.hsd1.or.comcast.net [24.22.0.219])
        by mx.google.com with ESMTPS id r24sm896831yba.18.2011.02.18.20.25.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 20:25:17 -0800 (PST)
X-X-Sender: torvalds@i5.linux-foundation.org
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167248>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Feb 2011 19:55:19 -0800

For the find_exact_renames() function, this allows us to pass the
diff_options structure pointer to the low-level routines.  We will use
that to distinguish between the "rename" and "copy" cases.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

So I changed the "int flag" to a "void *data". That should be more 
flexible, with the slight downside that there are now two "void *" 
pointers, and the callback routine obviously has to know that the first 
one is the one from the hash chain, and the other one is the "data" 
helper.

This does NOT change any semantics. It is purely setup code that passes 
the new pointer around, but doesn't actually use it.

 builtin/describe.c |    4 ++--
 diffcore-rename.c  |   14 ++++++++------
 hash.c             |    4 ++--
 hash.h             |    2 +-
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 342129f..3ba26dc 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -63,7 +63,7 @@ static inline struct commit_name *find_commit_name(const unsigned char *peeled)
 	return n;
 }
 
-static int set_util(void *chain)
+static int set_util(void *chain, void *data)
 {
 	struct commit_name *n;
 	for (n = chain; n; n = n->next) {
@@ -289,7 +289,7 @@ static void describe(const char *arg, int last_one)
 		fprintf(stderr, "searching to describe %s\n", arg);
 
 	if (!have_util) {
-		for_each_hash(&names, set_util);
+		for_each_hash(&names, set_util, NULL);
 		have_util = 1;
 	}
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index df41be5..e5e88fe 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -247,7 +247,8 @@ struct file_similarity {
 };
 
 static int find_identical_files(struct file_similarity *src,
-				struct file_similarity *dst)
+				struct file_similarity *dst,
+				struct diff_options *options)
 {
 	int renames = 0;
 
@@ -306,11 +307,12 @@ static void free_similarity_list(struct file_similarity *p)
 	}
 }
 
-static int find_same_files(void *ptr)
+static int find_same_files(void *ptr, void *data)
 {
 	int ret;
 	struct file_similarity *p = ptr;
 	struct file_similarity *src = NULL, *dst = NULL;
+	struct diff_options *options = data;
 
 	/* Split the hash list up into sources and destinations */
 	do {
@@ -329,7 +331,7 @@ static int find_same_files(void *ptr)
 	 * If we have both sources *and* destinations, see if
 	 * we can match them up
 	 */
-	ret = (src && dst) ? find_identical_files(src, dst) : 0;
+	ret = (src && dst) ? find_identical_files(src, dst, options) : 0;
 
 	/* Free the hashes and return the number of renames found */
 	free_similarity_list(src);
@@ -377,7 +379,7 @@ static void insert_file_table(struct hash_table *table, int src_dst, int index,
  * and then during the second round we try to match
  * cache-dirty entries as well.
  */
-static int find_exact_renames(void)
+static int find_exact_renames(struct diff_options *options)
 {
 	int i;
 	struct hash_table file_table;
@@ -390,7 +392,7 @@ static int find_exact_renames(void)
 		insert_file_table(&file_table, 1, i, rename_dst[i].two);
 
 	/* Find the renames */
-	i = for_each_hash(&file_table, find_same_files);
+	i = for_each_hash(&file_table, find_same_files, options);
 
 	/* .. and free the hash data structure */
 	free_hash(&file_table);
@@ -467,7 +469,7 @@ void diffcore_rename(struct diff_options *options)
 	 * We really want to cull the candidates list early
 	 * with cheap tests in order to avoid doing deltas.
 	 */
-	rename_count = find_exact_renames();
+	rename_count = find_exact_renames(options);
 
 	/* Did we only want exact renames? */
 	if (minimum_score == MAX_SCORE)
diff --git a/hash.c b/hash.c
index 1cd4c9d..749ecfe 100644
--- a/hash.c
+++ b/hash.c
@@ -81,7 +81,7 @@ void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table)
 	return insert_hash_entry(hash, ptr, table);
 }
 
-int for_each_hash(const struct hash_table *table, int (*fn)(void *))
+int for_each_hash(const struct hash_table *table, int (*fn)(void *, void *), void *data)
 {
 	int sum = 0;
 	unsigned int i;
@@ -92,7 +92,7 @@ int for_each_hash(const struct hash_table *table, int (*fn)(void *))
 		void *ptr = array->ptr;
 		array++;
 		if (ptr) {
-			int val = fn(ptr);
+			int val = fn(ptr, data);
 			if (val < 0)
 				return val;
 			sum += val;
diff --git a/hash.h b/hash.h
index 69e33a4..b875ce6 100644
--- a/hash.h
+++ b/hash.h
@@ -30,7 +30,7 @@ struct hash_table {
 
 extern void *lookup_hash(unsigned int hash, const struct hash_table *table);
 extern void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table);
-extern int for_each_hash(const struct hash_table *table, int (*fn)(void *));
+extern int for_each_hash(const struct hash_table *table, int (*fn)(void *, void *), void *data);
 extern void free_hash(struct hash_table *table);
 
 static inline void init_hash(struct hash_table *table)
-- 
1.7.4.1.51.g2bf8a
