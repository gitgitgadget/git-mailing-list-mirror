From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [WIP PATCH 6/6] notes: add notes-index for a substantial speedup.
Date: Mon, 16 Jul 2007 00:26:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160025480.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:26:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADTz-0001oZ-4E
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbXGOX02 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbXGOX01
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:26:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:49492 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755070AbXGOX00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:26:26 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:26:24 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp030) with SMTP; 16 Jul 2007 01:26:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kyr51fw8ksjSVzlEilFXGCOfJDIpvacD+PFU6GD
	JKuVOOjTYQ5+Dc
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707152326080.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52605>


Actually, this commit adds two methods for a notes index:

- a sorted list with a fan out to help binary search, and
- a modified hash table.

It also adds a test which is used to determine the best algorithm.
---
	Not signed off because this is not suitable to be applied as-is.
	It is only meant to test the different approaches.

 notes.c                          |  392 ++++++++++++++++++++++++++++++++++++--
 t/t3302-notes-index-expensive.sh |  118 ++++++++++++
 2 files changed, 490 insertions(+), 20 deletions(-)
 create mode 100755 t/t3302-notes-index-expensive.sh

diff --git a/notes.c b/notes.c
index 5d1bb1a..5a90abf 100644
--- a/notes.c
+++ b/notes.c
@@ -1,10 +1,370 @@
 #include "cache.h"
 #include "commit.h"
+#include "tree-walk.h"
 #include "notes.h"
 #include "refs.h"
 
 static int initialized;
 
