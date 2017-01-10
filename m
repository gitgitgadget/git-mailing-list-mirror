Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33F720756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdAJUnT (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:43:19 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34882 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdAJUmn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:43 -0500
Received: by mail-qt0-f172.google.com with SMTP id x49so111084431qtc.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5SD2/XAv3AQElvd4Otn+v9Sy7tKwfkAXD+0dPUPSHWg=;
        b=udsaRiYvggyYsTPw9VlC7bkS1QJe903pe5AUj0Ot3NIHK1WAM1r04wx5asV+x+fI5z
         QSmruYSNGAHOrESP+4tbcYq1gPk/lpmRa3V1kFa4XOfM+P7bomFQVEA5X5Crx5zmPlCK
         F8twNme24VMcSPFUqOm0hgMwQOpnkw5PtHxgNRQ8LM8lqG8Rue8cOxyWOxTQiY1Vhtl4
         UPHVHv/KLOzVMw8EN3mIRrEEaXsGXVi4Nk9Zaeqh5G1S0uPd6vT26JHe6AA44jopSKgC
         lfsaqr6uv9xReAzLzurI4bXdFWtXndAbotPmndHMHrbwwIkBtQN1VJ9honnyUUJRHDJD
         o31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5SD2/XAv3AQElvd4Otn+v9Sy7tKwfkAXD+0dPUPSHWg=;
        b=S1rCDf0VAJ7TzTUE3mx+8jeq7//yxDQmIWEn52dakk0D+PZq7334o8e+OfPkskIEzm
         HLlanTjsD2dI+ubfRP/8oD4GUECfm8BNeOLnU7L842gMQNdIi9JkIkiaNRSB52zyJ9fP
         wPjDjweT7hI87bCbGH2t2y3I52q+Kt28oShWub0vUUHGHd4hxSU05zwGTm4JyOHDV2n9
         p381tAadcVe2D0mvtul+A2fzdfEvQIWfTkYolb14A0B0T+MpipUtipGjC9LbdCQ3U5LQ
         cbSw03PggtOz9wPHmINFEPVRXIyXJUKwRdGeQtps8gw36MBoT+WWRmssh83n2fjKhQpR
         urBg==
X-Gm-Message-State: AIkVDXLB699XGbB30vEY7AI7jbXPcPD9Nq+dJuumzD0t8w97DWkncUWaPztRGaTIZln7vNsa
X-Received: by 10.200.49.41 with SMTP id g38mr4541132qtb.175.1484080962625;
        Tue, 10 Jan 2017 12:42:42 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:42 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 05/14] t7610: use test_when_finished for cleanup tasks
Date:   Tue, 10 Jan 2017 15:41:53 -0500
Message-Id: <20170110204202.21779-6-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a step toward making the tests more independent so that if one
test fails it doesn't cause subsequent tests to fail.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 71 +++++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 550838a1c..f62ceffdc 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -145,6 +145,11 @@ test_expect_success 'custom mergetool' '
 '
 
 test_expect_success 'mergetool crlf' '
+	test_when_finished "git reset --hard" &&
+	# This test_config line must go after the above reset line so that
+	# core.autocrlf is unconfigured before reset runs.  (The
+	# test_config command uses test_when_finished internally and
+	# test_when_finished is LIFO.)
 	test_config core.autocrlf true &&
 	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
@@ -161,9 +166,7 @@ test_expect_success 'mergetool crlf' '
 	test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
 	git submodule update -N &&
 	test "$(cat submod/bar)" = "master submodule" &&
-	git commit -m "branch1 resolved with mergetool - autocrlf" &&
-	test_config core.autocrlf false &&
-	git reset --hard
+	git commit -m "branch1 resolved with mergetool - autocrlf"
 '
 
 test_expect_success 'mergetool in subdir' '
@@ -194,6 +197,7 @@ test_expect_success 'mergetool on file in parent dir' '
 '
 
 test_expect_success 'mergetool skips autoresolved' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
@@ -202,8 +206,7 @@ test_expect_success 'mergetool skips autoresolved' '
 	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
 	output="$(git mergetool --no-prompt)" &&
-	test "$output" = "No files need merging" &&
-	git reset --hard
+	test "$output" = "No files need merging"
 '
 
 test_expect_success 'mergetool merges all from subdir' '
@@ -223,6 +226,7 @@ test_expect_success 'mergetool merges all from subdir' '
 '
 
 test_expect_success 'mergetool skips resolved paths when rerere is active' '
+	test_when_finished "git reset --hard" &&
 	test_config rerere.enabled true &&
 	rm -rf .git/rr-cache &&
 	git checkout -b test$test_count branch1 &&
@@ -232,8 +236,7 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
 	( yes "d" "d" | git mergetool --no-prompt >/dev/null 2>&1 ) &&
 	git submodule update -N &&
 	output="$(yes "n" | git mergetool --no-prompt)" &&
-	test "$output" = "No files need merging" &&
-	git reset --hard
+	test "$output" = "No files need merging"
 '
 
 test_expect_success 'conflicted stash sets up rerere'  '
@@ -264,6 +267,7 @@ test_expect_success 'conflicted stash sets up rerere'  '
 '
 
 test_expect_success 'mergetool takes partial path' '
+	test_when_finished "git reset --hard" &&
 	git reset --hard &&
 	test_config rerere.enabled false &&
 	git checkout -b test$test_count branch1 &&
@@ -272,11 +276,11 @@ test_expect_success 'mergetool takes partial path' '
 
 	( yes "" | git mergetool subdir ) &&
 
