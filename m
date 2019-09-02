Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257BF1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 22:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfIBWj4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 18:39:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58514 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727625AbfIBWjy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Sep 2019 18:39:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6959:e43b:5cf6:a465])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 44DA8610BC;
        Mon,  2 Sep 2019 22:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567463993;
        bh=EhhSXzRcNfjwy4mmA5sKo1vU/mv6XZJhXaOfaHoRzm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=v0lhzCFxaJiuKtziOMNKJRpuKhjGZTsgZm3xiBj/ArKY1mUWEzN4Yb3QW6Ya8TXAf
         OpkEBNq6M+pi0KmuGQikPbwPl9uAJ+ltXy3kh/JXpVy83itP0azD61G1aN+qGCoqUT
         trhwNC0B7rM3+zFAnh2AAI4KT0KG9tSC9OBAL7U7KlTo0XicDbuu5S6synYL0mvlC2
         wf/sKYDHFbMCnEOrbNR3ZcUiLy1+5AC+RF07Du52CZeJ6CmUPMHYgw/2iJmH/DETVE
         5OpLUY3z6VLDTfnpNGE28fzVbKnQjrGoTmTbRJvPK3sF4sblFUcUb0U8e23QjJoOOF
         Mb/YxKtZZdg2/3yK1xt5wZ50r9XuIkHlLVRIDg2aRiNMOgePhoCeyqI7VMMeLxVotO
         oyLBRb1AVsTlGGUn+1MFKTZikYxjUQ8eMP7RU7gn1teaLzLGTasRxAjjqHAB2ceXai
         XLyWcMObcj4QSWlcRQnK4mQH6aAPslx421THDjBU9NDNM8q3xcp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 2/2] am: reload .gitattributes after patching it
Date:   Mon,  2 Sep 2019 22:39:44 +0000
Message-Id: <20190902223944.897504-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734
In-Reply-To: <20190902223944.897504-1-sandals@crustytoothpaste.net>
References: <20190825233340.10894-1-sandals@crustytoothpaste.net>
 <20190902223944.897504-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When applying multiple patches with git am, or when rebasing using the
am backend, it's possible that one of our patches has updated a
gitattributes file. Currently, we cache this information, so if a
file in a subsequent patch has attributes applied, the file will be
written out with the attributes in place as of the time we started the
rebase or am operation, not with the attributes applied by the previous
patch. This problem does not occur when using the -m or -i flags to
rebase.

To ensure we write the correct data into the working tree, expire the
cache after each patch that touches a path ending in ".gitattributes".
Since we load these attributes in multiple separate files, we must
expire them accordingly.

Verify that both the am and rebase code paths work correctly, including
the conflict marker size with am -3.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 apply.c           | 11 ++++++++++
 convert.c         | 21 ++++++++++++++++++-
 convert.h         |  6 ++++++
 ll-merge.c        | 19 +++++++++++++----
 ll-merge.h        |  1 +
 t/t3400-rebase.sh | 36 ++++++++++++++++++++++++++++++++
 t/t4150-am.sh     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 141 insertions(+), 5 deletions(-)

