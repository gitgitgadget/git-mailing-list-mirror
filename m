Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56035C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFD72067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgG2UKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:10:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:41476 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2UKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:10:22 -0400
Received: (qmail 8790 invoked by uid 109); 29 Jul 2020 20:10:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 20:10:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7795 invoked by uid 111); 29 Jul 2020 20:10:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 16:10:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 16:10:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v2 2/7] revision: add "--no-diff-merges" option to counteract
 "-m"
Message-ID: <20200729201020.GB2989342@coredump.intra.peff.net>
References: <20200729201002.GA2989059@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729201002.GA2989059@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "-m" option sets revs->ignore_merges to "0", but there's no way to
undo it. This probably isn't something anybody overly cares about, since
"1" is already the default, but it will serve as an escape hatch when we
flip the default for ignore_merges to "0" in more situations.

We'll also add a few extra niceties:

  - initialize the value to "-1" to indicate "not set", and then resolve
    it to the normal 0/1 bool in setup_revisions(). This lets any tweak
    functions, as well as setup_revisions() itself, avoid clobbering the
    user's preference (which until now they couldn't actually express).

  - since we now have --no-diff-merges, let's add the matching
    --diff-merges, which is just a synonym for "-m". Then we don't even
    need to document --no-diff-merges separately; it countermands the
    long form of "-m" in the usual way.

The new test shows that this behaves just the same as the current
behavior without "-m".

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt            |  1 +
 builtin/log.c                                 |  4 +-
 revision.c                                    | 10 ++-
 revision.h                                    |  2 +-
 t/t4013-diff-various.sh                       |  1 +
 ..._--no-diff-merges_-p_--first-parent_master | 78 +++++++++++++++++++
 6 files changed, 90 insertions(+), 6 deletions(-)
 create mode 100644 t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b01b2b6773..0785a0cfe9 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1148,6 +1148,7 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 	rename or copy detection have been requested).
 
 -m::
+--diff-merges::
 	This flag makes the merge commits show the full diff like
 	regular commits; for each merge parent, a separate log entry
 	and diff is generated. An exception is that only diff against
diff --git a/builtin/log.c b/builtin/log.c
index 281d2ae8eb..39b3d773a9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -599,8 +599,8 @@ static int show_tree_object(const struct object_id *oid,
 static void show_setup_revisions_tweak(struct rev_info *rev,
 				       struct setup_revision_opt *opt)
 {
-	if (rev->ignore_merges) {
-		/* There was no "-m" on the command line */
+	if (rev->ignore_merges < 0) {
+		/* There was no "-m" variant on the command line */
 		rev->ignore_merges = 0;
 		if (!rev->first_parent_only && !rev->combine_merges) {
 			/* No "--first-parent", "-c", or "--cc" */
diff --git a/revision.c b/revision.c
index 6aa7f4f567..669bc85669 100644
--- a/revision.c
+++ b/revision.c
@@ -1795,7 +1795,7 @@ void repo_init_revisions(struct repository *r,
 
 	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
-	revs->ignore_merges = 1;
+	revs->ignore_merges = -1;
 	revs->simplify_history = 1;
 	revs->pruning.repo = r;
 	revs->pruning.flags.recursive = 1;
@@ -2323,8 +2323,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
 		revs->diffopt.flags.tree_in_recursive = 1;
-	} else if (!strcmp(arg, "-m")) {
+	} else if (!strcmp(arg, "-m") || !strcmp(arg, "--diff-merges")) {
 		revs->ignore_merges = 0;
+	} else if (!strcmp(arg, "--no-diff-merges")) {
+		revs->ignore_merges = 1;
 	} else if (!strcmp(arg, "-c")) {
 		revs->diff = 1;
 		revs->dense_combined_merges = 0;
@@ -2834,8 +2836,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			copy_pathspec(&revs->diffopt.pathspec,
 				      &revs->prune_data);
 	}
-	if (revs->combine_merges)
+	if (revs->combine_merges && revs->ignore_merges < 0)
 		revs->ignore_merges = 0;
+	if (revs->ignore_merges < 0)
+		revs->ignore_merges = 1;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
 
diff --git a/revision.h b/revision.h
index f412ae85eb..5258024743 100644
--- a/revision.h
+++ b/revision.h
@@ -190,11 +190,11 @@ struct rev_info {
 			show_root_diff:1,
 			no_commit_id:1,
 			verbose_header:1,
-			ignore_merges:1,
 			combine_merges:1,
 			combined_all_paths:1,
 			dense_combined_merges:1,
 			always_show_header:1;
+	int             ignore_merges:2;
 
 	/* Format info */
 	int		show_notes;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 43267d6024..40e222c945 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -297,6 +297,7 @@ log --root --patch-with-stat --summary master
 log --root -c --patch-with-stat --summary master
 # improved by Timo's patch
 log --root --cc --patch-with-stat --summary master
+log --no-diff-merges -p --first-parent master
 log -p --first-parent master
 log -m -p --first-parent master
 log -m -p master
diff --git a/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master b/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master
new file mode 100644
index 0000000000..94bf1850b2
--- /dev/null
+++ b/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master
@@ -0,0 +1,78 @@
+$ git log --no-diff-merges -p --first-parent master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side' into master
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+diff --git a/dir/sub b/dir/sub
+index 8422d40..cead32e 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -2,3 +2,5 @@ A
+ B
+ C
+ D
++E
++F
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..8422d40 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++C
++D
+diff --git a/file0 b/file0
+index 01e79c3..b414108 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++4
++5
++6
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
-- 
2.28.0.465.gd2839157e3

