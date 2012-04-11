From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] fast-import: allow branch_table to grow dynamically
Date: Wed, 11 Apr 2012 07:15:01 -0500
Message-ID: <20120411121500.GE19568@burratino>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
 <20120411121259.GB19568@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:15:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHwSB-0000GH-Hq
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 14:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760086Ab2DKMPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 08:15:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36755 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab2DKMPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 08:15:07 -0400
Received: by iagz16 with SMTP id z16so1198737iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FqELir8SLxPLUzwlCMZ3lzmbpEMN2Qk+Ek7BZqe5aNI=;
        b=FbrdP/NueHiQEVt205dFuk13CE8+idxagN+7I8pRHLcb6uqkmKejbgWDjslXqCZDsv
         umny0k6RxAAEONLOWkqjD8EtD+vBE1LRu3Ia9RUijwV7jsFvnT2tE3qEJtFH0anRC9vV
         Q9wJ/zh9dES6EK2Piaq67z48r8EQeuDksy5/6lW2StxxwB/w72or5AQAIDnaMVw0+/np
         ubSsSaSkTDw+hWnSHVOXw9V7VSXJph81QRH3HTyF4Q29sZSz6/d99bCoH0+o0tpJX0Lu
         KNjoX+fHgBs/3hU2i4GvRmShvipv90PYBziU7KVqWTrDu+NmJKOV1fq6MVBaWTVIIk1z
         vbog==
Received: by 10.50.106.200 with SMTP id gw8mr6221443igb.10.1334146507410;
        Wed, 11 Apr 2012 05:15:07 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l9sm7310670iga.6.2012.04.11.05.15.06
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 05:15:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120411121259.GB19568@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195174>

Date: Mon, 30 May 2011 22:25:35 -0500

Use a struct hash_table to allow the table for branches to grow.  The
main benefit is to make the code more self-consistent and avoid a
magic number for table size.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c |  104 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 35 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 67769573..ebb27006 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -334,8 +334,7 @@ static struct strbuf new_tree = STRBUF_INIT;
 /* Branch data */
 static unsigned long max_active_branches = 5;
 static unsigned long cur_active_branches;
-static unsigned long branch_table_sz = 1039;
-static struct branch **branch_table;
+static struct hash_table branch_table;
 static struct branch *active_branches;
 
 /* Tag data */
@@ -364,8 +363,10 @@ static void parse_argv(void);
 static void parse_cat_blob(void);
 static void parse_ls(struct branch *b);
 
-static void write_branch_report(FILE *rpt, struct branch *b)
+static int write_branch_report(struct branch *b, void *cb)
 {
+	FILE *rpt = cb;
+
 	fprintf(rpt, "%s:\n", b->name);
 
 	fprintf(rpt, "  status      :");
@@ -388,6 +389,36 @@ static void write_branch_report(FILE *rpt, struct branch *b)
 	fputc('\n', rpt);
 
 	fputc('\n', rpt);
+
+	return 0;
+}
+
+struct for_each_branch_data {
+	int (*fn)(struct branch *, void *);
+	void *data;
+};
+
+static int for_each_branch_helper(void *bucket, void *helper_data)
+{
+	struct for_each_branch_data *cb = helper_data;
+	struct branch *b;
+	int sum = 0;
+
+	for (b = bucket; b; b = b->table_next_branch) {
+		int val = cb->fn(b, cb->data);
+		if (val < 0)
+			return val;
+		sum += val;
+	}
+	return sum;
+}
+
+static int for_each_branch(int (*fn)(struct branch *, void *), void *data)
+{
+	struct for_each_branch_data cb;
+	cb.fn = fn;
+	cb.data = data;
+	return for_each_hash(&branch_table, for_each_branch_helper, &cb);
 }
 
 static void dump_marks_helper(FILE *, uintmax_t, struct mark_set *);
@@ -445,10 +476,7 @@ static void write_crash_report(const char *err)
 	fputc('\n', rpt);
 	fputs("Inactive Branches\n", rpt);
 	fputs("-----------------\n", rpt);
