Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD26C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbhLPNp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbhLPNpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:45:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E879C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e5so10879216wrc.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjpRisVgNkMQzQcoNk0yxJ9ncuPF84MmsHl8nNmtVjQ=;
        b=omKtvGba270puv1QeKnZi6qBYRKgjUakeCB3biOQ52+TTXTMfThR+QkbYMcWOJG/DD
         nfZM7EZeKg50AABkY3A289zsY2Y8KQSR3Rx9R6wfhhd8gkH6fuA9dAvMWbwifLa8JjtB
         EwJKu0EnAGzb0isxcG+7eyNf0tDWmD3BX2Aj7IYvqwwnJS10keFBlTSbj2F5C3MDibDw
         KylDawEUOJ6YjTKuZuzoUv8uangRCoiYhcC8SPwFSQEXjUMhvJ5y7Zy+2UPD1JU3131c
         1PiYUCkCTKtjbyUXYnIux0bF95aZmfFVjorT5u99yKMHrSa9P03JeAl+8ruQXUREGcXe
         HmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjpRisVgNkMQzQcoNk0yxJ9ncuPF84MmsHl8nNmtVjQ=;
        b=ID4Ed7AVyK/2tHiF5mhiReQ4Bw+zMJXSa+lrBN3y9oUBuE92+CAtJjoQ9m6J2KY67L
         5kkIzwyp16duWS0c69teWYan472V+4glnO0n+5F44qqphhIKH8A3KXC2VOqGFyiKj1dQ
         SZ0ByjqL8w3kK0ZKm8By+BQop+h+VrSzz7lvlr2eFeKVaJbbGJY9bmiW8IrXPLh48H/f
         hTt2gzv/IOoFeiT/GETBNUp1lqMKXpci3oNjDG+rz18fB+EOLxOuW5PNZsbQMXOFTaj2
         +qqR2RLyqBnFGt+X+iyItpV2hdNQK0YgtuuQA7uNDg0PRCk8jolz26vSYVS4QjFj9HeS
         WKvg==
X-Gm-Message-State: AOAM533FLercVQv2cG8rH0oXxF+MLtL/FIm26NV2YfxITAUTvXo4kBtM
        0MeD6xZcBsdZ19+yTeNLhDGtvPx4+hQiUA==
X-Google-Smtp-Source: ABdhPJyGSms8klVkVT8YCF2cE8a1omG0PCbf0FxSaGletZ6BgHqCKvUBgh4WPKvH5STvbmYzmvHRUA==
X-Received: by 2002:adf:8165:: with SMTP id 92mr9229141wrm.199.1639662323820;
        Thu, 16 Dec 2021 05:45:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm4866821wrn.73.2021.12.16.05.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:45:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/9] reflog: change one->many worktree->refnames to use a string_list
Date:   Thu, 16 Dec 2021 14:45:12 +0100
Message-Id: <patch-v2-3.9-c0e190e46cf-20211216T134028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gc80c40b6642
In-Reply-To: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the FLEX_ARRAY pattern added in bda3a31cc79 (reflog-expire:
Avoid creating new files in a directory inside readdir(3) loop,
2008-01-25) the string-list API instead.

This does not change any behavior, allows us to delete much of this
code as it's replaced by things we get from the string-list API for
free, as a result we need just one struct to keep track of this data,
instead of two.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6989492bf5c..0fb46ade19f 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -48,16 +48,9 @@ struct expire_reflog_policy_cb {
 	struct commit_list *tips;
 };
 
-struct collected_reflog {
-	struct object_id oid;
-	char reflog[FLEX_ARRAY];
-};
-
-struct collect_reflog_cb {
-	struct collected_reflog **e;
-	int alloc;
-	int nr;
-	struct worktree *wt;
+struct worktree_reflogs {
+	struct worktree *worktree;
+	struct string_list reflogs;
 };
 
 /* Remember to update object flag allocation in object.h */
@@ -403,24 +396,20 @@ static void reflog_expiry_cleanup(void *cb_data)
 
 static int collect_reflog(const char *ref, const struct object_id *oid, int unused, void *cb_data)
 {
-	struct collected_reflog *e;
-	struct collect_reflog_cb *cb = cb_data;
+	struct worktree_reflogs *cb = cb_data;
+	struct worktree *worktree = cb->worktree;
 	struct strbuf newref = STRBUF_INIT;
 
 	/*
 	 * Avoid collecting the same shared ref multiple times because
 	 * they are available via all worktrees.
 	 */
-	if (!cb->wt->is_current && ref_type(ref) == REF_TYPE_NORMAL)
+	if (!worktree->is_current && ref_type(ref) == REF_TYPE_NORMAL)
 		return 0;
 
-	strbuf_worktree_ref(cb->wt, &newref, ref);
-	FLEX_ALLOC_STR(e, reflog, newref.buf);
-	strbuf_release(&newref);
+	strbuf_worktree_ref(worktree, &newref, ref);
+	string_list_append(&cb->reflogs, strbuf_detach(&newref, NULL));
 
-	oidcpy(&e->oid, oid);
-	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
-	cb->e[cb->nr++] = e;
 	return 0;
 }
 
@@ -609,33 +598,34 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	}
 
 	if (do_all) {
-		struct collect_reflog_cb collected;
+		struct worktree_reflogs collected = {
+			.reflogs = STRING_LIST_INIT_NODUP,
+		};
+		struct string_list_item *item;
 		struct worktree **worktrees, **p;
-		int i;
 
-		memset(&collected, 0, sizeof(collected));
 		worktrees = get_worktrees();
 		for (p = worktrees; *p; p++) {
 			if (!all_worktrees && !(*p)->is_current)
 				continue;
-			collected.wt = *p;
+			collected.worktree = *p;
 			refs_for_each_reflog(get_worktree_ref_store(*p),
 					     collect_reflog, &collected);
 		}
 		free_worktrees(worktrees);
-		for (i = 0; i < collected.nr; i++) {
-			struct collected_reflog *e = collected.e[i];
+
+		for_each_string_list_item(item, &collected.reflogs) {
 			struct expire_reflog_policy_cb cb = { .cmd = cmd };
 
-			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
-			status |= reflog_expire(e->reflog, flags,
+			set_reflog_expiry_param(&cb.cmd, explicit_expiry, item->string);
+			status |= reflog_expire(item->string, flags,
 						reflog_expiry_prepare,
 						should_expire_reflog_ent,
 						reflog_expiry_cleanup,
 						&cb);
-			free(e);
 		}
-		free(collected.e);
+		collected.reflogs.strdup_strings = 1;
+		string_list_clear(&collected.reflogs, 0);
 	}
 
 	for (; i < argc; i++) {
-- 
2.34.1.1020.gc80c40b6642

