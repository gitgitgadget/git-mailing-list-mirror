Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3018DC433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 20:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385905AbiEEUgh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385894AbiEEUge (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 16:36:34 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3928B5F8EA
        for <git@vger.kernel.org>; Thu,  5 May 2022 13:32:54 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x22so4072213qto.2
        for <git@vger.kernel.org>; Thu, 05 May 2022 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKvAip+QVMJG77BrZdsdgT4zmHfAIqD5R2KHtQLTQ/s=;
        b=VhB/jKfsCk6h9AOfX0IffnRGJ1h9396OpYlcEjptXrScuPrNSctMLOer77ERgDWdFz
         +DmLEUtA76gaaIBs3H13r9ic+ETX/B4tw3xoH/2RccU3wMrU6xALaKJ4G+9H+f4+r0JS
         alMbJ96ceDSGwjYu22gWQqKzoUf2MyiTFokXxwNkAuoFSwO09y5zbXvxpwBI9a0knZRp
         LFVB2w5UsoaxlSHRIFuBDhbZZaVAFOi69mYS5vAvoCigFjNA39/+OxWimFVUfGB5T3hd
         SIT+PaXeYQuHxLwRVDyQASm4RqtpciG7Unfw5yET4USKjgbKZR2JyiHwCq35H74Hm63D
         8o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKvAip+QVMJG77BrZdsdgT4zmHfAIqD5R2KHtQLTQ/s=;
        b=IG2Q8PeEf26hkM4+ECKg3G6+9Oo84rHm5+Fpt3+Y0LSmH/5aaw89qr7NscrzKkq3Jy
         Fjw6UAUrixKpgu9/VZxjqnLfpkCGye255X6QQy8UQUVh30gNsXErOwU3od4eszVxWedy
         AgLO0RaBVpxJIhUfjY3I1B93zjfwDk7ngsa92TT8QE6cFjnRh6QzUdr58kDcmfPYoytV
         vRw5YCbS0IzJ8yDnDkLx/2AHPH6Kutn0IKP2EvG0wzUF1moslVq9ATL2YKqyiwR3Ueag
         SnnimYf9wyc3Ea++ZYQh8A4Rf9JEVHp83M/GIiIvbiPSoliK67ZXtYWoIY3NLz9Pq9ll
         keOQ==
X-Gm-Message-State: AOAM530QzGjYrRw0AofU4W30jDXnqd7MBA+N9wGYiI2MYVDSl9zIKfmP
        Rv5bYBLRUFToBQhYNip4GrdyE/1kZYdSqsLAWww=
X-Google-Smtp-Source: ABdhPJxDwAdTrf5JNhaiPRmSjniG7iH1FJ4viOGdix/t1+j7VuFwLJP6i0r02qFHv39Fb5fgY3aPmg==
X-Received: by 2002:ac8:5f85:0:b0:2f3:c5c8:8cb0 with SMTP id j5-20020ac85f85000000b002f3c5c88cb0mr924833qta.408.1651782773104;
        Thu, 05 May 2022 13:32:53 -0700 (PDT)
Received: from localhost.localdomain (pool-100-33-115-203.nycmny.fios.verizon.net. [100.33.115.203])
        by smtp.gmail.com with ESMTPSA id y12-20020ac8524c000000b002f39b99f695sm1350285qtn.47.2022.05.05.13.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 13:32:52 -0700 (PDT)
From:   Goss Geppert <gg.oss.dev@gmail.com>
X-Google-Original-From: Goss Geppert <ggossdev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [RFC PATCH 1/1] dir: consider worktree config in path recursion
Date:   Thu,  5 May 2022 20:32:34 +0000
Message-Id: <20220505203234.21586-2-ggossdev@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505203234.21586-1-ggossdev@gmail.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 8d92fb2927 (dir: replace exponential algorithm with a linear one,
2020-04-01) the following no longer works:

    1) Initialize a repository.
    2) Set the `core.worktree` location to a parent directory of the
       default worktree.
    3) Add a file located in the default worktree location to the index
       (i.e. anywhere in the immediate parent directory of the gitdir).

This commit adds a check to determine whether a nested repository that
is encountered in recursing a path is actually `the_repository`.  If so,
simply treat the directory as if it doesn't contain a nested repository.

Prior to this commit, the `add` operation was silently ignored.
---
 dir.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index f2b0f24210..cef39f43d8 100644
--- a/dir.c
+++ b/dir.c
@@ -1861,7 +1861,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 */
 	enum path_treatment state;
 	int matches_how = 0;
-	int nested_repo = 0, check_only, stop_early;
+	int check_only, stop_early;
 	int old_ignored_nr, old_untracked_nr;
 	/* The "len-1" is to strip the final '/' */
 	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
@@ -1893,16 +1893,39 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 
 	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
 		!(dir->flags & DIR_NO_GITLINKS)) {
+		/*
+		 * Determine if `dirname` is a nested repo by confirming that:
+		 * 1) we are in a nonbare repository, and
+		 * 2) `dirname` is not an immediate parent of `the_repository->gitdir`,
+		 *    which could occur if the `worktree` location was manually
+		 *    configured by the user
+		 */
+		int nested_repo;
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addstr(&sb, dirname);
 		nested_repo = is_nonbare_repository_dir(&sb);
+
+		if (nested_repo) {
+			char *real_dirname, *real_gitdir;
+			strbuf_reset(&sb);
+			strbuf_addstr(&sb, dirname);
+			strbuf_complete(&sb, '/');
+			strbuf_addstr(&sb, ".git");
+			real_dirname = real_pathdup(sb.buf, 0);
+			real_gitdir = real_pathdup(the_repository->gitdir, 0);
+
+			nested_repo = !!strcmp(real_dirname, real_gitdir);
+			free(real_gitdir);
+			free(real_dirname);
+		}
 		strbuf_release(&sb);
-	}
-	if (nested_repo) {
-		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
-		    (matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
-			return path_none;
-		return excluded ? path_excluded : path_untracked;
+
+		if (nested_repo) {
+			if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
+				(matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
+				return path_none;
+			return excluded ? path_excluded : path_untracked;
+		}
 	}
 
 	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
-- 
2.36.0

