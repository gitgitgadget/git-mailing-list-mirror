Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4223320A40
	for <e@80x24.org>; Tue,  5 Dec 2017 22:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbdLEWNn (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 17:13:43 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:43991 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbdLEWNn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 17:13:43 -0500
Received: by mail-pg0-f49.google.com with SMTP id b18so1155269pgv.10
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 14:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uafPUytunM6LPfde0UJbFSRQG9WqFdpkuHJsVSU6ibc=;
        b=NDLpDl2PPRXOhnkXAxVfRxXxM2T0CmwXFhsBQRiLA2G87pTRidQMbTrI38//8jA7Tk
         F158uJ1eG/VV+ocuAwGYlp3qpBWf/TyksVlZaqVXGCuhzIOo+mk/AWrvTMBRbckJEHjz
         bfyVEfLyP09aBaeUIjxvaAPplk+ZVbyMdVXnmti9M4wo/lJt7Iw+8eG7G+4N/pQfG7vn
         0fn6VoBYY5rRSnYDsQq7f3/AO9ZRwd3Frw5t3t81XFBbxwBfZw8APaSXe2Cs0K1bs/UO
         iqWeifLo04CWvqMYW9hMHsqDSPk2wKpZ3yssMLFoPeEXwCKJ+ERIx1gBiAR0q8SoMY9t
         fwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uafPUytunM6LPfde0UJbFSRQG9WqFdpkuHJsVSU6ibc=;
        b=MpFyihebk4Tp2N6ULnSa33gSkTf+j+rjy74uKIdTmrY7N0B8P2hAbLd9PeZ5zlPdkp
         YM0uk9GNXh5GMirrphDHYKacK2fkWLZhi1iWB3tDYOh573uzDchySStJ9iR036edWRjw
         L25Wq307EW1P4Sf813Q/0f8vAIdrUVr75gesUdRDbR1dKOdtFiwXivibW9dWJEgh5biZ
         HEsjuP4kB5dTZJZwPOspqF0bDYdn0pdFHa20MxTmHNis9rtSt9EREIv7RnJtVNlc1qHl
         iJ28SeFkUKsxK3TCn/4IAKrx0Sc3lMKBhw2QnkxQ+/hnWW9a40q+IhO1stxozmrTqqsu
         YJyw==
X-Gm-Message-State: AKGB3mIBZnShkUnaPi9BPN7TuffzwSVNmg5N14u+kXkKDbslWFAbFATV
        RICiHznpkr/K7JGASoKPLglV0bKMXh8=
X-Google-Smtp-Source: AGs4zMb6r9MuA0tOZqihEPchBzghJ9QlBOohRMN6zs8QjY60SGMCFd0nlmalni8pkCWGnyh23BAvZA==
X-Received: by 10.99.113.1 with SMTP id m1mr441126pgc.397.1512512021796;
        Tue, 05 Dec 2017 14:13:41 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id y7sm1437915pfe.8.2017.12.05.14.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Dec 2017 14:13:40 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     ben.boeckel@kitware.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH] diff-tree: read the index so attribute checks work in bare repositories
Date:   Tue,  5 Dec 2017 14:13:37 -0800
Message-Id: <20171205221337.140548-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171205194801.GA31721@megas.kitware.com>
References: <20171205194801.GA31721@megas.kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A regression was introduced in 557a5998d (submodule: remove
gitmodules_config, 2017-08-03) to how attribute processing was handled
in bare repositories when running the diff-tree command.

By default the attribute system will first try to read ".gitattribute"
files from the working tree and then falls back to reading them from the
index if there isn't a copy checked out in the worktree.  Prior to
557a5998d the index was read as a side effect of the call to
'gitmodules_config()' which ensured that the index was already populated
before entering the attribute subsystem.

Since the call to 'gitmodules_config()' was removed the index is no
longer being read so when the attribute system tries to read from the
in-memory index it doesn't find any ".gitattribute" entries effectively
ignoring any configured attributes.

Fix this by explicitly reading the index during the setup of diff-tree.

Reported-by: Ben Boeckel <ben.boeckel@kitware.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---

This patch should fix the regression.  Let me know if it doesn't solve the
issue and I'll investigate some more.

 builtin/diff-tree.c        |  1 +
 t/t4015-diff-whitespace.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index d66499909..cfe7d0281 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -110,6 +110,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(opt, prefix);
+	read_cache();
 	opt->abbrev = 0;
 	opt->diff = 1;
 	opt->disable_stdin = 1;
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 559a7541a..6e061a002 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -636,6 +636,23 @@ test_expect_success 'check with space before tab in indent (diff-tree)' '
 	test_must_fail git diff-tree --check HEAD^ HEAD
 '
 
+test_expect_success 'check with ignored trailing whitespace attr (diff-tree)' '
+	test_when_finished "git reset --hard HEAD^" &&
+
+	# Create a whitespace error that should be ignored.
+	echo "* -whitespace" > ".gitattributes" &&
+	git add ".gitattributes" &&
+	echo "trailing space -> " > "trailing-space" &&
+	git add "trailing-space" &&
+	git commit -m "trailing space" &&
+
+	# With a worktree diff-tree ignores the whitespace error
+	git diff-tree --root --check HEAD &&
+
+	# Without a worktree diff-tree still ignores the whitespace error
+	git -C .git diff-tree --root --check HEAD
+'
+
 test_expect_success 'check trailing whitespace (trailing-space: off)' '
 	git config core.whitespace "-trailing-space" &&
 	echo "foo ();   " >x &&
-- 
2.15.1.424.g9478a66081-goog

