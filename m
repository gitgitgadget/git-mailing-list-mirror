Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFBBB1F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeJOFz6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46781 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeJOFz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so16034865edg.13
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHa0zAHLWk77tcQY429TCX9GhamIFWbVggrrnhPqEZQ=;
        b=WA/zdOGBk8jIGsQnZfouDd2NfRfbA4yRn6UUI+WME31FBXY7VreE9P9qNvQGGGThII
         /YziW2wTfurpc5ten39HoW8UEoKISVmiczS8VkMorezyuqrO8gjBEE3vtAHrLl+RddSw
         m6Xzx9GX0idTpjdRzdJ+nz6Wyd9lBQBYrR7h5Y7GD2Bfar0nDVtMslbbygnllQkkhWyJ
         g+ECQprir8SK38db0YOxbroJMsGcu5wvFl16VVQdpCI/j/O9WnWQRq5wqgaqxEcfF8nB
         zejcStQAG8dNDCGVrgzIrIXD8bo9nZPPjAnpvRKlcdt+zr6QCHUJYjCM3zEXBYkjQtBD
         csmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHa0zAHLWk77tcQY429TCX9GhamIFWbVggrrnhPqEZQ=;
        b=GF424FubdGz0oe5YO/OMshBNr2ka2FeFYWNzSs8eKZKPzEnkU923d08EGNjFQMKzMH
         B7koH/pGNhikDfPZ7k1pnt+07HPucR9y/9UB1s9wrS+WxoM8mTFdCruQriCDHWgRfPt8
         5uPT1pC3BeU2Kp6e0awdHej0rSCYMC60ktBur1Z0wJxW2G8/LkPtflvNG3XOkHvVWlOq
         hBD/vjX91vzq6sHcDL7LizTt25zWqrqp687P8N0VuMjofjPrJotT3t6lBa+uahr12OhV
         gSXbi8mwAuBI9H/WQCYEwBgVwVFwseB9ZX1iNW3hLNW5W4BFMTVOVhmSjUXpukB+sZqU
         K8mw==
X-Gm-Message-State: ABuFfojZCSk50nu+BPfYSO8/iiJ4GdlHp6fnEhVTJvs2DsCPjur7vPg5
        F9QCOy35sJIAzL0CiB8YttTT+p7v
X-Google-Smtp-Source: ACcGV60Po8e7LtV38g2mpvf8WZxudl3ddHc7JnFfmnRu6nhUioMol5UH3Kfw1SUENIcF6unoOTB2wA==
X-Received: by 2002:a50:a643:: with SMTP id d61-v6mr21509819edc.281.1539555209707;
        Sun, 14 Oct 2018 15:13:29 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:29 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 20/21] stash: optimize `get_untracked_files()` and `check_changes()`
Date:   Mon, 15 Oct 2018 01:11:26 +0300
Message-Id: <171db39a89b57a907b0baa3f6d783c6dab62806c.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
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
index e945c13c42..d2365ada2e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -881,18 +881,18 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
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
@@ -920,14 +920,26 @@ static int check_changes(struct pathspec ps, int include_untracked)
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
@@ -1138,7 +1150,7 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 		head_commit = lookup_commit(the_repository, &info->b_commit);
 	}
 
-	if (!check_changes(ps, include_untracked)) {
+	if (!check_changes(ps, include_untracked, &untracked_files)) {
 		ret = 1;
 		goto done;
 	}
@@ -1163,8 +1175,7 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 		goto done;
 	}
 
-	if (include_untracked && get_untracked_files(ps, include_untracked,
-						     &untracked_files)) {
+	if (include_untracked) {
 		if (save_untracked_files(info, &msg, untracked_files)) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save "
@@ -1244,19 +1255,15 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	stash_msg = stash_msg_buf.buf;
 
 	memset(&ps, 0, sizeof(ps));
-	ret = do_create_stash(ps, &stash_msg, 0, 0, &info, NULL, 0);
+	if (!check_changes_tracked_files(ps))
+		return 0;
 
-	if (!ret)
+	if (!(ret = do_create_stash(ps, &stash_msg, 0, 0, &info, NULL, 0)))
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
 	strbuf_release(&stash_msg_buf);
 	free(stash_msg);
-
-	/*
-	 * ret can be 1 if there were no changes. In this case, we should
-	 * not error out.
-	 */
-	return ret < 0;
+	return ret;
 }
 
 static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
@@ -1265,6 +1272,7 @@ static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
 	int ret = 0;
 	struct stash_info info;
 	struct strbuf patch = STRBUF_INIT;
+	struct strbuf untracked_files = STRBUF_INIT;
 
 	if (patch_mode && keep_index == -1)
 		keep_index = 1;
@@ -1299,7 +1307,7 @@ static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
 		goto done;
 	}
 
-	if (!check_changes(ps, include_untracked)) {
+	if (!check_changes(ps, include_untracked, &untracked_files)) {
 		if (!quiet)
 			printf_ln(_("No local changes to save"));
 		goto done;
-- 
2.19.0.rc0.23.g10a62394e7

