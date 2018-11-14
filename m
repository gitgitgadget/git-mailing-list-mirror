Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1186D1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbeKNKPB (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:15:01 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:56214 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKPB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:15:01 -0500
Received: by mail-yb1-f201.google.com with SMTP id y125-v6so3831154ybe.22
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/OtJ1IIPFcty7vJipL34AStQVGkZLwdq+ROwHdxDi30=;
        b=CbFX6bOu97+N2ArWPAPN1tGcPycTgLr0J/Yr2ZZaOelSkCBvVwYNuezojVwUQfzK1b
         HxF3aA/pIAOs9n51xgPv5618NV02zmz0AHhRm83ki0WyG11YPX8DfuGocyEPMdrykd+B
         or7gyRcNZ66ye1Pj4LrDvTpL5gadqgjK0lTXtX4K2XfSmYfc4w5kUF2EyUXvNmMALFZG
         H2ZnKM4NpGf56CW5aX6yQRDKHn9sF7Bs8Ojx/bMg7pIgGbSns3BoTbwNDEUlhDHGzYmn
         jpHEx1vaoTo6jfi+z8kFvEyc5YeoWaPFEhn0eh+ReyrQpBh/C1L1V+zgl6SS/E050C0X
         UE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/OtJ1IIPFcty7vJipL34AStQVGkZLwdq+ROwHdxDi30=;
        b=AbEM6iTr5BLHlfdW8k6SrsaidRL2bc4MFEqcMny58uWeEV89kcbnoeQtpV8R9gH5S/
         YK+KFtj4Xk6RnGh3kV3jAdcumYlh08okJRxsehPPNYNQrG+n2cRl9phXcrpir7AukPz/
         CbN0oys/UOq6HXd5giqUsfcHEmMgqN7i6XaVHzu+RDlEI9himG/dzmoOuPERrpb54vwV
         8iATcN5NU6McSNDR+5Wn0n5Cq4xzopZxyc9WbTPCzcU/S52oXSPRuKAEuuYyI+eN37Ym
         MtLz1PyDt1IDPoMtIKTAsSblp2MBnjA06xN5Z5yII8LRLVqucp1rdhgUijWr+R2xC2dR
         4eyw==
X-Gm-Message-State: AGRZ1gJgpr1NEoRsQKjGjg5SRzS74czhnhkBLew/A0YB9pdmmMaerv/w
        s+xQLNtO5Pk/RbJSS73K7C7Yf/FQ3mRP
X-Google-Smtp-Source: AJdET5cg62SGhX5yiWDRCuCs8CQ8WhlNPEHdKDFe6K1E7F4yCNoSS7dMHLmLdiwf181iYmERGi2XTYynqEkP
X-Received: by 2002:a25:80ce:: with SMTP id c14-v6mr3741904ybm.53.1542154457666;
 Tue, 13 Nov 2018 16:14:17 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:13:01 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-19-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 18/23] submodule: use submodule repos for object lookup
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This converts the 'show_submodule_header' function to use
the repository API properly, such that the submodule objects
are not added to the main object store.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 73 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/submodule.c b/submodule.c
index d9d3046689..262f03f118 100644
--- a/submodule.c
+++ b/submodule.c
@@ -443,7 +443,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	return prepare_revision_walk(rev);
 }
 
