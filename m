Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D34A61F403
	for <e@80x24.org>; Sun,  3 Jun 2018 06:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbeFCG6a (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 02:58:30 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48618 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751013AbeFCG6Q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jun 2018 02:58:16 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w536s3X3018498;
        Sat, 2 Jun 2018 23:58:13 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbs3g93kh-1;
        Sat, 02 Jun 2018 23:58:13 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8A4C9228A267;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 79A502CDE66;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 4/7] merge-recursive: fix assumption that head tree being merged is HEAD
Date:   Sat,  2 Jun 2018 23:58:07 -0700
Message-Id: <20180603065810.23841-5-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.49.g3c08dc0fef
In-Reply-To: <20180603065810.23841-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806030083
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git merge-recursive` does a three-way merge between user-specified trees
base, head, and remote.  Since the user is allowed to specify head, we can
not necesarily assume that head == HEAD.

We modify index_has_changes() to take an extra argument specifying the
tree to compare the index to.  If NULL, it will compare to HEAD.  We then
use this from merge-recursive to make sure we compare to the
user-specified head.

Signed-off-by: Elijah Newren <newren@gmail.com>
---

I'm really unsure where the index_has_changes() declaration should go;
I stuck it in tree.h, but is there a better spot?

 builtin/am.c                             |  6 +++---
 cache.h                                  |  8 --------
 merge-recursive.c                        |  2 +-
 merge.c                                  | 10 ++++++----
 t/t6044-merge-unrelated-index-changes.sh |  2 +-
 tree.h                                   |  8 ++++++++
 6 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 2fc2d1e82c..c5b76cd095 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1763,7 +1763,7 @@ static void am_run(struct am_state *state, int resume)
 
 	refresh_and_write_cache();
 
-	if (index_has_changes(&sb)) {
+	if (index_has_changes(&sb, NULL)) {
 		write_state_bool(state, "dirtyindex", 1);
 		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
 	}
@@ -1820,7 +1820,7 @@ static void am_run(struct am_state *state, int resume)
 			 * Applying the patch to an earlier tree and merging
 			 * the result may have produced the same tree as ours.
 			 */
-			if (!apply_status && !index_has_changes(NULL)) {
+			if (!apply_status && !index_has_changes(NULL, NULL)) {
 				say(state, stdout, _("No changes -- Patch already applied."));
 				goto next;
 			}
@@ -1878,7 +1878,7 @@ static void am_resolve(struct am_state *state)
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
-	if (!index_has_changes(NULL)) {
+	if (!index_has_changes(NULL, NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
 			"If there is nothing left to stage, chances are that something else\n"
 			"already introduced the same changes; you might want to skip this patch."));
diff --git a/cache.h b/cache.h
index 89a107a7f7..439b9d9f6e 100644
--- a/cache.h
+++ b/cache.h
@@ -634,14 +634,6 @@ extern int discard_index(struct index_state *);
 extern void move_index_extensions(struct index_state *dst, struct index_state *src);
 extern int unmerged_index(const struct index_state *);
 
-/**
- * Returns 1 if the index differs from HEAD, 0 otherwise. When on an unborn
- * branch, returns 1 if there are entries in the index, 0 otherwise. If an
- * strbuf is provided, the space-separated list of files that differ will be
- * appended to it.
- */
-extern int index_has_changes(struct strbuf *sb);
-
 extern int verify_path(const char *path, unsigned mode);
 extern int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
 extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
diff --git a/merge-recursive.c b/merge-recursive.c
index b3deb7b182..762aa087d0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3263,7 +3263,7 @@ int merge_trees(struct merge_options *o,
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
 		struct strbuf sb = STRBUF_INIT;
 
-		if (!o->call_depth && index_has_changes(&sb)) {
+		if (!o->call_depth && index_has_changes(&sb, head)) {
 			err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 			    sb.buf);
 			return -1;
diff --git a/merge.c b/merge.c
index 0783858739..965d287646 100644
--- a/merge.c
+++ b/merge.c
@@ -14,19 +14,21 @@ static const char *merge_argument(struct commit *commit)
 	return oid_to_hex(commit ? &commit->object.oid : the_hash_algo->empty_tree);
 }
 
-int index_has_changes(struct strbuf *sb)
+int index_has_changes(struct strbuf *sb, struct tree *tree)
 {
-	struct object_id head;
+	struct object_id cmp;
 	int i;
 
-	if (!get_oid_tree("HEAD", &head)) {
+	if (tree)
+		cmp = tree->object.oid;
+	if (tree || !get_oid_tree("HEAD", &cmp)) {
 		struct diff_options opt;
 
 		diff_setup(&opt);
 		opt.flags.exit_with_status = 1;
 		if (!sb)
 			opt.flags.quick = 1;
-		do_diff_cache(&head, &opt);
+		do_diff_cache(&cmp, &opt);
 		diffcore_std(&opt);
 		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
 			if (i)
diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index 3876cfa4fa..1d43712c52 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -126,7 +126,7 @@ test_expect_success 'recursive, when merge branch matches merge base' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
-test_expect_failure 'merge-recursive, when index==head but head!=HEAD' '
+test_expect_success 'merge-recursive, when index==head but head!=HEAD' '
 	git reset --hard &&
 	git checkout C^0 &&
 
diff --git a/tree.h b/tree.h
index e2a80be4ef..2e1d8ea720 100644
--- a/tree.h
+++ b/tree.h
@@ -37,4 +37,12 @@ extern int read_tree_recursive(struct tree *tree,
 extern int read_tree(struct tree *tree, int stage, struct pathspec *pathspec,
 		     struct index_state *istate);
 
+/**
+ * Returns 1 if the index differs from tree, 0 otherwise.  If tree is NULL,
+ * compares to HEAD.  If tree is NULL and on an unborn branch, returns 1 if
+ * there are entries in the index, 0 otherwise. If an strbuf is provided,
+ * the space-separated list of files that differ will be appended to it.
+ */
+extern int index_has_changes(struct strbuf *sb, struct tree *tree);
+
 #endif /* TREE_H */
-- 
2.18.0.rc0.49.g3c08dc0fef

