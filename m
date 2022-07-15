Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4866AC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 07:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiGOHYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiGOHYD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 03:24:03 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E717FFD39
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 00:24:01 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id n9so2126932ilq.12
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 00:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=hzgDzJE178SartGJtRzLI5wXh2xHkY5TPRAvIkytMbc=;
        b=fMcYVJpw8P3Yj5sf+gZ/PdOmIgEMrReyhBm7jUZx4nJY4u4wsvm45GZHJ8DPy3CgLK
         yGPjVMvvpbgYgKNghciER+qWwA1Uuqe4K0yLh+Emo49T13tI/Lu1skM3i9PrHan9ZyRg
         i9pg4BxwFkROqgJjYfUt01lD/FTEN28jXTZzLrnpfJAXDxpk660m/IzIl+zvca+KecVG
         4FfiwcgSsQA1LOSG9L9B1SXVph7LePGfJZofAH1MtgevLbUJpOE9zltDCIK3F+dIEHBp
         tmNcW+BtO7OSJYG8qczHe0Y3uXNrcgykZXzFFH/7F2IK1VzGR4sVaKQMqdnoE5CFzRNI
         NoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hzgDzJE178SartGJtRzLI5wXh2xHkY5TPRAvIkytMbc=;
        b=Oa9+2WUYWOBW5vJsEabFDIk/5tOFWexWfGSSCXWQoNXm3/dMoiE9XhmACo3FUf7Eqw
         LBxziqGIV6um770Q2wCUdhqXODTvuOWNzacho6vceGMurZ2p33SSB2PSOn/ySTICXCCp
         Zn2szCItx2zRIXB+jcz98tplkvDbExQ86CQJbsIXPjRqKWyFg56WpmxcQs/V3uz2Lwd9
         oLTZs5t8lq7T1PwiyGiKiL/0axfu1sfwGtrQB0xA6NWHMB716Fpp92U+sZFU4xGVsnib
         HETlJrrpewLn/iqHSccWtiea/N6a4o4E8j0082v1GXtKXjL80jggEU3UXBITbYsiugrB
         sghA==
X-Gm-Message-State: AJIora9gUtWt2X0Mrj1u60Z2XHGb2dtQAduYhUpEEFlmTdB46iLlMEcM
        6hOsx9hl/8+ho+HsK5sGbE3rQD1mWcb0WZ0rMQYr9hlhpdeia9yE
X-Google-Smtp-Source: AGRyM1txOXU9LxGRgkr53rZSrRlp3c3s5rCfJVUMy9m4EGe1FHEjrnzmypiaylxf3yaC6zh4r7pjwbqAhOdE9xBiEeo=
X-Received: by 2002:a92:c08a:0:b0:2dc:2d67:6046 with SMTP id
 h10-20020a92c08a000000b002dc2d676046mr6465187ile.236.1657869841080; Fri, 15
 Jul 2022 00:24:01 -0700 (PDT)
MIME-Version: 1.0
From:   void f <fvoidcn@gmail.com>
Date:   Fri, 15 Jul 2022 15:23:50 +0800
Message-ID: <CA+dtV-gLyXSXAkG_0bBKC6TRN5Rcu6ct=wTAjkPDuGmBDv13Og@mail.gmail.com>
Subject: Add a new config to tell Git only check files matched sparse-checkout patterns.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From ce8ed96edd72d0c7d57303c0a8b5e734daefeefe Mon Sep 17 00:00:00 2001
From: fvoidCN <fvoidcn@gmail.com>
Date: Fri, 15 Jul 2022 14:33:37 +0800
Subject: [PATCH] repo_read_index: add config
 `sparse.onlyCheckFilesMatchPatterns` to tell Git only check files matched
 sparse-checkout patterns.

By Default with sparse checkouts, all files with SKIP_WORKTREE bit
in the index must check whether exists in the worktree. And Git will
expand all of that files in the index and must traverse recursively
in the worktree. This option can be used to tell Git that just check
files which can match the sparse-checkout patterns.

It is useful when you are using a visual file system in order to
on-demand loading working tree lazily. It can control which directory
should load by using sparse-checkout patterns. But it doesn't want to
visit other directory which haven't been load but just have an empty
directory for the entry of the file loading switch. In default model,
Git would traverse root direcotry recursively however all files would
be loaded, this behaviour would very expensive. With
`sparse.onlyCheckFilesMatchPatterns` model, Git would just check the
path witch only matched the sparse-checkout patterns to prevent loading
all the directory.

Signed-off-by: fvoid <fvoidcn@gmail.com>
---
 Documentation/config/sparse.txt  | 25 ++++++++++++++++
 cache.h                          |  1 +
 config.c                         |  5 ++++
 environment.c                    |  1 +
 sparse-index.c                   | 19 ++++++++----
 t/t1090-sparse-checkout-scope.sh | 50 ++++++++++++++++++++++++++++++++
 6 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
index aff49a8d3a..f71716f446 100644
--- a/Documentation/config/sparse.txt
+++ b/Documentation/config/sparse.txt
@@ -25,3 +25,28 @@ Regardless of this setting, Git does not check for
 present-despite-skipped files unless sparse checkout is enabled, so
 this config option has no effect unless `core.sparseCheckout` is
 `true`.
