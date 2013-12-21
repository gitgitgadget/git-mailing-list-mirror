From: Jeff King <peff@peff.net>
Subject: [PATCH v4 0/22] pack bitmaps
Date: Sat, 21 Dec 2013 08:56:51 -0500
Message-ID: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 14:56:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN34-0002fL-7o
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 14:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab3LUN4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 08:56:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:48465 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753831Ab3LUN4x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 08:56:53 -0500
Received: (qmail 7022 invoked by uid 102); 21 Dec 2013 13:56:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 07:56:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 08:56:51 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239593>

Here's the v4 re-roll of the pack bitmap series.

The changes from v3 are:

 - reworked add_object_entry refactoring (see patch 11, which is new,
   and patch 12 which builds on it in a more natural way)

 - better error/die reporting from write_reused_pack

 - added Ramsay's PRIx64 compat fix

 - fixed a user-after-free in the warning message of open_pack_bitmap_1

 - minor typo/thinko fixes from Thomas in docs and tests

Interdiff is below.

  [01/23]: sha1write: make buffer const-correct
  [02/23]: revindex: Export new APIs
  [03/23]: pack-objects: Refactor the packing list
  [04/23]: pack-objects: factor out name_hash
  [05/23]: revision: allow setting custom limiter function
  [06/23]: sha1_file: export `git_open_noatime`
  [07/23]: compat: add endianness helpers
  [08/23]: ewah: compressed bitmap implementation
  [09/23]: documentation: add documentation for the bitmap format
  [10/23]: pack-bitmap: add support for bitmap indexes
  [11/23]: pack-objects: split add_object_entry
  [12/23]: pack-objects: use bitmaps when packing objects
  [13/23]: rev-list: add bitmap mode to speed up object lists
  [14/23]: pack-objects: implement bitmap writing
  [15/23]: repack: stop using magic number for ARRAY_SIZE(exts)
  [16/23]: repack: turn exts array into array-of-struct
  [17/23]: repack: handle optional files created by pack-objects
  [18/23]: repack: consider bitmaps when performing repacks
  [19/23]: count-objects: recognize .bitmap in garbage-checking
  [20/23]: t: add basic bitmap functionality tests
  [21/23]: t/perf: add tests for pack bitmaps
  [22/23]: pack-bitmap: implement optional name_hash cache
  [23/23]: compat/mingw.h: Fix the MinGW and msvc builds

---
diff --git a/Documentation/config.txt b/Documentation/config.txt
index e6d3922..499a3c4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1866,7 +1866,7 @@ pack.useBitmaps::
 
 pack.writebitmaps::
 	When true, git will write a bitmap index when packing all
-	objects to disk (e.g., as when `git repack -a` is run).  This
+	objects to disk (e.g., when `git repack -a` is run).  This
 	index can speed up the "counting objects" phase of subsequent
 	packs created for clones and fetches, at the cost of some disk
 	space and extra time spent on the initial repack.  Defaults to
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4504789..fd74197 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -72,11 +72,6 @@ static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
-enum {
-	OBJECT_ENTRY_EXCLUDE = (1 << 0),
-	OBJECT_ENTRY_NO_TRY_DELTA = (1 << 1)
-};
-
 /*
  * stats
  */
@@ -712,21 +707,20 @@ static struct object_entry **compute_write_order(void)
 
 static off_t write_reused_pack(struct sha1file *f)
 {
-	uint8_t buffer[8192];
+	unsigned char buffer[8192];
 	off_t to_write;
 	int fd;
 
 	if (!is_pack_valid(reuse_packfile))
-		return 0;
+		die("packfile is invalid: %s", reuse_packfile->pack_name);
 
 	fd = git_open_noatime(reuse_packfile->pack_name);
 	if (fd < 0)
-		return 0;
+		die_errno("unable to open packfile for reuse: %s",
+			  reuse_packfile->pack_name);
 
-	if (lseek(fd, sizeof(struct pack_header), SEEK_SET) == -1) {
-		close(fd);
-		return 0;
-	}
+	if (lseek(fd, sizeof(struct pack_header), SEEK_SET) == -1)
+		die_errno("unable to seek in reused packfile");
 
 	if (reuse_packfile_offset < 0)
 		reuse_packfile_offset = reuse_packfile->pack_size - 20;
@@ -736,10 +730,8 @@ static off_t write_reused_pack(struct sha1file *f)
 	while (to_write) {
 		int read_pack = xread(fd, buffer, sizeof(buffer));
 
-		if (read_pack <= 0) {
-			close(fd);
-			return 0;
-		}
+		if (read_pack <= 0)
+			die_errno("unable to read from reused packfile");
 
 		if (read_pack > to_write)
 			read_pack = to_write;
@@ -785,9 +777,6 @@ static void write_pack_file(void)
 			assert(pack_to_stdout);
 
 			packfile_size = write_reused_pack(f);
-			if (!packfile_size)
-				die_errno("failed to re-use existing pack");
-
 			offset += packfile_size;
 		}
 
@@ -909,86 +898,143 @@ static int no_try_delta(const char *path)
 	return 0;
 }
 
