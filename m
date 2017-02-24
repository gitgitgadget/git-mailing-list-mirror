Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46BC201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbdBXXvU (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:51:20 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33154 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdBXXvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:51:16 -0500
Received: by mail-pg0-f44.google.com with SMTP id z128so17264260pgb.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 15:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VPJx38CebABuTkiU9rOG/cgfHEizjXX0Vma7mDU+dRM=;
        b=N7X14ds6WG/SX8T3LmsE/VN7aa2f7HwepJhHmJKSQjY6oj674BDIXuGenxly4L+hdk
         cc1WZJ13BN8rd7OP3qeS3gtX32OheGlIzTWJmOruU7KTi9x2mmaDb3SXM300X/exonQN
         5GDW+6AclQfU9jK7+tO/ZmvY4qxcYBF12B+oDqcQANMSQ8ld9faG5+jVUEM3VgZxjJqf
         fUypTrZVVoX7jWRr7+MQUF8CW5UkUKzjo10PYxv3sR64jRXD4EcCsTa1ITOtmE7NlJjX
         uhGscUPHWi1ytDvfSYlf2itcx8mFXX2rEB7+zj22CylyfuFCDQRLa8Q6lzrKDTSKfnMk
         +OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VPJx38CebABuTkiU9rOG/cgfHEizjXX0Vma7mDU+dRM=;
        b=OnxWkD92eRSF1QU4ivT2Q+WnDH+MtdYjvkG2gkYyLUTMHxlhjPg8fyRfdtQK62Z68t
         Wd58H3MXK5iqZ6YG31KBkcoRXj+kD5u4mKoc+1hldLMlf3zyVzqxottjnvG3/KwqRwm0
         ka++yokCpnsrXRVJesAMVdHwZSpGC1CPAsJ1lYhXP16PZa3qr2DKSuXL5ytxqIx7c5Ad
         4aGGCdsluJfbSLZHnRDc7bMdvvAqReTVS23Ed1wTGLkDnTtnXlt67RWDFThgJ4xcepkK
         IGpP+KMEEIl0wYOxrzbwVrbYwsvEQlTb9R7YwQxE3KULaPjUMErcjYPAC8OIZDL48gVz
         zK8g==
X-Gm-Message-State: AMke39lBQFx2GKDlxrER92MjSndgB3/eLQ0tSTM0E61MudgkENaW/Gi6nYQF1PMvuUVqnE87
X-Received: by 10.84.229.151 with SMTP id c23mr7523896plk.27.1487980275054;
        Fri, 24 Feb 2017 15:51:15 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id v69sm17048236pgd.18.2017.02.24.15.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 15:51:14 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com
Subject: [PATCH 5/5] ls-files: fix bug when recuring with relative pathspec
Date:   Fri, 24 Feb 2017 15:51:00 -0800
Message-Id: <20170224235100.52627-6-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170224235100.52627-1-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug which causes a child process for a submodule to error out when a
relative pathspec with a ".." is provided in the superproject.

While at it, correctly construct the super-prefix to be used in a submodule
when not at the root of the repository.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c                     | 8 ++++++--
 t/t3007-ls-files-recurse-submodules.sh | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 159229081..89533ab8e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -194,12 +194,15 @@ static void compile_submodule_options(const struct dir_struct *dir, int show_tag
 static void show_gitlink(const struct cache_entry *ce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf name = STRBUF_INIT;
 	int status;
 	int i;
 
+	quote_path_relative(ce->name, prefix, &name);
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
 			 super_prefix ? super_prefix : "",
-			 ce->name);
+			 name.buf);
+	strbuf_release(&name);
 	argv_array_push(&cp.args, "ls-files");
 	argv_array_push(&cp.args, "--recurse-submodules");
 
@@ -615,7 +618,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
+		       (super_prefix ? PATHSPEC_FROMROOT : 0),
 		       prefix, argv);
 
 	/*
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index d8ab10866..1522ed235 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -188,7 +188,7 @@ test_expect_success '--recurse-submodules and pathspecs' '
 	test_cmp expect actual
 '
 
-test_expect_failure '--recurse-submodules and relative paths' '
+test_expect_success '--recurse-submodules and relative paths' '
 	# From top works
 	cat >expect <<-\EOF &&
 	.gitmodules
-- 
2.11.0.483.g087da7b7c-goog

