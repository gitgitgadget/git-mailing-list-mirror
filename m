Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1BBC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiCDKoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbiCDKoN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:44:13 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE8C1AC299
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:43:25 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o23so7164311pgk.13
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTJ9o84c0gZUTwdV/dNn0LYgzY5QUbjGEeHsdbTEEIA=;
        b=NUuedFLLSovCL0uLM6BlVUE8rmvp4+vRNUhC6c4Al2vwm8P+Z7kmtO1iZSfVd4MLMY
         wsHt5J09IPgEEe3LqKA+EEgz30bj7r0VFcs2RQnjueTqYRctkidTTJGp5OoL3UTndIQm
         i7P1UlkK+1DGgJZQ+NI3OJ91BXplOfUFr54T6CZQLNfAUowja3GAizJIrmRjp/oxkY3i
         lh0NH5z6q/my/fLvJdcxRArUXP2UczOl+eodOifMTwF42fuCS5cYed5DoUI/WScIA5uV
         d/cg8CIudQXXHGKsj7l8XWu0lIwZH2Guhj+Mi0AvGcQQBad3bv6qaeIk0RTGL/EnUWdZ
         15Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTJ9o84c0gZUTwdV/dNn0LYgzY5QUbjGEeHsdbTEEIA=;
        b=PvlnyGsGtqv8YtWzgjWSDfexfHj2ltOt3zP5FPmzeqIMgH8jL7d9mgT9qmow0od/Pg
         KmRKEj9AP4KKYEy/zM0f0O3YrQEmuh/uBl4GQxxMnkuFm8wTqSURdTsYSEq96ClJyzHS
         PyuOCu9y2MKWsx8nRC4QASOGGXzMUbAME2bejt2qU0x2klSqsflVIbe/OaQq8GFf40wG
         pwFJqiuVqsKHNembscPWGkHGFEye0iiiVg/Y86VGIx2Ng5IhM8KfiJXZZyFFHTIV3hsj
         2snP+yhjjYt3GOMDmo8bmhU9cxuk1LjRncNzyCFLKNLe7Qc5hhcih0FXJEccTEjrWyXU
         44mg==
X-Gm-Message-State: AOAM533HjJQI8zv5RCE1uw701KIU5wMFahZaNFjVHL/xbwi/wktSZ89/
        j9ZhHiCnKOJlwoinUkz7cGCG9T/AxMLI7GNy
X-Google-Smtp-Source: ABdhPJyWUFboaq3WMZfrQ2mXHQyyqVwEyMxDX+oq1YKlVrcqxRxxq2YbhKxQgd9WnNXrWko2XcfacQ==
X-Received: by 2002:a63:8843:0:b0:37c:926d:3fc7 with SMTP id l64-20020a638843000000b0037c926d3fc7mr2818121pgd.112.1646390605077;
        Fri, 04 Mar 2022 02:43:25 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.43.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:43:24 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v12 07/12] ls-tree: fix "--name-only" and "--long" combined use bug
Date:   Fri,  4 Mar 2022 18:42:33 +0800
Message-Id: <25a07e048f25e0efdd2f8690f2e6967352a20e9b.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we execute "git ls-tree" with combined "--name-only" and "--long"
, only the pathname will be printed, the size is omitted (the original
discoverer was Peff in [1]).

This commit fix this issue by using `OPT_CMDMODE()` instead to make both
of them mutually exclusive.

[1] https://public-inbox.org/git/YZK0MKCYAJmG+pSU@coredump.intra.peff.net/

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c       | 12 ++++++------
 t/t3103-ls-tree-misc.sh |  9 +++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index d4be71bad2..7be4c13228 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -123,12 +123,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_SHOW_TREES),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("terminate entries with NUL byte"), 0),
-		OPT_BIT('l', "long", &ls_options, N_("include object size"),
-			LS_SHOW_SIZE),
-		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
-		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
+		OPT_CMDMODE('l', "long", &ls_options, N_("include object size"),
+			    LS_SHOW_SIZE),
+		OPT_CMDMODE(0, "name-only", &ls_options, N_("list only filenames"),
+			    LS_NAME_ONLY),
+		OPT_CMDMODE(0, "name-status", &ls_options, N_("list only filenames"),
+			    LS_NAME_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index d18ba1bd84..d9d7fa932f 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -23,4 +23,13 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 	test_must_fail git ls-tree -r HEAD
 '
 
+for opts in \
+	"--name-only --long" \
+	"--name-status --long"
+do
+	test_expect_success "usage: incompatible options: $opts" '
+		test_expect_code 129 git ls-tree $opts $tree
+    '
+done
+
 test_done
-- 
2.34.1.402.gef0f5bd184

