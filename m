Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A05C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 02:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiF3CiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiF3CiE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 22:38:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B4E248EF
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:38:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso2366508pjz.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uUBWU57BKFV2sTn/wPtrtu20bGU+hkpkuTCcqrLsJ5E=;
        b=I8oIstlkKEjrJpvOCrM2VgQm6HQ86wHD4/9aDuP2YvYag99B1rYI+m7beuIjklLOlu
         HNTBTNCuoUBTJq3onIqtvIV7onIIt1VRz4d3kQXto0997IUkAZle0cgxgYi55Z1AA3jM
         cita0H7o2a1pyNeFofeebfVmOYuz0EUkHdOqEU3hETsRO7M/c1uAePlmN4+YlpOY3ZO5
         8lAK/quGMYrWbD6tFM9e+AOVnf3n09vaVzKHjK0YwY8zAu5zuOlJar1XYKjTPWJ3Bwc7
         DZ0LfJiLSrIGCW5vzko/m2o/5aGkUFA8aUYgLxmUj0OoTH+oYer8FQsMpZnRgFUX78i+
         Hf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUBWU57BKFV2sTn/wPtrtu20bGU+hkpkuTCcqrLsJ5E=;
        b=MWkLtlWITPLgmI3+LEr1iP/Ha5SuOvpCQf86Qe+wnCPXDkOkHZqeoGsZgPnQKEwKuB
         +KYPADVQswYLWmY8J7R0OhOnHHrKOOXQlysV9s2zoZop3IBKcsqEDQuziSbK/pFL3hUf
         eaWlk5pFhnQBnCtNL9KxAwDfUQn1BIo25yutE9nfzRVSS2bxkUTCwtMfRoJbvyix+5Qm
         JHG2X8LCHv34/W16sSkYku4qfVON7Bh4bRWTnLg8anf9b1VF7vMTJboZQTC/wjak6otl
         RWRs0AvH/WoLQM48C6KyNXmt5b7IR5p+8MfZYIvUuBDJb1RTZs1k4vVDAJMnUTqfnY/+
         wpfg==
X-Gm-Message-State: AJIora/XyXd3f7WfmJ0cgQVFNY4uy76HxgT72F3e29C30EzlWRb0l75P
        QJ8Um4xX84W5syRP3Tj0AVlRHQ4o10M=
X-Google-Smtp-Source: AGRyM1vHESrKbFYEm3dIo7cGAsswYsxtrVqMYSKmB5hZZs5fXHIwT4Ydp6QGyoMUAaTThw/V1R6QSA==
X-Received: by 2002:a17:902:ce83:b0:16a:4663:f34b with SMTP id f3-20020a170902ce8300b0016a4663f34bmr12288795plg.125.1656556682745;
        Wed, 29 Jun 2022 19:38:02 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.226.29])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm12157509pls.100.2022.06.29.19.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 19:38:01 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 5/8] mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
Date:   Thu, 30 Jun 2022 10:37:34 +0800
Message-Id: <20220630023737.473690-6-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving a <source> file which is not on-disk but exists in
index as a SKIP_WORKTREE enabled cache entry, "giv mv" command errors
out with "bad source".

Change the checking logic, so that such <source>
file makes "giv mv" command warns with "advise_on_updating_sparse_paths()"
instead of "bad source"; also user now can supply a "--sparse" flag so
this operation can be carried out successfully.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 21 +++++++++++++++++++--
 t/t7002-mv-sparse-checkout.sh |  4 ++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index e800da3ab8..520be85774 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -186,11 +186,28 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		length = strlen(src);
 		if (lstat(src, &st) < 0) {
-			/* only error if existence is expected. */
-			if (modes[i] != SPARSE) {
+			int pos;
+			const struct cache_entry *ce;
+
+			pos = cache_name_pos(src, length);
+			if (pos < 0) {
+				/* only error if existence is expected. */
+				if (modes[i] != SPARSE)
+					bad = _("bad source");
+				goto act_on_entry;
+			}
+
+			ce = active_cache[pos];
+			if (!ce_skip_worktree(ce)) {
 				bad = _("bad source");
 				goto act_on_entry;
 			}
+
+			if (!ignore_sparse)
+				string_list_append(&only_match_skip_worktree, src);
+			else
+				modes[i] = SPARSE;
+			goto act_on_entry;
 		}
 		if (!strncmp(src, dst, length) &&
 		    (dst[length] == 0 || dst[length] == '/')) {
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 023e657c9e..1510b5ed6a 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -241,7 +241,7 @@ test_expect_failure 'can move out-of-cone directory with --sparse' '
 	test_path_is_file sub/folder1/file1
 '
 
-test_expect_failure 'refuse to move out-of-cone file without --sparse' '
+test_expect_success 'refuse to move out-of-cone file without --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
@@ -252,7 +252,7 @@ test_expect_failure 'refuse to move out-of-cone file without --sparse' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'can move out-of-cone file with --sparse' '
+test_expect_success 'can move out-of-cone file with --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
-- 
2.35.1