-static int add_object_entry_1(const unsigned char *sha1, enum object_type type,
-			      int flags, uint32_t name_hash,
-			      struct packed_git *found_pack, off_t found_offset)
+/*
+ * When adding an object, check whether we have already added it
+ * to our packing list. If so, we can skip. However, if we are
+ * being asked to excludei t, but the previous mention was to include
+ * it, make sure to adjust its flags and tweak our numbers accordingly.
+ *
+ * As an optimization, we pass out the index position where we would have
+ * found the item, since that saves us from having to look it up again a
+ * few lines later when we want to add the new entry.
+ */
+static int have_duplicate_entry(const unsigned char *sha1,
+				int exclude,
+				uint32_t *index_pos)
 {
 	struct object_entry *entry;
-	struct packed_git *p;
-	uint32_t index_pos;
-	int exclude = (flags & OBJECT_ENTRY_EXCLUDE);
-
-	entry = packlist_find(&to_pack, sha1, &index_pos);
-	if (entry) {
-		if (exclude) {
-			if (!entry->preferred_base)
-				nr_result--;
-			entry->preferred_base = 1;
-		}
+
+	entry = packlist_find(&to_pack, sha1, index_pos);
+	if (!entry)
 		return 0;
+
+	if (exclude) {
+		if (!entry->preferred_base)
+			nr_result--;
+		entry->preferred_base = 1;
 	}
 
+	return 1;
+}
+
+/*
+ * Check whether we want the object in the pack (e.g., we do not want
+ * objects found in non-local stores if the "--local" option was used).
+ *
+ * As a side effect of this check, we will find the packed version of this
+ * object, if any. We therefore pass out the pack information to avoid having
+ * to look it up again later.
+ */
+static int want_object_in_pack(const unsigned char *sha1,
+			       int exclude,
+			       struct packed_git **found_pack,
+			       off_t *found_offset)
+{
+	struct packed_git *p;
+
 	if (!exclude && local && has_loose_object_nonlocal(sha1))
 		return 0;
 
-	if (!found_pack) {
-		for (p = packed_git; p; p = p->next) {
-			off_t offset = find_pack_entry_one(sha1, p);
-			if (offset) {
-				if (!found_pack) {
-					if (!is_pack_valid(p)) {
-						warning("packfile %s cannot be accessed", p->pack_name);
-						continue;
-					}
-					found_offset = offset;
-					found_pack = p;
+	*found_pack = NULL;
+	*found_offset = 0;
+
+	for (p = packed_git; p; p = p->next) {
+		off_t offset = find_pack_entry_one(sha1, p);
+		if (offset) {
+			if (!*found_pack) {
+				if (!is_pack_valid(p)) {
+					warning("packfile %s cannot be accessed", p->pack_name);
+					continue;
 				}
-				if (exclude)
-					break;
-				if (incremental)
-					return 0;
-				if (local && !p->pack_local)
-					return 0;
-				if (ignore_packed_keep && p->pack_local && p->pack_keep)
-					return 0;
+				*found_offset = offset;
+				*found_pack = p;
 			}
+			if (exclude)
+				return 1;
+			if (incremental)
+				return 0;
+			if (local && !p->pack_local)
+				return 0;
+			if (ignore_packed_keep && p->pack_local && p->pack_keep)
+				return 0;
 		}
 	}
 
+	return 1;
+}
+
+static void create_object_entry(const unsigned char *sha1,
+				enum object_type type,
+				uint32_t hash,
+				int exclude,
+				int no_try_delta,
+				uint32_t index_pos,
+				struct packed_git *found_pack,
+				off_t found_offset)
+{
+	struct object_entry *entry;
+
 	entry = packlist_alloc(&to_pack, sha1, index_pos);
-	entry->hash = name_hash;
+	entry->hash = hash;
 	if (type)
 		entry->type = type;
 	if (exclude)
 		entry->preferred_base = 1;
 	else
 		nr_result++;
-
-	if (flags & OBJECT_ENTRY_NO_TRY_DELTA)
-		entry->no_try_delta = 1;
-
 	if (found_pack) {
 		entry->in_pack = found_pack;
 		entry->in_pack_offset = found_offset;
 	}
 
-	display_progress(progress_state, to_pack.nr_objects);
-
-	return 1;
+	entry->no_try_delta = no_try_delta;
 }
 
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
 			    const char *name, int exclude)
 {
-	int flags = 0;
+	struct packed_git *found_pack;
+	off_t found_offset;
+	uint32_t index_pos;
 
-	if (exclude)
-		flags |= OBJECT_ENTRY_EXCLUDE;
+	if (have_duplicate_entry(sha1, exclude, &index_pos))
+		return 0;
+
+	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset))
+		return 0;
+
+	create_object_entry(sha1, type, pack_name_hash(name),
+			    exclude, name && no_try_delta(name),
+			    index_pos, found_pack, found_offset);
 
-	if (name && no_try_delta(name))
-		flags |= OBJECT_ENTRY_NO_TRY_DELTA;
+	display_progress(progress_state, to_pack.nr_objects);
+	return 1;
+}
 
-	return add_object_entry_1(sha1, type, flags, pack_name_hash(name), NULL, 0);
+static int add_object_entry_from_bitmap(const unsigned char *sha1,
+					enum object_type type,
+					int flags, uint32_t name_hash,
+					struct packed_git *pack, off_t offset)
+{
+	uint32_t index_pos;
+
+	if (have_duplicate_entry(sha1, 0, &index_pos))
+		return 0;
+
+	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
+
+	display_progress(progress_state, to_pack.nr_objects);
+	return 1;
 }
 
 struct pbase_tree_cache {
@@ -2397,7 +2443,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 		}
 	}
 
-	traverse_bitmap_commit_list(&add_object_entry_1);
+	traverse_bitmap_commit_list(&add_object_entry_from_bitmap);
 	return 0;
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 078f7c6..ae0b57b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -266,7 +266,7 @@ static int open_pack_bitmap_1(struct packed_git *packfile)
 	}
 
 	if (bitmap_git.pack) {
-		warning("ignoring extra bitmap file: %s", idx_name);
+		warning("ignoring extra bitmap file: %s", packfile->pack_name);
 		close(fd);
 		return -1;
 	}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index e4e1a57..8b7f4e9 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -19,7 +19,7 @@ struct bitmap_disk_header {
 	unsigned char checksum[20];
 };
 
