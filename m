Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF571F462
	for <e@80x24.org>; Fri, 26 Apr 2019 23:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfDZXv7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 19:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfDZXv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 19:51:59 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED83020869;
        Fri, 26 Apr 2019 23:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556322718;
        bh=Bl4DNgzKh/sFoPdUbJfmOG+kYnREpwFdQRucZAI+e+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JwJcZxGsTVXR4QI/F3XPzBHm15ra/aJNMj+oE9M7wajeg6qjMaB1RxNjble0KRAqn
         He+lwqNOJvzDsZZqhwy3pT/vvR//OskQ2YjMrsVBFvtGB7iQZN5qxH917cRZwGEJIU
         xqDP/zmm3JIU22LdKjzxOqBaX14ItLRF8nyPvsmY=
From:   Stephen Boyd <sboyd@kernel.org>
To:     git@vger.kernel.org
Cc:     Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH 2/2] format-patch: Make --base patch-id output stable
Date:   Fri, 26 Apr 2019 16:51:57 -0700
Message-Id: <20190426235157.106350-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190426235157.106350-1-sboyd@kernel.org>
References: <20190426235157.106350-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We weren't flushing the context each time we processed a hunk in the
patch-id generation code in diff.c, but we were doing that when we
generated "stable" patch-ids with the 'patch-id' tool. Let's port that
similar logic over from patch-id.c into diff.c so we can get the same
hash when we're generating patch-ids for 'format-patch --base=' types of
command invocations.

Cc: Xiaolong Ye <xiaolong.ye@intel.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

I wonder if we need to make some other sort of form of
"prerequisite-patch-id:" here and let that be a legacy form of the
patch-id so that users know that they have a fixed version of this code?
Maybe "prerequisite-stable-patch-id:"? Or we don't have to care because
it's been broken for anything besides the most trivial type of patches
and presumably users aren't able to use it with 'patch-id --stable'?

 Documentation/git-format-patch.txt |  2 +-
 builtin/log.c                      |  2 +-
 builtin/patch-id.c                 | 17 +---------------
 diff.c                             | 32 +++++++++++++++++++++++++-----
 diff.h                             |  3 ++-
 patch-ids.c                        | 10 +++++-----
 patch-ids.h                        |  2 +-
 t/t4014-format-patch.sh            |  8 ++++----
 8 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index e8cc792e7f5d..1af85d404f51 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -583,7 +583,7 @@ of 'base commit' in topological order before the patches can be applied.
 The 'base commit' is shown as "base-commit: " followed by the 40-hex of
 the commit object name.  A 'prerequisite patch' is shown as
 "prerequisite-patch-id: " followed by the 40-hex 'patch id', which can
-be obtained by passing the patch through the `git patch-id --unstable`
+be obtained by passing the patch through the `git patch-id --stable`
 command.
 
 Imagine that on top of the public commit P, you applied well-known
diff --git a/builtin/log.c b/builtin/log.c
index e43ee12fb1dd..147850dc7317 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1435,7 +1435,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		struct object_id *patch_id;
 		if (*commit_base_at(&commit_base, commit))
 			continue;
-		if (commit_patch_id(commit, &diffopt, &oid, 0))
+		if (commit_patch_id(commit, &diffopt, &oid, 0, 1))
 			die(_("cannot get patch id"));
 		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
 		patch_id = bases->patch_id + bases->nr_patch_id;
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 970d0d30b4f4..bd28b80b2d0f 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "diff.h"
 
 static void flush_current_id(int patchlen, struct object_id *id, struct object_id *result)
 {
@@ -54,22 +55,6 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	return 1;
 }
 
-static void flush_one_hunk(struct object_id *result, git_SHA_CTX *ctx)
-{
-	unsigned char hash[GIT_MAX_RAWSZ];
-	unsigned short carry = 0;
-	int i;
-
-	git_SHA1_Final(hash, ctx);
-	git_SHA1_Init(ctx);
-	/* 20-byte sum, with carry */
-	for (i = 0; i < GIT_SHA1_RAWSZ; ++i) {
-		carry += result->hash[i] + hash[i];
-		result->hash[i] = carry;
-		carry >>= 8;
-	}
-}
-
 static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 			   struct strbuf *line_buf, int stable)
 {
diff --git a/diff.c b/diff.c
index 4d3cf83a27e5..8e3675b416a2 100644
--- a/diff.c
+++ b/diff.c
@@ -5988,6 +5988,22 @@ static int remove_space(char *line, int len)
 	return dst - line;
 }
 
+void flush_one_hunk(struct object_id *result, git_SHA_CTX *ctx)
+{
+	unsigned char hash[GIT_MAX_RAWSZ];
+	unsigned short carry = 0;
+	int i;
+
+	git_SHA1_Final(hash, ctx);
+	git_SHA1_Init(ctx);
+	/* 20-byte sum, with carry */
+	for (i = 0; i < GIT_SHA1_RAWSZ; ++i) {
+		carry += result->hash[i] + hash[i];
+		result->hash[i] = carry;
+		carry >>= 8;
+	}
+}
+
 static void patch_id_consume(void *priv, char *line, unsigned long len)
 {
 	struct patch_id_t *data = priv;
@@ -6012,8 +6028,8 @@ static void patch_id_add_mode(git_SHA_CTX *ctx, unsigned mode)
 	git_SHA1_Update(ctx, buf, len);
 }
 