+/*
+ * There are two choices of data structure for the notes index.
+ *
+ * A) Fan out enhanced sorted list.
+ *
+ * This is a regular sorted list with a 256 entry fan out.  In other words,
+ * every time an entry is looked up, a binary search is performed over the
+ * sublist defined by the first byte of the SHA-1.
+ *
+ * The disadvantage is an average runtime logarithmic in the number of
+ * commit notes.  The advantages are a compact representation on disk,
+ * and a _guaranteed_ logarithmic runtime.
+ *
+ * You could even squeeze out one more byte per entry, since the
+ * first byte is known from the fan out list.  This would complicate our
+ * algorithm, though.
+ *
+ * B) Hash
+ *
+ * This is not your classical hash.  It is _mostly_ like a hash, with
+ * a few notable exceptions:
+ *
+ * - it is possibly larger than size suggests: since it is file based,
+ *   it is easier to write at the end than to wrap around.
+ *
+ * - as a consequence we can make the entries _strictly_ sorted. This
+ *   is not only nice to look at, but makes incremental updates much,
+ *   much easier.
+ *
+ * The disadvantages of a hash is its loose packing.  In order to operate
+ * reasonably well, it needs a size roughly double the number of entries.
+ * It also has a worst runtime linear in the number of entries.
+ *
+ * The advantage is an expected constant lookup time.
+ *
+ * The performance of a hash map depends highly on a good hashing
+ * algorithm, to avoid collisions.  Lucky us!  SHA-1 is a pretty good
+ * hashing algorithm.
+ *
+ * There is another advantage to hash maps: with not much effort, the
+ * incremental update can be performed in place, relying on O_TRUNC to
+ * detect interruptions.  This operation has an expected constant runtime.
+ */
+
+struct notes_entry {
+	unsigned char commit_sha1[20];
+	unsigned char notes_sha1[20];
+};
+
+struct notes_index {
+	char signature[4]; /* FANO for fan our, HASH for hash */
+
+	unsigned char tree_sha1[20];
+	unsigned char subtree_sha1[256][20]; /* for incremental caching */
+	off_t offsets[256]; /* for fan out */
+	off_t count, size; /* for hash */
+} notes_index;
+
+static int notes_index_fd;
+static int (*get_notes)(const unsigned char *commit_sha1,
+		unsigned char *notes_sha1);
+
+#define GIT_NOTES_MODE "GIT_NOTES_MODE"
+static int use_hash;
+
+static int index_uptodate_check(struct tree *tree) {
+	const char *signature = use_hash ? "HASH" : "FANO";
+	int fd = open(git_path("notes-index"), O_RDONLY);
+
+	if (fd < 0)
+		return fd;
+
+	notes_index_fd = fd;
+
+	return read_in_full(fd, &notes_index, sizeof(notes_index)) < 0||
+			memcmp(notes_index.signature, signature, 4) ||
+			memcmp(notes_index.tree_sha1,
+				&tree->object.sha1, 20);
+}
+
+struct lock_file update_lock;
+
+/* this reads the remaining 38 hexchars */
+static int get_remaining_hexchars(unsigned char *sha1, const char *path)
+{
+	int i, j1, j2;
+	for (i = 0; i < 38; i += 2)
+		if ((j1 = hexval(path[i])) < 0 ||
+				(j2 = hexval(path[i + 1])) < 0)
+			return -1;
+		else
+			sha1[1 + i / 2] = (j1 << 4) | j2;
+	return path[38] != '\0';
+}
+
+static int get_notes_hash_count(struct tree *tree) {
+	struct tree_desc desc, desc2;
+	struct name_entry entry;
+	void *buf;
+	unsigned long count = 0;
+
+	buf = fill_tree_descriptor(&desc, notes_index.tree_sha1);
+	if (!buf)
+		return 0;
+	while (tree_entry(&desc, &entry)) {
+		void *buf2 = fill_tree_descriptor(&desc2, entry.sha1);
+		if (!buf2)
+			continue;
+		while (tree_entry(&desc2, &entry))
+			count++;
+		free(buf2);
+	}
+	free(buf);
+
+	return count;
+}
+
+static unsigned long get_hash_index(const unsigned char *sha1)
+{
+	return (ntohl(*(unsigned long *)sha1) % notes_index.size);
+}
+
+static int write_hash_gap(int fd, unsigned char *sha1)
+{
+	off_t min_offset = sizeof(notes_index) +
+		get_hash_index(sha1) * sizeof(struct notes_entry);
+	while (min_offset > lseek(fd, 0, SEEK_CUR))
+		if (write_in_full(fd, null_sha1, 20) < 0 ||
+				write_in_full(fd, null_sha1, 20) < 0)
+			return error("Could not write gaps in notes-index");
+	return 0;
+}
+
+static int update_index(struct tree *tree) {
+	/*
+	 * Fan out sorted list:
+	 *
+	 * Write out the header, and seek back to it, in order to update it.
+	 * Actually only seek at the end, and make sure that you write
+	 * something big-endian.
+	 *
+	 * Plan for incremental: if subtree_sha1 is equal, copy out.
+	 * Otherwise construct, and remember in the copy of the header.
+	 *
+	 * Hash:
+	 *
+	 * Always use a power of two as size.  Not the next higher one, but
+	 * the next next higher one.
+	 *
+	 * Read the tree recursively, and leave as many zeros as needed
+	 * until the next entry comes.  Or if the entry has a hash larger
+	 * than the last free entry, write it at once.
+	 */
+
+	/* Plan for incremental: (not in-place)
+	 * Look at tree differences.  Write null_sha1 until next, or next
+	 * subtree.  Continue writing until original entry is null_sha1 or
+	 * greater than current subtree entry.
+	 */
+
+	int new_fd = hold_lock_file_for_update(&update_lock,
+			git_path("notes-index"), 0);
+	struct tree_desc desc;
+	struct name_entry entry;
+	void *buf;
+	int i;
+
+	if (new_fd < 0)
+		return error("Could not construct notes-index");
+
+	memset(&notes_index, 0, sizeof(notes_index));
+	hashcpy(notes_index.tree_sha1, tree->object.sha1);
+	notes_index.offsets[0] = sizeof(notes_index);
+	if (use_hash) {
+		notes_index.count = get_notes_hash_count(tree);
+		for (notes_index.size = 1; notes_index.size / 2
+				>= notes_index.count; notes_index.size <<= 1)
+			; /* do nothing */
+		memcpy(notes_index.signature, "HASH", 4);
+	} else
+		memcpy(notes_index.signature, "FANO", 4);
+
+	if (write_in_full(new_fd, &notes_index, sizeof(notes_index)) < 0)
+		return error("Could not write notes-index");
+
+	buf = fill_tree_descriptor(&desc, notes_index.tree_sha1);
+	if (!buf)
+		return error("Could not read %s for notes-index",
+				sha1_to_hex(notes_index.tree_sha1));
+
+	i = 0;
+	while (tree_entry(&desc, &entry)) {
+		int j1, j2;
+		unsigned char sha1[20];
+		struct tree_desc desc2;
+		struct name_entry entry2;
+		void *buf2;
+
+		if (!S_ISDIR(entry.mode) ||
+				(j1 = hexval(entry.path[0])) < 0 ||
+				(j2 = hexval(entry.path[1])) < 0)
+			continue;
+		sha1[0] = j1 * 16 + j2;
+		while (++i < sha1[0])
+			notes_index.offsets[i] = notes_index.offsets[i - 1];
+
+		hashcpy(notes_index.subtree_sha1[i], entry.sha1);
+		buf2 = fill_tree_descriptor(&desc2, entry.sha1);
+		if (!buf2)
+			continue;
+		while(tree_entry(&desc2, &entry2)) {
+			if (get_remaining_hexchars(sha1, entry2.path))
+				continue;
+			if (use_hash && write_hash_gap(new_fd, sha1))
+				return -1;
+			if (write_in_full(new_fd, sha1, 20) < 0 ||
+					write_in_full(new_fd,
+						entry2.sha1, 20) < 0)
+				return error("Could not write notes-index");
+		}
+		free(buf2);
+		notes_index.offsets[i] = lseek(new_fd, 0, SEEK_CUR);
+	}
+	free(buf);
+
+	while (++i < 256)
+		notes_index.offsets[i] = notes_index.offsets[i - 1];
+
+	/* update fan_out */
+	lseek(new_fd, 0, SEEK_SET);
+	write(new_fd, &notes_index, sizeof(notes_index));
+	lseek(new_fd, notes_index.offsets[255], SEEK_SET);
+
+	return close(new_fd) || commit_lock_file(&update_lock) ||
+		(notes_index_fd = open(git_path("notes-index"), O_RDONLY));
+}
+
+static void *notes_mmap;
+
+static void unmap_notes_mmap(void)
+{
+	munmap(notes_mmap, notes_index.offsets[255]);
+}
+
+static int get_notes_fan_out(const unsigned char *commit_sha1,
+		unsigned char *notes_sha1)
+{
+	/*
+	 * Header is assumed to be read.
+	 *
+	 * mmap() the area, and bisect.
+	 */
+	off_t off;
+	size_t size;
+	int i, i2, ret = -1;
+	struct notes_entry *list;
+
+	i = commit_sha1[0];
+	off = i ? notes_index.offsets[i - 1] : sizeof(notes_index);
+	size = notes_index.offsets[i] - off;
+	if (!size)
+		return -1;
+
+	if (!notes_mmap) {
+		notes_mmap = xmmap(NULL, notes_index.offsets[255],
+				PROT_READ, MAP_PRIVATE, notes_index_fd, 0);
+		atexit(unmap_notes_mmap);
+	}
+
+	list = (void *)((char *)notes_mmap + off);
+
+	i = 0;
+	i2 = size / sizeof(*list);
+	while (i + 1 < i2) {
+		int middle = (i + i2) / 2;
+		int cmp = hashcmp(commit_sha1, list[middle].commit_sha1);
+		if (cmp < 0)
+			i2 = middle;
+		else if (cmp > 0)
+			i = middle;
+		else {
+			hashcpy(notes_sha1, list[middle].notes_sha1);
+			i = middle;
+			ret = 0;
+			break;
+		}
+	}
+	if (i == 0 && !hashcmp(commit_sha1, list[i].commit_sha1)) {
+		hashcpy(notes_sha1, list[i].notes_sha1);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int get_notes_hash(const unsigned char *commit_sha1,
+		unsigned char *notes_sha1)
+{
+	/*
+	 * Header is assumed to be read. fd is still open.
+	 *
+	 * Seek to hash, read until lower or equal (0000... is lower...)
+	 */
+	int i = get_hash_index(commit_sha1);
+	struct notes_entry entry;
+
+	lseek(notes_index_fd,
+			sizeof(notes_index) + i * sizeof(entry), SEEK_SET);
+	while (!read_in_full(notes_index_fd, &entry, sizeof(entry)) &&
+			!is_null_sha1(entry.commit_sha1)) {
+		int cmp = hashcmp(commit_sha1, entry.commit_sha1);
+		if (!cmp) {
+			hashcpy(notes_sha1, entry.notes_sha1);
+			return 0;
+		} else if (cmp < 0)
+			break;
+	}
+	return -1;
+}
+
+static inline void init_notes_index(void)
+{
+	const char *env;
+	struct commit *notes_ref;
+	unsigned char sha1[20];
+
+	if (initialized)
+		return;
+
+	initialized = 1;
+	env = getenv(GIT_NOTES_REF);
+	if (env) {
+		if (notes_ref_name)
+			free(notes_ref_name);
+		notes_ref_name = xstrdup(env);
+	} else if (!notes_ref_name)
+		notes_ref_name = xstrdup("refs/notes/commits");
+
+	if (!notes_ref_name)
+		return;
+	if (read_ref(notes_ref_name, sha1)) {
+		free(notes_ref_name);
+		notes_ref_name = NULL;
+		return;
+	}
+	env = getenv("GIT_NOTES_MODE");
+	if (env && !strcmp("HASH", env)) {
+		use_hash = 1;
+		get_notes = get_notes_hash;
+	} else if (env && !strcmp("FANO", env))
+		get_notes = get_notes_fan_out;
+	if (get_notes && !get_sha1(notes_ref_name, sha1) &&
+			(notes_ref = (struct commit *)parse_object(sha1)) &&
+			notes_ref->object.type == OBJ_COMMIT)
+		if (index_uptodate_check(notes_ref->tree))
+			if (update_index(notes_ref->tree))
+				get_notes = NULL; /* disable notes-index */
+}
+
 void get_commit_notes(const struct commit *commit,
 		char **buf_p, unsigned long *offset_p, unsigned long *space_p)
 {
@@ -15,28 +375,20 @@ void get_commit_notes(const struct commit *commit,
 	unsigned long msgoffset, msglen;
 	enum object_type type;
 
-	if (!initialized) {
-		const char *env = getenv(GIT_NOTES_REF);
-		if (env) {
-			if (notes_ref_name)
-				free(notes_ref_name);
-			notes_ref_name = xstrdup(getenv(GIT_NOTES_REF));
-		} else if (!notes_ref_name)
-			notes_ref_name = xstrdup("refs/notes/commits");
-		if (notes_ref_name && read_ref(notes_ref_name, sha1)) {
-			free(notes_ref_name);
-			notes_ref_name = NULL;
-		}
-		initialized = 1;
-	}
-	if (!notes_ref_name)
-		return;
+	init_notes_index();
 
-	hex = sha1_to_hex(commit->object.sha1);
-	snprintf(name, sizeof(name), "%s:%.*s/%.*s",
-			notes_ref_name, 2, hex, 38, hex + 2);
-	if (get_sha1(name, sha1))
+	if (!notes_ref_name)
 		return;
+	if (get_notes) {
+		if (get_notes(commit->object.sha1, sha1))
+			return;
+	} else {
+		hex = sha1_to_hex(commit->object.sha1);
+		snprintf(name, sizeof(name), "%s:%.*s/%.*s",
+				notes_ref_name, 2, hex, 38, hex + 2);
+		if (get_sha1(name, sha1))
+			return;
+	}
 
 	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen)
 		return;
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
new file mode 100755
index 0000000..075b8e2
--- /dev/null
+++ b/t/t3302-notes-index-expensive.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='Test commit notes index (expensive!)'
+
+. ./test-lib.sh
+
+test -z "$GIT_NOTES_TIMING_TESTS" && {
+	say Skipping timing tests
+	test_done
+	exit
+}
+
+create_repo () {
+	number_of_commits=$1
+	nr=0
+	parent=
+	test -d .git || {
+	git init &&
+	tree=$(git write-tree) &&
+	while [ $nr -lt $number_of_commits ]; do
+		test_tick &&
+		commit=$(echo $nr | git commit-tree $tree $parent) ||
+			return
+		parent="-p $commit"
+		nr=$(($nr+1))
+	done &&
+	git update-ref refs/heads/master $commit &&
+	{
+		export GIT_INDEX_FILE=.git/temp;
+		git rev-list HEAD | cat -n | sed "s/^[ 	][ 	]*/ /g" |
+		while read nr sha1; do
+			blob=$(echo note $nr | git hash-object -w --stdin) &&
+			echo $sha1 | sed "s/^../0644 $blob 0	&\//"
+		done | git update-index --index-info &&
+		tree=$(git write-tree) &&
+		test_tick &&
+		commit=$(echo notes | git commit-tree $tree) &&
+		git update-ref refs/notes/commits $commit
+	} &&
+	git config core.notesRef refs/notes/commits
+	}
+}
+
+test_notes () {
+	count=$1 &&
+	git config core.notesRef refs/notes/commits &&
+	git log | grep "^    " > output &&
+	i=1 &&
+	while [ $i -le $count ]; do
+		echo "    $(($count-$i))" &&
+		echo "    note $i" &&
+		i=$(($i+1));
+	done > expect &&
+	git diff expect output
+}
+
+cat > time_notes << EOF
+	mode=\$1
+	i=1
+	while [ \$i -lt \$2 ]; do
+		case \$1 in
+		no-notes)
+			export GIT_NOTES_REF=non-existing
+		;;
+		no-cash)
+			unset GIT_NOTES_REF
+			export GIT_NOTES_MODE=NONE
+		;;
+		hash-cache-create)
+			unset GIT_NOTES_REF
+			export GIT_NOTES_MODE=HASH
+			rm .git/notes-index
+		;;
+		hash-cache)
+			unset GIT_NOTES_REF
+			export GIT_NOTES_MODE=HASH
+		;;
+		sorted-list-cache-create)
+			unset GIT_NOTES_REF
+			export GIT_NOTES_MODE=FANO
+			rm .git/notes-index
+		;;
+		sorted-list-cache)
+			unset GIT_NOTES_REF
+			export GIT_NOTES_MODE=FANO
+		;;
+		esac
+		git log >/dev/null
+		i=\$((\$i+1))
+	done
+EOF
+
+time_notes () {
+	for mode in no-notes no-cash \
+			hash-cache-create hash-cache \
+			sorted-list-cache-create sorted-list-cache; do
+		echo $mode
+		/usr/bin/time sh ../trash/time_notes $mode $1
+	done
+}
+
+for count in 10 100 1000; do
+
+	test -d ../trash-$count || mkdir ../trash-$count
+	(cd ../trash-$count;
+
+	test_expect_success "setup $count" "create_repo $count"
+
+	test_expect_success 'notes work' "test_notes $count"
+
+	test_expect_success 'notes timing' "time_notes 100"
+	)
+done
+
+test_done
-- 
1.5.3.rc1.2718.gd2dc9-dirty
