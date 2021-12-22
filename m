Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E70C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242220AbhLVEHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbhLVEHK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:07:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDDAC061401
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:10 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t26so2094911wrb.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0C3CZ2NUK1+YuLd2rn0jDbaNvQhELPtIiuGFdUPm35g=;
        b=it0+EuDOZnPX8SAXc+aAAwXcOCYZD/97iahLNbWzNs5DYzHob0rHGNvsDC9hZ0fN+L
         9J7qGPNJMZa23ldTp32gXPXCrTORx2vg7Bhyg1KtsNf972VUbxVU8708s3hsHFVZXsWA
         iKwhBoh9sNu7hAw+218+Vbx2dobP2/Q5/XdGgfR5QdbxzlUWIfIKOHN3YzWNKQQ7aDOQ
         npmxCSMCKu4WOXqiT8tqxQYU/9VXzFanFVgZ7Lp/HuEwF732SogjnEi+sgwLpxSTrKZy
         6sBPLHKZGvEcO0iMxffXMaQwFXYiWdRySdPsNhPweBRtJS1bvxZOyhUiyDoGep+0EG3z
         r9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0C3CZ2NUK1+YuLd2rn0jDbaNvQhELPtIiuGFdUPm35g=;
        b=2ndExJJhi4gA8Bl6m2ztHayDnKUA7MrWhE7Mdtvnpv/ogSVCyQfW/v0Ru7rj1F17Kc
         PAjJHYuEMRj4upkibA5y7ReXkT+78iXRxPUHnG6JQtqjsbV3NmxGx2W8CTRQ6DObOvYl
         /M5zovqFgji+nhAsqxaxlyPclPIjbqe/cNJN+hJQviDS2RGqF8tQjC0X2mHekiLdp9it
         787jAGpaKd9Y4YnNI0k/kEeqiD5BlVB3tAF1WoUjczpIjbVaQuQU3TwMhyG//qrLUFaG
         V0xwhqSNBrv2Lc6hAazJgKqEhRNYbbFoYq/SbV13pGWXaya+dW6su/E4SSfaeCTMdrm3
         kUvA==
X-Gm-Message-State: AOAM532R7D1IsGujbA3OLnCLEbG35WW8cMuD/HbdKlghOtp93LW71t2z
        H4Kz3Ef7A5nC9bdf5j7VWPf/eqxbrYKmfA==
X-Google-Smtp-Source: ABdhPJytuvVi497zlcS4qnVCwQP9f+Yfc4J/RfwvivRNY77r+tnd+SOL4+pBCL8qYM8vMVdQeseIpQ==
X-Received: by 2002:a5d:64e1:: with SMTP id g1mr705548wri.403.1640146028658;
        Tue, 21 Dec 2021 20:07:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm710484wru.87.2021.12.21.20.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:07:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/9] reflog expire: refactor & use "tip_commit" only for UE_NORMAL
Date:   Wed, 22 Dec 2021 05:06:44 +0100
Message-Id: <patch-v3-5.9-896ae9f73eb-20211222T040557Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
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
into a one-line ternary instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 8d05660e644..f18a63751f3 100644
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
2.34.1.1146.gb52885e7c44

