From: Jeff King <peff@peff.net>
Subject: [PATCH 12/19] rev-list: add bitmap mode to speed up object lists
Date: Thu, 24 Oct 2013 14:06:27 -0400
Message-ID: <20131024180627.GL24180@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 20:06:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZPIo-00089n-Mf
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 20:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788Ab3JXSGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 14:06:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:54894 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755337Ab3JXSG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 14:06:29 -0400
Received: (qmail 912 invoked by uid 102); 24 Oct 2013 18:06:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 13:06:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 14:06:27 -0400
Content-Disposition: inline
In-Reply-To: <20131024175915.GA23398@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236599>

From: Vicent Marti <tanoku@gmail.com>

The bitmap reachability index used to speed up the counting objects
phase during `pack-objects` can also be used to optimize a normal
rev-list if the only thing required are the SHA1s of the objects during
the list (i.e., not the path names at which trees and blobs were found).

Calling `git rev-list --objects --use-bitmap-index [committish]` will
perform an object iteration based on a bitmap result instead of actually
walking the object graph.

These are some example timings for `torvalds/linux` (warm cache,
best-of-five):

    $ time git rev-list --objects master > /dev/null

    real    0m34.191s
    user    0m33.904s
    sys     0m0.268s

    $ time git rev-list --objects --use-bitmap-index master > /dev/null

    real    0m1.041s
    user    0m0.976s
    sys     0m0.064s

Likewise, using `git rev-list --count --use-bitmap-index` will speed up
the counting operation by building the resulting bitmap and performing a
fast popcount (number of bits set on the bitmap) on the result.

Here are some sample timings of different ways to count commits in
`torvalds/linux`:

    $ time git rev-list master | wc -l
        399882

        real    0m6.524s
        user    0m6.060s
        sys     0m3.284s

    $ time git rev-list --count master
        399882

        real    0m4.318s
        user    0m4.236s
        sys     0m0.076s

    $ time git rev-list --use-bitmap-index --count master
        399882

        real    0m0.217s
        user    0m0.176s
        sys     0m0.040s

This also respects negative refs, so you can use it to count
a slice of history:

        $ time git rev-list --count v3.0..master
        144843

        real    0m1.971s
        user    0m1.932s
        sys     0m0.036s

        $ time git rev-list --use-bitmap-index --count v3.0..master
        real    0m0.280s
        user    0m0.220s
        sys     0m0.056s

Though note that the closer the endpoints, the less it helps. In the
traversal case, we have fewer commits to cross, so we take less time.
But the bitmap time is dominated by generating the pack revindex, which
is constant with respect to the refs given.

Note that you cannot yet get a fast --left-right count of a symmetric
difference (e.g., "--count --left-right master...topic"). The slow part
of that walk actually happens during the merge-base determination when
we parse "master...topic". Even though a count does not actually need to
know the real merge base (it only needs to take the symmetric difference
of the bitmaps), the revision code would require some refactoring to
handle this case.

Additionally, a `--test-bitmap` flag has been added that will perform
the same rev-list manually (i.e. using a normal revwalk) and using
bitmaps, and verify that the results are the same. This can be used to
exercise the bitmap code, and also to verify that the contents of the
.bitmap file are sane.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Note that most of the time we spend for --count invocations is on
generating the pack revindex. It may be worth storing a revidx (either
in a separate file, as part of the .idx, or as an optional section in
the .bitmap file).

 builtin/rev-list.c | 39 +++++++++++++++++++++++++++++++++++++++
 pack-bitmap.c      |  2 +-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 4fc1616..5209255 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -3,6 +3,8 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "pack.h"
+#include "pack-bitmap.h"
 #include "builtin.h"
 #include "log-tree.h"
 #include "graph.h"
@@ -257,6 +259,18 @@ static int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 	return 0;
 }
 
+static int show_object_fast(
+	const unsigned char *sha1,
+	enum object_type type,
+	int exclude,
+	uint32_t name_hash,
+	struct packed_git *found_pack,
+	off_t found_offset)
+{
+	fprintf(stdout, "%s\n", sha1_to_hex(sha1));
+	return 1;
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -265,6 +279,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
+	int use_bitmap_index = 0;
 
 	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
@@ -306,6 +321,14 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_show_vars = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--use-bitmap-index")) {
+			use_bitmap_index = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--test-bitmap")) {
+			test_bitmap_walk(&revs);
+			return 0;
+		}
 		usage(rev_list_usage);
 
 	}
@@ -333,6 +356,22 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list)
 		revs.limited = 1;
 
+	if (use_bitmap_index) {
+		if (revs.count && !revs.left_right && !revs.cherry_mark) {
+			uint32_t commit_count;
+			if (!prepare_bitmap_walk(&revs)) {
+				count_bitmap_commit_list(&commit_count, NULL, NULL, NULL);
+				printf("%d\n", commit_count);
+				return 0;
+			}
+		} else if (revs.tag_objects && revs.tree_objects && revs.blob_objects) {
+			if (!prepare_bitmap_walk(&revs)) {
+				traverse_bitmap_commit_list(&show_object_fast);
+				return 0;
+			}
+		}
+	}
+
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	if (revs.tree_objects)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index b800736..cec56b2 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -920,7 +920,7 @@ void test_bitmap_walk(struct rev_info *revs)
 		die("failed to load bitmap indexes");
 
 	if (revs->pending.nr != 1)
-		die("only one bitmap can be tested at a time");
+		die("you must specify exactly one commit to test");
 
 	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
 		bitmap_git.version, bitmap_git.entry_count);
-- 
1.8.4.1.898.g8bf8a41.dirty
