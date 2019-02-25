Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D978E20248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfBYXR2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39329 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfBYXR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id z84so554274wmg.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtIdkuS5YJ0WmI+S4YqixXhUQ9/aCnbMviPSyqEIlmg=;
        b=qN7Snn0etnZeShtbJz/uXstnvfttTI/HNozhfALMCcV6onRGrszfScCasI1ZCIYfuu
         Sr3I1rGeY5oCW4Rf8Y10VNdWXjs6ZFUagc3GdD3s+ktjnSMUAmbZtALzlje9oMu8NEW7
         +Lo/XId9BWmDsR2gQRs0km0dopKpo8EYb8PtRPqj0hCHrsdTojmcwPWJfM1peOlJrkBZ
         yAEk+MdDIsAf2VeI7pUQsnmQGbR/6X4Mp757ptRKo04mrcAoWCeMa0odHtJ7IK7hhJOh
         NifB6q6z89q9Nmx5EoAIfpZ0uNKwPl03fu7YK5qNwUF2eBmHhN+NLq52/qirKoBkty7Z
         sTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtIdkuS5YJ0WmI+S4YqixXhUQ9/aCnbMviPSyqEIlmg=;
        b=NY5qMScv5IL8HmfNmRhMRnQ2MucPR/DHYKBz2dgwedOH5ziZoEuEM+ejqiFQXJ8dMM
         z3EJGuOpN7U9AH56eMTmbiG/AUvdXxnBn/pdqJO3SWzBeBv13r5SzdEF7IHfrph7k6op
         ctuM+MSo6cKWW2MyAaUe90qHNvmU0KJCdLTJX5phgYTOIaAIknqkABQAdijs6I9kD+KK
         zXHnHwfapv+G+P4dhej7iEqj3+DZxjWhrRZihsAS6VYBAFXc8RwxnHPGk9BKbh2wmiho
         J4CqkHOwDZSnartgrRUawqF36QAKoZPgySHpZh3K3RC1ErNJrj8jxB60z9VSoo6SW594
         eLQQ==
X-Gm-Message-State: AHQUAuaQuYYdneeFR7cC1S6uzyR69601pWfnluv9bouowVbGIYX2Kdsc
        zc0scxseXn/xcimx1LIgB/Husx/E
X-Google-Smtp-Source: AHgI3IYiKmrFIAEVM9NEknKfLENBf6rcdKV3SUmd5N0P1POPuzPCaxdgMONp1u1aBY3deX+lvU0GBA==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr651124wmb.61.1551136644440;
        Mon, 25 Feb 2019 15:17:24 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id d21sm32763438wrc.44.2019.02.25.15.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:22 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 22/27] stash: optimize `get_untracked_files()` and `check_changes()`
Date:   Mon, 25 Feb 2019 23:16:26 +0000
Message-Id: <20190225231631.30507-23-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

This commits introduces a optimization by avoiding calling the
same functions again. For example, `git stash push -u`
would call at some points the following functions:

 * `check_changes()` (inside `do_push_stash()`)
 * `do_create_stash()`, which calls: `check_changes()` and
`get_untracked_files()`

Note that `check_changes()` also calls `get_untracked_files()`.
So, `check_changes()` is called 2 times and `get_untracked_files()`
3 times.

The old function `check_changes()` now consists of two functions:
`get_untracked_files()` and `check_changes_tracked_files()`.

These are the call chains for `push` and `create`:

 * `push_stash()` -> `do_push_stash()` -> `do_create_stash()`

 * `create_stash()` -> `do_create_stash()`

To prevent calling the same functions over and over again,
`check_changes()` inside `do_create_stash()` is now placed
in the caller functions (`create_stash()` and `do_push_stash()`).
This way `check_changes()` and `get_untracked files()` are called
only one time.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash--helper.c | 46 ++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 8e4e96e353..4c51b58206 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -879,18 +879,17 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
 }
 
 /*
- * The return value of `check_changes()` can be:
+ * The return value of `check_changes_tracked_files()` can be:
  *
  * < 0 if there was an error
  * = 0 if there are no changes.
  * > 0 if there are changes.
  */
-static int check_changes(struct pathspec ps, int include_untracked)
+static int check_changes_tracked_files(struct pathspec ps)
 {
 	int result;
 	struct rev_info rev;
 	struct object_id dummy;
-	struct strbuf out = STRBUF_INIT;
 
 	/* No initial commit. */
 	if (get_oid("HEAD", &dummy))
@@ -918,14 +917,25 @@ static int check_changes(struct pathspec ps, int include_untracked)
 	if (diff_result_code(&rev.diffopt, result))
 		return 1;
 
+	return 0;
+}
+
+/*
+ * The function will fill `untracked_files` with the names of untracked files
+ * It will return 1 if there were any changes and 0 if there were not.
+ */
+static int check_changes(struct pathspec ps, int include_untracked,
+			 struct strbuf *untracked_files)
+{
+	int ret = 0;
+	if (check_changes_tracked_files(ps))
+		ret = 1;
+
 	if (include_untracked && get_untracked_files(ps, include_untracked,
-						     &out)) {
-		strbuf_release(&out);
-		return 1;
-	}
+						     untracked_files))
+		ret = 1;
 
-	strbuf_release(&out);
-	return 0;
+	return ret;
 }
 
 static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
@@ -1137,7 +1147,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 		head_commit = lookup_commit(the_repository, &info->b_commit);
 	}
 
-	if (!check_changes(ps, include_untracked)) {
+	if (!check_changes(ps, include_untracked, &untracked_files)) {
 		ret = 1;
 		goto done;
 	}
@@ -1162,8 +1172,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 		goto done;
 	}
 
-	if (include_untracked && get_untracked_files(ps, include_untracked,
-						     &untracked_files)) {
+	if (include_untracked) {
 		if (save_untracked_files(info, &msg, untracked_files)) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save "
@@ -1248,6 +1257,9 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 			     0);
 
 	memset(&ps, 0, sizeof(ps));
+	if (!check_changes_tracked_files(ps))
+		return 0;
+
 	strbuf_addstr(&stash_msg_buf, stash_msg);
 	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
 			      NULL, 0);
@@ -1255,12 +1267,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
 	strbuf_release(&stash_msg_buf);
-
-	/*
-	 * ret can be 1 if there were no changes. In this case, we should
-	 * not error out.
-	 */
-	return ret < 0;
+	return ret;
 }
 
 static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
@@ -1270,6 +1277,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 	struct stash_info info;
 	struct strbuf patch = STRBUF_INIT;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
+	struct strbuf untracked_files = STRBUF_INIT;
 
 	if (patch_mode && keep_index == -1)
 		keep_index = 1;
@@ -1304,7 +1312,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 		goto done;
 	}
 
-	if (!check_changes(ps, include_untracked)) {
+	if (!check_changes(ps, include_untracked, &untracked_files)) {
 		if (!quiet)
 			printf_ln(_("No local changes to save"));
 		goto done;
-- 
2.21.0.rc2.291.g17236886c5

