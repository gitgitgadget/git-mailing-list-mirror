Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94FC81F790
	for <e@80x24.org>; Tue,  2 May 2017 19:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbdEBTcf (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 15:32:35 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34171 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdEBTcd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 15:32:33 -0400
Received: by mail-pf0-f176.google.com with SMTP id e64so1781370pfd.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cMj1MuMJ37F+ouDl7/L2hnDVTizjASaEE/Kl19CnsOM=;
        b=Pa8+rVi1VCgx/RxWUGFVr9JWYwq9cOEEBJ315GrbAMKGIt9hn5FtR6RjgaKZob4dOa
         dJmYDPTv1jZOCWby5UBpUKFe5hd6HRXd4yelNySgOB4QWKgmZD9zaNtssy/c25TerKAS
         RyOwqSDUFn6VTet5hyPUXY0nAItNM4C1A0YpwRGuuW7iWEufbgI6O9p6Ofcn/syAKLFc
         5fZYJn54slIMwC0Bq5InMYO7M0CILKJ2x3z0JSBkwqP8UkC7XEzXmQtVxgr2nj2JwX4v
         KD7rMMOB4fopFkokh41hqctWlCyftRG1187iI70r3PM79kXWd//xslGr8tK9yE/vSUyH
         uAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cMj1MuMJ37F+ouDl7/L2hnDVTizjASaEE/Kl19CnsOM=;
        b=sZNzEHJYCnKJ+Xw2/SjsIH8lcNqV0DYlIBt841Ei3KmzuAZlfRLDc78zvxRiN4B3KD
         snquAe1xJ4eWDHUJDTu0b0CVYqsNEa0WAHBJEYYeOx0Kdi4KKhajP3ZhjDNuRKl4zfTQ
         XhUwjuu1e+giB7y8drlwHSnkr7uOVH3soaMDGEOfmSxJfz7mDe27H+Pkf6R4jO588AHw
         PgRg0Oa7JYXyGy9x5RYeP1Z60PLULZ5Wvvup/GAK9RkvpYzo0yxYu8dMFX9kAjsfO/h/
         u87C55DXepJZ9vAay/2PnlpdOkADQA1ONEYiLxGpn4sVw6I6RqTGUOau+JkwJFPzjJOY
         6New==
X-Gm-Message-State: AN3rC/5mKGqhleJUYdYvcR5y0/akwzjHRFN7oRiZKFFAl9+GC0SpuqU7
        Tmjt0YY4ol5mfo4s
X-Received: by 10.98.68.133 with SMTP id m5mr737013pfi.60.1493753547662;
        Tue, 02 May 2017 12:32:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id 202sm20157272pge.12.2017.05.02.12.32.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 12:32:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/3] submodule: properly recurse for read-tree and checkout
Date:   Tue,  2 May 2017 12:32:14 -0700
Message-Id: <20170502193214.7121-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.18.g9ce9a66034
In-Reply-To: <20170502193214.7121-1-sbeller@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
 <20170502193214.7121-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We forgot to prepare the submodule env, which is only a problem for
nested submodules. See 2e5d6503bd (ls-files: fix recurse-submodules
with nested submodules, 2017-04-13) for further explanation.

To come up with a proper test for this, we'd need to look at nested
submodules just as in that given commit. It turns out we're lucky
and these tests already exist, but are marked as failing. We need
to pass `--recurse-submodules` to read-tree additionally to make
these tests pass. Passing that flag alone would not make the tests
pass, such that this covers testing for the bug fix of the submodule
env as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                    | 3 ++-
 t/lib-submodule-update.sh      | 7 +------
 t/t1013-read-tree-submodule.sh | 1 -
 t/t2013-checkout-submodule.sh  | 1 -
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index b0141a66dd..b3ae642f29 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1446,7 +1446,7 @@ int submodule_move_head(const char *path,
 
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
 			get_super_prefix_or_empty(), path);
-	argv_array_pushl(&cp.args, "read-tree", NULL);
+	argv_array_pushl(&cp.args, "read-tree", "--recurse-submodules", NULL);
 
 	if (flags & SUBMODULE_MOVE_HEAD_DRY_RUN)
 		argv_array_push(&cp.args, "-n");
@@ -1474,6 +1474,7 @@ int submodule_move_head(const char *path,
 			cp.no_stdin = 1;
 			cp.dir = path;
 
+			prepare_submodule_repo_env(&cp.env_array);
 			argv_array_pushl(&cp.args, "update-ref", "HEAD", new, NULL);
 
 			if (run_command(&cp)) {
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index fb4f7b014e..2c17826e95 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -787,11 +787,6 @@ test_submodule_switch_recursing () {
 	then
 		RESULTDS=failure
 	fi
-	RESULTR=success
-	if test "$KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED" = 1
-	then
-		RESULTR=failure
-	fi
 	RESULTOI=success
 	if test "$KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED" = 1
 	then
@@ -1003,7 +998,7 @@ test_submodule_switch_recursing () {
 	'
 
 	# recursing deeper than one level doesn't work yet.
-	test_expect_$RESULTR "$command: modified submodule updates submodule recursively" '
+	test_expect_success "$command: modified submodule updates submodule recursively" '
 		prolog &&
 		reset_work_tree_to_interested add_nested_sub &&
 		(
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index de1ba02dc5..7019d0a04f 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -5,7 +5,6 @@ test_description='read-tree can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index e8f70b806f..aa35223369 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -64,7 +64,6 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 '
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
-KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 test_submodule_switch_recursing "git checkout --recurse-submodules"
 
 test_submodule_forced_switch_recursing "git checkout -f --recurse-submodules"
-- 
2.13.0.rc1.19.g083305f9b1

