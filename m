From: Jeff King <peff@peff.net>
Subject: [PATCH v3 11/21] pack-objects: use bitmaps when packing objects
Date: Thu, 14 Nov 2013 07:45:10 -0500
Message-ID: <20131114124510.GK10757@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:45:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwIP-0000cy-7p
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515Ab3KNMpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:45:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:39132 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753331Ab3KNMpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:45:12 -0500
Received: (qmail 11544 invoked by uid 102); 14 Nov 2013 12:45:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:45:11 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:45:10 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237835>

From: Vicent Marti <tanoku@gmail.com>

In this patch, we use the bitmap API to perform the `Counting Objects`
phase in pack-objects, rather than a traditional walk through the object
graph. For a reasonably-packed large repo, the time to fetch and clone
is often dominated by the full-object revision walk during the Counting
Objects phase. Using bitmaps can reduce the CPU time required on the
server (and therefore start sending the actual pack data with less
delay).

For bitmaps to be used, the following must be true:

  1. We must be packing to stdout (as a normal `pack-objects` from
     `upload-pack` would do).

  2. There must be a .bitmap index containing at least one of the
     "have" objects that the client is asking for.

  3. Bitmaps must be enabled (they are enabled by default, but can be
     disabled by setting `pack.usebitmaps` to false, or by using
     `--no-use-bitmap-index` on the command-line).

If any of these is not true, we fall back to doing a normal walk of the
object graph.

Here are some sample timings from a full pack of `torvalds/linux` (i.e.
something very similar to what would be generated for a clone of the
repository) that show the speedup produced by various
methods:

    [existing graph traversal]
    $ time git pack-objects --all --stdout --no-use-bitmap-index \
			    </dev/null >/dev/null
    Counting objects: 3237103, done.
    Compressing objects: 100% (508752/508752), done.
    Total 3237103 (delta 2699584), reused 3237103 (delta 2699584)

    real    0m44.111s
    user    0m42.396s
    sys     0m3.544s

    [bitmaps only, without partial pack reuse; note that
     pack reuse is automatic, so timing this required a
     patch to disable it]
    $ time git pack-objects --all --stdout </dev/null >/dev/null
    Counting objects: 3237103, done.
    Compressing objects: 100% (508752/508752), done.
    Total 3237103 (delta 2699584), reused 3237103 (delta 2699584)

    real    0m5.413s
    user    0m5.604s
    sys     0m1.804s

    [bitmaps with pack reuse (what you get with this patch)]
    $ time git pack-objects --all --stdout </dev/null >/dev/null
    Reusing existing pack: 3237103, done.
    Total 3237103 (delta 0), reused 0 (delta 0)

    real    0m1.636s
    user    0m1.460s
    sys     0m0.172s

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |   6 ++
 builtin/pack-objects.c   | 169 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 150 insertions(+), 25 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab26963..a981369 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1858,6 +1858,12 @@ pack.packSizeLimit::
 	Common unit suffixes of 'k', 'm', or 'g' are
 	supported.
 
+pack.useBitmaps::
+	When true, git will use pack bitmaps (if available) when packing
+	to stdout (e.g., during the server side of a fetch). Defaults to
+	true. You should not generally need to turn this off unless
+	you are debugging pack bitmaps.
+
 pager.<cmd>::
 	If the value is boolean, turns on or off pagination of the
 	output of a particular Git subcommand when writing to a tty.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index faf746b..f04cce5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -19,6 +19,7 @@
 #include "refs.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "pack-bitmap.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [options...] [< ref-list | < object-list]"),
@@ -57,12 +58,23 @@ static struct progress *progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
 
+static struct packed_git *reuse_packfile;
+static uint32_t reuse_packfile_objects;
+static off_t reuse_packfile_offset;
+
+static int use_bitmap_index = 1;
+
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
 static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
+enum {
+	OBJECT_ENTRY_EXCLUDE = (1 << 0),
+	OBJECT_ENTRY_NO_TRY_DELTA = (1 << 1)
+};
+
 /*
  * stats
  */
@@ -678,6 +690,49 @@ static struct object_entry **compute_write_order(void)
 	return wo;
 }
 
