Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CD9EB8FAD
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 06:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbjIFGCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 02:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjIFGCx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 02:02:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87046CFC
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 23:02:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fbfcb8d90so35057137b3.1
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693980168; x=1694584968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl9KhXwcJmtX/eCvWVlJ11En0qCO8zhv8vSHJ3YtxWk=;
        b=wxH2KnBr8WbhYbCVcB7lTcWskrhVnpWp07yR59z7NvNDb0NhZs/+cfPuJKH+ayBhrR
         n6kmH7mrWDdu8gSQwNMIIP0SRPZvozH8GV9YZfZmv7cWJTaw737oS0x6mlXiba2SMNmB
         jWuvykBpkudrvs0wQAblaUr/W78zsInm6jUbqEmGlVyIEfnFuztIzLGPqFvFZ1pTGGKv
         IQqo6cnJEjxfSR91i0cX36OD3ubBEYo1dBs/AioYrjL7ZTlfzvaxqxazZxXIn7EXT+uh
         W091BekZn7cedzo5pqUKUuafmZlUx/CmSf4AV1BPqsmyxqOH5uXRafaS0T46eqlnTgph
         FYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693980168; x=1694584968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl9KhXwcJmtX/eCvWVlJ11En0qCO8zhv8vSHJ3YtxWk=;
        b=F1SAli6h93R/boY8jUQDRGLS+ptuyTmwnB2DPns0phPmfbYBTtovmmwG/BiCatYKp/
         VhiuM4ofWclUqXCJNQzX3DLhrLkU/nvbb0PKgyOE1XNbtO+qqWvERQfyS4MZ944rxpgs
         9PMLS9/Cw5sw6tAjCORdK6lt5KDvS0RL6hE8PK1n71w7uWMUEub+5s4tuRfGsjkgJP6Z
         UFa9vAsN1jrpkB1FMohHB1ByebP9LC+f4tcgnl78bdKJUI2oMSmfCKCzzetM57T4BqGe
         JqSK3tcLZ+xJ0YgFRi6ZY2ehBHXf0Duwfo0ySBT9yNP+XyvqUIv9wj6rHYiQHerSW3Ac
         ZoKw==
X-Gm-Message-State: AOJu0YyrihskpjSIOGTNdRsCb/lNfK6z0B6PdGJj8+X9Y6lDM52PdwyX
        opINcQpzdtprx7uA4O9Xm/Md7Aw/ehHI+A==
X-Google-Smtp-Source: AGHT+IHyqZI3cnBbmi3pS5hbZQxGVAzkJiczn2G/avfH2Bugy4EiiSuvaZVuYIAkAItOZNT2HoNXqtqy44YM1g==
X-Received: from sokac.sfo.corp.google.com ([2620:15c:11a:202:5a2c:e12e:a0b:b02])
 (user=sokcevic job=sendgmr) by 2002:a81:af66:0:b0:56d:647:664b with SMTP id
 x38-20020a81af66000000b0056d0647664bmr427904ywj.5.1693980168795; Tue, 05 Sep
 2023 23:02:48 -0700 (PDT)
Date:   Tue,  5 Sep 2023 23:02:42 -0700
In-Reply-To: <20230829005606.136615-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230829005606.136615-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230906060241.944886-2-sokcevic@google.com>
Subject: [PATCH] [diff-lib] Fix check_removed when fsmonitor is on
From:   Josip Sokcevic <sokcevic@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        Josip Sokcevic <sokcevic@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-diff-index may return incorrect deleted entries when fsmonitor is used in a
repository with git submodules. This can be observed on Mac machines, but it
can affect all other supported platforms too.

If fsmonitor is used, `stat *st` may not be initialized. Since `lstat` calls
aren't not desired when fsmonitor is on, skip the entire gitlink check using
the same condition used to initialize `stat *st`.
---
This patch is using jonathantanmy@ test case, which now passes. It's
possible there are similar edge cases with fsmonitor, so I'll do more
extensive e2e testing tomorrow.
 diff-lib.c                   | 2 +-
 t/t7527-builtin-fsmonitor.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index d8aa777a73..c67aa5ff89 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -46,7 +46,7 @@ static int check_removed(const struct index_state *istate, const struct cache_en
 	}
 	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
 		return 1;
-	if (S_ISDIR(st->st_mode)) {
+	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && S_ISDIR(st->st_mode)) {
 		struct object_id sub;
 
 		/*
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 0c241d6c14..894a80fbe8 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -824,6 +824,10 @@ test_expect_success 'submodule always visited' '
 
 	create_super super &&
 	create_sub sub &&
+	git -C super --no-optional-locks diff-index --name-status HEAD >actual.with &&
+	git -C super --no-optional-locks -c core.fsmonitor=false \
+	    diff-index --name-status HEAD >actual.without &&
+	    test_cmp actual.with actual.without &&
 
 	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
 	git -C super commit -m "add sub" &&
@@ -837,6 +841,8 @@ test_expect_success 'submodule always visited' '
 	# some dirt in the submodule and confirm matching output.
 
 	# Completely clean status.
+	echo Now running for clean status &&
+
 	my_match_and_clean &&
 
 	# .M S..U
-- 
2.42.0.283.g2d96d420d3-goog


