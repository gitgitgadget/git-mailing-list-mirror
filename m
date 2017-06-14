Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F03220282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbdFNSH7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:07:59 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36589 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbdFNSH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:07:57 -0400
Received: by mail-pf0-f169.google.com with SMTP id x63so3915983pff.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gW4ER1ThTzchFgyYNUzRpQly4ysAEhLQJI69fKT5nAY=;
        b=rfo9flgFGayKDyioaSFcpOHZ9uHEv6EYVmF43sEGoW2UyW0ZxIypC6oRgPyPqVdLEz
         RjtMNoqPgBcPpBTULK8cF2KR2gTDhNmgZKtB9MROdhhLKX2EREXJGIpudpPth8vZdw6I
         Q+AkH8u+gqovkBi55BF4KBAtwVsrhzOG3CM/ZPileeSWm8lgAOGiRlYq1peeF3ufJXe9
         FS9gdDjrYDvVpphApG2CZyp3y1rxAz25uXbNHA+cGp2jCBXhx/+NxI540Ig8YwZHh0o0
         9oQ68xXlJrsWVL41PtrXzYAujjFJgF0HqsfS56uhOOuJwh0fhkRqkM9XIUSfbTrHj6g7
         O/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gW4ER1ThTzchFgyYNUzRpQly4ysAEhLQJI69fKT5nAY=;
        b=YVy32J6yBQqYnSnFk23sIeCdhQ8JLDy03LqEBeOxnCJTVnUSxlVDYoAEpZv+64yj+Z
         tNUXo+iT4UW80CfTz5XJrTOfaItsgGi+zGTlrOMXLDDFf8bN+glQBGOJs4ddicOVLrgF
         kQi7OXf1qxQ4HkcERXXZfkp6d1LzYkMO9AwX6gLkCzeOH5gkSVwgdevvrJm7gezUWJbC
         J8b13iLOFJCm40bZ4eGroF9sv/RFE7kDmT1TV1OFnOPk8rYmcAqOEuGIFgGrApNdawj6
         0s352JYi1Q+6livS11kYstQDLc934AVIMOhHR/Mcm63evFKDtkeQa49nXV3+WVyHEttw
         t5XQ==
X-Gm-Message-State: AKS2vOw4PJDKr9S2ioOFIKBdYilu6mrEajB1fes2Kt05E50E8ygCv9SW
        fjv+hFe4N3wh6VYmTwpjnw==
X-Received: by 10.84.231.1 with SMTP id f1mr1424113plk.258.1497463671718;
        Wed, 14 Jun 2017 11:07:51 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t2sm1001646pfi.76.2017.06.14.11.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 11:07:50 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 5/6] config: respect commondir
Date:   Wed, 14 Jun 2017 11:07:38 -0700
Message-Id: <20170614180739.72193-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170614180739.72193-1-bmwill@google.com>
References: <20170613210321.152978-1-bmwill@google.com>
 <20170614180739.72193-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Worktrees present an interesting problem when it comes to the config.
Historically we could assume that the per-repository config lives at
'gitdir/config', but since worktrees were introduced this isn't the case
anymore.  There is currently no way to specify per-worktree
configuration, and as such the repository config is shared with all
worktrees and is located at 'commondir/config'.

Many users of the config machinery correctly set
'config_options.git_dir' with the repository's commondir, allowing the
config to be properly loaded when operating in a worktree.  But other's,
like 'read_early_config()', set 'config_options.git_dir' with the
repository's gitdir which can be incorrect when using worktrees.

To fix this issue, and to make things less ambiguous, lets add a
'commondir' field to the 'config_options' struct and have all callers
properly set both the 'git_dir' and 'commondir' fields so that the
config machinery is able to properly find the repository's config.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 config.c | 11 +++++++----
 config.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index e82e1d987..dd7ad5e1e 100644
--- a/config.c
+++ b/config.c
@@ -1547,8 +1547,8 @@ static int do_git_config_sequence(const struct config_options *opts,
 	char *user_config = expand_user_path("~/.gitconfig", 0);
 	char *repo_config;
 
-	if (opts->git_dir)
-		repo_config = mkpathdup("%s/config", opts->git_dir);
+	if (opts->commondir)
+		repo_config = mkpathdup("%s/config", opts->commondir);
 	else if (have_git_dir())
 		repo_config = git_pathdup("config");
 	else
@@ -1660,7 +1660,8 @@ void read_early_config(config_fn_t cb, void *data)
 
 	opts.respect_includes = 1;
 
-	if (have_git_dir())
+	if (have_git_dir()) {
+		opts.commondir = get_git_common_dir();
 		opts.git_dir = get_git_dir();
 	/*
 	 * When setup_git_directory() was not yet asked to discover the
@@ -1670,8 +1671,10 @@ void read_early_config(config_fn_t cb, void *data)
 	 * notably, the current working directory is still the same after the
 	 * call).
 	 */
-	else if (!discover_git_directory(&commondir, &gitdir))
+	} else if (!discover_git_directory(&commondir, &gitdir)) {
+		opts.commondir = commondir.buf;
 		opts.git_dir = gitdir.buf;
+	}
 
 	git_config_with_options(cb, data, NULL, &opts);
 
diff --git a/config.h b/config.h
index c70599bd5..63b92784c 100644
--- a/config.h
+++ b/config.h
@@ -30,6 +30,7 @@ enum config_origin_type {
 
 struct config_options {
 	unsigned int respect_includes : 1;
+	const char *commondir;
 	const char *git_dir;
 };
 
-- 
2.13.1.518.g3df882009-goog

