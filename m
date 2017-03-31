Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02D01FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 23:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754922AbdCaXRo (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 19:17:44 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34302 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754693AbdCaXRm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 19:17:42 -0400
Received: by mail-pg0-f52.google.com with SMTP id 21so83857225pgg.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 16:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9+DnKLSLDQqxXH1jpYuGNu254peeGVH0EXa7eSXLm10=;
        b=lTVUfaPKuwpvXJgL5ML/cxjJVmHHuPFT2+DG6RhHqHsrGxAHqZYwKwCoRFDBbwdDMx
         PRQXlG8Dcy1q+lznxJS5GGAmS1TfMHnFldAQ2SrxLFy7XApG1L0u+IOv+s7qLa6zVsRx
         BBRclknK+P5HNBKtbmd9d41AJg+epW653OK2ZmDCPSzEpeN5rrXaLrAwSvdigL4brZhV
         joc0RaywDsHEBSDT6EkrUJ24+lLqtLnQZD7rAwwLP9jEhDiGKEAlmeoTqK5h8Bo6zqZH
         vsj/Q3Kn9GRN2zzbH6QHCRFy4d+sM5RPP67CrpUCpGt/ti4/T8UEiHrpukFUoLMSV4qt
         u5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9+DnKLSLDQqxXH1jpYuGNu254peeGVH0EXa7eSXLm10=;
        b=AkvxYZJFARSw5/4HzrL796MIz230nJ14Mww7Dc8qW0aGQYCqGiXp48trLAEuVnL1FY
         tsBRJR1q4MdDJmUuNf+CGdXKaQxQEOX9XxAvLaYoSalqlnuqtIQ8j2AyW4VdVUBUtCBu
         BScipuY0ZkFENi85s4WO0/zDnjlvWfPxg0fIBcb2Cq+KfYoLLkDtkF4owpqmnppIpg3N
         Bl/bfFZcG1rRL7e1D/3SfmuOoOXyDslJkNySzzejfMwzIf4ECCLUiagzPL8aL3OvkBXO
         CImK4q0a63fTWglQIMPO30qJCK6vZ/zAfXpshQTVpEwUVAanh2bmaRObzaxDAe6fbJ9M
         bFbA==
X-Gm-Message-State: AFeK/H2oFOsOCgkH8jQeq+93rkCyW5DnWJq44A0XvD6ubfVCVWSIYWMnFrk9FioaM8bNfpQm
X-Received: by 10.99.101.197 with SMTP id z188mr5320893pgb.164.1491002262092;
        Fri, 31 Mar 2017 16:17:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:240e:6326:bc58:48a9])
        by smtp.gmail.com with ESMTPSA id c19sm12436780pfd.85.2017.03.31.16.17.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 16:17:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jacob.keller@gmail.com
Cc:     git@vger.kernel.org, daveparrish@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] diff: recurse into nested submodules for inline diff
Date:   Fri, 31 Mar 2017 16:17:33 -0700
Message-Id: <20170331231733.11123-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.576.g7be6e4ba40.dirty
In-Reply-To: <20170331231733.11123-1-sbeller@google.com>
References: <20170331231733.11123-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fd47ae6a5b (diff: teach diff to display submodule difference with an
inline diff, 2016-08-31) was introduced, we did not think of recursing
into nested submodules.

When showing the inline diff for submodules, automatically recurse
into nested submodules as well with inline submodule diffs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                                  |  3 +-
 t/t4060-diff-submodule-option-diff-format.sh | 41 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index d84109908f..471ca9ce7d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -553,7 +553,8 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 	cp.no_stdin = 1;
 
 	/* TODO: other options may need to be passed here. */
-	argv_array_push(&cp.args, "diff");
+	argv_array_pushl(&cp.args, "diff", "--submodule=diff", NULL);
+
 	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index d4a3ffa69c..33ec26d755 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -775,4 +775,45 @@ test_expect_success 'diff --submodule=diff with moved nested submodule HEAD' '
 	test_cmp expected actual
 '
 
+test_expect_success 'diff --submodule=diff recurses into nested submodules' '
+	cat >expected <<-EOF &&
+	Submodule sm2 contains modified content
+	Submodule sm2 a5a65c9..280969a:
+	diff --git a/sm2/.gitmodules b/sm2/.gitmodules
+	new file mode 100644
+	index 0000000..3a816b8
+	--- /dev/null
+	+++ b/sm2/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "nested"]
+	+	path = nested
+	+	url = ../sm2
+	Submodule nested 0000000...b55928c (new submodule)
+	diff --git a/sm2/nested/file b/sm2/nested/file
+	new file mode 100644
+	index 0000000..ca281f5
+	--- /dev/null
+	+++ b/sm2/nested/file
+	@@ -0,0 +1 @@
+	+nested content
+	diff --git a/sm2/nested/foo8 b/sm2/nested/foo8
+	new file mode 100644
+	index 0000000..db9916b
+	--- /dev/null
+	+++ b/sm2/nested/foo8
+	@@ -0,0 +1 @@
+	+foo8
+	diff --git a/sm2/nested/foo9 b/sm2/nested/foo9
+	new file mode 100644
+	index 0000000..9c3b4f6
+	--- /dev/null
+	+++ b/sm2/nested/foo9
+	@@ -0,0 +1 @@
+	+foo9
+	EOF
+	git diff --submodule=diff >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.12.2.576.g7be6e4ba40.dirty

