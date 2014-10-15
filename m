From: Jeff King <peff@peff.net>
Subject: [PATCH v2 24/25] repack: pack objects mentioned by the index
Date: Wed, 15 Oct 2014 18:46:32 -0400
Message-ID: <20141015224632.GX25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:46:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXL5-0002Z2-9m
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbaJOWqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:46:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:59037 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750870AbaJOWqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:46:35 -0400
Received: (qmail 2821 invoked by uid 102); 15 Oct 2014 22:46:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:46:35 -0500
Received: (qmail 28318 invoked by uid 107); 15 Oct 2014 22:46:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:46:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:46:32 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we pack all objects, we use only the objects reachable
from references and reflogs. This misses any objects which
are reachable from the index, but not yet referenced.

By itself this isn't a big deal; the objects can remain
loose until they are actually used in a commit. However, it
does create a problem when we drop packed but unreachable
objects. We try to optimize out the writing of objects that
we will immediately prune, which means we must follow the
same rules as prune in determining what is reachable. And
prune uses the index for this purpose.

This is rather uncommon in practice, as objects in the index
would not usually have been packed in the first place. But
it could happen in a sequence like:

  1. You make a commit on a branch that references blob X.

  2. You repack, moving X into the pack.

  3. You delete the branch (and its reflog), so that X is
     unreferenced.

  4. You "git add" blob X so that it is now referenced only
     by the index.

  5. You repack again with git-gc. The pack-objects we
     invoke will see that X is neither referenced nor
     recent and not bother loosening it.

Signed-off-by: Jeff King <peff@peff.net>
---
In addition to fixing the safety, this is actually _packing_ those index
objects. I don't see anything wrong with that, but if would prefer not
to, it should be possible to do a separate traversal over the index
objects (and mark them as "to keep", but not "to pack").

 builtin/pack-objects.c               |  8 ++++++++
 builtin/repack.c                     |  1 +
 t/t7701-repack-unpack-unreachable.sh | 13 +++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b26276b..3dc9108 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2617,6 +2617,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int all_progress_implied = 0;
 	struct argv_array rp = ARGV_ARRAY_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
+	int rev_list_index = 0;
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
 			    N_("do not show progress meter"), 0),
@@ -2663,6 +2664,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		{ OPTION_SET_INT, 0, "reflog", &rev_list_reflog, NULL,
 		  N_("include objects referred by reflog entries"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		{ OPTION_SET_INT, 0, "index-objects", &rev_list_index, NULL,
+		  N_("include objects referred to by the index"),
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
 			 N_("output pack to stdout")),
 		OPT_BOOL(0, "include-tag", &include_tag,
@@ -2720,6 +2724,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		use_internal_rev_list = 1;
 		argv_array_push(&rp, "--reflog");
 	}
+	if (rev_list_index) {
+		use_internal_rev_list = 1;
+		argv_array_push(&rp, "--index-objects");
+	}
 	if (rev_list_unpacked) {
 		use_internal_rev_list = 1;
 		argv_array_push(&rp, "--unpacked");
diff --git a/builtin/repack.c b/builtin/repack.c
index 2aae05d..80b6021 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -209,6 +209,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd_args, "--non-empty");
 	argv_array_push(&cmd_args, "--all");
 	argv_array_push(&cmd_args, "--reflog");
+	argv_array_push(&cmd_args, "--index-objects");
 	if (window)
 		argv_array_pushf(&cmd_args, "--window=%s", window);
 	if (window_memory)
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index b8d4cde..aad8a9c 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -109,4 +109,17 @@ test_expect_success 'do not bother loosening old objects' '
 	test_must_fail git cat-file -p $obj2
 '
 
+test_expect_success 'keep packed objects found only in index' '
+	echo my-unique-content >file &&
+	git add file &&
+	git commit -m "make it reachable" &&
+	git gc &&
+	git reset HEAD^ &&
+	git reflog expire --expire=now --all &&
+	git add file &&
+	test-chmtime =-86400 .git/objects/pack/* &&
+	git gc --prune=1.hour.ago &&
+	git cat-file blob :file
+'
+
 test_done
-- 
2.1.2.596.g7379948
