Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901DFC18E5B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544E920727
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UBbC6Nos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCJSWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:22:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51056 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbgCJSWM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Mar 2020 14:22:12 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0A71060732;
        Tue, 10 Mar 2020 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1583864531;
        bh=ndXgVAzwQzxO2oVuQgp+c905PfFiaizs1VOk9UZF5lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UBbC6Noski9eAmCQNZb7aZF3mBmM4wZSq9PqY7QZbDiHh2cGanKQ4oTgxR32I7zrd
         QoLiTAmsxm1YNHTbnrxP8LKDp8NjKlKNsmLKAJlDnGhRzfrP/xvVLTH4Ge11ObEyBr
         WUKqwdiu3tjTfOEHK20w0AbKiiA7qXzGWZHkgE3gkPzmWZmgXiwIrWM6qt5b5GmexG
         Qvu2+h6bxTnebGs8QSLVbpYweKqHVnjAB9xW2tOuG6b+Y8KK7IvrsmKzVsOEKzFKsb
         8KAsPUumc9w2P/vdAtFGA7D82mXXXTeQImw2ewYXoaKV0nPq2Eb4FTijZVmmuknMUn
         nBYyvqNI7qH0LfJxH/hoO5SgKbkEo8FgcTOuCdwmz7EdAehyobTvamKGUUWf1Tlq8E
         HNsm37U4dMlX6gtI96Ph5XB9JwjuHM7UeNxgY5UD1+8G5FbEFEmAQHNcAEJDbv2+49
         fw33mZ6VZaEs9KzQijtEm+bT8YDEN7M6Hxvggj4x0oCYlUvHBDh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 4/8] builtin/checkout: compute checkout metadata for checkouts
Date:   Tue, 10 Mar 2020 18:20:42 +0000
Message-Id: <20200310182046.748959-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200310182046.748959-1-sandals@crustytoothpaste.net>
References: <20200310182046.748959-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

