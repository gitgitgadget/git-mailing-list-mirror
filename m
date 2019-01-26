Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185051F453
	for <e@80x24.org>; Sat, 26 Jan 2019 22:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfAZWSj (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 17:18:39 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59212 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbfAZWSj (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Jan 2019 17:18:39 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0QMF7NA013180;
        Sat, 26 Jan 2019 14:18:15 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2q8p9rgbst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 26 Jan 2019 14:18:14 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sat, 26 Jan 2019 14:18:10 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sat, 26 Jan 2019 14:17:58 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 4F7212212480;
        Sat, 26 Jan 2019 14:18:13 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3] log,diff-tree: add --combined-all-names option
Date:   Sat, 26 Jan 2019 14:18:11 -0800
Message-ID: <20190126221811.20241-1-newren@gmail.com>
X-Mailer: git-send-email 2.20.1.310.g17ca096f17
In-Reply-To: <20190125165416.17473-1-newren@gmail.com>
References: <20190125165416.17473-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901260169
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The combined diff format for merges will only list one filename, even if
rename or copy detection is active.  For example, with raw format one
might see:

  ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
  ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	bar.sh
  ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	phooey.c

This doesn't let us know what the original name of bar.sh was in the
first parent, and doesn't let us know what either of the original names
of phooey.c were in either of the parents.  In contrast, for non-merge
commits, raw format does provide original filenames (and a rename score
to boot).  In order to also provide original filenames for merge
commits, add a --combined-all-names option (which must be used with
either -c or --cc, and is likely only useful with rename or copy
detection active) so that we can print tab-separated filenames when
renames are involved.  This transforms the above output to:

  ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	desc.c	desc.c	desc.c
  ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	foo.sh	bar.sh	bar.sh
  ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	fooey.c	fuey.c	phooey.c

Further, in patch format, this changes the from/to headers so that
instead of just having one "from" header, we get one for each parent.
For example, instead of having

  --- a/phooey.c
  +++ b/phooey.c

we would see

  --- a/fooey.c
  --- a/fuey.c
  +++ b/phooey.c

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v2:
  * Renamed --combined-with-paths to --combined-all-names
  * No longer implies -c, --raw, or -M
  * Works with either -c or --cc, with either --raw or -p, and with
    either -M or -C
  * Always shows the name in each parent even if it doesn't differ
  * additional testcase checking patch format header with --cc

 Documentation/diff-format.txt         | 20 +++++--
 Documentation/diff-generate-patch.txt | 13 +++++
 Documentation/git-diff-tree.txt       | 11 +++-
 Documentation/rev-list-options.txt    |  7 +++
 builtin/diff-tree.c                   |  6 ++-
 combine-diff.c                        | 76 +++++++++++++++++++++++----
 diff.h                                |  1 +
 revision.c                            |  6 +++
 revision.h                            |  1 +
 t/t4038-diff-combined.sh              | 47 +++++++++++++++++
 10 files changed, 171 insertions(+), 17 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index cdcc17f0ad..8fe800cd9b 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -95,12 +95,26 @@ from the format described above in the following way:
 . there are more "src" modes and "src" sha1
 . status is concatenated status characters for each parent
 . no optional "score" number
-. single path, only for "dst"
+. tab-separated pathname(s) of the file
 
-Example:
+For `-c` and `--cc`, only the destination or final path is shown even
+if the file was renamed on any side of history.  With
+`--combined-all-names`, the name of the path in each parent is shown
+followed by the name of the path in the merge commit.
+
+Examples for `-c` and `-cc` without `--combined-all-names`:
+------------------------------------------------
+::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	desc.c
+::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	bar.sh
+::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	phooey.c
+------------------------------------------------
+
+Examples when `--combined-all-names` added to either `-c` or `--cc`:
 
 ------------------------------------------------
-::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
+::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	desc.c	desc.c	desc.c
+::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	foo.sh	bar.sh	bar.sh
+::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	fooey.c	fuey.c	phooey.c
 ------------------------------------------------
 
 Note that 'combined diff' lists only files which were modified from
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 231105cff4..69cb3b0349 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -144,6 +144,19 @@ Similar to two-line header for traditional 'unified' diff
 format, `/dev/null` is used to signal created or deleted
 files.
 
+However, if the --combined-all-paths option is provided, instead of a
+two-line from-file/to-file you get a N+1 line from-file/to-file header,
+where N is the number of parents in the merge commit
+
+       --- a/file
+       --- a/file
+       --- a/file
+       +++ b/file
++
+This extended format can be useful if rename or copy detection is
+active, to allow you to see the original name of the file in different
+parents.
+
 4.   Chunk header format is modified to prevent people from
      accidentally feeding it to `patch -p1`. Combined diff format
      was created for review of merge commit changes, and was not
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 2319b2b192..7b6dcbd7a8 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git diff-tree' [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
-	      [-t] [-r] [-c | --cc] [--root] [<common diff options>]
-	      <tree-ish> [<tree-ish>] [<path>...]
+	      [-t] [-r] [-c | --cc] [--combined-all-names] [--root]
+	      [<common diff options>] <tree-ish> [<tree-ish>] [<path>...]
 
 DESCRIPTION
 -----------
@@ -108,6 +108,13 @@ include::pretty-options.txt[]
 	itself and the commit log message is not shown, just like in any other
 	"empty diff" case.
 
+--combined-all-names::
+	This flag causes combined diffs (used for merge commits) to
+	list the name of the file from all parents.  It thus only has
+	effect when -c or --cc are specified, and is likely only
+	useful if filename changes are detected (i.e. when either
+	rename or copy detection have been requested).
+
 --always::
 	Show the commit itself and the commit log message even
 	if the diff itself is empty.
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 98b538bc77..97a6651bae 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -948,6 +948,13 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 	the parents have only two variants and the merge result picks
 	one of them without modification.
 
+--combined-all-names::
+	This flag causes combined diffs (used for merge commits) to
+	list the name of the file from all parents.  It thus only has
+	effect when -c or --cc are specified, and is likely only
+	useful if filename changes are detected (i.e. when either
+	rename or copy detection have been requested).
+
 -m::
 	This flag makes the merge commits show the full diff like
 	regular commits; for each merge parent, a separate log entry
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index ef996126d7..bbeebc833f 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -82,9 +82,13 @@ static int diff_tree_stdin(char *line)
 }
 
 static const char diff_tree_usage[] =
