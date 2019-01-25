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
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B3F1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 17:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfAYRMW (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 12:12:22 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59758 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726311AbfAYRMW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Jan 2019 12:12:22 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0PH8ggA022619;
        Fri, 25 Jan 2019 09:12:05 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2q69wxvs16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 25 Jan 2019 09:12:04 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 25 Jan 2019 09:11:50 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 25 Jan 2019 09:11:50 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 4B80C220FFEA;
        Fri, 25 Jan 2019 09:12:02 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] log,diff-tree: add --combined-with-paths options for merges with renames
Date:   Fri, 25 Jan 2019 08:54:16 -0800
Message-ID: <20190125165416.17473-1-newren@gmail.com>
X-Mailer: git-send-email 2.20.1.310.g29e9ddf532
In-Reply-To: <20190124164654.1923-1-newren@gmail.com>
References: <20190124164654.1923-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901250137
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The raw diff format for merges with -c or --cc will only list one
filename, even if rename detection is active and a rename was detected
for the given path.  Examples:

  ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
  ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	bar.sh
  ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	phooey.c

This doesn't let us know what the original name of bar.sh was in the
first parent, and doesn't let us know what either of the original
names of phooey.c were in either of the parents.  In contrast, for
non-merge commits, raw format does provide original filenames (and a
rename score to boot).  In order to also provide original filenames
for merge commits, add a --combined-with-paths option (which is only
useful in conjunction with -c, --raw, and -M and thus implies all
those options) so that we can print tab-separated filenames when
renames are involved.  This transforms the above output to:

  ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
  ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	foo.sh	bar.sh
  ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	fooey.c	fuey.c	phooey.c

Signed-off-by: Elijah Newren <newren@gmail.com>
---

Differences since v1: added a testcase, with and without -z

 Documentation/diff-format.txt      | 23 +++++++++++++---
 Documentation/git-diff-tree.txt    |  9 +++++--
 Documentation/rev-list-options.txt |  5 ++++
 combine-diff.c                     | 42 ++++++++++++++++++++++++++----
 diff.h                             |  1 +
 revision.c                         |  7 +++++
 revision.h                         |  1 +
 t/t4038-diff-combined.sh           | 36 +++++++++++++++++++++++++
 8 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index cdcc17f0ad..6e6cfc5d56 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -87,7 +87,7 @@ diff format for merges
 ----------------------
 
 "git-diff-tree", "git-diff-files" and "git-diff --raw"
-can take `-c` or `--cc` option
+can take `-c`, `--cc`, or `--combined-with-paths` option
 to generate diff output also for merge commits.  The output differs
 from the format described above in the following way:
 
@@ -95,12 +95,29 @@ from the format described above in the following way:
 . there are more "src" modes and "src" sha1
 . status is concatenated status characters for each parent
 . no optional "score" number
-. single path, only for "dst"
+. tab-separated pathname(s) of the file
 
-Example:
+For `-c` and `--cc`, only the destination or final path is shown even
+if the file was renamed on any side of history.  With
+`--combined-with-paths`, the number of paths printed will be one more
+than the number of 'R' characters in the concatenated status.  For
+each 'R' in the concatenated status characters, the original pathname
+on that side of history will be shown, and the final path shown on the
+line will be the path used in the merge.
+
+Examples for `-c` and `-cc`:
+------------------------------------------------
+::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
+::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	bar.sh
+::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	phooey.c
+------------------------------------------------
+
+Examples for `--combined-with-paths`:
 
 ------------------------------------------------
 ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
+::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	foo.sh	bar.sh
+::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	fooey.c	fuey.c	phooey.c
 ------------------------------------------------
 
 Note that 'combined diff' lists only files which were modified from
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 2319b2b192..2d9ba382bc 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git diff-tree' [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
-	      [-t] [-r] [-c | --cc] [--root] [<common diff options>]
-	      <tree-ish> [<tree-ish>] [<path>...]
+	      [-t] [-r] [-c | --cc | --combined-with-paths] [--root]
+	      [<common diff options>] <tree-ish> [<tree-ish>] [<path>...]
 
 DESCRIPTION
 -----------
@@ -108,6 +108,11 @@ include::pretty-options.txt[]
 	itself and the commit log message is not shown, just like in any other
 	"empty diff" case.
 
+--combined-with-paths::
+	This flag is similar to -c, but modifies the raw output format for
+	merges to also show the original paths when renames are found.
+	Implies	-c, -M, and --raw.
+
 --always::
 	Show the commit itself and the commit log message even
 	if the diff itself is empty.
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 98b538bc77..4fdcaef52d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -948,6 +948,11 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 	the parents have only two variants and the merge result picks
 	one of them without modification.
 
+--combined-with-paths::
+	This flag is similar to -c, but modifies the raw output format for
+	merges to also show the original paths when renames are found.
+	Implies	-c, -M, and --raw.
+
 -m::
 	This flag makes the merge commits show the full diff like
 	regular commits; for each merge parent, a separate log entry
diff --git a/combine-diff.c b/combine-diff.c
index a143c00634..77f7de14c9 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -23,11 +23,15 @@ static int compare_paths(const struct combine_diff_path *one,
 				 two->path, strlen(two->path), two->mode);
 }
 
