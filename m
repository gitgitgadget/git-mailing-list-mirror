From: Jeff King <peff@peff.net>
Subject: [PATCH v4 12/23] pack-objects: use bitmaps when packing objects
Date: Sat, 21 Dec 2013 09:00:09 -0500
Message-ID: <20131221140009.GL21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:00:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN6M-0005MF-W1
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244Ab3LUOAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:00:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:48488 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755201Ab3LUOAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:00:11 -0500
Received: (qmail 7422 invoked by uid 102); 21 Dec 2013 14:00:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:00:10 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:00:09 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239605>

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
 Documentation/config.txt |   6 +++
 builtin/pack-objects.c   | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

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
index 13b171d..030d894 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -19,6 +19,7 @@
 #include "refs.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "pack-bitmap.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [options...] [< ref-list | < object-list]"),
@@ -57,6 +58,12 @@ static struct progress *progress_state;
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
@@ -678,6 +685,46 @@ static struct object_entry **compute_write_order(void)
 	return wo;
 }
 
+static off_t write_reused_pack(struct sha1file *f)
+{
+	unsigned char buffer[8192];
+	off_t to_write;
+	int fd;
+
+	if (!is_pack_valid(reuse_packfile))
+		die("packfile is invalid: %s", reuse_packfile->pack_name);
+
+	fd = git_open_noatime(reuse_packfile->pack_name);
+	if (fd < 0)
+		die_errno("unable to open packfile for reuse: %s",
+			  reuse_packfile->pack_name);
+
+	if (lseek(fd, sizeof(struct pack_header), SEEK_SET) == -1)
+		die_errno("unable to seek in reused packfile");
+
+	if (reuse_packfile_offset < 0)
+		reuse_packfile_offset = reuse_packfile->pack_size - 20;
+
+	to_write = reuse_packfile_offset - sizeof(struct pack_header);
+
+	while (to_write) {
+		int read_pack = xread(fd, buffer, sizeof(buffer));
+
+		if (read_pack <= 0)
+			die_errno("unable to read from reused packfile");
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
@@ -704,6 +751,15 @@ static void write_pack_file(void)
 		offset = write_pack_header(f, nr_remaining);
 		if (!offset)
 			die_errno("unable to write pack header");
+
+		if (reuse_packfile) {
+			off_t packfile_size;
+			assert(pack_to_stdout);
+
+			packfile_size = write_reused_pack(f);
+			offset += packfile_size;
+		}
+
 		nr_written = 0;
 		for (; i < to_pack.nr_objects; i++) {
 			struct object_entry *e = write_order[i];
@@ -923,6 +979,22 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	return 1;
 }
 
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
+}
+
 struct pbase_tree_cache {
 	unsigned char sha1[20];
 	int ref;
@@ -2085,6 +2157,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
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
@@ -2293,6 +2369,29 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
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
+	traverse_bitmap_commit_list(&add_object_entry_from_bitmap);
+	return 0;
+}
+
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
@@ -2320,6 +2419,9 @@ static void get_object_list(int ac, const char **av)
 			die("bad revision '%s'", line);
 	}
 
+	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
+		return;
+
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(&revs, show_edge);
@@ -2449,6 +2551,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			    N_("pack compression level")),
 		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
 			    N_("do not hide commits by grafts"), 0),
+		OPT_BOOL(0, "use-bitmap-index", &use_bitmap_index,
+			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_END(),
 	};
 
@@ -2515,6 +2619,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (keep_unreachable && unpack_unreachable)
 		die("--keep-unreachable and --unpack-unreachable are incompatible.");
 
+	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
+		use_bitmap_index = 0;
+
 	if (progress && all_progress_implied)
 		progress = 2;
 
-- 
1.8.5.1.399.g900e7cd