-	test "$(cat subdir/file3)" = "master new sub" &&
-	git reset --hard
+	test "$(cat subdir/file3)" = "master new sub"
 '
 
 test_expect_success 'mergetool delete/delete conflict' '
+	test_when_finished "git reset --hard HEAD" &&
 	git checkout move-to-c &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
@@ -288,29 +292,30 @@ test_expect_success 'mergetool delete/delete conflict' '
 	git reset --hard HEAD &&
 	test_must_fail git merge move-to-b &&
 	! echo a | git mergetool a/a/file.txt &&
-	! test -f a/a/file.txt &&
-	git reset --hard HEAD
+	! test -f a/a/file.txt
 '
 
 test_expect_success 'mergetool produces no errors when keepBackup is used' '
+	test_when_finished "git reset --hard HEAD" &&
 	test_config mergetool.keepBackup true &&
 	test_must_fail git merge move-to-b &&
 	: >expect &&
 	echo d | git mergetool a/a/file.txt 2>actual &&
 	test_cmp expect actual &&
-	! test -d a &&
-	git reset --hard HEAD
+	! test -d a
 '
 
 test_expect_success 'mergetool honors tempfile config for deleted files' '
+	test_when_finished "git reset --hard HEAD" &&
 	test_config mergetool.keepTemporaries false &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
-	! test -d a &&
-	git reset --hard HEAD
+	! test -d a
 '
 
 test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
+	test_when_finished "git reset --hard HEAD" &&
+	test_when_finished "git clean -fdx" &&
 	test_config mergetool.keepTemporaries true &&
 	test_must_fail git merge move-to-b &&
 	! (echo a; echo n) | git mergetool a/a/file.txt &&
@@ -321,12 +326,11 @@ test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 	file_REMOTE_.txt
 	EOF
 	ls -1 a/a | sed -e "s/[0-9]*//g" >actual &&
-	test_cmp expect actual &&
-	git clean -fdx &&
-	git reset --hard HEAD
+	test_cmp expect actual
 '
 
 test_expect_success 'deleted vs modified submodule' '
+	test_when_finished "git reset --hard HEAD" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
@@ -391,8 +395,7 @@ test_expect_success 'deleted vs modified submodule' '
 	test "$(cat submod/bar)" = "master submodule" &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
-	git commit -m "Merge resolved by keeping module" &&
-	git reset --hard HEAD
+	git commit -m "Merge resolved by keeping module"
 '
 
 test_expect_success 'file vs modified submodule' '
@@ -479,6 +482,7 @@ test_expect_success 'submodule in subdirectory' '
 		git commit -m "add initial versions"
 		)
 	) &&
+	test_when_finished "rm -rf subdir/subdir_module" &&
 	git submodule add git://example.com/subsubmodule subdir/subdir_module &&
 	git add subdir/subdir_module &&
 	git commit -m "add submodule in subdirectory" &&
@@ -523,8 +527,7 @@ test_expect_success 'submodule in subdirectory' '
 	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
 	git submodule update -N &&
 	test "$(cat subdir/subdir_module/file15)" = "test$test_count.a" &&
-	git commit -m "branch1 resolved with mergetool" &&
-	rm -rf subdir/subdir_module
+	git commit -m "branch1 resolved with mergetool"
 '
 
 test_expect_success 'directory vs modified submodule' '
@@ -578,34 +581,34 @@ test_expect_success 'directory vs modified submodule' '
 '
 
 test_expect_success 'file with no base' '
+	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
 	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool mybase -- both &&
 	>expected &&
-	test_cmp both expected &&
-	git reset --hard master >/dev/null 2>&1
+	test_cmp both expected
 '
 
 test_expect_success 'custom commands override built-ins' '
+	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	test_config mergetool.defaults.trustExitCode true &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool defaults -- both &&
 	echo master both added >expected &&
-	test_cmp both expected &&
-	git reset --hard master >/dev/null 2>&1
+	test_cmp both expected
 '
 
 test_expect_success 'filenames seen by tools start with ./' '
+	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp false &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
-	grep ^\./both_LOCAL_ actual >/dev/null &&
-	git reset --hard master >/dev/null 2>&1
+	grep ^\./both_LOCAL_ actual >/dev/null
 '
 
 test_lazy_prereq MKTEMP '
@@ -614,6 +617,7 @@ test_lazy_prereq MKTEMP '
 '
 
 test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToTemp' '
+	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp true &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -621,11 +625,11 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
 	test_must_fail grep ^\./both_LOCAL_ actual >/dev/null &&
-	grep /both_LOCAL_ actual >/dev/null &&
-	git reset --hard master >/dev/null 2>&1
+	grep /both_LOCAL_ actual >/dev/null
 '
 
 test_expect_success 'diff.orderFile configuration is honored' '
+	test_when_finished "git reset --hard >/dev/null" &&
 	git checkout order-file-side2 &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -640,10 +644,10 @@ test_expect_success 'diff.orderFile configuration is honored' '
 	EOF
 	git mergetool --no-prompt --tool myecho >output &&
 	git grep --no-index -h -A2 Merging: output >actual &&
-	test_cmp expect actual &&
-	git reset --hard >/dev/null
+	test_cmp expect actual
 '
 test_expect_success 'mergetool -Oorder-file is honored' '
+	test_when_finished "git reset --hard >/dev/null 2>&1" &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
@@ -667,8 +671,7 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	EOF
 	git mergetool -Oorder-file --no-prompt --tool myecho >output &&
 	git grep --no-index -h -A2 Merging: output >actual &&
-	test_cmp expect actual &&
-	git reset --hard >/dev/null 2>&1
+	test_cmp expect actual
 '
 
 test_done
-- 
2.11.0.390.gc69c2f50cf-goog