-static void print_submodule_summary(struct rev_info *rev, struct diff_options *o)
+static void print_submodule_summary(struct repository *r, struct rev_info *rev, struct diff_options *o)
 {
 	static const char format[] = "  %m %s";
 	struct strbuf sb = STRBUF_INIT;
@@ -454,7 +454,8 @@ static void print_submodule_summary(struct rev_info *rev, struct diff_options *o
 		ctx.date_mode = rev->date_mode;
 		ctx.output_encoding = get_log_output_encoding();
 		strbuf_setlen(&sb, 0);
-		format_commit_message(commit, format, &sb, &ctx);
+		repo_format_commit_message(r, commit, format, &sb,
+				      &ctx);
 		strbuf_addch(&sb, '\n');
 		if (commit->object.flags & SYMMETRIC_LEFT)
 			diff_emit_submodule_del(o, sb.buf);
@@ -481,14 +482,44 @@ void prepare_submodule_repo_env(struct argv_array *out)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
-/* Helper function to display the submodule header line prior to the full
- * summary output. If it can locate the submodule objects directory it will
- * attempt to lookup both the left and right commits and put them into the
- * left and right pointers.
+/*
+ * Initialize 'out' based on the provided submodule path.
+ *
+ * Unlike repo_submodule_init, this tolerates submodules not present
+ * in .gitmodules. This function exists only to preserve historical behavior,
+ *
+ * Returns 0 on success, -1 when the submodule is not present.
  */
-static void show_submodule_header(struct diff_options *o, const char *path,
+static struct repository *open_submodule(const char *path)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct repository *out = xmalloc(sizeof(*out));
+
+	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
+		strbuf_release(&sb);
+		free(out);
+		return NULL;
+	}
+
+	out->submodule_prefix = xstrdup(path);
+
+	strbuf_release(&sb);
+	return out;
+}
+
+/*
+ * Helper function to display the submodule header line prior to the full
+ * summary output.
+ *
+ * If it can locate the submodule git directory it will create a repository
+ * handle for the submodule and lookup both the left and right commits and
+ * put them into the left and right pointers.
+ */
+static void show_submodule_header(struct diff_options *o,
+		const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule,
+		struct repository *sub,
 		struct commit **left, struct commit **right,
 		struct commit_list **merge_bases)
 {
@@ -507,7 +538,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	else if (is_null_oid(two))
 		message = "(submodule deleted)";
 
-	if (add_submodule_odb(path)) {
+	if (!sub) {
 		if (!message)
 			message = "(commits not present)";
 		goto output_header;
@@ -517,8 +548,8 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	 * Attempt to lookup the commit references, and determine if this is
 	 * a fast forward or fast backwards update.
 	 */
-	*left = lookup_commit_reference(the_repository, one);
-	*right = lookup_commit_reference(the_repository, two);
+	*left = lookup_commit_reference(sub, one);
+	*right = lookup_commit_reference(sub, two);
 
 	/*
 	 * Warn about missing commits in the submodule project, but only if
@@ -528,7 +559,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	     (!is_null_oid(two) && !*right))
 		message = "(commits not present)";
 
-	*merge_bases = get_merge_bases(*left, *right);
+	*merge_bases = repo_get_merge_bases(sub, *left, *right);
 	if (*merge_bases) {
 		if ((*merge_bases)->item == *left)
 			fast_forward = 1;
@@ -562,16 +593,18 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 	struct rev_info rev;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
+	struct repository *sub;
 
+	sub = open_submodule(path);
 	show_submodule_header(o, path, one, two, dirty_submodule,
-			      &left, &right, &merge_bases);
+			      sub, &left, &right, &merge_bases);
 
 	/*
 	 * If we don't have both a left and a right pointer, there is no
 	 * reason to try and display a summary. The header line should contain
 	 * all the information the user needs.
 	 */
-	if (!left || !right)
+	if (!left || !right || !sub)
 		goto out;
 
 	/* Treat revision walker failure the same as missing commits */
@@ -580,13 +613,17 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 		goto out;
 	}
 
-	print_submodule_summary(&rev, o);
+	print_submodule_summary(sub, &rev, o);
 
 out:
 	if (merge_bases)
 		free_commit_list(merge_bases);
 	clear_commit_marks(left, ~0);
 	clear_commit_marks(right, ~0);
+	if (sub) {
+		repo_clear(sub);
+		free(sub);
+	}
 }
 
 void show_submodule_inline_diff(struct diff_options *o, const char *path,
@@ -598,9 +635,11 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	struct commit_list *merge_bases = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
+	struct repository *sub;
 
+	sub = open_submodule(path);
 	show_submodule_header(o, path, one, two, dirty_submodule,
-			      &left, &right, &merge_bases);
+			      sub, &left, &right, &merge_bases);
 
 	/* We need a valid left and right commit to display a difference */
 	if (!(left || is_null_oid(one)) ||
@@ -661,6 +700,10 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		clear_commit_marks(left, ~0);
 	if (right)
 		clear_commit_marks(right, ~0);
+	if (sub) {
+		repo_clear(sub);
+		free(sub);
+	}
 }
 
 int should_update_submodules(void)
-- 
2.19.1.1215.g8438c0b245-goog

