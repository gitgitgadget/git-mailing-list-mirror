Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F231A1FF30
	for <e@80x24.org>; Tue, 18 Jul 2017 22:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbdGRW26 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 18:28:58 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36172 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbdGRW24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 18:28:56 -0400
Received: by mail-pg0-f42.google.com with SMTP id u5so19860935pgq.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=30MJP0pTaegGwhwEFj2OoVauzZFmcPsuEUnbb/TZcbA=;
        b=Wi/9Le4BewTxFoFJZHEmoKmHR0xE3+eBA8qqid91xQ+UIpNZEvggYhzRDZXl459qjD
         d2aj8s+geuS9dB04GNvHgjXytrAEsY/deG+kdVAKAX/fqROiwqB11onhkxMD9CTxmmO9
         BUVRSJ6vgoU4F72vAZAN7WZpDQ4ZSkQyMAOpOWK+Uqt74yWlTZkRP2suV/Kvkm8zGOGs
         vD/5lENrx6atKk6/2zkaMQazEfzCvpT5DXEdgqsfSgzuMmAjPc7DuKZh1RDelzgvzKkm
         lJXoa3c8fYZpwcUASubnyjWCGAU0iMVUSAnjEFNogZKhaH783jcgVoUATOyPlWQrOASr
         uu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=30MJP0pTaegGwhwEFj2OoVauzZFmcPsuEUnbb/TZcbA=;
        b=NWA65GoJ8UR5Dk70djONjEB8hfHu6VzcIwJuGc341X4Wf5y3ete+Apa9A+6sdD988U
         zUKLvlQPtkyjTXeloqDzRB2jw/Km8pCodH8de9mtDQvrKdMuGM0sEVv/ua3YixdFGEWm
         iveFLuHlVk2dKRqu9HTZvNN0YUcgm471zjnFk2mK8AdB7Zy3HTxLhBtKFvS/IgbZvwYl
         48qn5yroCLCncHIXuJ04HM57dMB3sO0yOINuypN45o3EiM7Jt0CieDSWuImcHVFBixPj
         831z15CSMq+oiiLQkWTPrtkon192fd+ROzuutZyC7a8QKKXQxj4k3c1AkTfdf7aIdm94
         wzsg==
X-Gm-Message-State: AIVw110SL4wT8J+KDWxg1hSdG1JCYNAAfh/PdU2LOK1TEoWuVpel+ywx
        22u5RxykPNKaZ85q9KUTCw==
X-Received: by 10.99.37.131 with SMTP id l125mr3967187pgl.251.1500416935855;
        Tue, 18 Jul 2017 15:28:55 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id o4sm6058564pga.47.2017.07.18.15.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 15:28:54 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] fsck: remove redundant parse_tree() invocation
Date:   Tue, 18 Jul 2017 15:28:48 -0700
Message-Id: <20170718222848.1453-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If obj->type == OBJ_TREE, an invocation of fsck_walk() will invoke
parse_tree() and return quickly if that returns nonzero, so it is of no
use for traverse_one_object() to invoke parse_tree() in this situation
before invoking fsck_walk(). Remove that code.

The behavior of traverse_one_object() is changed slightly in that it now
returns -1 instead of 1 in the case that parse_tree() fails, but this is
not an issue because its only caller (traverse_reachable) does not care
about the value as long as it is nonzero.

This code was introduced in commit 271b8d2 ("builtin-fsck: move away
from object-refs to fsck_walk", 2008-02-25). The same issue existed in
that commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Here's a code cleanup. I noticed this while looking at modifying fsck.
---
 builtin/fsck.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99dea7adf..4ba311cda 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -168,18 +168,7 @@ static void mark_object_reachable(struct object *obj)
 
 static int traverse_one_object(struct object *obj)
 {
-	int result;
-	struct tree *tree = NULL;
-
-	if (obj->type == OBJ_TREE) {
-		tree = (struct tree *)obj;
-		if (parse_tree(tree) < 0)
-			return 1; /* error already displayed */
-	}
-	result = fsck_walk(obj, obj, &fsck_walk_options);
-	if (tree)
-		free_tree_buffer(tree);
-	return result;
+	return fsck_walk(obj, obj, &fsck_walk_options);
 }
 
 static int traverse_reachable(void)
-- 
2.13.2.932.g7449e964c-goog

