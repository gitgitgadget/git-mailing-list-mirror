Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3CA1201A7
	for <e@80x24.org>; Wed, 17 May 2017 21:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754376AbdEQVbt (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 17:31:49 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36004 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbdEQVbr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 17:31:47 -0400
Received: by mail-pf0-f173.google.com with SMTP id m17so13348266pfg.3
        for <git@vger.kernel.org>; Wed, 17 May 2017 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2EK1Bz4RaPqZjiOMBGAVLeyDpa3Urev92SpI5QXQUaA=;
        b=D77runcjG0YYI9YPn80D9BYHt39Ymu0QvHwxQ3/rCAp8Kkcm/oLk46/DVMAmrwBYWY
         E3kbjPrI6l52/FZUhhdRiFAOuEJuQN8TGhwqgcgx8ows41188dcyybWnvgJs3N2aMwHq
         eaDDWKZMAeg2ALWdRIbgVX18c2TyJUbR+3NI9pk1RCh2eaHjvK93mi2D9p2VNV7qW8kH
         8pqkpYZ43fhPf5fZ0QuLulUiV3PKGACrpwfcKqsHAcCc0miDDHcr9P+0TtP3o73qHiHS
         x2DypNCjX3Ef2nG6FXPOX+02olr71Gl+aPKEsOgEatll/EmutUARV9WTideFxTOX8fYG
         L6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2EK1Bz4RaPqZjiOMBGAVLeyDpa3Urev92SpI5QXQUaA=;
        b=NwuDWrEWTjs51bpnlESZzZZb5sPaRkYuAOPDQsoq2hnTKd9cdVTqEmm6vHmYlr47v7
         TMhoXRI4NqQmDK0pLcEKHAuOqOi2uFqLRTETnFR7uBTJ7pov2hhBwHWAEXPuvobdbcMw
         tJiLt0YVRcS9t32XjogEiFp2sQLQrDFZ2y8LaNcTq1G8b/ECmoQIi7fC/P68rMU112Fz
         eGDjUQxBR8dbCDMpdvnFfj0v0VeZs4mzJyLT/E7DsFYHnuTUa7FC3C9t8pgzpjq8O17k
         fYqxJVW3HoFoF9K4b9kse29qfukrCi03vWHY4zj6XswHYLYyOVG1rPsHohnp2yYGCD4e
         DnGw==
X-Gm-Message-State: AODbwcBwcbnCfLInCTxwkPT6FVzQsPvuYgW3f7gP1YeKCJKQSvNCmDH/
        0QPaf1bDq4mDR0hnpROyvg==
X-Received: by 10.84.231.16 with SMTP id f16mr934707plk.20.1495056706977;
        Wed, 17 May 2017 14:31:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:f5dc:a4cd:fb33:e862])
        by smtp.gmail.com with ESMTPSA id i67sm5893793pfk.87.2017.05.17.14.31.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 14:31:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] submodule test invocation: only pass additional arguments
Date:   Wed, 17 May 2017 14:31:34 -0700
Message-Id: <20170517213135.20988-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517213135.20988-1-sbeller@google.com>
References: <20170517213135.20988-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to test a command without the
'--recurse-submodules' given, but instead we'd give a '-c <option>.

To enable that we'll just pass the minimum required to the submodule
testing, such that we can construct the command with the option easier.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh      | 6 ++++--
 t/t1013-read-tree-submodule.sh | 4 ++--
 t/t2013-checkout-submodule.sh  | 4 ++--
 t/t7112-reset-submodule.sh     | 4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index f0b1b18206..0f70b5ec7b 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -782,7 +782,8 @@ test_submodule_forced_switch () {
 #   git directory first into the superproject.
 
 test_submodule_switch_recursing () {
-	command="$1"
+	cmd_args="$1"
+	command="git $cmd_args --recurse-submodules"
 	RESULTDS=success
 	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
 	then
@@ -1022,7 +1023,8 @@ test_submodule_switch_recursing () {
 # that change a submodule, but throwing away local changes in
 # the superproject as well as the submodule is allowed.
 test_submodule_forced_switch_recursing () {
-	command="$1"
+	cmd_args="$1"
+	command="git $cmd_args --recurse-submodules"
 	RESULT=success
 	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
 	then
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index de1ba02dc5..a779e6917c 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -9,9 +9,9 @@ KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
-test_submodule_switch_recursing "git read-tree --recurse-submodules -u -m"
+test_submodule_switch_recursing "read-tree -u -m"
 
-test_submodule_forced_switch_recursing "git read-tree --recurse-submodules -u --reset"
+test_submodule_forced_switch_recursing "read-tree -u --reset"
 
 test_submodule_switch "git read-tree -u -m"
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index e8f70b806f..2672f104cf 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -65,9 +65,9 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
-test_submodule_switch_recursing "git checkout --recurse-submodules"
+test_submodule_switch_recursing "checkout"
 
-test_submodule_forced_switch_recursing "git checkout -f --recurse-submodules"
+test_submodule_forced_switch_recursing "checkout -f"
 
 test_submodule_switch "git checkout"
 
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index f86ccdf215..a000304221 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -9,9 +9,9 @@ KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
-test_submodule_switch_recursing "git reset --recurse-submodules --keep"
+test_submodule_switch_recursing "reset --keep"
 
-test_submodule_forced_switch_recursing "git reset --hard --recurse-submodules"
+test_submodule_forced_switch_recursing "reset --hard"
 
 test_submodule_switch "git reset --keep"
 
-- 
2.13.0.18.g7d86cc8ba0