-static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};;
+static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
 
 #define NEEDS_BITMAP (1u<<22)
 
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 8811fc4..685d46f 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -22,7 +22,7 @@ test_perf 'simulated clone' '
 '
 
 test_perf 'simulated fetch' '
-	have=$(git rev-list HEAD --until=1.week.ago -1) &&
+	have=$(git rev-list HEAD~100 -1) &&
 	{
 		echo HEAD &&
 		echo ^$have
@@ -31,7 +31,7 @@ test_perf 'simulated fetch' '
 
 test_expect_success 'create partial bitmap state' '
 	# pick a commit to represent the repo tip in the past
-	cutoff=$(git rev-list HEAD --until=1.week.ago -1) &&
+	cutoff=$(git rev-list HEAD~100 -1) &&
 	orig_tip=$(git rev-parse HEAD) &&
 
 	# now kill off all of the refs and pretend we had
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 2c2632f..d3a3afa 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -127,9 +127,9 @@ test_expect_success JGIT 'we can read jgit bitmaps' '
 '
 
 test_expect_success JGIT 'jgit can read our bitmaps' '
-	git clone . compat-us.git &&
+	git clone . compat-us &&
 	(
-		cd compat-us.git &&
+		cd compat-us &&
 		git repack -adb &&
 		# jgit gc will barf if it does not like our bitmaps
 		jgit gc
