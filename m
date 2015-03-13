From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 08/10] commit: convert parts to struct object_id
Date: Fri, 13 Mar 2015 23:39:34 +0000
Message-ID: <1426289976-568060-9-git-send-email-sandals@crustytoothpaste.net>
References: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 00:40:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWZBp-0008Qk-1n
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 00:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160AbbCMXkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 19:40:20 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50126 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752973AbbCMXkN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2015 19:40:13 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D35AA28093;
	Fri, 13 Mar 2015 23:40:12 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265430>

Convert struct commit_graft and necessary local parts of commit.c.
Also, convert several constants based on the hex length of an SHA-1 to
use GIT_SHA1_HEXSZ, and move several magic constants into variables for
readability.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c      | 56 ++++++++++++++++++++++++++++++--------------------------
 commit.h      |  4 ++--
 log-tree.c    |  2 +-
 send-pack.c   |  2 +-
 shallow.c     |  8 ++++----
 upload-pack.c |  2 +-
 6 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/commit.c b/commit.c
index a8c7577..2d9de80 100644
--- a/commit.c
+++ b/commit.c
@@ -55,12 +55,12 @@ struct commit *lookup_commit(const unsigned char *sha1)
 
 struct commit *lookup_commit_reference_by_name(const char *name)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct commit *commit;
 
-	if (get_sha1_committish(name, sha1))
+	if (get_sha1_committish(name, oid.hash))
 		return NULL;
-	commit = lookup_commit_reference(sha1);
+	commit = lookup_commit_reference(oid.hash);
 	if (parse_commit(commit))
 		return NULL;
 	return commit;
@@ -99,7 +99,7 @@ static int commit_graft_alloc, commit_graft_nr;
 static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 {
 	struct commit_graft **commit_graft_table = table;
-	return commit_graft_table[index]->sha1;
+	return commit_graft_table[index]->oid.hash;
 }
 
 static int commit_graft_pos(const unsigned char *sha1)
@@ -110,7 +110,7 @@ static int commit_graft_pos(const unsigned char *sha1)
 
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
-	int pos = commit_graft_pos(graft->sha1);
+	int pos = commit_graft_pos(graft->oid.hash);
 
 	if (0 <= pos) {
 		if (ignore_dups)
@@ -138,22 +138,23 @@ struct commit_graft *read_graft_line(char *buf, int len)
 	/* The format is just "Commit Parent1 Parent2 ...\n" */
 	int i;
 	struct commit_graft *graft = NULL;
+	const int entry_size = GIT_SHA1_HEXSZ + 1;
 
 	while (len && isspace(buf[len-1]))
 		buf[--len] = '\0';
 	if (buf[0] == '#' || buf[0] == '\0')
 		return NULL;
-	if ((len + 1) % 41)
+	if ((len + 1) % entry_size)
 		goto bad_graft_data;
-	i = (len + 1) / 41 - 1;
-	graft = xmalloc(sizeof(*graft) + 20 * i);
+	i = (len + 1) / entry_size - 1;
+	graft = xmalloc(sizeof(*graft) + GIT_SHA1_RAWSZ * i);
 	graft->nr_parent = i;
-	if (get_sha1_hex(buf, graft->sha1))
+	if (get_oid_hex(buf, &graft->oid))
 		goto bad_graft_data;
-	for (i = 40; i < len; i += 41) {
+	for (i = GIT_SHA1_HEXSZ; i < len; i += entry_size) {
 		if (buf[i] != ' ')
 			goto bad_graft_data;
-		if (get_sha1_hex(buf + i + 1, graft->parent[i/41]))
+		if (get_sha1_hex(buf + i + 1, graft->parent[i/entry_size].hash))
 			goto bad_graft_data;
 	}
 	return graft;
@@ -302,39 +303,42 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
-	unsigned char parent[20];
+	struct object_id parent;
 	struct commit_list **pptr;
 	struct commit_graft *graft;
+	const int tree_entry_len = GIT_SHA1_HEXSZ + 5;
+	const int parent_entry_len = GIT_SHA1_HEXSZ + 7;
 
 	if (item->object.parsed)
 		return 0;
 	item->object.parsed = 1;
 	tail += size;
-	if (tail <= bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45] != '\n')
+	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
+			bufptr[tree_entry_len] != '\n')
 		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
-	if (get_sha1_hex(bufptr + 5, parent) < 0)
+	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
 		return error("bad tree pointer in commit %s",
 			     sha1_to_hex(item->object.sha1));
-	item->tree = lookup_tree(parent);
-	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
+	item->tree = lookup_tree(parent.hash);
+	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
 	graft = lookup_commit_graft(item->object.sha1);
