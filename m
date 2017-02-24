Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56A0C201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbdBXXvR (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:51:17 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35031 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdBXXvN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:51:13 -0500
Received: by mail-pg0-f54.google.com with SMTP id b129so17225851pgc.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 15:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E61qe/mirXDDuIAjqNJiLVJJiHnUalQLhqtwnZ9vW+k=;
        b=VhfY6T3kkrvPVYNQcn/r/Ojhm0QRSQHZEX4jg4mLUycsJeBddn4EGGp8kljoH5BeEe
         wBunsa6DXOajouBO/+92O65mJKwWQQsaPGUr/2hh/x9tSdSNX2LLkuYzWcU6FAq9AgHv
         8oGmZ2tkG2L5XfFYepgXG15VPHY7bafT4tCPrN8Og7lKnZptvNEtRvpKVcxH5tIOjo/s
         oXQ2O+xKvgxfBOvCGsX5YmbtJdbEQhoUbRscm7dPcpXZW19eO5hcQuR20Yn+lC80nGe/
         SZhWKPnm0LLGPx/bCpiFtN60x/ufjp9UVAK05obs8EAk/UPujIsNesIvIsJXPNpudQdX
         ggEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E61qe/mirXDDuIAjqNJiLVJJiHnUalQLhqtwnZ9vW+k=;
        b=ZWMd0uva7aYRzK6MGYewjPcJ7TkOBzIm9U+479kSgphsIjdMvVBNi2nbXGXNgVNPjn
         ALyEGlZJxJ/C2O43RLDxc/dxUWiWKYExnjC9n+tdtDfbe250TVFAOjq8pOONtH4ymDuC
         Pk1csw7hJAXofRiDMW+Aiykcvk4yS8RX5J0J2iQiXaixnzzh1pUV90+A/pTMESYeu/GJ
         cegY++WWFAjp3RedHNzPZU9DMHOGaANmatcf95FG6E0f640L+mkeThGhETTx/B3QUvzV
         A5mW8I6f0vWBc7MMdNMPVyiTx6xE72/JHH7yE+Jlha7q37jjQAkjLxv7OixRsABKuDqt
         j/hA==
X-Gm-Message-State: AMke39lgEhLmRgcHCSvLD4TCQI+DLG3gveER8GxmyTik6MTbIZVgc/BaaDQngrDF6LLM2y/g
X-Received: by 10.84.128.33 with SMTP id 30mr7576991pla.128.1487980272193;
        Fri, 24 Feb 2017 15:51:12 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id v69sm17048236pgd.18.2017.02.24.15.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 15:51:10 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com
Subject: [PATCH 3/5] grep: fix bug when recuring with relative pathspec
Date:   Fri, 24 Feb 2017 15:50:58 -0800
Message-Id: <20170224235100.52627-4-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170224235100.52627-1-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug which causes a child process for a submodule to error out when
a relative pathspec with a ".." is provided in the superproject.

While at it, correctly construct the super-prefix to be used in a
submodule when not at the root of the repository.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/grep.c                     | 8 ++++++--
 t/t7814-grep-recurse-submodules.sh | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2c727ef49..65f3413d1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -538,6 +538,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	int status, i;
 	const char *end_of_base;
 	const char *name;
+	struct strbuf buf = STRBUF_INIT;
 	struct work_item *w = opt->output_priv;
 
 	end_of_base = strchr(gs->name, ':');
@@ -550,9 +551,11 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
 
 	/* Add super prefix */
+	quote_path_relative(name, opt->prefix, &buf);
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
 			 super_prefix ? super_prefix : "",
-			 name);
+			 buf.buf);
+	strbuf_release(&buf);
 	argv_array_push(&cp.args, "grep");
 
 	/*
@@ -1199,7 +1202,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
-		       (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
+		       (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0) |
+		       (super_prefix ? PATHSPEC_FROMROOT : 0),
 		       prefix, argv + i);
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 418ba68fe..e0932b2b7 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -227,7 +227,7 @@ test_expect_success 'grep history with moved submoules' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'grep using relative path' '
+test_expect_success 'grep using relative path' '
 	test_when_finished "rm -rf parent sub" &&
 	git init sub &&
 	echo "foobar" >sub/file &&
-- 
2.11.0.483.g087da7b7c-goog

