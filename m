Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16926C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhLVEHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbhLVEHM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:07:12 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19B4C061747
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c66so697817wma.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sPGQf5GcyOoCA1fXO3cw3uqCuO7zsLcDC/cKwYqWuPM=;
        b=KXOyaswM+ERC24EwKiqqKVMLjsCle3aZWb7YCLVxkbGTMx1hqMZo482OCdv6I8iMkk
         8sDUuWultMEYJKLB5nTW3Kzd/s/6KePai1Ek8iMYHXhq6IAk0r0f58hwVeyDfjiDtW8m
         fJOJO0aMlN8K+hJMJ24vL/kLSUzIOQccPvj/uigssDA6j6ZEdQq9L6aSRnk41YKSZQT0
         k5wxwJrrbabOIPYwsto4hCERu8bfgEv1tqLoHuiYidZx54biOqwRK9gurOWlqlNAm/BE
         d9PQ4VYbljlkURYzQhZa/z79h/XyXom1wvEZfvgWP9yKaj6im/iPkBPhdRSXSJK3eur7
         xFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sPGQf5GcyOoCA1fXO3cw3uqCuO7zsLcDC/cKwYqWuPM=;
        b=MGVXNRAHsK8nA+VZqSIqLeJThexBSD9U6sxTMAOoanJfwWA7cCO30gsSNpQD4PJBte
         MLnT7inUIWjCaoKMSRNXbIy5kDO3EBjAFmwpjx0udiawDtzgREP+BcQ2udHkyA9R829C
         Sm4QJjBygb2n1R0hTCZZ9O+QMlIrIj9fewjfHTK1WHPfRXJBInztoQOAluqtnUQaQqph
         UCiaw3aU1iT2HX1k3jimU2QOROBOhp0KkG4mYgNxPFs13THAUqo7YLUzJOV1Ia4atSnc
         XGdVtufVz09ZI0F29cir66g5bzgbgXRWRk//cWZIBs6w9OqQDkTx+661CDUWRYmaIzlH
         BDoA==
X-Gm-Message-State: AOAM530qThYA+nvLa7ZpLeuI3BU0LhkcLBxGS/wp7uZbRqTSv2lQ4ViJ
        bLKM6Nbj2DonXEJeNphxpuW4sBZ8CCz2pQ==
X-Google-Smtp-Source: ABdhPJzbAPQiW4zkRywVLqt9HmCXsxpWIysL1f1nI0CYLPimCnBYOjckLCyHD5YeNZtLM6SDUjMOJA==
X-Received: by 2002:a05:600c:114c:: with SMTP id z12mr764582wmz.119.1640146030237;
        Tue, 21 Dec 2021 20:07:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm710484wru.87.2021.12.21.20.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:07:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/9] reflog: reduce scope of "struct rev_info"
Date:   Wed, 22 Dec 2021 05:06:46 +0100
Message-Id: <patch-v3-7.9-b3a62b9b177-20211222T040557Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "cmd.stalefix" handling added in 1389d9ddaa6 (reflog expire
--fix-stale, 2007-01-06) to use a locally scoped "struct
rev_info". This code relies on mark_reachable_objects() twiddling
flags in the walked objects.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index fe0bd353829..4ff63846058 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -28,7 +28,6 @@ static timestamp_t default_reflog_expire;
 static timestamp_t default_reflog_expire_unreachable;
 
 struct cmd_reflog_expire_cb {
-	struct rev_info revs;
 	int stalefix;
 	timestamp_t expire_total;
 	timestamp_t expire_unreachable;
@@ -594,13 +593,15 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	 * from reflog if the repository was pruned with older git.
 	 */
 	if (cmd.stalefix) {
-		repo_init_revisions(the_repository, &cmd.revs, prefix);
-		cmd.revs.do_not_die_on_missing_tree = 1;
-		cmd.revs.ignore_missing = 1;
-		cmd.revs.ignore_missing_links = 1;
+		struct rev_info revs;
+
+		repo_init_revisions(the_repository, &revs, prefix);
+		revs.do_not_die_on_missing_tree = 1;
+		revs.ignore_missing = 1;
+		revs.ignore_missing_links = 1;
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf(_("Marking reachable objects..."));
-		mark_reachable_objects(&cmd.revs, 0, 0, NULL);
+		mark_reachable_objects(&revs, 0, 0, NULL);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			putchar('\n');
 	}
-- 
2.34.1.1146.gb52885e7c44

