Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D97211FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 23:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754916AbdCaXRn (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 19:17:43 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34298 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbdCaXRl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 19:17:41 -0400
Received: by mail-pg0-f42.google.com with SMTP id 21so83856951pgg.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 16:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NFrFrqr3COLFM3eIk6DucZiLarG/BOvVDrqDY5zbdUM=;
        b=TEhId3rAf4M2rP0imc4zfM0cvojs49Z/2lDTDZDr6wwVSplMKUtFZdwfAUvpb0+rq9
         Sw/YNoMM8n6NB05Oj5U2kkcdoQ0LUSbCfqxd5O9WWi+RJQSnhnQITj1QLnJl1z+OXXrT
         4I47j+7k4ZqT9BwXUXUkGd/jAcbhJXGE7OMIJAadBfNhNsrQVuZpGk0owKSOQAUmTlL3
         jOV5Hry4FjjhHXEgvaLsiWVCaHR2ZfMuKWGnnPLz+bGk6pvILC5dXB0pTczslRZGbWVC
         qnz2JKirULJ5itcQEZ77gq8DsqfQKxZWB9xY6IP5mRSgzhAeM9NK0UMEz+xnaNobwaot
         qROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NFrFrqr3COLFM3eIk6DucZiLarG/BOvVDrqDY5zbdUM=;
        b=UmceTgzXzD4yxznCc3255cXAUODJGNQNTDZBr07iGYTkTdv7FKI/t5lKkqPpSJsahr
         J2XSfm3sJSbz0kWH0ELExl6g57aKNvMfx8E7+rblAIMiccJCa/rmnYQkIIibEH0DR6ma
         uGzxzzWkL6H/a6qJ/nFDqOrRz6iI8Mnm2/mDLmvWQXieFH7FmmsR5ptYVoLKNrjTOMYV
         tqJLO/ZBHpu86uZ0hqHwG422Fbo+bMLLzJoa+6GrnfaTxrrxvi5lkdvkXZNiLqHPE5KT
         iuOdCXgr9tJrUMajQs3i4vLd4Mz/ut+xjZ2cuayjIypGY3Cd9Jl5FezC8c8qeb8gTBxj
         in4g==
X-Gm-Message-State: AFeK/H3QB9dxZEGA3fXT+Et0FIg40haHAfdBxZVTuu7DJ4HMCspR0HdpASsMnnUHVO34L0kr
X-Received: by 10.84.213.144 with SMTP id g16mr5814748pli.28.1491002261005;
        Fri, 31 Mar 2017 16:17:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:240e:6326:bc58:48a9])
        by smtp.gmail.com with ESMTPSA id m69sm12427281pfc.33.2017.03.31.16.17.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 16:17:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jacob.keller@gmail.com
Cc:     git@vger.kernel.org, daveparrish@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] diff: submodule inline diff to initialize env array.
Date:   Fri, 31 Mar 2017 16:17:32 -0700
Message-Id: <20170331231733.11123-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.576.g7be6e4ba40.dirty
In-Reply-To: <20170331231733.11123-1-sbeller@google.com>
References: <20170331231733.11123-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David reported:
> When I try to run `git diff --submodule=diff` in a submodule which has
> it's own submodules that have changes I get the error: fatal: bad
> object.

This happens, because we do not properly initialize the environment
in which the diff is run in the submodule. That means we inherit the
environment from the main process, which sets environment variables.
(Apparently we do set environment variables which we do not set
when not in a submodules, i.e. the .git directory is linked)

This commit, just like fd47ae6a5b (diff: teach diff to display
submodule difference with an inline diff, 2016-08-31) introduces bad
test code (i.e. hard coded hash values), which will be cleanup up in
a later patch.

Reported-by: David Parrish <daveparrish@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                                  |  1 +
 t/t4060-diff-submodule-option-diff-format.sh | 29 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/submodule.c b/submodule.c
index c52d6634c5..d84109908f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -576,6 +576,7 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 	if (!(dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
 		argv_array_push(&cp.args, oid_to_hex(new));
 
+	prepare_submodule_repo_env(&cp.env_array);
 	if (run_command(&cp))
 		fprintf(f, "(diff failed)\n");
 
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 7e23b55ea4..d4a3ffa69c 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -746,4 +746,33 @@ test_expect_success 'diff --submodule=diff with .git file' '
 	test_cmp expected actual
 '
 
+test_expect_success 'setup nested submodule' '
+	git submodule add -f ./sm2 &&
+	git commit -a -m "add sm2" &&
+	git -C sm2 submodule add ../sm2 nested &&
+	git -C sm2 commit -a -m "nested sub"
+'
+
+test_expect_success 'move nested submodule HEAD' '
+	echo "nested content" >sm2/nested/file &&
+	git -C sm2/nested add file &&
+	git -C sm2/nested commit --allow-empty -m "new HEAD"
+'
+
+test_expect_success 'diff --submodule=diff with moved nested submodule HEAD' '
+	cat >expected <<-EOF &&
+	Submodule nested a5a65c9..b55928c:
+	diff --git a/nested/file b/nested/file
+	new file mode 100644
+	index 0000000..ca281f5
+	--- /dev/null
+	+++ b/nested/file
+	@@ -0,0 +1 @@
+	+nested content
+	EOF
+	git -C sm2 diff --submodule=diff >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.12.2.576.g7be6e4ba40.dirty