-	for (lu = 0; lu < branch_table_sz; lu++) {
-		for (b = branch_table[lu]; b; b = b->table_next_branch)
-			write_branch_report(rpt, b);
-	}
+	for_each_branch(write_branch_report, rpt);
 
 	if (first_tag) {
 		struct tag *tg;
@@ -714,10 +742,10 @@ static struct atom_str *to_atom(const char *s, unsigned short len)
 
 static struct branch *lookup_branch(const char *name)
 {
-	unsigned int hc = hc_str(name, strlen(name)) % branch_table_sz;
+	unsigned int hc = hc_str(name, strlen(name));
 	struct branch *b;
 
-	for (b = branch_table[hc]; b; b = b->table_next_branch)
+	for (b = lookup_hash(hc, &branch_table); b; b = b->table_next_branch)
 		if (!strcmp(name, b->name))
 			return b;
 	return NULL;
@@ -725,8 +753,9 @@ static struct branch *lookup_branch(const char *name)
 
 static struct branch *new_branch(const char *name)
 {
-	unsigned int hc = hc_str(name, strlen(name)) % branch_table_sz;
+	unsigned int hc = hc_str(name, strlen(name));
 	struct branch *b = lookup_branch(name);
+	void **pos;
 
 	if (b)
 		die("Invalid attempt to create duplicate branch: %s", name);
@@ -740,13 +769,16 @@ static struct branch *new_branch(const char *name)
 
 	b = pool_calloc(1, sizeof(struct branch));
 	b->name = pool_strdup(name);
-	b->table_next_branch = branch_table[hc];
 	b->branch_tree.versions[0].mode = S_IFDIR;
 	b->branch_tree.versions[1].mode = S_IFDIR;
 	b->num_notes = 0;
 	b->active = 0;
 	b->pack_id = MAX_PACK_ID;
-	branch_table[hc] = b;
+	pos = insert_hash(hc, b, &branch_table);
+	if (pos) {
+		b->table_next_branch = *pos;
+		*pos = b;
+	}
 	branch_count++;
 	return b;
 }
@@ -956,6 +988,15 @@ static void unkeep_all_packs(void)
 	}
 }
 
+static int print_sha1_if_same_pack(struct branch *b, void *cb)
+{
+	const unsigned int *pack_id = cb;
+
+	if (b->pack_id == *pack_id)
+		fprintf(pack_edges, " %s", sha1_to_hex(b->sha1));
+	return 0;
+}
+
 static void end_packfile(void)
 {
 	struct packed_git *old_p = pack_data, *new_p;
@@ -964,8 +1005,6 @@ static void end_packfile(void)
 	if (object_count) {
 		unsigned char cur_pack_sha1[20];
 		char *idx_name;
-		int i;
-		struct branch *b;
 		struct tag *t;
 
 		close_pack_windows(pack_data);
@@ -986,12 +1025,7 @@ static void end_packfile(void)
 		/* Print the boundary */
 		if (pack_edges) {
 			fprintf(pack_edges, "%s:", new_p->pack_name);
-			for (i = 0; i < branch_table_sz; i++) {
-				for (b = branch_table[i]; b; b = b->table_next_branch) {
-					if (b->pack_id == pack_id)
-						fprintf(pack_edges, " %s", sha1_to_hex(b->sha1));
-				}
-			}
+			for_each_branch(print_sha1_if_same_pack, &pack_id);
 			for (t = first_tag; t; t = t->next_tag) {
 				if (t->pack_id == pack_id)
 					fprintf(pack_edges, " %s", sha1_to_hex(t->sha1));
@@ -1667,7 +1701,8 @@ static int tree_content_get(
 	return 0;
 }
 
-static int update_branch(struct branch *b)
+/* 1 means failure; -1 means stop. */
+static int update_branch(struct branch *b, void *unused)
 {
 	static const char *msg = "fast-import";
 	struct ref_lock *lock;
@@ -1678,8 +1713,10 @@ static int update_branch(struct branch *b)
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
 	lock = lock_any_ref_for_update(b->name, old_sha1, 0);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
+	if (!lock) {
+		error("Unable to lock %s", b->name);
+		return 1;
+	}
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
@@ -1687,7 +1724,8 @@ static int update_branch(struct branch *b)
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
 		if (!old_cmit || !new_cmit) {
 			unlock_ref(lock);
-			return error("Branch %s is missing commits.", b->name);
+			error("Branch %s is missing commits.", b->name);
+			return 1;
 		}
 
 		if (!in_merge_bases(old_cmit, &new_cmit, 1)) {
@@ -1695,23 +1733,19 @@ static int update_branch(struct branch *b)
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
-			return -1;
+			return 1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	if (write_ref_sha1(lock, b->sha1, msg) < 0) {
+		error("Unable to update %s", b->name);
+		return 1;
+	}
 	return 0;
 }
 
 static void dump_branches(void)
 {
-	unsigned int i;
-	struct branch *b;
-
-	for (i = 0; i < branch_table_sz; i++) {
-		for (b = branch_table[i]; b; b = b->table_next_branch)
-			failure |= update_branch(b);
-	}
+	failure |= for_each_branch(update_branch, NULL);
 }
 
 static void dump_tags(void)
@@ -3275,7 +3309,7 @@ int main(int argc, const char **argv)
 	alloc_objects(object_entry_alloc);
 	strbuf_init(&command_buf, 0);
 	init_hash(&atom_table);
-	branch_table = xcalloc(branch_table_sz, sizeof(struct branch*));
+	init_hash(&branch_table);
 	avail_tree_table = xcalloc(avail_tree_table_sz, sizeof(struct avail_tree_content*));
 	init_hash(&object_table);
 	marks = pool_calloc(1, sizeof(struct mark_set));
-- 
1.7.10
