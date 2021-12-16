Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A25C433FE
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhLPNpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbhLPNp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:45:28 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D24C06173F
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so3502401wrg.7
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t38cs7kw53FJsz0U9UiPcn1F0YPoruTh7cj6wPrl/kA=;
        b=gXZWDTStI17GNgrKTs4r31mM7Dpo9E9TJqc6kDJKAN3gtm9GBfWuxdYJUQPIrzguDu
         pnjRzjP7rUI/49bZNKSqtWUD8dgJ7FeyajH112ewQ8tnZVithKxIGiSHnwc0WfemA0S9
         sajjzysphwbhv5WeX6z5vqgpEeTuwlHRXnUUiQ3zr/M8J1xihghieOcKWRY2ckbvE81U
         BMcpiI/+Ij5OiRfc+qJQJce6q3wbX2BJsNhNUyoH2QIFpQryxZCQ4cFYsJqny0tuubwl
         4mlG+74vQQ30qUo5QRjvpAY/Yie990zCpPXOokgy3vcmRyEYuQ+aj7rmZMMLg51zrxS+
         ZVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t38cs7kw53FJsz0U9UiPcn1F0YPoruTh7cj6wPrl/kA=;
        b=GeeMwiZ3W5/rPPzkze9COMi1eI2f7I7VZSwbx5wOAeEU2Md4sHqFPqIjbhdp1J5bY7
         JSTiS3lf/kBpvmhHQ7jgxjentlxf9Myo1gJPCl7uQdvk268UvfOl623RMXvQC/LvHdFQ
         0+HdTfOpV90+1sPiwOW65h6DQKkcwu0u2zI1jJTJqpOjb04z5hP+OE6ZTTXAqRG968V9
         y0ZYfz6z2mk9wiXasmqJqTmipq5vLEPKIVEMXhqDLfpYB+uJk5Ij0qv8UGmG04/GEMFe
         RINQxPfUq597BvLponCak23tsSgEmqewf6oiGOSBdaSqlwF1FU1XbtFVdud3YpGev8Ya
         119A==
X-Gm-Message-State: AOAM533igjaUA/mwUg0N6yBtMmvl735fwYYEgtTzxpfne4nvPnTYexRF
        vw+YNcKc3uPlvmRkeuFuiszeUSk7zAHJbQ==
X-Google-Smtp-Source: ABdhPJxVqp7wifPgZvw2Hs3paX6Kdgggc7ihqquFi5+XoHl3wnjrXYxss+f38T24F32lwGV+M44q3Q==
X-Received: by 2002:a05:6000:1868:: with SMTP id d8mr9503873wri.285.1639662325898;
        Thu, 16 Dec 2021 05:45:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm4866821wrn.73.2021.12.16.05.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:45:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/9] reflog expire: refactor & use "tip_commit" only for UE_NORMAL
Date:   Thu, 16 Dec 2021 14:45:14 +0100
Message-Id: <patch-v2-5.9-39263cd00ae-20211216T134028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gc80c40b6642
In-Reply-To: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an intermediate variable for "tip_commit" in
reflog_expiry_prepare(), and only add it to the struct if we're
handling the UE_NORMAL case.

The code behaves the same way as before, but this makes the control
flow clearer, and the shorter name allows us to fold a 4-line i/else
int a one-line terany instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index f8a24f1aa26..ec0c6051135 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -354,16 +354,14 @@ static void reflog_expiry_prepare(const char *refname,
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
 	struct commit_list *elem;
+	struct commit *commit = NULL;
 
 	if (!cb->cmd.expire_unreachable || is_head(refname)) {
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
-		cb->tip_commit = lookup_commit_reference_gently(the_repository,
-								oid, 1);
-		if (!cb->tip_commit)
-			cb->unreachable_expire_kind = UE_ALWAYS;
-		else
-			cb->unreachable_expire_kind = UE_NORMAL;
+		commit = lookup_commit_reference_gently(the_repository,
+							oid, 1);
+		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
 	}
 
 	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
@@ -378,7 +376,9 @@ static void reflog_expiry_prepare(const char *refname,
 			commit_list_insert(elem->item, &cb->mark_list);
 		break;
 	case UE_NORMAL:
-		commit_list_insert(cb->tip_commit, &cb->mark_list);
+		commit_list_insert(commit, &cb->mark_list);
+		/* For reflog_expiry_cleanup() below */
+		cb->tip_commit = commit;
 	}
 	cb->mark_limit = cb->cmd.expire_total;
 	mark_reachable(cb);
-- 
2.34.1.1020.gc80c40b6642

