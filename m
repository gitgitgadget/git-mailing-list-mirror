From: Jeff King <peff@peff.net>
Subject: [PATCH v3 12/21] rev-list: add bitmap mode to speed up object lists
Date: Thu, 14 Nov 2013 07:45:23 -0500
Message-ID: <20131114124523.GL10757@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:45:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwIb-0000oJ-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748Ab3KNMp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:45:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:39135 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753331Ab3KNMpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:45:25 -0500
Received: (qmail 11563 invoked by uid 102); 14 Nov 2013 12:45:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:45:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:45:23 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237836>

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
 Documentation/git-rev-list.txt     |  1 +
 Documentation/rev-list-options.txt |  8 ++++++++
 builtin/rev-list.c                 | 39 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 045b37b..7a1585d 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -55,6 +55,7 @@ SYNOPSIS
 	     [ \--reverse ]
 	     [ \--walk-reflogs ]
 	     [ \--no-walk ] [ \--do-walk ]
+	     [ \--use-bitmap-index ]
 	     <commit>... [ \-- <paths>... ]
 
 DESCRIPTION
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ec86d09..f7c8a4d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -274,6 +274,14 @@ See also linkgit:git-reflog[1].
 	Output excluded boundary commits. Boundary commits are
 	prefixed with `-`.
 
+ifdef::git-rev-list[]
+--use-bitmap-index::
+
+	Try to speed up the traversal using the pack bitmap index (if
+	one is available). Note that when traversing with `--objects`,
+	trees and blobs will not have their associated path printed.
+endif::git-rev-list[]
+
 --
 
 History Simplification
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0745e2d..9f92905 100644
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
-- 
1.8.5.rc0.443.g2df7f3f
