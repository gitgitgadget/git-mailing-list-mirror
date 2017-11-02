Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA08020281
	for <e@80x24.org>; Thu,  2 Nov 2017 17:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934302AbdKBRur (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 13:50:47 -0400
Received: from siwi.pair.com ([209.68.5.199]:39985 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934300AbdKBRul (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 13:50:41 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D8A2884550;
        Thu,  2 Nov 2017 13:50:40 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 39B5F84565;
        Thu,  2 Nov 2017 13:50:40 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 6/6] pack-objects: add list-objects filtering
Date:   Thu,  2 Nov 2017 17:50:13 +0000
Message-Id: <20171102175013.3371-7-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102175013.3371-1-git@jeffhostetler.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach pack-objects to use the filtering provided by the
traverse_commit_list_filtered() interface to omit unwanted
objects from the resulting packfile.

This feature is intended for partial clone/fetch.

Filtering requires the use of the "--stdout" option.

Add t5317 test.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-pack-objects.txt     |  12 +-
 builtin/pack-objects.c                 |  28 ++-
 t/t5317-pack-objects-filter-objects.sh | 369 +++++++++++++++++++++++++++++++++
 3 files changed, 407 insertions(+), 2 deletions(-)
 create mode 100755 t/t5317-pack-objects-filter-objects.sh

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 473a161..6786351 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
-	[--revs [--unpacked | --all]] [--stdout | base-name]
+	[--revs [--unpacked | --all]]
+	[--stdout [--filter=<filter-spec>] | base-name]
 	[--shallow] [--keep-true-parents] < object-list
 
 
@@ -236,6 +237,15 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	With this option, parents that are hidden by grafts are packed
 	nevertheless.
 
+--filter=<filter-spec>::
+	Requires `--stdout`.  Omits certain objects (usually blobs) from
+	the resulting packfile.  See linkgit:git-rev-list[1] for valid
+	`<filter-spec>` forms.
+
+--filter-ignore-missing:
+	Ignore missing objects without error.  This may be used with
+	or without and of the above filtering.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6e77dfd..e16722f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -15,6 +15,8 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "list-objects-filter.h"
+#include "list-objects-filter-options.h"
 #include "pack-objects.h"
 #include "progress.h"
 #include "refs.h"
@@ -79,6 +81,9 @@ static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
+static struct list_objects_filter_options filter_options;
+static int arg_ignore_missing;
+
 /*
  * stats
  */
@@ -2547,6 +2552,15 @@ static void show_commit(struct commit *commit, void *data)
 
 static void show_object(struct object *obj, const char *name, void *data)
 {
+	/*
+	 * Quietly ignore missing objects when they are expected.  This
+	 * avoids staging them and getting an odd error later.  If we are
+	 * not expecting them, stage it and let the normal error handling
+	 * deal with it.
+	 */
+	if (arg_ignore_missing && !has_object_file(&obj->oid))
+		return;
+
 	add_preferred_base_object(name);
 	add_object_entry(obj->oid.hash, obj->type, name, 0);
 	obj->flags |= OBJECT_ADDED;
@@ -2816,7 +2830,10 @@ static void get_object_list(int ac, const char **av)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(&revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
+
+	traverse_commit_list_filtered(&filter_options, &revs,
+				      show_commit, show_object, NULL,
+				      NULL);
 
 	if (unpack_unreachable_expiration) {
 		revs.ignore_missing_links = 1;
@@ -2952,6 +2969,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
 			 N_("write a bitmap index together with the pack index")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+		OPT_BOOL(0, "filter-ignore-missing", &arg_ignore_missing,
+			 N_("ignore and omit missing objects from packfile")),
 		OPT_END(),
 	};
 
@@ -3028,6 +3048,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
+	if (filter_options.choice) {
+		if (!pack_to_stdout)
+			die("cannot use filtering with an indexable pack.");
+		use_bitmap_index = 0;
+	}
+
 	/*
 	 * "soft" reasons not to use bitmaps - for on-disk repack by default we want
 	 *
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
new file mode 100755
index 0000000..4249557
--- /dev/null
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -0,0 +1,369 @@
+#!/bin/sh
+
+test_description='git pack-objects with object filtering for partial clone'
+
+. ./test-lib.sh
+
+# Test blob:none filter.
+
+test_expect_success 'setup r1' '
+	echo "{print \$1}" >print_1.awk &&
+	echo "{print \$2}" >print_2.awk &&
+
+	git init r1 &&
+	for n in 1 2 3 4 5
+	do
+		echo "This is file: $n" > r1/file.$n
+		git -C r1 add file.$n
+		git -C r1 commit -m "$n"
+	done
+'
+
+test_expect_success 'verify blob count in normal packfile' '
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r1 pack-objects --rev --stdout >all.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r1 index-pack ../all.pack &&
+	git -C r1 verify-pack -v ../all.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:none packfile has no blobs' '
+	git -C r1 pack-objects --rev --stdout --filter=blob:none >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r1 index-pack ../filter.pack &&
+	git -C r1 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	nr=$(wc -l <observed) &&
+	test 0 -eq $nr
+'
+
+test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
+	git -C r1 verify-pack -v ../all.pack \
+		| grep -E "commit|tree" \
+		| awk -f print_1.awk \
+		| sort >expected &&
+	git -C r1 verify-pack -v ../filter.pack \
+		| grep -E "commit|tree" \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+# Test blob:limit=<n>[kmg] filter.
+# We boundary test around the size parameter.  The filter is strictly less than
+# the value, so size 500 and 1000 should have the same results, but 1001 should
+# filter more.
+
+test_expect_success 'setup r2' '
+	git init r2 &&
+	for n in 1000 10000
+	do
+		printf "%"$n"s" X > r2/large.$n
+		git -C r2 add large.$n
+		git -C r2 commit -m "$n"
+	done
+'
+
+test_expect_success 'verify blob count in normal packfile' '
+	git -C r2 ls-files -s large.1000 large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 pack-objects --rev --stdout >all.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../all.pack &&
+	git -C r2 verify-pack -v ../all.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=500 omits all blobs' '
+	git -C r2 pack-objects --rev --stdout --filter=blob:limit=500 >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+	git -C r2 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	nr=$(wc -l <observed) &&
+	test 0 -eq $nr
+'
+
+test_expect_success 'verify blob:limit=1000' '
+	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1000 >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+	git -C r2 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	nr=$(wc -l <observed) &&
+	test 0 -eq $nr
+'
+
+test_expect_success 'verify blob:limit=1001' '
+	git -C r2 ls-files -s large.1000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1001 >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+	git -C r2 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=10001' '
+	git -C r2 ls-files -s large.1000 large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 pack-objects --rev --stdout --filter=blob:limit=10001 >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+	git -C r2 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=1k' '
+	git -C r2 ls-files -s large.1000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+	git -C r2 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=1m' '
+	git -C r2 ls-files -s large.1000 large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1m >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+	git -C r2 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify normal and blob:limit packfiles have same commits/trees' '
+	git -C r2 verify-pack -v ../all.pack \
+		| grep -E "commit|tree" \
+		| awk -f print_1.awk \
+		| sort >expected &&
+	git -C r2 verify-pack -v ../filter.pack \
+		| grep -E "commit|tree" \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+# Test sparse:path=<path> filter.
+# Use a local file containing a sparse-checkout specification to filter
+# out blobs not required for the corresponding sparse-checkout.  We do not
+# require sparse-checkout to actually be enabled.
+
+test_expect_success 'setup r3' '
+	git init r3 &&
+	mkdir r3/dir1 &&
+	for n in sparse1 sparse2
+	do
+		echo "This is file: $n" > r3/$n
+		git -C r3 add $n
+		echo "This is file: dir1/$n" > r3/dir1/$n
+		git -C r3 add dir1/$n
+	done &&
+	git -C r3 commit -m "sparse" &&
+	echo dir1/ >pattern1 &&
+	echo sparse1 >pattern2
+'
+
+test_expect_success 'verify blob count in normal packfile' '
+	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r3 pack-objects --rev --stdout >all.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r3 index-pack ../all.pack &&
+	git -C r3 verify-pack -v ../all.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify sparse:path=pattern1' '
+	git -C r3 ls-files -s dir1/sparse1 dir1/sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r3 pack-objects --rev --stdout --filter=sparse:path=../pattern1 >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r3 index-pack ../filter.pack &&
+	git -C r3 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify normal and sparse:path=pattern1 packfiles have same commits/trees' '
+	git -C r3 verify-pack -v ../all.pack \
+		| grep -E "commit|tree" \
+		| awk -f print_1.awk \
+		| sort >expected &&
+	git -C r3 verify-pack -v ../filter.pack \
+		| grep -E "commit|tree" \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify sparse:path=pattern2' '
+	git -C r3 ls-files -s sparse1 dir1/sparse1 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r3 pack-objects --rev --stdout --filter=sparse:path=../pattern2 >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r3 index-pack ../filter.pack &&
+	git -C r3 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify normal and sparse:path=pattern2 packfiles have same commits/trees' '
+	git -C r3 verify-pack -v ../all.pack \
+		| grep -E "commit|tree" \
+		| awk -f print_1.awk \
+		| sort >expected &&
+	git -C r3 verify-pack -v ../filter.pack \
+		| grep -E "commit|tree" \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+# Test sparse:oid=<oid-ish> filter.
+# Like sparse:path, but we get the sparse-checkout specification from
+# a blob rather than a file on disk.
+
+test_expect_success 'setup r4' '
+	git init r4 &&
+	mkdir r4/dir1 &&
+	for n in sparse1 sparse2
+	do
+		echo "This is file: $n" > r4/$n
+		git -C r4 add $n
+		echo "This is file: dir1/$n" > r4/dir1/$n
+		git -C r4 add dir1/$n
+	done &&
+	echo dir1/ >r4/pattern &&
+	git -C r4 add pattern &&
+	git -C r4 commit -m "pattern"
+'
+
+test_expect_success 'verify blob count in normal packfile' '
+	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r4 pack-objects --rev --stdout >all.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r4 index-pack ../all.pack &&
+	git -C r4 verify-pack -v ../all.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify sparse:oid=OID' '
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	oid=$(git -C r4 ls-files -s pattern | awk -f print_2.awk) &&
+	git -C r4 pack-objects --rev --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r4 index-pack ../filter.pack &&
+	git -C r4 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify sparse:oid=oid-ish' '
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r4 pack-objects --rev --stdout --filter=sparse:oid=master:pattern >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r4 index-pack ../filter.pack &&
+	git -C r4 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+# Delete some loose objects and use pack-objects, but WITHOUT any filtering.
+# This models previously omitted objects that we did not receive.
+
+test_expect_success 'setup r1 - delete loose blobs' '
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	for id in `cat expected | sed "s|..|&/|"`
+	do
+		rm r1/.git/objects/$id
+	done
+'
+
+test_expect_success 'verify pack-objects fails w/ missing objects' '
+	test_must_fail git -C r1 pack-objects --rev --stdout >miss.pack <<-EOF
+	HEAD
+	EOF
+'
+
+test_expect_success 'verify pack-objects w/ ignore-missing' '
+	git -C r1 pack-objects --rev --stdout --filter-ignore-missing >miss.pack <<-EOF
+	HEAD
+	EOF
+'
+
+test_done
-- 
2.9.3

