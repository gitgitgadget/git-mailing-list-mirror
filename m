Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70CF51F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439064AbeKWJsO (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32872 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439027AbeKWJsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:48:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id 79so10466558wmo.0
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKHAkcCph+l6RnTe6mxTpRHnu/mOqNh+0NCmev7+L/Y=;
        b=lmu4bIZ5ZNlH26Ehrx9x6/S08rgJMNUBJIq7lTwfLLWmO4yGSvxK3uTe9pVqO25eVx
         PsI3irh1z3VAnhDtChySK2xXIJ5G5jEiG5xzGYv9UzfuTRToTtOKQiaaBpNBE6EI+7Rs
         dR2dXL/kAna/V9KIycLBG8lHcCFLpqskiTVAX3/C+INSHbOb5AGDuQJ2Tqk9ggSZ/Teq
         tIBNLFCsdQSQnlQiKHdM5ZTHz3KW2DDyaMQU6cT5ogT6M4C+1DJWo7DSyiFP5bQ8/XGs
         baZDTTajza9EPkC5PNMyGQEtMDiMMQHMIojDqNkDZuWumjwR2VuOBcvhISUrJf+s+2lz
         x6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKHAkcCph+l6RnTe6mxTpRHnu/mOqNh+0NCmev7+L/Y=;
        b=oHCpk6VBSL4r06qN/Go1gHC7EGmVadkW5q2CI9pTa2tLgvIvcX82Fc/k1rfYRjSXPp
         e2E+xiOzxOgPzKkLVFdYYV5tdRKGWVVscrnyL2uO1MRFzt1nfLCoT08ND1IDoZUKXVEz
         yf8kqGJpb+nUfLZgHpf/Vx6A4nRSZoJ7UygMCnGc9gKc6d0HNke+ezd8+1y9AdOw0Ii5
         X0eZRpz8Xw415J0n/VUi5IppW3w2jgLbNVFley7ThYHcAoYEIOzmEMEa3G5Knce7ZtX9
         0q/rShwEKqG/hqN/h1q+T2txhLa1jq7yl0B0FKUZs2+J436p4w92ltPlR86yfHUaGj8D
         uI1w==
X-Gm-Message-State: AA+aEWaMcUo58CQ1mbVNpxqVN/EfCQMMSGqrOw2JkN0xAuLDZ0CJAjtu
        7GGRllU/RcRAB86AWFewcIY3kLIY
X-Google-Smtp-Source: AFSGD/Wi4nSSjeN9/yn+VSNM+BxIBoo8mt3WebXKH3knbY/j1yjOtUNVpP2Jyw/6gIawXjDn78LvZg==
X-Received: by 2002:a1c:150d:: with SMTP id 13mr3725528wmv.104.1542927992838;
        Thu, 22 Nov 2018 15:06:32 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:32 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 21/22] stash: optimize `get_untracked_files()` and `check_changes()`
Date:   Fri, 23 Nov 2018 01:05:41 +0200
Message-Id: <7ca8408f1e8c192324ac276ec42559c3343e9eee.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

https://public-inbox.org/git/20180818223329.GJ11326@hank.intra.tgummerer.com/

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash.c | 50 ++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index c76a1936d5..5ad0f443ca 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -879,18 +879,18 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
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
+
+static int check_changes_tracked_files(struct pathspec ps)
 {
 	int result;
 	struct rev_info rev;
 	struct object_id dummy;
-	struct strbuf out = STRBUF_INIT;
 
 	/* No initial commit. */
 	if (get_oid("HEAD", &dummy))
@@ -918,14 +918,26 @@ static int check_changes(struct pathspec ps, int include_untracked)
 	if (diff_result_code(&rev.diffopt, result))
 		return 1;
 
+	return 0;
+}
+
+/*
+ * The function will fill `untracked_files` with the names of untracked files
+ * It will return 1 if there were any changes and 0 if there were not.
+ */
+
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
@@ -1134,7 +1146,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 		head_commit = lookup_commit(the_repository, &info->b_commit);
 	}
 
-	if (!check_changes(ps, include_untracked)) {
+	if (!check_changes(ps, include_untracked, &untracked_files)) {
 		ret = 1;
 		goto done;
 	}
@@ -1159,8 +1171,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 		goto done;
 	}
 
-	if (include_untracked && get_untracked_files(ps, include_untracked,
-						     &untracked_files)) {
+	if (include_untracked) {
 		if (save_untracked_files(info, &msg, untracked_files)) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save "
@@ -1235,18 +1246,14 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0);
+	if (!check_changes_tracked_files(ps))
+		return 0;
 
-	if (!ret)
+	if (!(ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0)))
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
@@ -1256,6 +1263,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 	struct stash_info info;
 	struct strbuf patch = STRBUF_INIT;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
+	struct strbuf untracked_files = STRBUF_INIT;
 
 	if (patch_mode && keep_index == -1)
 		keep_index = 1;
@@ -1290,7 +1298,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 		goto done;
 	}
 
-	if (!check_changes(ps, include_untracked)) {
+	if (!check_changes(ps, include_untracked, &untracked_files)) {
 		if (!quiet)
 			printf_ln(_("No local changes to save"));
 		goto done;
-- 
2.19.1.878.g0482332a22