+static off_t write_reused_pack(struct sha1file *f)
+{
+	uint8_t buffer[8192];
+	off_t to_write;
+	int fd;
+
+	if (!is_pack_valid(reuse_packfile))
+		return 0;
+
+	fd = git_open_noatime(reuse_packfile->pack_name);
+	if (fd < 0)
+		return 0;
+
+	if (lseek(fd, sizeof(struct pack_header), SEEK_SET) == -1) {
+		close(fd);
+		return 0;
+	}
+
+	if (reuse_packfile_offset < 0)
+		reuse_packfile_offset = reuse_packfile->pack_size - 20;
+
+	to_write = reuse_packfile_offset - sizeof(struct pack_header);
+
+	while (to_write) {
+		int read_pack = xread(fd, buffer, sizeof(buffer));
+
+		if (read_pack <= 0) {
+			close(fd);
+			return 0;
+		}
+
+		if (read_pack > to_write)
+			read_pack = to_write;
+
+		sha1write(f, buffer, read_pack);
+		to_write -= read_pack;
+	}
+
+	close(fd);
+	written += reuse_packfile_objects;
+	return reuse_packfile_offset - sizeof(struct pack_header);
+}
+
 static void write_pack_file(void)
 {
 	uint32_t i = 0, j;
@@ -704,6 +759,18 @@ static void write_pack_file(void)
 		offset = write_pack_header(f, nr_remaining);
 		if (!offset)
 			die_errno("unable to write pack header");
+
+		if (reuse_packfile) {
+			off_t packfile_size;
+			assert(pack_to_stdout);
+
+			packfile_size = write_reused_pack(f);
+			if (!packfile_size)
+				die_errno("failed to re-use existing pack");
+
+			offset += packfile_size;
+		}
+
 		nr_written = 0;
 		for (; i < to_pack.nr_objects; i++) {
 			struct object_entry *e = write_order[i];
@@ -800,14 +867,14 @@ static int no_try_delta(const char *path)
 	return 0;
 }
 
-static int add_object_entry(const unsigned char *sha1, enum object_type type,
-			    const char *name, int exclude)
+static int add_object_entry_1(const unsigned char *sha1, enum object_type type,
+			      int flags, uint32_t name_hash,
+			      struct packed_git *found_pack, off_t found_offset)
 {
 	struct object_entry *entry;
-	struct packed_git *p, *found_pack = NULL;
-	off_t found_offset = 0;
-	uint32_t hash = pack_name_hash(name);
+	struct packed_git *p;
 	uint32_t index_pos;
+	int exclude = (flags & OBJECT_ENTRY_EXCLUDE);
 
 	entry = packlist_find(&to_pack, sha1, &index_pos);
 	if (entry) {
@@ -822,36 +889,42 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	if (!exclude && local && has_loose_object_nonlocal(sha1))
 		return 0;
 
-	for (p = packed_git; p; p = p->next) {
-		off_t offset = find_pack_entry_one(sha1, p);
-		if (offset) {
-			if (!found_pack) {
-				if (!is_pack_valid(p)) {
-					warning("packfile %s cannot be accessed", p->pack_name);
-					continue;
+	if (!found_pack) {
+		for (p = packed_git; p; p = p->next) {
+			off_t offset = find_pack_entry_one(sha1, p);
+			if (offset) {
+				if (!found_pack) {
+					if (!is_pack_valid(p)) {
+						warning("packfile %s cannot be accessed", p->pack_name);
+						continue;
+					}
+					found_offset = offset;
+					found_pack = p;
 				}
-				found_offset = offset;
-				found_pack = p;
+				if (exclude)
+					break;
+				if (incremental)
+					return 0;
+				if (local && !p->pack_local)
+					return 0;
+				if (ignore_packed_keep && p->pack_local && p->pack_keep)
+					return 0;
 			}
-			if (exclude)
-				break;
-			if (incremental)
-				return 0;
-			if (local && !p->pack_local)
-				return 0;
-			if (ignore_packed_keep && p->pack_local && p->pack_keep)
-				return 0;
 		}
 	}
 
 	entry = packlist_alloc(&to_pack, sha1, index_pos);
-	entry->hash = hash;
+	entry->hash = name_hash;
 	if (type)
 		entry->type = type;
 	if (exclude)
 		entry->preferred_base = 1;
 	else
 		nr_result++;
+
+	if (flags & OBJECT_ENTRY_NO_TRY_DELTA)
+		entry->no_try_delta = 1;
+
 	if (found_pack) {
 		entry->in_pack = found_pack;
 		entry->in_pack_offset = found_offset;
@@ -859,10 +932,21 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 
 	display_progress(progress_state, to_pack.nr_objects);
 
+	return 1;
+}
+
+static int add_object_entry(const unsigned char *sha1, enum object_type type,
+			    const char *name, int exclude)
+{
+	int flags = 0;
+
+	if (exclude)
+		flags |= OBJECT_ENTRY_EXCLUDE;
+
 	if (name && no_try_delta(name))
-		entry->no_try_delta = 1;
+		flags |= OBJECT_ENTRY_NO_TRY_DELTA;
 
-	return 1;
+	return add_object_entry_1(sha1, type, flags, pack_name_hash(name), NULL, 0);
 }
 
 struct pbase_tree_cache {
@@ -2027,6 +2111,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		cache_max_small_delta_size = git_config_int(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.usebitmaps")) {
+		use_bitmap_index = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
 		if (delta_search_threads < 0)
@@ -2235,6 +2323,29 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 	}
 }
 
+static int get_object_list_from_bitmap(struct rev_info *revs)
+{
+	if (prepare_bitmap_walk(revs) < 0)
+		return -1;
+
+	if (!reuse_partial_packfile_from_bitmap(
+			&reuse_packfile,
+			&reuse_packfile_objects,
+			&reuse_packfile_offset)) {
+		assert(reuse_packfile_objects);
+		nr_result += reuse_packfile_objects;
+
+		if (progress) {
+			fprintf(stderr, "Reusing existing pack: %d, done.\n",
+				reuse_packfile_objects);
+			fflush(stderr);
+		}
+	}
+
+	traverse_bitmap_commit_list(&add_object_entry_1);
+	return 0;
+}
+
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
@@ -2262,6 +2373,9 @@ static void get_object_list(int ac, const char **av)
 			die("bad revision '%s'", line);
 	}
 
+	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
+		return;
+
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(&revs, show_edge);
@@ -2391,6 +2505,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			    N_("pack compression level")),
 		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
 			    N_("do not hide commits by grafts"), 0),
+		OPT_BOOL(0, "use-bitmap-index", &use_bitmap_index,
+			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_END(),
 	};
 
@@ -2457,6 +2573,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (keep_unreachable && unpack_unreachable)
 		die("--keep-unreachable and --unpack-unreachable are incompatible.");
 
+	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
+		use_bitmap_index = 0;
+
 	if (progress && all_progress_implied)
 		progress = 2;
 
-- 
1.8.5.rc0.443.g2df7f3f