-"git diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
+"git diff-tree [--stdin] [-m] [-c | --cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
 "[<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "  -r            diff recursively\n"
+"  -c            show combined diff for merge commits\n"
+"  --cc          show combined diff for merge commits removing uninteresting hunks\n"
+"  --combined-all-names\n"
+"                show name of file in all parents for combined diffs\n"
 "  --root        include the initial commit as diff against /dev/null\n"
 COMMON_DIFF_OPTIONS_HELP;
 
diff --git a/combine-diff.c b/combine-diff.c
index a143c00634..339daac02b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -23,11 +23,20 @@ static int compare_paths(const struct combine_diff_path *one,
 				 two->path, strlen(two->path), two->mode);
 }
 
-static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
+static int filename_changed(char status)
+{
+	return status == 'R' || status == 'C';
+}
+
+static struct combine_diff_path *intersect_paths(
+	struct combine_diff_path *curr,
+	int n,
+	int num_parent,
+	int combined_all_names)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct combine_diff_path *p, **tail = &curr;
-	int i, cmp;
+	int i, j, cmp;
 
 	if (!n) {
 		for (i = 0; i < q->nr; i++) {
@@ -50,6 +59,13 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
 			p->parent[n].mode = q->queue[i]->one->mode;
 			p->parent[n].status = q->queue[i]->status;
+
+			if (combined_all_names &&
+			    filename_changed(p->parent[n].status)) {
+				strbuf_init(&p->parent[n].path, 0);
+				strbuf_addstr(&p->parent[n].path,
+					      q->queue[i]->one->path);
+			}
 			*tail = p;
 			tail = &p->next;
 		}
@@ -68,6 +84,10 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 		if (cmp < 0) {
 			/* p->path not in q->queue[]; drop it */
 			*tail = p->next;
+			for (j = 0; j < num_parent; j++)
+				if (combined_all_names &&
+				    filename_changed(p->parent[j].status))
+					strbuf_release(&p->parent[j].path);
 			free(p);
 			continue;
 		}
@@ -81,6 +101,10 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 		oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
 		p->parent[n].mode = q->queue[i]->one->mode;
 		p->parent[n].status = q->queue[i]->status;
+		if (combined_all_names &&
+		    filename_changed(p->parent[n].status))
+			strbuf_addstr(&p->parent[n].path,
+				      q->queue[i]->one->path);
 
 		tail = &p->next;
 		i++;
@@ -960,12 +984,25 @@ static void show_combined_header(struct combine_diff_path *elem,
 	if (!show_file_header)
 		return;
 
-	if (added)
-		dump_quoted_path("--- ", "", "/dev/null",
-				 line_prefix, c_meta, c_reset);
-	else
-		dump_quoted_path("--- ", a_prefix, elem->path,
-				 line_prefix, c_meta, c_reset);
+	if (rev->combined_all_names) {
+		for (i = 0; i < num_parent; i++) {
+			char *path = filename_changed(elem->parent[i].status)
+				? elem->parent[i].path.buf : elem->path;
+			if (elem->parent[i].status == DIFF_STATUS_ADDED)
+				dump_quoted_path("--- ", "", "/dev/null",
+						 line_prefix, c_meta, c_reset);
+			else
+				dump_quoted_path("--- ", a_prefix, path,
+						 line_prefix, c_meta, c_reset);
+		}
+	} else {
+		if (added)
+			dump_quoted_path("--- ", "", "/dev/null",
+					 line_prefix, c_meta, c_reset);
+		else
+			dump_quoted_path("--- ", a_prefix, elem->path,
+					 line_prefix, c_meta, c_reset);
+	}
 	if (deleted)
 		dump_quoted_path("+++ ", "", "/dev/null",
 				 line_prefix, c_meta, c_reset);
@@ -1227,6 +1264,15 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 		putchar(inter_name_termination);
 	}
 
+	for (i = 0; i < num_parent; i++)
+		if (rev->combined_all_names) {
+			if (filename_changed(p->parent[i].status))
+				write_name_quoted(p->parent[i].path.buf, stdout,
+						  inter_name_termination);
+			else
+				write_name_quoted(p->path, stdout,
+						  inter_name_termination);
+		}
 	write_name_quoted(p->path, stdout, line_termination);
 }
 