Provide commit metadata for checkout code paths that use unpack_trees
and friends.  When we're checking out a commit, use the commit
information, but don't provide commit information if we're checking out
from the index, since there need not be any particular commit associated
with the index, and even if there is one, we can't know what it is.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 builtin/checkout.c      | 17 ++++++---
 merge.c                 |  1 +
 t/t0021-conversion.sh   | 78 ++++++++++++++++++++++++++---------------
 t/t0021/rot13-filter.pl |  2 +-
 unpack-trees.c          |  1 +
 unpack-trees.h          |  1 +
 6 files changed, 67 insertions(+), 33 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a7bfa3688d..1e0919f80a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -602,7 +602,8 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 }
 
 static int reset_tree(struct tree *tree, const struct checkout_opts *o,
-		      int worktree, int *writeout_error)
+		      int worktree, int *writeout_error,
+		      struct branch_info *info)
 {
 	struct unpack_trees_options opts;
 	struct tree_desc tree_desc;
@@ -617,6 +618,10 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	init_checkout_metadata(&opts.meta, info->path,
+			       info->commit ? &info->commit->object.oid :
+			       &tree->object.oid,
+			       NULL);
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	switch (unpack_trees(1, &tree_desc, &opts)) {
@@ -668,7 +673,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	} else
 		new_tree = get_commit_tree(new_branch_info->commit);
 	if (opts->discard_changes) {
-		ret = reset_tree(new_tree, opts, 1, writeout_error);
+		ret = reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
 		if (ret)
 			return ret;
 	} else {
@@ -697,6 +702,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		topts.quiet = opts->merge && old_branch_info->commit;
 		topts.verbose_update = opts->show_progress;
 		topts.fn = twoway_merge;
+		init_checkout_metadata(&topts.meta, new_branch_info->path,
+				       new_branch_info->commit ?
+				       &new_branch_info->commit->object.oid :
+				       NULL, NULL);
 		if (opts->overwrite_ignore) {
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
 			topts.dir->flags |= DIR_SHOW_IGNORED;
@@ -767,7 +776,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 			ret = reset_tree(new_tree,
 					 opts, 1,
-					 writeout_error);
+					 writeout_error, new_branch_info);
 			if (ret)
 				return ret;
 			o.ancestor = old_branch_info->name;
@@ -787,7 +796,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				exit(128);
 			ret = reset_tree(new_tree,
 					 opts, 0,
-					 writeout_error);
+					 writeout_error, new_branch_info);
 			strbuf_release(&o.obuf);
 			strbuf_release(&old_commit_shortname);
 			if (ret)
diff --git a/merge.c b/merge.c
index 7c1d756c3f..aa36de2f64 100644
--- a/merge.c
+++ b/merge.c
@@ -94,6 +94,7 @@ int checkout_fast_forward(struct repository *r,
 	opts.verbose_update = 1;
 	opts.merge = 1;
 	opts.fn = twoway_merge;
+	init_checkout_metadata(&opts.meta, NULL, remote, NULL);
 	setup_unpack_trees_porcelain(&opts, "merge");
 
 	if (unpack_trees(nr_trees, t, &opts)) {
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index dc664da551..4b8d6a74a7 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -364,6 +364,10 @@ test_expect_success PERL 'required process filter should filter data' '
 		S=$(file_size test.r) &&
 		S2=$(file_size test2.r) &&
 		S3=$(file_size "testsubdir/test3 '\''sq'\'',\$x=.r") &&
+		M=$(git hash-object test.r) &&
+		M2=$(git hash-object test2.r) &&
+		M3=$(git hash-object "testsubdir/test3 '\''sq'\'',\$x=.r") &&
+		EMPTY=$(git hash-object /dev/null) &&
 
 		filter_git add . &&
 		cat >expected.log <<-EOF &&
@@ -378,14 +382,15 @@ test_expect_success PERL 'required process filter should filter data' '
 		test_cmp_count expected.log debug.log &&
 
 		git commit -m "test commit 2" &&
+		META="ref=refs/heads/master treeish=$(git rev-parse --verify master)" &&
 		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x=.r" &&
 
 		filter_git checkout --quiet --no-progress . &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
-			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: smudge test2.r blob=$M2 $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r blob=$M3 $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
@@ -406,10 +411,10 @@ test_expect_success PERL 'required process filter should filter data' '
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
-			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
-			IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
-			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: smudge test.r $META blob=$M $S [OK] -- OUT: $S . [OK]
+			IN: smudge test2.r $META blob=$M2 $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge test4-empty.r $META blob=$EMPTY 0 [OK] -- OUT: 0  [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $META blob=$M3 $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
@@ -519,17 +524,22 @@ test_expect_success PERL 'required process filter should process multiple packet
 		EOF
 		test_cmp_count expected.log debug.log &&
 
-		rm -f *.file &&
+		M1="blob=$(git hash-object 1pkt_1__.file)" &&
+		M2="blob=$(git hash-object 2pkt_1+1.file)" &&
+		M3="blob=$(git hash-object 2pkt_2-1.file)" &&
+		M4="blob=$(git hash-object 2pkt_2__.file)" &&
+		M5="blob=$(git hash-object 3pkt_2+1.file)" &&
+		rm -f *.file debug.log &&
 
 		filter_git checkout --quiet --no-progress -- *.file &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge 1pkt_1__.file $(($S    )) [OK] -- OUT: $(($S    )) . [OK]
-			IN: smudge 2pkt_1+1.file $(($S  +1)) [OK] -- OUT: $(($S  +1)) .. [OK]
-			IN: smudge 2pkt_2-1.file $(($S*2-1)) [OK] -- OUT: $(($S*2-1)) .. [OK]
-			IN: smudge 2pkt_2__.file $(($S*2  )) [OK] -- OUT: $(($S*2  )) .. [OK]
-			IN: smudge 3pkt_2+1.file $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
+			IN: smudge 1pkt_1__.file $M1 $(($S    )) [OK] -- OUT: $(($S    )) . [OK]
+			IN: smudge 2pkt_1+1.file $M2 $(($S  +1)) [OK] -- OUT: $(($S  +1)) .. [OK]
+			IN: smudge 2pkt_2-1.file $M3 $(($S*2-1)) [OK] -- OUT: $(($S*2-1)) .. [OK]
+			IN: smudge 2pkt_2__.file $M4 $(($S*2  )) [OK] -- OUT: $(($S*2  )) .. [OK]
+			IN: smudge 3pkt_2+1.file $M5 $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
@@ -578,6 +588,10 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		S=$(file_size test.r) &&
 		S2=$(file_size test2.r) &&
 		SF=$(file_size smudge-write-fail.r) &&
+		M=$(git hash-object test.r) &&
+		M2=$(git hash-object test2.r) &&
+		MF=$(git hash-object smudge-write-fail.r) &&
+		rm -f debug.log &&
 
 		git add . &&
 		rm -f *.r &&
@@ -591,11 +605,11 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge smudge-write-fail.r $SF [OK] -- [WRITE FAIL]
+			IN: smudge smudge-write-fail.r blob=$MF $SF [OK] -- [WRITE FAIL]
 			START
 			init handshake complete
-			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
-			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge test.r blob=$M $S [OK] -- OUT: $S . [OK]
+			IN: smudge test2.r blob=$M2 $S2 [OK] -- OUT: $S2 . [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
@@ -629,6 +643,10 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 		S=$(file_size test.r) &&
 		S2=$(file_size test2.r) &&
 		SE=$(file_size error.r) &&
+		M=$(git hash-object test.r) &&
+		M2=$(git hash-object test2.r) &&
+		ME=$(git hash-object error.r) &&
+		rm -f debug.log &&
 
 		git add . &&
 		rm -f *.r &&
@@ -637,9 +655,9 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge error.r $SE [OK] -- [ERROR]
-			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
-			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge error.r blob=$ME $SE [OK] -- [ERROR]
+			IN: smudge test.r blob=$M $S [OK] -- OUT: $S . [OK]
+			IN: smudge test2.r blob=$M2 $S2 [OK] -- OUT: $S2 . [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
@@ -665,18 +683,21 @@ test_expect_success PERL 'process filter abort stops processing of all further f
 		echo "error this blob and all future blobs" >abort.o &&
 		cp abort.o abort.r &&
 
+		M="blob=$(git hash-object abort.r)" &&
+		rm -f debug.log &&
 		SA=$(file_size abort.r) &&
 
 		git add . &&
 		rm -f *.r &&
 
+
 		# Note: This test assumes that Git filters files in alphabetical
 		# order ("abort.r" before "test.r").
 		filter_git checkout --quiet --no-progress . &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge abort.r $SA [OK] -- [ABORT]
+			IN: smudge abort.r $M $SA [OK] -- [ABORT]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
@@ -727,27 +748,28 @@ test_expect_success PERL 'delayed checkout in process filter' '
 	) &&
 
 	S=$(file_size "$TEST_ROOT/test.o") &&
+	M="blob=$(git -C repo rev-parse --verify master:test.a)" &&
 	cat >a.exp <<-EOF &&
 		START
 		init handshake complete
-		IN: smudge test.a $S [OK] -- OUT: $S . [OK]
-		IN: smudge test-delay10.a $S [OK] -- [DELAYED]
-		IN: smudge test-delay11.a $S [OK] -- [DELAYED]
-		IN: smudge test-delay20.a $S [OK] -- [DELAYED]
+		IN: smudge test.a $M $S [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay10.a $M $S [OK] -- [DELAYED]
+		IN: smudge test-delay11.a $M $S [OK] -- [DELAYED]
+		IN: smudge test-delay20.a $M $S [OK] -- [DELAYED]
 		IN: list_available_blobs test-delay10.a test-delay11.a [OK]
-		IN: smudge test-delay10.a 0 [OK] -- OUT: $S . [OK]
-		IN: smudge test-delay11.a 0 [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay10.a $M 0 [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay11.a $M 0 [OK] -- OUT: $S . [OK]
 		IN: list_available_blobs test-delay20.a [OK]
-		IN: smudge test-delay20.a 0 [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay20.a $M 0 [OK] -- OUT: $S . [OK]
 		IN: list_available_blobs [OK]
 		STOP
 	EOF
 	cat >b.exp <<-EOF &&
 		START
 		init handshake complete
-		IN: smudge test-delay10.b $S [OK] -- [DELAYED]
+		IN: smudge test-delay10.b $M $S [OK] -- [DELAYED]
 		IN: list_available_blobs test-delay10.b [OK]
-		IN: smudge test-delay10.b 0 [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay10.b $M 0 [OK] -- OUT: $S . [OK]
 		IN: list_available_blobs [OK]
 		STOP
 	EOF
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index c43cf433cf..cd32a82da5 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -136,7 +136,7 @@ sub rot13 {
 					$DELAY{$pathname}{"requested"} = 1;
 				}
 			} elsif ($buffer =~ /^(ref|treeish|blob)=/) {
-				# Do nothing.
+				print $debug " $buffer";
 			} else {
 				# In general, filters need to be graceful about
 				# new metadata, since it's documented that we
diff --git a/unpack-trees.c b/unpack-trees.c
index 1ecdab3304..3aba5da6b6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -371,6 +371,7 @@ static int check_updates(struct unpack_trees_options *o)
 	state.quiet = 1;
 	state.refresh_cache = 1;
 	state.istate = index;
+	clone_checkout_metadata(&state.meta, &o->meta, NULL);
 
 	if (!o->update || o->dry_run) {
 		remove_marked_cache_entries(index, 0);
diff --git a/unpack-trees.h b/unpack-trees.h
index ae1557fb80..ad41b45a71 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -85,6 +85,7 @@ struct unpack_trees_options {
 	struct index_state result;
 
 	struct pattern_list *pl; /* for internal use */
+	struct checkout_metadata meta;
 };
 
 int unpack_trees(unsigned n, struct tree_desc *t,
