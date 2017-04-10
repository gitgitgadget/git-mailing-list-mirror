Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372BB20960
	for <e@80x24.org>; Mon, 10 Apr 2017 21:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbdDJVOT (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 17:14:19 -0400
Received: from siwi.pair.com ([209.68.5.199]:36453 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752819AbdDJVOO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 17:14:14 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A33AC84569;
        Mon, 10 Apr 2017 17:14:12 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v8 2/3] p0006-read-tree-checkout: perf test to time read-tree
Date:   Mon, 10 Apr 2017 21:14:02 +0000
Message-Id: <20170410211403.25126-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170410211403.25126-1-git@jeffhostetler.com>
References: <20170410211403.25126-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Created t/perf/repos/many-files.sh to generate large, but
artificial repositories.

Created t/perf/p0006-read-tree-checkout.sh to measure
performance on various read-tree, checkout, and update-index
operations.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p0006-read-tree-checkout.sh |  90 ++++++++++++++++++++++++++++
 t/perf/repos/.gitignore            |   1 +
 t/perf/repos/many-files.sh         | 118 +++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100755 t/perf/p0006-read-tree-checkout.sh
 create mode 100644 t/perf/repos/.gitignore
 create mode 100755 t/perf/repos/many-files.sh

diff --git a/t/perf/p0006-read-tree-checkout.sh b/t/perf/p0006-read-tree-checkout.sh
new file mode 100755
index 0000000..69425ae
--- /dev/null
+++ b/t/perf/p0006-read-tree-checkout.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+##
+## This test measures the performance of various read-tree
+## and checkout operations.  It is primarily interested in
+## the algorithmic costs of index operations and recursive
+## tree traversal -- and NOT disk I/O on thousands of files.
+## Therefore, it uses sparse-checkout to avoid populating
+## the ballast files.
+##
+## It expects the test repo to have certain characteristics.
+## Branches:
+## () master        := an arbitrary commit.
+## () ballast       := an arbitrary commit with a large number
+##                     of changes relative to "master".
+## () ballast-alias := a branch pointing to the same commit
+##                     as "ballast".
+## () ballast-1     := a commit with a 1 file difference from
+##                     "ballast".
+##
+## Ballast files in the repository should not appear in
+## the sparse-checkout (if present).
+##
+## See "t/perf/repos/many-files.sh" to generate some
+## synthetic data.
+## 
+
+test_description="Tests performance of read-tree"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'setup' '
+	echo "sparse/*" >>.git/info/sparse-checkout &&
+	git config --local core.sparsecheckout 1 &&
+	git checkout ballast
+'
+
+nr_files=$(git ls-files | wc -l)
+
+test_perf "read-tree master ballast ($nr_files)" '
+	git read-tree -m master ballast -n
+'
+
+## Alternate between a commit with and without the ballast.
+test_perf "switch between master ballast ($nr_files)" '
+	git checkout master &&
+	git checkout ballast
+'
+
+## Alternate between 2 commits with the ballast and 1 change.
+test_perf "switch between ballast ballast-1 ($nr_files)" '
+	git checkout ballast-1 &&
+	git checkout ballast
+'
+
+## Alternate between 2 aliases for the same commit.
+test_perf "switch between aliases ballast ballast-alias ($nr_files)" '
+	git checkout ballast-alias &&
+	git checkout ballast
+'
+
+export nr_random=200000
+
+## Add random items in sorted order. These will effectively
+## get appended because "zzzz/" sorts after anything already
+## present in index.  Then delete them in reverse order, so
+## that the last is removed each time.
+test_perf "add forward sorted items ($nr_files) ($nr_random)" '
+	awk "BEGIN { for (f = 0; f <= $nr_random; f++) printf \"r_%06d\n\", f }" |
+	sed "s|^|100644 $EMPTY_BLOB	zzzz/|" |
+	git update-index --index-info &&
+	awk "BEGIN { for (f = $nr_random; f >= 0; f--) printf \"r_%06d\n\", f }" |
+	sed "s|^|000000 $EMPTY_BLOB	zzzz/|" |
+	git update-index --index-info
+'
+
+## Add random items in reverse order. These will be inserted
+## NEAR the end of the index, but not at the end.  Then delete
+## them in the opposite order, so that we remove from the middle.
+test_perf "add reverse sorted items ($nr_files) ($nr_random)" '
+	awk "BEGIN { for (f = $nr_random; f >= 0; f--) printf \"r_%06d\n\", f }" |
+	sed "s|^|100644 $EMPTY_BLOB	zzzz/|" |
+	git update-index --index-info &&
+	awk "BEGIN { for (f = 0; f <= $nr_random; f++) printf \"r_%06d\n\", f }" |
+	sed "s|^|000000 $EMPTY_BLOB	zzzz/|" |
+	git update-index --index-info
+'
+
+test_done
diff --git a/t/perf/repos/.gitignore b/t/perf/repos/.gitignore
new file mode 100644
index 0000000..72e3dc3
--- /dev/null
+++ b/t/perf/repos/.gitignore
@@ -0,0 +1 @@
+gen-*/
diff --git a/t/perf/repos/many-files.sh b/t/perf/repos/many-files.sh
new file mode 100755
index 0000000..a4c44b3
--- /dev/null
+++ b/t/perf/repos/many-files.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+## Generate test data repository "many-files.git" using the given parameters.
+## Usage: [-r repo] [-d depth] [-w width] [-f files]
+##
+## -r repo: path to the new repo to be generated
+## -d depth: the depth of sub-directories
+## -w width: the number of sub-directories at each level
+## -f files: the number of files created in each directory
+##
+## Note that all files will have the same SHA-1 and each
+## directory at a level will have the same SHA-1, so we
+## will potentially have a large index, but not a large
+## ODB.
+##
+## Ballast will be created under "ballast/".  Sparse-checkout
+## will be enabled so that they will not be populated by
+## default.
+
+EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+
+set -e
+
+## (5, 10, 9) will create 999,999 ballast files.
+## (4, 10, 9) will create  99,999 ballast files.
+depth=5
+width=10
+files=9
+
+while test "$#" -ne 0
+do
+    case "$1" in
+	-r)
+	    shift;
+	    test "$#" -ne 0 || { echo 'error: -r requires an argument' >&2; exit 1; }
+	    repo=$1;
+	    shift ;;
+	-d)
+	    shift;
+	    test "$#" -ne 0 || { echo 'error: -d requires an argument' >&2; exit 1; }
+	    depth=$1;
+	    shift ;;
+	-w)
+	    shift;
+	    test "$#" -ne 0 || { echo 'error: -w requires an argument' >&2; exit 1; }
+	    width=$1;
+	    shift ;;
+	-f)
+	    shift;
+	    test "$#" -ne 0 || { echo 'error: -f requires an argument' >&2; exit 1; }
+	    files=$1;
+	    shift ;;
+	*)
+	    echo "error: unknown option '$1'" >&2; exit 1 ;;
+	esac
+done
+
+## Inflate the index with thousands of empty files.
+## usage: dir depth width files
+fill_index() {
+	awk -v arg_dir=$1 -v arg_depth=$2 -v arg_width=$3 -v arg_files=$4 '
+		function make_paths(dir, depth, width, files, f, w) {
+			for (f = 1; f <= files; f++) {
+				print dir "/file" f
+			}
+			if (depth > 0) {
+				for (w = 1; w <= width; w++) {
+					make_paths(dir "/dir" w, depth - 1, width, files)
+				}
+			}
+		}
+		END { make_paths(arg_dir, arg_depth, arg_width, arg_files) }
+		' </dev/null |
+	sed "s/^/100644 $EMPTY_BLOB	/" |
+	git update-index --index-info
+	return 0
+}
+
+[ -z "$repo" ] && repo=gen-many-files-$depth.$width.$files.git
+
+mkdir $repo
+cd $repo
+git init .
+
+## Create initial commit just to define branch.
+mkdir sparse
+touch sparse/file.txt
+echo "$depth $width $files" >sparse/repo.params
+git add sparse
+git commit -q -m params
+
+## Turn on sparse-checkout so that we don't have to populate
+## the ballast when switching branches.  Use reset --hard to
+## quickly checkout the new HEAD with minimum actual files.
+echo 'sparse/*' >>.git/info/sparse-checkout
+git config --local core.sparsecheckout 1
+git reset --hard
+
+## Inflate the index with thousands of empty files and commit.
+git checkout -b ballast
+fill_index "ballast" $depth $width $files
+git commit -q -m "ballast"
+
+## Create an alias for that commit.
+git branch "ballast-alias"
+
+nr_files=$(git ls-files | wc -l)
+
+## Modify 1 file and commit.
+git checkout -b "ballast-1"
+echo x >sparse/file.txt
+git add sparse
+git commit -q -m "ballast plus 1"
+
+## Checkout master to put repo in canonical state.
+git checkout master
+
+echo "Repository "$repo" ($depth, $width, $files) created.  Ballast $nr_files."
+exit 0
-- 
2.9.3