@@ -1324,7 +1370,9 @@ static const char *path_path(void *obj)
 
 /* find set of paths that every parent touches */
 static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
-	const struct oid_array *parents, struct diff_options *opt)
+	const struct oid_array *parents,
+	struct diff_options *opt,
+	int combined_all_names)
 {
 	struct combine_diff_path *paths = NULL;
 	int i, num_parent = parents->nr;
@@ -1350,7 +1398,8 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 			opt->output_format = DIFF_FORMAT_NO_OUTPUT;
 		diff_tree_oid(&parents->oid[i], oid, "", opt);
 		diffcore_std(opt);
-		paths = intersect_paths(paths, i, num_parent);
+		paths = intersect_paths(paths, i, num_parent,
+					combined_all_names);
 
 		/* if showing diff, show it in requested order */
 		if (opt->output_format != DIFF_FORMAT_NO_OUTPUT &&
@@ -1460,7 +1509,8 @@ void diff_tree_combined(const struct object_id *oid,
 		 * diff(sha1,parent_i) for all i to do the job, specifically
 		 * for parent0.
 		 */
-		paths = find_paths_generic(oid, parents, &diffopts);
+		paths = find_paths_generic(oid, parents, &diffopts,
+					   rev->combined_all_names);
 	}
 	else {
 		int stat_opt;
@@ -1535,6 +1585,10 @@ void diff_tree_combined(const struct object_id *oid,
 	while (paths) {
 		struct combine_diff_path *tmp = paths;
 		paths = paths->next;
+		for (i = 0; i < num_parent; i++)
+			if (rev->combined_all_names &&
+			    filename_changed(tmp->parent[i].status))
+				strbuf_release(&tmp->parent[i].path);
 		free(tmp);
 	}
 
diff --git a/diff.h b/diff.h
index b512d0477a..90ea0256a5 100644
--- a/diff.h
+++ b/diff.h
@@ -294,6 +294,7 @@ struct combine_diff_path {
 		char status;
 		unsigned int mode;
 		struct object_id oid;
+		struct strbuf path;
 	} parent[FLEX_ARRAY];
 };
 #define combine_diff_path_size(n, l) \
diff --git a/revision.c b/revision.c
index 13cfb59b38..a608884aad 100644
--- a/revision.c
+++ b/revision.c
@@ -1995,6 +1995,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->dense_combined_merges = 0;
 		revs->combine_merges = 1;
+	} else if (!strcmp(arg, "--combined-all-names")) {
+		revs->diff = 1;
+		revs->combined_all_names = 1;
 	} else if (!strcmp(arg, "--cc")) {
 		revs->diff = 1;
 		revs->dense_combined_merges = 1;
@@ -2491,6 +2494,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	}
 	if (revs->combine_merges)
 		revs->ignore_merges = 0;
+	if (revs->combined_all_names && !revs->combine_merges)
+		die("--combined-all-names makes no sense without -c or --cc");
+
 	revs->diffopt.abbrev = revs->abbrev;
 
 	if (revs->line_level_traverse) {
diff --git a/revision.h b/revision.h
index 52e5a88ff5..074a584410 100644
--- a/revision.h
+++ b/revision.h
@@ -171,6 +171,7 @@ struct rev_info {
 			verbose_header:1,
 			ignore_merges:1,
 			combine_merges:1,
+			combined_all_names:1,
 			dense_combined_merges:1,
 			always_show_header:1;
 
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index e2824d3437..5bccc323f6 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -435,4 +435,51 @@ test_expect_success 'combine diff gets tree sorting right' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for --combined-with-paths' '
+	git branch side1c &&
+	git branch side2c &&
+	git checkout side1c &&
+	test_seq 1 10 >$(printf "file\twith\ttabs") &&
+	git add file* &&
+	git commit -m with &&
+	git checkout side2c &&
+	test_seq 1 9 >$(printf "i\tam\ttabbed") &&
+	echo ten >>$(printf "i\tam\ttabbed") &&
+	git add *tabbed &&
+	git commit -m iam &&
+	git checkout -b mergery side1c &&
+	git merge --no-commit side2c &&
+	git rm *tabs &&
+	echo eleven >>$(printf "i\tam\ttabbed") &&
+	git mv "$(printf "i\tam\ttabbed")" "$(printf "fickle\tnaming")" &&
+	git add fickle* &&
+	git commit
+'
+
+test_expect_success '--combined-all-names and --raw' '
+	cat <<-\EOF >expect &&
+	::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR	"file\twith\ttabs"	"i\tam\ttabbed"	"fickle\tnaming"
+	EOF
+	git diff-tree -c -M --raw --combined-all-names HEAD >actual.tmp &&
+	sed 1d <actual.tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--combined-all-names and --raw -and -z' '
+	printf "0f9645804ebb04cc3eef91f799eb7fb54d70cefb\0::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
+	git diff-tree -c -M --raw --combined-all-names -z HEAD >actual &&
+	test_cmp -a expect actual
+'
+
+test_expect_success '--combined-all-names and --cc' '
+	cat <<-\EOF >expect &&
+	--- "a/file\twith\ttabs"
+	--- "a/i\tam\ttabbed"
+	+++ "b/fickle\tnaming"
+	EOF
+	git diff-tree --cc -M --combined-all-names HEAD >actual.tmp &&
+	grep ^[-+][-+][-+] <actual.tmp >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.20.1.310.gf2549f3af6

