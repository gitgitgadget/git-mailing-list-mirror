Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B216220281
	for <e@80x24.org>; Thu,  2 Nov 2017 17:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbdKBRuv (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 13:50:51 -0400
Received: from siwi.pair.com ([209.68.5.199]:39978 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934297AbdKBRul (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 13:50:41 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 193738457E;
        Thu,  2 Nov 2017 13:50:40 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5F61884565;
        Thu,  2 Nov 2017 13:50:39 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 5/6] rev-list: add list-objects filtering support
Date:   Thu,  2 Nov 2017 17:50:12 +0000
Message-Id: <20171102175013.3371-6-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102175013.3371-1-git@jeffhostetler.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach rev-list to use the filtering provided by the
traverse_commit_list_filtered() interface to omit
unwanted objects from the result.  This feature is
intended to help with partial clone.

Object filtering is only allowed when one of the "--objects*"
options are used.

When the "--filter-print-omitted" option is used, the omitted
objects are printed at the end.  These are marked with a "~".
This option can be combined with "--quiet" to get a list of
just the omitted objects.

Normally, rev-list will stop with an error when there are
missing objects.

When the "--filter-print-missing" option is used, rev-list
will print a list of any missing objects that should have
been included in the output (rather than stopping).
These are marked with a "?".

When the "--filter-ignore-missing" option is used, rev-list
will silently ignore any missing objects and continue without
error.

Add t6112 test.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-rev-list.txt      |   6 +-
 Documentation/rev-list-options.txt  |  34 ++++++
 builtin/rev-list.c                  |  75 +++++++++++-
 t/t6112-rev-list-filters-objects.sh | 225 ++++++++++++++++++++++++++++++++++++
 4 files changed, 337 insertions(+), 3 deletions(-)
 create mode 100755 t/t6112-rev-list-filters-objects.sh

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ef22f17..b8a3a5b 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -47,7 +47,11 @@ SYNOPSIS
 	     [ --fixed-strings | -F ]
 	     [ --date=<format>]
 	     [ [ --objects | --objects-edge | --objects-edge-aggressive ]
-	       [ --unpacked ] ]
+	       [ --unpacked ]
+	       [ --filter=<filter-spec> ] ]
+	     [ --filter-print-missing ]
+	     [ --filter-print-omitted ]
+	     [ --filter-ignore-missing ]
 	     [ --pretty | --header ]
 	     [ --bisect ]
 	     [ --bisect-vars ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 13501e1..9233134 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -706,6 +706,40 @@ ifdef::git-rev-list[]
 --unpacked::
 	Only useful with `--objects`; print the object IDs that are not
 	in packs.
+
+--filter=<filter-spec>::
+	Only useful with one of the `--objects*`; omits objects (usually
+	blobs) from the list of printed objects.  The '<filter-spec>'
+	may be one of the following:
++
+The form '--filter=blob:none' omits all blobs.
++
+The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
+or units.  The value may be zero.  Special files matching '.git*' are
+alwayse included, regardless of size.
++
+The form '--filter=sparse:oid=<oid-ish>' uses a sparse-checkout
+specification contained in the object (or the object that the expression
+evaluates to) to omit blobs not required by the corresponding sparse
+checkout.
++
+The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
+specification contained in <path>.
+
+--filter-print-missing::
+	Prints a list of the missing objects for the requested traversal.
+	Object IDs are prefixed with a ``?'' character.  The object type
+	is printed after the ID.  This may be used with or without any of
+	the above filtering options.
+
+--filter-ignore-missing::
+	Ignores missing objects encountered during the requested traversal.
+	This may be used with or without any of the above filtering options.
+
+--filter-print-omitted::
+	Only useful with one of the above `--filter*`; prints a list
+	of the omitted objects.  Object IDs are prefixed with a ``~''
+	character.
 endif::git-rev-list[]
 
 --no-walk[=(sorted|unsorted)]::
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c1c74d4..cc9fa40 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -4,6 +4,8 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "list-objects-filter.h"
+#include "list-objects-filter-options.h"
 #include "pack.h"
 #include "pack-bitmap.h"
 #include "builtin.h"
@@ -12,6 +14,7 @@
 #include "bisect.h"
 #include "progress.h"
 #include "reflog-walk.h"
+#include "oidset.h"
 
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -54,6 +57,15 @@ static const char rev_list_usage[] =
 
 static struct progress *progress;
 static unsigned progress_counter;
+static struct list_objects_filter_options filter_options;
+static struct oidset missing_objects;
+static struct oidset omitted_objects;
+static int arg_print_missing;
+static int arg_print_omitted;
+static int arg_ignore_missing;
+
+#define DEFAULT_OIDSET_SIZE     (16*1024)
+
 
 static void finish_commit(struct commit *commit, void *data);
 static void show_commit(struct commit *commit, void *data)
@@ -181,8 +193,16 @@ static void finish_commit(struct commit *commit, void *data)
 static void finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
+	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
+		if (arg_print_missing) {
+			oidset_insert(&missing_objects, &obj->oid);
+			return;
+		}
+		if (arg_ignore_missing)
+			return;
+
 		die("missing blob object '%s'", oid_to_hex(&obj->oid));
+	}
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
 		parse_object(&obj->oid);
 }
@@ -335,6 +355,30 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			show_progress = arg;
 			continue;
 		}