-/* returns 0 upon success, and writes result into sha1 */
-static int diff_get_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
+/* returns 0 upon success, and writes result into oid */
+static int diff_get_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only, int stable)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -6023,6 +6039,7 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 	git_SHA1_Init(&ctx);
 	memset(&data, 0, sizeof(struct patch_id_t));
 	data.ctx = &ctx;
+	oidclr(oid);
 
 	for (i = 0; i < q->nr; i++) {
 		xpparam_t xpp;
@@ -6098,17 +6115,22 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 				  patch_id_consume, &data, &xpp, &xecfg))
 			return error("unable to generate patch-id diff for %s",
 				     p->one->path);
+
+		if (stable)
+			flush_one_hunk(oid, &ctx);
 	}
 
-	git_SHA1_Final(oid->hash, &ctx);
+	if (!stable)
+		git_SHA1_Final(oid->hash, &ctx);
+
 	return 0;
 }
 
-int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
+int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only, int stable)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	int result = diff_get_patch_id(options, oid, diff_header_only);
+	int result = diff_get_patch_id(options, oid, diff_header_only, stable);
 
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
diff --git a/diff.h b/diff.h
index b20cbcc09142..de24a048649e 100644
--- a/diff.h
+++ b/diff.h
@@ -436,7 +436,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option);
 int run_diff_index(struct rev_info *revs, int cached);
 
 int do_diff_cache(const struct object_id *, struct diff_options *);
-int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
+int diff_flush_patch_id(struct diff_options *, struct object_id *, int, int);
+void flush_one_hunk(struct object_id *, git_SHA_CTX *);
 
 int diff_result_code(struct diff_options *, int);
 
diff --git a/patch-ids.c b/patch-ids.c
index c262e1be9c9c..f70d3966542d 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -11,7 +11,7 @@ static int patch_id_defined(struct commit *commit)
 }
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    struct object_id *oid, int diff_header_only)
+		    struct object_id *oid, int diff_header_only, int stable)
 {
 	if (!patch_id_defined(commit))
 		return -1;
@@ -22,7 +22,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 	else
 		diff_root_tree_oid(&commit->object.oid, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, oid, diff_header_only);
+	return diff_flush_patch_id(options, oid, diff_header_only, stable);
 }
 
 /*
@@ -46,11 +46,11 @@ static int patch_id_neq(const void *cmpfn_data,
 	struct patch_id *b = (void *)entry_or_key;
 
 	if (is_null_oid(&a->patch_id) &&
-	    commit_patch_id(a->commit, opt, &a->patch_id, 0))
+	    commit_patch_id(a->commit, opt, &a->patch_id, 0, 0))
 		return error("Could not get patch ID for %s",
 			oid_to_hex(&a->commit->object.oid));
 	if (is_null_oid(&b->patch_id) &&
-	    commit_patch_id(b->commit, opt, &b->patch_id, 0))
+	    commit_patch_id(b->commit, opt, &b->patch_id, 0, 0))
 		return error("Could not get patch ID for %s",
 			oid_to_hex(&b->commit->object.oid));
 	return !oideq(&a->patch_id, &b->patch_id);
@@ -80,7 +80,7 @@ static int init_patch_id_entry(struct patch_id *patch,
 	struct object_id header_only_patch_id;
 
 	patch->commit = commit;
-	if (commit_patch_id(commit, &ids->diffopts, &header_only_patch_id, 1))
+	if (commit_patch_id(commit, &ids->diffopts, &header_only_patch_id, 1, 0))
 		return -1;
 
 	hashmap_entry_init(patch, sha1hash(header_only_patch_id.hash));
diff --git a/patch-ids.h b/patch-ids.h
index 82a12b66f889..03bb04e7071f 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -20,7 +20,7 @@ struct patch_ids {
 };
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    struct object_id *oid, int);
+		    struct object_id *oid, int, int);
 int init_patch_ids(struct repository *, struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index e82c6c7d9177..7a5833a4b275 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1583,15 +1583,15 @@ test_expect_success 'format-patch --base' '
 	git format-patch --stdout --base=HEAD~3 HEAD~.. | tail -n 7 >actual2 &&
 	echo >expected &&
 	echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --unstable | awk "{print \$1}")" >>expected &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --unstable | awk "{print \$1}")" >>expected &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
 	signature >> expected &&
 	test_cmp expected actual1 &&
 	test_cmp expected actual2 &&
 	echo >fail &&
 	echo "base-commit: $(git rev-parse HEAD~3)" >>fail &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>fail &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>fail &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
 	signature >> fail &&
 	! test_cmp fail actual1 &&
 	! test_cmp fail actual2
-- 
Sent by a computer through tubes

