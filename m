Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6D81F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbdGYVkd (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:40:33 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35263 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbdGYVj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:56 -0400
Received: by mail-pg0-f52.google.com with SMTP id v190so75315841pgv.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xsv2wEEqtdFTUW+5SoP1UEUpoShU0PoFE1vD/xpn1aY=;
        b=I3UHmDux76VXXvHauheiy/H57ulYa41kywgNmtLgcPY9VPYvbC77d0vJQV4jUWQRIW
         IfE3Uyy7HrirSadovaJcqMkgYvv//olxFtaqKA9gJ92u21O1uUc1PHq6afs2I80oOnvM
         2EfmN7L+mnUjK0PTzqi4c0XN/Hm4IGFhYfdMDR24RfmY3GzYDuFbRksQqiB+dDHnrUwm
         s+v7yZWQZACOe4uHiE/IMWi/LRQFfGWFVJ2etnuWb9V5MKpR4tGOlQF1XJeE6MLucjIe
         7pQA3NcIYmfwGqNE/6gCouPu8yZoP+sik+UBU3agarUSQ7DNYI8zf9jhjPSt2oEjZR6M
         othQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xsv2wEEqtdFTUW+5SoP1UEUpoShU0PoFE1vD/xpn1aY=;
        b=s4QZIqrALmcsnVM/JAXKHTFjoXqFkcLZpmkXxLtQX3pssWsy4yTnYkeL+emEzACX53
         gF7r3qlDMyhnWxzLYPyAcDLPzPhLvq3A+ZzdA9+NRxJN7nTqCWxs3MYkBCi56NGWddvv
         Rub+DeUeqqCzeqAJfkvS/uoHbps0R+RDJerO937aD5zVsgf6tVwyDXvTCCv/0jSxLCPB
         6AvTEXxnywEMr0wcguticIDBOtGZNBw6SD6zU/0lxKuolQ1HZvc2VROFXvEFv/BmSur3
         98syETMux7GNxqz+qcEp29Cj3uIKPxLNx37F6yAGx5KJdj93jPZ5DXbBNeFVPEc8tINM
         xvaw==
X-Gm-Message-State: AIVw111RFSIRuRdmAlZB6HvMLij0FkSfHLLJUC23bdtFlmy0yZ5M4Rh+
        l8AnZTz9bEJUzmUECzbcJA==
X-Received: by 10.101.69.196 with SMTP id m4mr18250512pgr.105.1501018795566;
        Tue, 25 Jul 2017 14:39:55 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:54 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 10/15] diff: stop allowing diff to have submodules configured in .git/config
Date:   Tue, 25 Jul 2017 14:39:23 -0700
Message-Id: <20170725213928.125998-11-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
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
2.14.0.rc0.400.g1c36432dff-goog

