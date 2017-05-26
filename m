Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D374B1FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944641AbdEZTL3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:11:29 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32828 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938049AbdEZTK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:10:29 -0400
Received: by mail-pf0-f173.google.com with SMTP id e193so19465879pfh.0
        for <git@vger.kernel.org>; Fri, 26 May 2017 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eIhVTqLHbbtH9D2mlkcEVvZPrvJGxCkEa0AtH4kb//A=;
        b=qtDOgSysqAnBh6rGX3o4K9XNYCJhp4QzQIf/dguOXvFgjlh+9LmO045uDGrUGY8kQL
         6JAM2JtoHSyf6EQs4606B8R6O2jFB2q2c73Ml90QEtIFuMK1FQeIXE6EyVPCaWaB2se6
         nhg02xJ+gPSF6Gz+W94ZhLHbgKCdJv14g2gE+OdoBD5/4cP35okMyI7cBetY73zXY9OG
         dila0HE1RErtF/AmY66qWIITbBIsm2xkuD3VMuXSvVLWZKFyKExAVEs1/Tp22ueOPRyl
         PtSIhPGEHF060w4ZWFRSOmXWr6L8em+/4AdaEd0h/UxoTOS5e9cgjf6g9skRnhJjTgRZ
         y9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eIhVTqLHbbtH9D2mlkcEVvZPrvJGxCkEa0AtH4kb//A=;
        b=PNZ+Z0fwF2ehUft/ifegWazgUjkcSc3ivGcG5MeL/qOEqTDe8ZYQL+pYSU15psCRGf
         NVT5Sjgqf5GdO66680apV5alKckY6sbYGBY4fUt+2yUkRSnKePOmSw6Vd7uCBiGb2hcG
         XABltXP2LMaTDLgWv63aMJI61mV53xCVuCfyMFOB3Vm1rMqoCjYZCjRF23sL2N+2UAQ1
         fT0orjDS8fMwjx5BrBcBemZbc5k7xEMxt476kWg/1ma3v3e90xkOeo0UAT0CyMTT3436
         AEjlDe3d7p/JrxeVe1V6pxkXJDk3hDZGOqCZhEs4O2ua+W/D1k9LqMFFt5leQEsgkbs4
         OzCQ==
X-Gm-Message-State: AODbwcA32nm9pGZ8EEBVDcvbsVdrpozFMXtgQDB4ZrjEcGsM65truic4
        g6bKq8IXeHou2xEg
X-Received: by 10.84.130.67 with SMTP id 61mr60210032plc.150.1495825823648;
        Fri, 26 May 2017 12:10:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:818a:1f3a:57c6:8d29])
        by smtp.gmail.com with ESMTPSA id l16sm2504200pgu.45.2017.05.26.12.10.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 12:10:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/8] submodule test invocation: only pass additional arguments
Date:   Fri, 26 May 2017 12:10:11 -0700
Message-Id: <20170526191017.19155-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.g582985b1e4
In-Reply-To: <20170526191017.19155-1-sbeller@google.com>
References: <20170526191017.19155-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to introduce a config option to trigger the
submodule recursing by default. As this option should be available and
uniform across all commands that deal with submodules we'd want to test
for this option in the submodule update library.

So instead of calling the whole test set again for
"git -c submodule.recurse foo" instead of "git foo --recurse-submodules",
we'd only want to introduce one basic test that tests if the option is
recognized and respected to not overload the test suite.

Change the test functions by taking only the argument and assemble the
command inside the test function by embedding the arguments into the
command that is "git $arguments --recurse-submodules".

It would be nice to do this for all functions in lib-submodule-update,
but we cannot do that for the non-recursing tests, as there we do not
just pass in a git command but whole functions. (See t3426 for example)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh      | 10 ++++++----
 t/t1013-read-tree-submodule.sh |  4 ++--
 t/t2013-checkout-submodule.sh  |  4 ++--
 t/t7112-reset-submodule.sh     |  4 ++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index f0b1b18206..0272c4d8ca 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -781,8 +781,9 @@ test_submodule_forced_switch () {
 # - Removing a submodule with a git directory absorbs the submodules
 #   git directory first into the superproject.
 
-test_submodule_switch_recursing () {
-	command="$1"
+test_submodule_switch_recursing_with_args () {
+	cmd_args="$1"
+	command="git $cmd_args --recurse-submodules"
 	RESULTDS=success
 	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
 	then
@@ -1021,8 +1022,9 @@ test_submodule_switch_recursing () {
 # Test that submodule contents are updated when switching between commits
 # that change a submodule, but throwing away local changes in
 # the superproject as well as the submodule is allowed.
-test_submodule_forced_switch_recursing () {
-	command="$1"
+test_submodule_forced_switch_recursing_with_args () {
+	cmd_args="$1"
+	command="git $cmd_args --recurse-submodules"
 	RESULT=success
 	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
 	then
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index de1ba02dc5..2c8d620324 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -9,9 +9,9 @@ KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
-test_submodule_switch_recursing "git read-tree --recurse-submodules -u -m"
+test_submodule_switch_recursing_with_args "read-tree -u -m"
 
-test_submodule_forced_switch_recursing "git read-tree --recurse-submodules -u --reset"
+test_submodule_forced_switch_recursing_with_args "read-tree -u --reset"
 
 test_submodule_switch "git read-tree -u -m"
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index e8f70b806f..c962a02277 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -65,9 +65,9 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
-test_submodule_switch_recursing "git checkout --recurse-submodules"
+test_submodule_switch_recursing_with_args "checkout"
 
-test_submodule_forced_switch_recursing "git checkout -f --recurse-submodules"
+test_submodule_forced_switch_recursing_with_args "checkout -f"
 
 test_submodule_switch "git checkout"
 
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index f86ccdf215..a1cb9ff858 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -9,9 +9,9 @@ KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
-test_submodule_switch_recursing "git reset --recurse-submodules --keep"
+test_submodule_switch_recursing_with_args "reset --keep"
 
-test_submodule_forced_switch_recursing "git reset --hard --recurse-submodules"
+test_submodule_forced_switch_recursing_with_args "reset --hard"
 
 test_submodule_switch "git reset --keep"
 
-- 
2.13.0.17.g582985b1e4