-	while (bufptr + 48 < tail && !memcmp(bufptr, "parent ", 7)) {
+	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
-		if (tail <= bufptr + 48 ||
-		    get_sha1_hex(bufptr + 7, parent) ||
-		    bufptr[47] != '\n')
+		if (tail <= bufptr + parent_entry_len + 1 ||
+		    get_sha1_hex(bufptr + 7, parent.hash) ||
+		    bufptr[parent_entry_len] != '\n')
 			return error("bad parents in commit %s", sha1_to_hex(item->object.sha1));
-		bufptr += 48;
+		bufptr += parent_entry_len + 1;
 		/*
 		 * The clone is shallow if nr_parent < 0, and we must
 		 * not traverse its real parents even when we unhide them.
 		 */
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
-		new_parent = lookup_commit(parent);
+		new_parent = lookup_commit(parent.hash);
 		if (new_parent)
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
@@ -342,7 +346,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		int i;
 		struct commit *new_parent;
 		for (i = 0; i < graft->nr_parent; i++) {
-			new_parent = lookup_commit(graft->parent[i]);
+			new_parent = lookup_commit(graft->parent[i].hash);
 			if (!new_parent)
 				continue;
 			pptr = &commit_list_insert(new_parent, pptr)->next;
@@ -1580,10 +1584,10 @@ struct commit *get_merge_parent(const char *name)
 {
 	struct object *obj;
 	struct commit *commit;
-	unsigned char sha1[20];
-	if (get_sha1(name, sha1))
+	struct object_id oid;
+	if (get_sha1(name, oid.hash))
 		return NULL;
-	obj = parse_object(sha1);
+	obj = parse_object(oid.hash);
 	commit = (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
 	if (commit && !commit->util) {
 		struct merge_remote_desc *desc;
diff --git a/commit.h b/commit.h
index 9f189cb..ed3a1d5 100644
--- a/commit.h
+++ b/commit.h
@@ -226,9 +226,9 @@ enum rev_sort_order {
 void sort_in_topological_order(struct commit_list **, enum rev_sort_order);
 
 struct commit_graft {
-	unsigned char sha1[20];
+	struct object_id oid;
 	int nr_parent; /* < 0 if shallow commit */
-	unsigned char parent[FLEX_ARRAY][20]; /* more */
+	struct object_id parent[FLEX_ARRAY]; /* more */
 };
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
diff --git a/log-tree.c b/log-tree.c
index 7f0890e..51cc695 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -137,7 +137,7 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 
 static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 {
-	struct commit *commit = lookup_commit(graft->sha1);
+	struct commit *commit = lookup_commit(graft->oid.hash);
 	if (!commit)
 		return 0;
 	add_name_decoration(DECORATION_GRAFTED, "grafted", &commit->object);
diff --git a/send-pack.c b/send-pack.c
index 9d2b0c5..b2fd767 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -182,7 +182,7 @@ static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *c
 {
 	struct strbuf *sb = cb;
 	if (graft->nr_parent == -1)
-		packet_buf_write(sb, "shallow %s\n", sha1_to_hex(graft->sha1));
+		packet_buf_write(sb, "shallow %s\n", oid_to_hex(&graft->oid));
 	return 0;
 }
 
diff --git a/shallow.c b/shallow.c
index d8bf40a..d08d264 100644
--- a/shallow.c
+++ b/shallow.c
@@ -31,7 +31,7 @@ int register_shallow(const unsigned char *sha1)
 		xmalloc(sizeof(struct commit_graft));
 	struct commit *commit = lookup_commit(sha1);
 
-	hashcpy(graft->sha1, sha1);
+	hashcpy(graft->oid.hash, sha1);
 	graft->nr_parent = -1;
 	if (commit && commit->object.parsed)
 		commit->parents = NULL;
@@ -159,11 +159,11 @@ struct write_shallow_data {
 static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 {
 	struct write_shallow_data *data = cb_data;
-	const char *hex = sha1_to_hex(graft->sha1);
+	const char *hex = oid_to_hex(&graft->oid);
 	if (graft->nr_parent != -1)
 		return 0;
 	if (data->flags & SEEN_ONLY) {
-		struct commit *c = lookup_commit(graft->sha1);
+		struct commit *c = lookup_commit(graft->oid.hash);
 		if (!c || !(c->object.flags & SEEN)) {
 			if (data->flags & VERBOSE)
 				printf("Removing %s from .git/shallow\n",
@@ -282,7 +282,7 @@ static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *c
 {
 	int fd = *(int *)cb;
 	if (graft->nr_parent == -1)
-		packet_write(fd, "shallow %s\n", sha1_to_hex(graft->sha1));
+		packet_write(fd, "shallow %s\n", oid_to_hex(&graft->oid));
 	return 0;
 }
 
diff --git a/upload-pack.c b/upload-pack.c
index b531a32..0566ce0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -74,7 +74,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 {
 	FILE *fp = cb_data;
 	if (graft->nr_parent == -1)
-		fprintf(fp, "--shallow %s\n", sha1_to_hex(graft->sha1));
+		fprintf(fp, "--shallow %s\n", oid_to_hex(&graft->oid));
 	return 0;
 }
 
-- 
2.2.1.209.g41e5f3a
