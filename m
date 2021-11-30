Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E76C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbhK3VmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344243AbhK3Vlq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:41:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA9EC061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:25 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a18so47527256wrn.6
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pkf+nc9XahHl9Y5dnd/ZB1xwGfmKuGHguq7KqyfZxWM=;
        b=kYgg1sTas0YZesEo+U5CB2xWI237Hu7JhL1EoMVeuePdO9j3DFCWmyoXGCygyk1dx+
         C2bzYKfdpPiqaTrghxU08KqxpABn/eUdfIHXwDUkCWvVeyOgwIhHuWcBabPjOw3/u5LL
         FDMwG/XBqBrXxOdWhpYbtFRT3KUfVUbskREFrjNGvFT7ppkXmptP6XUSSq3fhYMEwSqx
         4UsDH1WyWB2VbqNjU01cX04rnpUsPEQNHnkH02LVO+REsRrtVpxA05knjbCJrblsjleY
         BWkd71UczA+PEVdsOzkwLcjFYpp0bBZ1jDDfalSFYB1zsUp3tirt2BdYpX/93BzeUXJI
         OZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pkf+nc9XahHl9Y5dnd/ZB1xwGfmKuGHguq7KqyfZxWM=;
        b=1VybovDX2AIomPf7zpcyc5ymfzX2VuMG911/PN6IqmY0oZt6E1E+CuvzduvqBCnQtc
         rFQ5GSG4zg9WBybsJ3MaiuRk5M4dpXnfAAsSRNEHINORJRELnPzMqzcrZpZVAEP4Qy7H
         /9Xv5rfTqoqVSekmIB9nx60Q0GNAuDrIpcG/cqjk6BhvLjNUqmS6+3k5CXAdcyPSWS0c
         69TC85ODuyyF1EeI9WrYOtNesxDnb5PLL4G/9EkTuLlxgvkv+z7+eA97SDOgmxkWURYK
         TIljwyzzxZXkbNdab84/L2LvheDuTj0BOpZIg9I2kaQ2FqWMGU/7O+Ab9YX6HgBLliWH
         Z4zQ==
X-Gm-Message-State: AOAM530YpQ05bpIhgn5L6iCrdqYNA5g9K1os0izTPmslJWYUl5Q+D2x+
        fnz4jEwvxJXuEqH13B7bwjK+C19UqrzDEA==
X-Google-Smtp-Source: ABdhPJz+JbMMRM5mWWvjatj5HAQUimGlEbqfiHMefmOgHrrjkzXAP2ZgifgPltvCVMfxMFc+ZD31nQ==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr1787204wrp.37.1638308304007;
        Tue, 30 Nov 2021 13:38:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:38:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/12] reflog: reduce scope of "struct rev_info"
Date:   Tue, 30 Nov 2021 22:38:09 +0100
Message-Id: <patch-07.12-3aab4a4a436-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
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
index 29dcd91abca..48e4f5887b0 100644
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
2.34.1.877.g7d5b0a3b8a6