+
+		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
+			parse_list_objects_filter(&filter_options, arg);
+			if (filter_options.choice && !revs.blob_objects)
+				die(_("object filtering requires --objects"));
+			if (filter_options.choice == LOFC_SPARSE_OID &&
+			    !filter_options.sparse_oid_value)
+				die(_("invalid sparse value '%s'"),
+				    filter_options.raw_value);
+			continue;
+		}
+		if (!strcmp(arg, "--filter-print-missing")) {
+			arg_print_missing = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--filter-print-omitted")) {
+			arg_print_omitted = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--filter-ignore-missing")) {
+			arg_ignore_missing = 1;
+			continue;
+		}
+		
 		usage(rev_list_usage);
 
 	}
@@ -360,6 +404,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.show_notes)
 		die(_("rev-list does not support display of notes"));
 
+	if (filter_options.choice && use_bitmap_index)
+		die(_("cannot combine --use-bitmap-index with object filtering"));
+
 	save_commit_buffer = (revs.verbose_header ||
 			      revs.grep_filter.pattern_list ||
 			      revs.grep_filter.header_list);
@@ -404,7 +451,31 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			return show_bisect_vars(&info, reaches, all);
 	}
 
-	traverse_commit_list(&revs, show_commit, show_object, &info);
+	if (arg_print_missing)
+		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
+	if (arg_print_omitted)
+		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
+
+	traverse_commit_list_filtered(
+		&filter_options, &revs, show_commit, show_object, &info,
+		(arg_print_omitted ? &omitted_objects : NULL));
+
+	if (arg_print_omitted) {
+		struct oidset_iter iter;
+		struct object_id *oid;
+		oidset_iter_init(&omitted_objects, &iter);
+		while ((oid = oidset_iter_next(&iter)))
+			printf("~%s\n", oid_to_hex(oid));
+		oidset_clear(&omitted_objects);
+	}
+	if (arg_print_missing) {
+		struct oidset_iter iter;
+		struct object_id *oid;
+		oidset_iter_init(&missing_objects, &iter);
+		while ((oid = oidset_iter_next(&iter)))
+			printf("?%s\n", oid_to_hex(oid));
+		oidset_clear(&missing_objects);
+	}
 
 	stop_progress(&progress);
 
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
new file mode 100755
index 0000000..9327974
--- /dev/null
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -0,0 +1,225 @@
+#!/bin/sh
+
+test_description='git rev-list with object filtering for partial clone'
+
+. ./test-lib.sh
+
+# Test the blob:none filter.
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
+test_expect_success 'verify blob:none omits all 5 blobs' '
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r1 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:none \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify emitted+omitted == all' '
+	git -C r1 rev-list HEAD --objects \
+		| awk -f print_1.awk \
+		| sort >expected &&
+	git -C r1 rev-list HEAD --objects --filter-print-omitted --filter=blob:none \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
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
+test_expect_success 'verify blob:limit=500 omits all blobs' '
+	git -C r2 ls-files -s large.1000 large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=500 \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify emitted+omitted == all' '
+	git -C r2 rev-list HEAD --objects \
+		| awk -f print_1.awk \
+		| sort >expected &&
+	git -C r2 rev-list HEAD --objects --filter-print-omitted --filter=blob:limit=500 \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=1000' '
+	git -C r2 ls-files -s large.1000 large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1000 \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=1001' '
+	git -C r2 ls-files -s large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1001 \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=1k' '
+	git -C r2 ls-files -s large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1k \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=1m' '
+	cat </dev/null >expected &&
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1m \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
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
+test_expect_success 'verify sparse:path=pattern1 omits top-level files' '
+	git -C r3 ls-files -s sparse1 sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern1 \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify sparse:path=pattern2 omits both sparse2 files' '
+	git -C r3 ls-files -s sparse2 dir1/sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern2 \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+# Test sparse:oid=<oid-ish> filter.
+# Like sparse:path, but we get the sparse-checkout specification from
+# a blob rather than a file on disk.
+
+test_expect_success 'setup r3 part 2' '
+	echo dir1/ >r3/pattern &&
+	git -C r3 add pattern &&
+	git -C r3 commit -m "pattern"
+'
+
+test_expect_success 'verify sparse:oid=OID omits top-level files' '
+	git -C r3 ls-files -s pattern sparse1 sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	oid=$(git -C r3 ls-files -s pattern | awk -f print_2.awk) &&
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=$oid \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
+	git -C r3 ls-files -s pattern sparse1 sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=master:pattern \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+# Delete some loose objects and use rev-list, but WITHOUT any filtering.
+# This models previously omitted objects that we did not receive.
+
+test_expect_success 'rev-list W/ print-missing' '
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	for id in `cat expected | sed "s|..|&/|"`
+	do
+		rm r1/.git/objects/$id
+	done &&
+	git -C r1 rev-list --quiet HEAD --filter-print-missing --objects \
+		| awk -f print_1.awk \
+		| sed "s/?//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'rev-list W/O print-missing fails' '
+	test_must_fail git -C r1 rev-list --quiet --objects HEAD
+'
+
+test_expect_success 'rev-list W/ ignore-missing' '
+	git -C r1 rev-list --quiet --filter-ignore-missing --objects HEAD
+'
+
+test_done
-- 
2.9.3

