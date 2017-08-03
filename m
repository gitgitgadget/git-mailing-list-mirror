Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1E51F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbdHCSU1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:27 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34734 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdHCSUY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:24 -0400
Received: by mail-pf0-f177.google.com with SMTP id o86so9401267pfj.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mjwr/8bxFyIWZNWqtGA0mS85TPaNg02WUptxS6fFVqs=;
        b=j3+mCfY2JdeE0g6g4Qp1/bicH0JeBQEhMrRxdBTPz+SUyJWb8b/hEYAoq8SU5yOlRK
         ctRIq5a9aU8BjwHxpnsM2XTsfxhyfekBziGVAPcW9XFyXWLYplMypaqMth8tnOfm5IXU
         +J7CX/jx5gQRDpDPNCesIjn2dZOjI+6pEGPCAfDBWS0RuDOaFlZgKueFSGExZqkWfV9q
         k4aSdDXy9sQgIU5uvWJe+9tr0/nc6G0UOY7yyLmJKVURN6Z04tYyND4jvXMt8XCj5njQ
         J1UySFXo8nAvMQVnVHaFsqX2dmCahpJPRc/M266EX7xx3VIl5NVjkwdGcOJLmakH/PeT
         IpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mjwr/8bxFyIWZNWqtGA0mS85TPaNg02WUptxS6fFVqs=;
        b=qFdsyqEhKRh3rytjilMsotVye3uW29zXN9RdAnqrXT066vC0LBqKd++Acg/Ya3XivW
         +2DX9HpwCAHXp7wNUVLM6Dm207pHeeOLjxg/cih03JDPoie4pWMafRj7tAktsnbpgnhm
         +Iin/QVvZgGnAFsVf/KCBHQgrGpFC64L5d/ZXYiKhzlMt+uDLMB9xho0+/jk2dTJVJKZ
         h6kI47xgzCYuwZnVVB/jLEgSDsveGJOoIVhGp/MfoG4FaBM5QSTFWrBEJ7+fWJj3jsJy
         3hQ0mFyCzWpyxO3DSIBcQ3y5MzXv6EKxluQkci4mf/bmD3ROmgnx9arMlHPx/lD93Asp
         hipA==
X-Gm-Message-State: AIVw1128SPM3hQleJo6UgwQ8p7t8Tlt1jMAwixnAif57d4wXGeltR32v
        MdYxkwNwok+txV9bzsjYlw==
X-Received: by 10.84.232.13 with SMTP id h13mr3040852plk.168.1501784422994;
        Thu, 03 Aug 2017 11:20:22 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:21 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 10/15] diff: stop allowing diff to have submodules configured in .git/config
Date:   Thu,  3 Aug 2017 11:19:55 -0700
Message-Id: <20170803182000.179328-11-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Traditionally a submodule is comprised of a gitlink as well as a
corresponding entry in the .gitmodules file.  Diff doesn't follow this
paradigm as its config callback routine falls back to populating the
submodule-config if a config entry starts with 'submodule.'.

Remove this behavior in order to be consistent with how the
submodule-config is populated, via calling 'gitmodules_config()' or
'repo_read_gitmodules()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff.c                    |  3 ---
 t/t4027-diff-submodule.sh | 67 -----------------------------------------------
 2 files changed, 70 deletions(-)

diff --git a/diff.c b/diff.c
index 85e714f6c..e43519b88 100644
--- a/diff.c
+++ b/diff.c
@@ -346,9 +346,6 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (starts_with(var, "submodule."))
-		return parse_submodule_config_option(var, value);
-
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
 
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 518bf9524..2ffd11a14 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -113,35 +113,6 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
 	! test -s actual4
 '
 
-test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.git/config]' '
-	git config diff.ignoreSubmodules all &&
-	git diff HEAD >actual &&
-	! test -s actual &&
-	git config submodule.subname.ignore none &&
-	git config submodule.subname.path sub &&
-	git diff HEAD >actual &&
-	sed -e "1,/^@@/d" actual >actual.body &&
-	expect_from_to >expect.body $subprev $subprev-dirty &&
-	test_cmp expect.body actual.body &&
-	git config submodule.subname.ignore all &&
-	git diff HEAD >actual2 &&
-	! test -s actual2 &&
-	git config submodule.subname.ignore untracked &&
-	git diff HEAD >actual3 &&
-	sed -e "1,/^@@/d" actual3 >actual3.body &&
-	expect_from_to >expect.body $subprev $subprev-dirty &&
-	test_cmp expect.body actual3.body &&
-	git config submodule.subname.ignore dirty &&
-	git diff HEAD >actual4 &&
-	! test -s actual4 &&
-	git diff HEAD --ignore-submodules=none >actual &&
-	sed -e "1,/^@@/d" actual >actual.body &&
-	expect_from_to >expect.body $subprev $subprev-dirty &&
-	test_cmp expect.body actual.body &&
-	git config --remove-section submodule.subname &&
-	git config --unset diff.ignoreSubmodules
-'
-
 test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.gitmodules]' '
 	git config diff.ignoreSubmodules dirty &&
 	git diff HEAD >actual &&
@@ -208,24 +179,6 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 	! test -s actual4
 '
 
-test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.git/config]' '
-	git config submodule.subname.ignore all &&
-	git config submodule.subname.path sub &&
-	git diff HEAD >actual2 &&
-	! test -s actual2 &&
-	git config submodule.subname.ignore untracked &&
-	git diff HEAD >actual3 &&
-	! test -s actual3 &&
-	git config submodule.subname.ignore dirty &&
-	git diff HEAD >actual4 &&
-	! test -s actual4 &&
-	git diff --ignore-submodules=none HEAD >actual &&
-	sed -e "1,/^@@/d" actual >actual.body &&
-	expect_from_to >expect.body $subprev $subprev-dirty &&
-	test_cmp expect.body actual.body &&
-	git config --remove-section submodule.subname
-'
-
 test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.gitmodules]' '
 	git config --add -f .gitmodules submodule.subname.ignore all &&
 	git config --add -f .gitmodules submodule.subname.path sub &&
@@ -261,26 +214,6 @@ test_expect_success 'git diff between submodule commits' '
 	! test -s actual
 '
 
-test_expect_success 'git diff between submodule commits [.git/config]' '
-	git diff HEAD^..HEAD >actual &&
-	sed -e "1,/^@@/d" actual >actual.body &&
-	expect_from_to >expect.body $subtip $subprev &&
-	test_cmp expect.body actual.body &&
-	git config submodule.subname.ignore dirty &&
-	git config submodule.subname.path sub &&
-	git diff HEAD^..HEAD >actual &&
-	sed -e "1,/^@@/d" actual >actual.body &&
-	expect_from_to >expect.body $subtip $subprev &&
-	test_cmp expect.body actual.body &&
-	git config submodule.subname.ignore all &&
-	git diff HEAD^..HEAD >actual &&
-	! test -s actual &&
-	git diff --ignore-submodules=dirty HEAD^..HEAD >actual &&
-	sed -e "1,/^@@/d" actual >actual.body &&
-	expect_from_to >expect.body $subtip $subprev &&
-	git config --remove-section submodule.subname
-'
-
 test_expect_success 'git diff between submodule commits [.gitmodules]' '
 	git diff HEAD^..HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

