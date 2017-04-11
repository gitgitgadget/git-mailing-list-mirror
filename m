Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963E320970
	for <e@80x24.org>; Tue, 11 Apr 2017 23:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753653AbdDKXt6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 19:49:58 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36253 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753419AbdDKXtv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 19:49:51 -0400
Received: by mail-pf0-f174.google.com with SMTP id o126so5333027pfb.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 16:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P45uLXvDcYVbQiqAjfU4Rhiz3C55+xIiGtIzGlVNIBE=;
        b=pvbME88eaGByi09oiLIxTgb6M/EVdjrGtX0uZ8pTmYTuci4ytZi0MlIen+Xhn5JH4L
         RpwapFv30EMfj6Y2adwd25pw710ksHR05ZHhsAwxwJ+QT2qfLBut24g3yDrgiGU/ocPt
         TmgdfcKKgnxHegumws0Rh+apETYMtyqvfoGqCPUYCy86T+0FdunyhORivjaSOLPNMjN9
         18fewzNsVjDKiZXLecG9ZhFxIvuoRlyz2VAeTVbduzwz8hgzLPAMEcPXJnzSMp29Zh7q
         S/5Myq0jVP/FyOwR54QlElTvBybIiM0GnJOMK37halr3RPfDiG6XOZmCuc40jbzlnUeb
         dCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P45uLXvDcYVbQiqAjfU4Rhiz3C55+xIiGtIzGlVNIBE=;
        b=CcGxudNHgjowORjNdqdcMhY4KPkj4eblWxqg1w+jViTbk5eiZkgx+EUJVe/KjrTHT+
         tJ0wU67YF420nIW3NueYSjetmJuDYQxu0c/HQsBm8HuyDsHbvJqw3LTg1LiwosZj32rM
         M3CgDjR2Bcj54IgyfxNTHzaZPwApZZmx2GCGF/Et1StTPXPvVZmCiLSQ4/UGJ3Qmbs3A
         b8AnAHQhhgUi9Ig/kQKljfbf5fsHtfRSNVxci+Iaeb+U+S16StoJ/6SJshQnMSzRGNSt
         4p0KNGSqWn3Tcyc4qQ/gb6gQ/er9/LKm2bawUZP/iHaqe0TEgtO/dRqxrnnYXwUeKJgC
         neWg==
X-Gm-Message-State: AFeK/H313XHo9v4pzoJWPPz/evb8j+3ztAucbhhxQRkLXDtw/Kx60VZSzySQilKPQaQjNLFw
X-Received: by 10.99.135.193 with SMTP id i184mr63460110pge.120.1491954590405;
        Tue, 11 Apr 2017 16:49:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:118b:650f:9c66:86dd])
        by smtp.gmail.com with ESMTPSA id f24sm13766804pfk.88.2017.04.11.16.49.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 16:49:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] submodule.c: harden submodule_move_head against broken submodules
Date:   Tue, 11 Apr 2017 16:49:22 -0700
Message-Id: <20170411234923.1860-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.603.g7b28dc31ba
In-Reply-To: <20170411234923.1860-1-sbeller@google.com>
References: <20170411234923.1860-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Early on in submodule_move_head just after the check if the submodule is
initialized, we need to check if the submodule is populated correctly.

If the submodule is initialized but doesn't look like populated, this
is a red flag and can indicate multiple sorts of failures:
(1) The submodule may be recorded at an object name, that is missing.
(2) The submodule '.git' file link may be broken and it is not pointing
    at a repository.

In both cases we want to complain to the user in the non-forced mode,
and in the forced mode ignoring the old state and just moving the
submodule into its new state with a fixed '.git' file link.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               | 17 +++++++++++++++++
 t/lib-submodule-update.sh | 23 ++++++++++++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 2fa42519a4..dda1ead854 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1331,10 +1331,19 @@ int submodule_move_head(const char *path,
 	int ret = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const struct submodule *sub;
+	int *errorcode, error_code;
 
 	if (!is_submodule_initialized(path))
 		return 0;
 
+	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
+		errorcode = &error_code;
+	else
+		errorcode = NULL;
+
+	if (old && !is_submodule_populated_gently(path, errorcode))
+		return 0;
+
 	sub = submodule_from_path(null_sha1, path);
 
 	if (!sub)
@@ -1361,6 +1370,14 @@ int submodule_move_head(const char *path,
 			/* make sure the index is clean as well */
 			submodule_reset_index(path);
 		}
+
+		if (old && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, "%s/modules/%s",
+				    get_git_common_dir(), sub->name);
+			connect_work_tree_and_git_dir(path, sb.buf);
+			strbuf_release(&sb);
+		}
 	}
 
 	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 22dd9e060c..f0b1b18206 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -1213,14 +1213,31 @@ test_submodule_forced_switch_recursing () {
 		)
 	'
 	# Updating a submodule from an invalid sha1 updates
-	test_expect_success "$command: modified submodule does not update submodule work tree from invalid commit" '
+	test_expect_success "$command: modified submodule does update submodule work tree from invalid commit" '
 		prolog &&
 		reset_work_tree_to_interested invalid_sub1 &&
 		(
 			cd submodule_update &&
 			git branch -t valid_sub1 origin/valid_sub1 &&
-			test_must_fail $command valid_sub1 &&
-			test_superproject_content origin/invalid_sub1
+			$command valid_sub1 &&
+			test_superproject_content origin/valid_sub1 &&
+			test_submodule_content sub1 origin/valid_sub1
+		)
+	'
+
+	# Old versions of Git were buggy writing the .git link file
+	# (e.g. before f8eaa0ba98b and then moving the superproject repo
+	# whose submodules contained absolute paths)
+	test_expect_success "$command: updating submodules fixes .git links" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			echo "gitdir: bogus/path" >sub1/.git &&
+			$command modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1
 		)
 	'
 }
-- 
2.12.2.603.g7b28dc31ba