+
+sparse.onlyCheckFilesMatchPatterns::
+    By Default with sparse checkouts, all files with SKIP_WORKTREE bit
+    in the index must check whether exists in the worktree. And Git will
+    expand all of that files in the index and must traverse recursively
+    in the worktree. This option can be used to tell Git that just check
+    files which can match the sparse-checkout patterns.
++
+The default is `false`, which allows Git to automatically recover
+from the list of files in the index and working tree falling out of
+sync.
++
+Set this to `true` if you just hope Git maintain the consistency
+between the presence of working tree files and sparsity patterns
+confining to which match the sparse-checkout patterns.For example,
+if you are using a visual file system in order to on-demand loading
+working tree lazily. It can control which directory should load by
+using sparse-checkout patterns. But it doesn't want to visit other
+directory which haven't been load but just have an empty directory
+for the entry of the file loading switch.
++
+Regardless of this setting, Git does not check for
+present-despite-skipped files unless sparse checkout is enabled, so
+this config option has no effect unless `core.sparseCheckout` is
+`true`.
\ No newline at end of file
diff --git a/cache.h b/cache.h
index ac5ab4ef9d..d1ed717403 100644
--- a/cache.h
+++ b/cache.h
@@ -1074,6 +1074,7 @@ extern int protect_ntfs;
 extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
+extern int sparse_only_check_files_match_patterns;

 /*
  * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
diff --git a/config.c b/config.c
index 9b0e9c9328..5ab9719479 100644
--- a/config.c
+++ b/config.c
@@ -1758,6 +1758,11 @@ static int git_default_sparse_config(const char
*var, const char *value)
      return 0;
   }

+  if (!strcmp(var, "sparse.onlycheckfilesmatchpatterns")) {
+     sparse_only_check_files_match_patterns = git_config_bool(var, value);
+     return 0;
+  }
+
   /* Add other config variables here and to Documentation/config/sparse.txt. */
   return 0;
 }
diff --git a/environment.c b/environment.c
index b3296ce7d1..0ee4190c7d 100644
--- a/environment.c
+++ b/environment.c
@@ -73,6 +73,7 @@ int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
+int sparse_only_check_files_match_patterns;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/sparse-index.c b/sparse-index.c
index e4a54ce194..264f4965e2 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -502,14 +502,21 @@ void
clear_skip_worktree_from_present_files(struct index_state *istate)
   for (i = 0; i < istate->cache_nr; i++) {
      struct cache_entry *ce = istate->cache[i];

-     if (ce_skip_worktree(ce) &&
-         path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
-        if (S_ISSPARSEDIR(ce->ce_mode)) {
-           ensure_full_index(istate);
-           goto restart;
+     if (ce_skip_worktree(ce)) {
+        if (sparse_only_check_files_match_patterns &&
+            !path_in_sparse_checkout(ce->name, istate)){
+           continue;
+        }
+
+        if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
+           if (S_ISSPARSEDIR(ce->ce_mode)) {
+              ensure_full_index(istate);
+              goto restart;
+           }
+           ce->ce_flags &= ~CE_SKIP_WORKTREE;
         }
-        ce->ce_flags &= ~CE_SKIP_WORKTREE;
      }
+
   }
 }

diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index d1833c0f31..da8173ebe5 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -71,6 +71,56 @@ test_expect_success 'skip-worktree on files outside
sparse patterns' '
   test_cmp expect actual
 '

+test_expect_success 'skip-worktree on files only matched patterns. default' '
+  git clean -f . &&
+  git update-index  --refresh &&
+  git sparse-checkout disable &&
+  git sparse-checkout set --no-cone "a*" &&
+  test_config sparse.expectFilesOutsideOfPatterns false &&
+  git checkout-index --all --ignore-skip-worktree-bits &&
+
+  git ls-files -t >output &&
+  ! grep ^S output >actual &&
+  test_must_be_empty actual
+'
+
+test_expect_success 'skip-worktree on files only matched patterns.
b,c not in patterns' '
+  git clean -f . &&
+  git update-index  --refresh &&
+  git sparse-checkout disable &&
+  git sparse-checkout set --no-cone "a*" &&
+  test_config sparse.onlyCheckFilesMatchPatterns true &&
+  git checkout-index --all --ignore-skip-worktree-bits &&
+
+  git ls-files -t >output &&
+  cat <<-\EOF >expect &&
+  H a
+  S b
+  S c
+  EOF
+  test_cmp expect output >>actual &&
+  test_must_be_empty actual
+'
+
+test_expect_success 'skip-worktree on files only matched patterns.
file b in patterns c is not' '
+  git clean -f . &&
+  git update-index  --refresh &&
+  git sparse-checkout disable &&
+  git sparse-checkout set --no-cone "a*" &&
+  test_config sparse.onlyCheckFilesMatchPatterns true &&
+  echo "b*" >>.git/info/sparse-checkout &&
+  git checkout-index --all --ignore-skip-worktree-bits &&
+
+  git ls-files -t >output &&
+  cat <<-\EOF >expect &&
+  H a
+  H b
+  S c
+  EOF
+  test_cmp expect output >>actual &&
+  test_must_be_empty actual
+'
+
 test_expect_success 'in partial clone, sparse checkout only fetches
needed blobs' '
   test_create_repo server &&
   git clone "file://$(pwd)/server" client &&
-- 
2.36.1
