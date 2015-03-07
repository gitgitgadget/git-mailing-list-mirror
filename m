From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 08/10] commit: convert parts to struct object_id
Date: Sat,  7 Mar 2015 23:24:03 +0000
Message-ID: <1425770645-628957-9-git-send-email-sandals@crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 00:24:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUO5H-0001mM-J6
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 00:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbbCGXYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 18:24:32 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49829 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753024AbbCGXYT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 18:24:19 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 20DCB28098;
	Sat,  7 Mar 2015 23:24:18 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265014>

Convert struct commit_graft and necessary local parts of commit.c.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c      | 32 ++++++++++++++++----------------
 commit.h      |  4 ++--
 log-tree.c    |  2 +-
 send-pack.c   |  2 +-
 shallow.c     |  8 ++++----
 upload-pack.c |  2 +-
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/commit.c b/commit.c
index a8c7577..89c207e 100644
--- a/commit.c
+++ b/commit.c
@@ -55,12 +55,12 @@ struct commit *lookup_commit(const unsigned char *sha1)
 
 struct commit *lookup_commit_reference_by_name(const char *name)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct commit *commit;
 
-	if (get_sha1_committish(name, sha1))
+	if (get_sha1_committish(name, oid.sha1))
 		return NULL;
-	commit = lookup_commit_reference(sha1);
+	commit = lookup_commit_reference(oid.sha1);
 	if (parse_commit(commit))
 		return NULL;
 	return commit;
@@ -99,7 +99,7 @@ static int commit_graft_alloc, commit_graft_nr;
 static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 {
 	struct commit_graft **commit_graft_table = table;
-	return commit_graft_table[index]->sha1;
+	return commit_graft_table[index]->oid.sha1;
 }
 
 static int commit_graft_pos(const unsigned char *sha1)
@@ -110,7 +110,7 @@ static int commit_graft_pos(const unsigned char *sha1)
 
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
-	int pos = commit_graft_pos(graft->sha1);
+	int pos = commit_graft_pos(graft->oid.sha1);
 
 	if (0 <= pos) {
 		if (ignore_dups)
@@ -148,12 +148,12 @@ struct commit_graft *read_graft_line(char *buf, int len)
 	i = (len + 1) / 41 - 1;
 	graft = xmalloc(sizeof(*graft) + 20 * i);
 	graft->nr_parent = i;
-	if (get_sha1_hex(buf, graft->sha1))
+	if (get_oid_hex(buf, &graft->oid))
 		goto bad_graft_data;
 	for (i = 40; i < len; i += 41) {
 		if (buf[i] != ' ')
 			goto bad_graft_data;
-		if (get_sha1_hex(buf + i + 1, graft->parent[i/41]))
+		if (get_sha1_hex(buf + i + 1, graft->parent[i/41].sha1))
 			goto bad_graft_data;
 	}
 	return graft;
@@ -302,7 +302,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
-	unsigned char parent[20];
+	struct object_id parent;
 	struct commit_list **pptr;
 	struct commit_graft *graft;
 
@@ -312,10 +312,10 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	tail += size;
 	if (tail <= bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45] != '\n')
 		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
-	if (get_sha1_hex(bufptr + 5, parent) < 0)
+	if (get_sha1_hex(bufptr + 5, parent.sha1) < 0)
 		return error("bad tree pointer in commit %s",
 			     sha1_to_hex(item->object.sha1));
-	item->tree = lookup_tree(parent);
+	item->tree = lookup_tree(parent.sha1);
 	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
@@ -324,7 +324,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		struct commit *new_parent;
 
 		if (tail <= bufptr + 48 ||
-		    get_sha1_hex(bufptr + 7, parent) ||
+		    get_sha1_hex(bufptr + 7, parent.sha1) ||
 		    bufptr[47] != '\n')
 			return error("bad parents in commit %s", sha1_to_hex(item->object.sha1));
 		bufptr += 48;
@@ -334,7 +334,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		 */
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
-		new_parent = lookup_commit(parent);
+		new_parent = lookup_commit(parent.sha1);
 		if (new_parent)
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
@@ -342,7 +342,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		int i;
 		struct commit *new_parent;
 		for (i = 0; i < graft->nr_parent; i++) {
-			new_parent = lookup_commit(graft->parent[i]);
+			new_parent = lookup_commit(graft->parent[i].sha1);
 			if (!new_parent)
 				continue;
 			pptr = &commit_list_insert(new_parent, pptr)->next;
@@ -1580,10 +1580,10 @@ struct commit *get_merge_parent(const char *name)
 {
 	struct object *obj;
 	struct commit *commit;
-	unsigned char sha1[20];
-	if (get_sha1(name, sha1))
+	struct object_id oid;
+	if (get_sha1(name, oid.sha1))
 		return NULL;
-	obj = parse_object(sha1);
+	obj = parse_object(oid.sha1);
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
index 7f0890e..f6b7801 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -137,7 +137,7 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 
 static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 {
-	struct commit *commit = lookup_commit(graft->sha1);
+	struct commit *commit = lookup_commit(graft->oid.sha1);
 	if (!commit)
 		return 0;
 	add_name_decoration(DECORATION_GRAFTED, "grafted", &commit->object);
diff --git a/send-pack.c b/send-pack.c
index 9d2b0c5..e8389a4 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -182,7 +182,7 @@ static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *c
 {
 	struct strbuf *sb = cb;
 	if (graft->nr_parent == -1)
-		packet_buf_write(sb, "shallow %s\n", sha1_to_hex(graft->sha1));
+		packet_buf_write(sb, "shallow %s\n", sha1_to_hex(graft->oid.sha1));
 	return 0;
 }
 
diff --git a/shallow.c b/shallow.c
index d8bf40a..9ff2d4c 100644
--- a/shallow.c
+++ b/shallow.c
@@ -31,7 +31,7 @@ int register_shallow(const unsigned char *sha1)
 		xmalloc(sizeof(struct commit_graft));
 	struct commit *commit = lookup_commit(sha1);
 
-	hashcpy(graft->sha1, sha1);
+	hashcpy(graft->oid.sha1, sha1);
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
+		struct commit *c = lookup_commit(graft->oid.sha1);
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
