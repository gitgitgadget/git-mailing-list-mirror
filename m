Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ADEC433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiGMNKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiGMNKr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:10:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEDDD59
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v16so15412309wrd.13
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=53NYxiy7JsQ4Nwv2ppG0ucODnzkND7IHCh4AsyJODHc=;
        b=aa/z5ZDlsG2fVNftBGhZ5YYoaytHPN36yy1I0LKZRFRDaeSw3wPczhJz71gzSSEZeR
         If8kbIbcJHSNHH+vzCeeR9f2skIiM2PEmh4o5Z5zgw0YjK9glO4Fs96p0d2RPs3LHClc
         YHDxi+pPag8t7in4JphNyTTqQS/kMWpSUT7wAjBtmhQfiy2e1vVtiSe59FPru7VTpwQK
         fFKWRh/FSLT9A8DeHIn8DUlVc+FAA4f+1zkdb6ypGnPEnrz0LB8vmZqRxOa0OkNp/z0T
         herY3Kv5wfWrXBPaX85jBrB3RgIss+vTlkVZglwS24v+dRNB6y3tR8WtvmhyAVM+0FhG
         Fd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=53NYxiy7JsQ4Nwv2ppG0ucODnzkND7IHCh4AsyJODHc=;
        b=LSfIGWCr7hBG9oEqD6/74IZ4KWSRSkZY402UCASgIqjOBCbinEKu2Aud5OWRHVEpFP
         EBuFFhaVQU2CQJH66FOrdI61dj/8o9SZEk3hNGWSWVThL+yweFi8ZpPj3nkruoLUWDWM
         BTquh99qa9H/z7cz+n3kHyhLounnk2nakFHal4h/X6obNKQj/DBmPtzBUkqKcOWc50yE
         XHnzAXvNqkqByMULlrpBAHTFQDEDDdWh5Qrl6igaoZBaSvuVcy9c1FloxKoySKZt23rB
         nhsGrwZ2Vm3sQ5WfOEoRZmcgrfcamLqXjG2iqYiJpDtAfOI8ycEqtqV9UB9LovcWV3Xb
         jmbA==
X-Gm-Message-State: AJIora9oehUW8fPAnqIZjb9NezsbLgI1iJ7Wo7+0PAs1jwn4kyYy6KCS
        EqdrmygQ2sseiGzYRHL/T2FNcJy4vfCg/A==
X-Google-Smtp-Source: AGRyM1sdVeKa8nismnbrlq79VFn7uAa3uBPWD8EsdDGkM64Cd1BZzaq07mN89pPke9VCBNYkJfbb1g==
X-Received: by 2002:adf:e7cf:0:b0:21d:60e0:a71a with SMTP id e15-20020adfe7cf000000b0021d60e0a71amr3523550wrn.38.1657717845192;
        Wed, 13 Jul 2022 06:10:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0039c4d022a44sm2183653wmq.1.2022.07.13.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:10:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] log: fix common "rev.pending" memory leak in "git show"
Date:   Wed, 13 Jul 2022 15:10:33 +0200
Message-Id: <patch-4.6-9bff7b10197-20220713T130511Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a very common memory leak introduced in 5d7eeee2ac6 (git-show: grok blobs,
trees and tags, too, 2006-12-14).

When "git show" displays commits it needs to temporarily clobbers the
"rev.pending" array, but by doing so we'll fail to
release_revisions(), as we have for most other uses of "struct
rev_info" since 2da81d1efb0 (Merge branch 'ab/plug-leak-in-revisions',
2022-06-07).

In the preceding commit this code was made to use a more extendable
pattern, which we can now complete. Once we've clobbered our
"rev.pending" and invoked "cmd_log_walk_no_free()" we need to
"object_array_clear()" our newly created "rev.pending" to avoid
leaking the memory related to the one member array we've created.

But more importantly we need to set "rev.pending" back to the original
we squirreled away in the "cp" variable, so that we'll make use of the
release_revisions() added in f6bfea0ad01 (revisions API users: use
release_revisions() in builtin/log.c, 2022-04-13). In f6bfea0ad01 this
memory leak was noted as an outstanding TODO, but it's now been fixed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c                                    | 2 ++
 t/t0203-gettext-setlocale-sanity.sh              | 1 +
 t/t1020-subdirectory.sh                          | 1 +
 t/t3307-notes-man.sh                             | 1 +
 t/t3920-crlf-messages.sh                         | 2 ++
 t/t4069-remerge-diff.sh                          | 1 +
 t/t7007-show.sh                                  | 1 +
 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh | 1 +
 t/t9122-git-svn-author.sh                        | 1 -
 t/t9162-git-svn-dcommit-interactive.sh           | 1 -
 10 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e0f40798d45..77ec256a8ae 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -747,6 +747,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			memcpy(&rev.pending, &blank, sizeof(rev.pending));
 			add_object_array(o, name, &rev.pending);
 			ret = cmd_log_walk_no_free(&rev);
+			object_array_clear(&rev.pending);
+			memcpy(&rev.pending, &cp, sizeof(rev.pending));
 			break;
 		default:
 			ret = error(_("unknown type: %d"), o->type);
diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setlocale-sanity.sh
index 0ce1f22eff6..86cff324ff1 100755
--- a/t/t0203-gettext-setlocale-sanity.sh
+++ b/t/t0203-gettext-setlocale-sanity.sh
@@ -5,6 +5,7 @@
 
 test_description="The Git C functions aren't broken by setlocale(3)"
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success 'git show a ISO-8859-1 commit under C locale' '
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 9fdbb2af80e..45eef9457fe 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -6,6 +6,7 @@
 test_description='Try various core-level commands in subdirectory.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t3307-notes-man.sh b/t/t3307-notes-man.sh
index 1aa366a410e..ae316502c45 100755
--- a/t/t3307-notes-man.sh
+++ b/t/t3307-notes-man.sh
@@ -4,6 +4,7 @@ test_description='Examples from the git-notes man page
 
 Make sure the manual is not full of lies.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 0276edbe3d3..4c661d4d54a 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='Test ref-filter and pretty APIs for commit and tag messages using CRLF'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 LIB_CRLF_BRANCHES=""
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 35f94957fce..9e7cac68b1c 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,6 +2,7 @@
 
 test_description='remerge-diff handling'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index d6cc69e0f2c..f908a4d1abc 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -2,6 +2,7 @@
 
 test_description='git show'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index ad1eb64ba0d..aa004b70a8d 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -5,6 +5,7 @@ test_description='pre-commit and pre-merge-commit hooks'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'root commit' '
diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 527ba3d2932..0fc289ae0f0 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -2,7 +2,6 @@
 
 test_description='git svn authorship'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'setup svn repository' '
diff --git a/t/t9162-git-svn-dcommit-interactive.sh b/t/t9162-git-svn-dcommit-interactive.sh
index e2aa8ed88a9..b3ce033a0d3 100755
--- a/t/t9162-git-svn-dcommit-interactive.sh
+++ b/t/t9162-git-svn-dcommit-interactive.sh
@@ -4,7 +4,6 @@
 
 test_description='git svn dcommit --interactive series'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
-- 
2.37.0.932.g7b7031e73bc