-static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
+static struct combine_diff_path *intersect_paths(
+	struct combine_diff_path *curr,
+	int n,
+	int num_parent,
+	int combined_with_paths)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct combine_diff_path *p, **tail = &curr;
-	int i, cmp;
+	int i, j, cmp;
 
 	if (!n) {
 		for (i = 0; i < q->nr; i++) {
@@ -50,6 +54,13 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
 			p->parent[n].mode = q->queue[i]->one->mode;
 			p->parent[n].status = q->queue[i]->status;
+
+			if (combined_with_paths &&
+			    p->parent[n].status == 'R') {
+				strbuf_init(&p->parent[n].path, 0);
+				strbuf_addstr(&p->parent[n].path,
+					      q->queue[i]->one->path);
+			}
 			*tail = p;
 			tail = &p->next;
 		}
@@ -68,6 +79,10 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 		if (cmp < 0) {
 			/* p->path not in q->queue[]; drop it */
 			*tail = p->next;
+			for (j = 0; j < num_parent; j++)
+				if (combined_with_paths &&
+				    p->parent[j].status == 'R')
+					strbuf_release(&p->parent[j].path);
 			free(p);
 			continue;
 		}
@@ -81,6 +96,10 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 		oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
 		p->parent[n].mode = q->queue[i]->one->mode;
 		p->parent[n].status = q->queue[i]->status;
+		if (combined_with_paths &&
+		    p->parent[n].status == 'R')
+			strbuf_addstr(&p->parent[n].path,
+				      q->queue[i]->one->path);
 
 		tail = &p->next;
 		i++;
@@ -1227,6 +1246,11 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 		putchar(inter_name_termination);
 	}
 
+	for (i = 0; i < num_parent; i++)
+		if (rev->combined_with_paths &&
+		    p->parent[i].status == 'R')
+			write_name_quoted(p->parent[i].path.buf, stdout,
+					  inter_name_termination);
 	write_name_quoted(p->path, stdout, line_termination);
 }
 
@@ -1324,7 +1348,9 @@ static const char *path_path(void *obj)
 
 /* find set of paths that every parent touches */
 static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
-	const struct oid_array *parents, struct diff_options *opt)
+	const struct oid_array *parents,
+	struct diff_options *opt,
+	int combined_with_paths)
 {
 	struct combine_diff_path *paths = NULL;
 	int i, num_parent = parents->nr;
@@ -1350,7 +1376,8 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 			opt->output_format = DIFF_FORMAT_NO_OUTPUT;
 		diff_tree_oid(&parents->oid[i], oid, "", opt);
 		diffcore_std(opt);
-		paths = intersect_paths(paths, i, num_parent);
+		paths = intersect_paths(paths, i, num_parent,
+					combined_with_paths);
 
 		/* if showing diff, show it in requested order */
 		if (opt->output_format != DIFF_FORMAT_NO_OUTPUT &&
@@ -1460,7 +1487,8 @@ void diff_tree_combined(const struct object_id *oid,
 		 * diff(sha1,parent_i) for all i to do the job, specifically
 		 * for parent0.
 		 */
-		paths = find_paths_generic(oid, parents, &diffopts);
+		paths = find_paths_generic(oid, parents, &diffopts,
+					   rev->combined_with_paths);
 	}
 	else {
 		int stat_opt;
@@ -1535,6 +1563,10 @@ void diff_tree_combined(const struct object_id *oid,
 	while (paths) {
 		struct combine_diff_path *tmp = paths;
 		paths = paths->next;
+		for (i = 0; i < num_parent; i++)
+			if (rev->combined_with_paths &&
+			    tmp->parent[i].status == 'R')
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
index 13cfb59b38..21c818ba11 100644
--- a/revision.c
+++ b/revision.c
@@ -1995,6 +1995,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->dense_combined_merges = 0;
 		revs->combine_merges = 1;
+	} else if (!strcmp(arg, "--combined-with-paths")) {
+		revs->diff = 1;
+		revs->dense_combined_merges = 0;
+		revs->combine_merges = 1;
+		revs->combined_with_paths = 1;
+		revs->diffopt.detect_rename = DIFF_DETECT_RENAME;
+		revs->diffopt.output_format |= DIFF_FORMAT_RAW;
 	} else if (!strcmp(arg, "--cc")) {
 		revs->diff = 1;
 		revs->dense_combined_merges = 1;
diff --git a/revision.h b/revision.h
index 52e5a88ff5..59a15b0ed0 100644
--- a/revision.h
+++ b/revision.h
@@ -171,6 +171,7 @@ struct rev_info {
 			verbose_header:1,
 			ignore_merges:1,
 			combine_merges:1,
+			combined_with_paths:1,
 			dense_combined_merges:1,
 			always_show_header:1;
 
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index e2824d3437..9420c1318a 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -435,4 +435,40 @@ test_expect_success 'combine diff gets tree sorting right' '
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
+test_expect_success '--combined-with-paths shows all paths involved' '
+	cat <<-\EOF >expect &&
+	::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR	"file\twith\ttabs"	"i\tam\ttabbed"	"fickle\tnaming"
+	EOF
+	git diff-tree --combined-with-paths HEAD >actual.tmp &&
+	sed 1d <actual.tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--combined-with-paths works with -z as well' '
+	printf "0f9645804ebb04cc3eef91f799eb7fb54d70cefb\0::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
+	git diff-tree --combined-with-paths -z HEAD >actual &&
+	test_cmp -a expect actual
+'
+
 test_done
-- 
2.20.1.310.g29e9ddf532