diff --git a/apply.c b/apply.c
index cde95369bb..57a61f2881 100644
--- a/apply.c
+++ b/apply.c
@@ -4643,6 +4643,7 @@ static int apply_patch(struct apply_state *state,
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 	int res = 0;
+	int flush_attributes = 0;
 
 	state->patch_input_file = filename;
 	if (read_patch_file(&buf, fd) < 0)
@@ -4670,6 +4671,14 @@ static int apply_patch(struct apply_state *state,
 			patch_stats(state, patch);
 			*listp = patch;
 			listp = &patch->next;
+
+			if ((patch->new_name &&
+			     ends_with_path_components(patch->new_name,
+						       GITATTRIBUTES_FILE)) ||
+			    (patch->old_name &&
+			     ends_with_path_components(patch->old_name,
+						       GITATTRIBUTES_FILE)))
+				flush_attributes = 1;
 		}
 		else {
 			if (state->apply_verbosity > verbosity_normal)
@@ -4746,6 +4755,8 @@ static int apply_patch(struct apply_state *state,
 	if (state->summary && state->apply_verbosity > verbosity_silent)
 		summary_patch_list(list);
 
+	if (flush_attributes)
+		reset_parsed_attributes();
 end:
 	free_patch_list(list);
 	strbuf_release(&buf);
diff --git a/convert.c b/convert.c
index 94ff837649..deb6f71b2d 100644
--- a/convert.c
+++ b/convert.c
@@ -8,6 +8,7 @@
 #include "pkt-line.h"
 #include "sub-process.h"
 #include "utf8.h"
+#include "ll-merge.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -1293,10 +1294,11 @@ struct conv_attrs {
 	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
 };
 
+static struct attr_check *check;
+
 static void convert_attrs(const struct index_state *istate,
 			  struct conv_attrs *ca, const char *path)
 {
-	static struct attr_check *check;
 	struct attr_check_item *ccheck = NULL;
 
 	if (!check) {
@@ -1339,6 +1341,23 @@ static void convert_attrs(const struct index_state *istate,
 		ca->crlf_action = CRLF_AUTO_INPUT;
 }
 
+void reset_parsed_attributes(void)
+{
+	struct convert_driver *drv, *next;
+
+	attr_check_free(check);
+	check = NULL;
+	reset_merge_attributes();
+
+	for (drv = user_convert; drv; drv = next) {
+		next = drv->next;
+		free((void *)drv->name);
+		free(drv);
+	}
+	user_convert = NULL;
+	user_convert_tail = NULL;
+}
+
 int would_convert_to_git_filter_fd(const struct index_state *istate, const char *path)
 {
 	struct conv_attrs ca;
diff --git a/convert.h b/convert.h
index 831559f10d..3710969d43 100644
--- a/convert.h
+++ b/convert.h
@@ -94,6 +94,12 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 int would_convert_to_git_filter_fd(const struct index_state *istate,
 				   const char *path);
 
+/*
+ * Reset the internal list of attributes used by convert_to_git and
+ * convert_to_working_tree.
+ */
+void reset_parsed_attributes(void);
+
 /*****************************************************************
  *
  * Streaming conversion support
diff --git a/ll-merge.c b/ll-merge.c
index 5b8d46aede..d65a8971db 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -32,6 +32,20 @@ struct ll_merge_driver {
 	char *cmdline;
 };
 
+static struct attr_check *merge_attributes;
+static struct attr_check *load_merge_attributes(void)
+{
+	if (!merge_attributes)
+		merge_attributes = attr_check_initl("merge", "conflict-marker-size", NULL);
+	return merge_attributes;
+}
+
+void reset_merge_attributes(void)
+{
+	attr_check_free(merge_attributes);
+	merge_attributes = NULL;
+}
+
 /*
  * Built-in low-levels
  */
@@ -354,7 +368,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	     struct index_state *istate,
 	     const struct ll_merge_options *opts)
 {
-	static struct attr_check *check;
+	struct attr_check *check = load_merge_attributes();
 	static const struct ll_merge_options default_opts;
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
@@ -369,9 +383,6 @@ int ll_merge(mmbuffer_t *result_buf,
 		normalize_file(theirs, path, istate);
 	}
 
-	if (!check)
-		check = attr_check_initl("merge", "conflict-marker-size", NULL);
-
 	git_check_attr(istate, path, check);
 	ll_driver_name = check->items[0].value;
 	if (check->items[1].value) {
diff --git a/ll-merge.h b/ll-merge.h
index b9e2af1c88..e78973dd55 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -26,5 +26,6 @@ int ll_merge(mmbuffer_t *result_buf,
 	     const struct ll_merge_options *opts);
 
 int ll_merge_marker_size(struct index_state *istate, const char *path);
+void reset_merge_attributes(void);
 
 #endif
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 80b23fd326..23469cc789 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -301,6 +301,42 @@ test_expect_success 'rebase --am and --show-current-patch' '
 	)
 '
 
+test_expect_success 'rebase --am and .gitattributes' '
+	test_create_repo attributes &&
+	(
+		cd attributes &&
+		test_commit init &&
+		git config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
+		git config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&
+
+		test_commit second &&
+		git checkout -b test HEAD^ &&
+
+		echo "*.txt filter=test" >.gitattributes &&
+		git add .gitattributes &&
+		test_commit third &&
+
+		echo "This text is smudged." >a.txt &&
+		git add a.txt &&
+		test_commit fourth &&
+
+		git checkout -b removal HEAD^ &&
+		git rm .gitattributes &&
+		git add -u &&
+		test_commit fifth &&
+		git cherry-pick test &&
+
+		git checkout test &&
+		git rebase master &&
+		grep "smudged" a.txt &&
+
+		git checkout removal &&
+		git reset --hard &&
+		git rebase master &&
+		grep "clean" a.txt
+	)
+'
+
 test_expect_success 'rebase--merge.sh and --show-current-patch' '
 	test_create_repo conflict-merge &&
 	(
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 3f7f750cc8..4f1e24ecbe 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1061,4 +1061,56 @@ test_expect_success 'am --quit keeps HEAD where it is' '
 	test_cmp expected actual
 '
 
+test_expect_success 'am and .gitattibutes' '
+	test_create_repo attributes &&
+	(
+		cd attributes &&
+		test_commit init &&
+		git config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
+		git config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&
+
+		test_commit second &&
+		git checkout -b test HEAD^ &&
+
+		echo "*.txt filter=test conflict-marker-size=10" >.gitattributes &&
+		git add .gitattributes &&
+		test_commit third &&
+
+		echo "This text is smudged." >a.txt &&
+		git add a.txt &&
+		test_commit fourth &&
+
+		git checkout -b removal HEAD^ &&
+		git rm .gitattributes &&
+		git add -u &&
+		test_commit fifth &&
+		git cherry-pick test &&
+
+		git checkout -b conflict third &&
+		echo "This text is different." >a.txt &&
+		git add a.txt &&
+		test_commit sixth &&
+
+		git checkout test &&
+		git format-patch --stdout master..HEAD >patches &&
+		git reset --hard master &&
+		git am patches &&
+		grep "smudged" a.txt &&
+
+		git checkout removal &&
+		git reset --hard &&
+		git format-patch --stdout master..HEAD >patches &&
+		git reset --hard master &&
+		git am patches &&
+		grep "clean" a.txt &&
+
+		git checkout conflict &&
+		git reset --hard &&
+		git format-patch --stdout master..HEAD >patches &&
+		git reset --hard fourth &&
+		test_must_fail git am -3 patches &&
+		grep "<<<<<<<<<<" a.txt
+	)
+'
+
 test_done
