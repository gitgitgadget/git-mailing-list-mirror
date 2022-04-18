Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CF8C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 01:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiDRBaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Apr 2022 21:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiDRBaG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Apr 2022 21:30:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7812601
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 18:27:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n18so11222068plg.5
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 18:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNqFptEY5V/3c7RGvte+x032caC/PSBwVohRuxaayfk=;
        b=DnvadNk9Iy95GWeZYZNYEgb2Op4KMosVypdSkbN8j/Z+vntOUHxJqK/Bxb48Ab+K+v
         aYhys9VE6UYuCLTJv8xm6asrrgs2ItCt8SBhTmtA2iDyPFiEPQRvXtTMzmVRZUhQl0uN
         H5l9tEUXl7vsLLa0MkWadqZCmcQJZHzWBoQRpT3PtJEzJC4TZoId1b/X4fHAw/ONQYht
         uKwwfxs7aEtEzf87TI13WkBslDnoRs4Y1G3PTssX1fmpMG9q6xw2kR6mxjL5FlYU053W
         jHnmNq9iusxiiyv2BzG74a92v9qEoMyLLobKBQdm74oHAm6GZL7E5vTjf2ig4kqi+bob
         +LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNqFptEY5V/3c7RGvte+x032caC/PSBwVohRuxaayfk=;
        b=zSUZu2++Tv57/ez2n3MstOTpIw2PIioK/QZJNKriAaOlHW+kzU9ZCnxc9xsRDYeA/Z
         dyVYAzsgBWUNPvF9DbQn0DTqaEf7bwDy8WjVQh1196+NDaQharLsHWF8rW4quprKS4hY
         MJb6B2E8MWUhIJ2PxLYlIpsdB24MAKaBE7bn3oXN5A3ta5N3YDTGDDkcIflSBYaAM0BG
         1rYwODhcUU9t6Qq6TaVtfK9Qfx786qM8fFZ9/i86915ZJTQrJ5Nh+LjouUV4fgMIxAVO
         z6skhpEOFMrG7YtEAB1we3NRQ7d+ssis7IWXdFKddtLlYbYDh6bQPjX0VI7hJLJMDUhc
         FuZw==
X-Gm-Message-State: AOAM531EzeRp49YNzfOco5Gma8Dbl0leqrkbZOaZDEVP7LB4ds3uM2s6
        xMdGbNecI/vKTUqUqCAd1rC8pdEPjPg=
X-Google-Smtp-Source: ABdhPJwKvSkE+qJ2zxq/c6KYyUoy3PeXvs0DDQDdhGvCxmSIKYyu+oDNqGw/Eg78DBQji1Fa3/syDA==
X-Received: by 2002:a17:90b:390d:b0:1d2:7a7d:170e with SMTP id ob13-20020a17090b390d00b001d27a7d170emr6670727pjb.230.1650245247780;
        Sun, 17 Apr 2022 18:27:27 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id c4-20020a62e804000000b0050a4ed8fe7csm6436456pfi.126.2022.04.17.18.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 18:27:27 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, liu.denton@gmail.com, sunshine@sunshineco.com,
        gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] rebase: use correct base for --keep-base when a branch is given
Date:   Sun, 17 Apr 2022 19:27:16 -0600
Message-Id: <20220418012716.2683624-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--keep-base rebases onto the merge base of the given upstream and the
current HEAD regardless of whether a branch is given. This is contrary
to the documentation and to the option's intended purpose. Instead,
rebase onto the merge base of the given upstream and the given branch.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-rebase.txt     |  5 +--
 builtin/rebase.c                 | 55 ++++++++++++++++----------------
 t/t3416-rebase-onto-threedots.sh | 33 +++++++++++++++++++
 3 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9da4647061..262fb01aec 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -215,9 +215,10 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 
 --keep-base::
 	Set the starting point at which to create the new commits to the
-	merge base of <upstream> <branch>. Running
+	merge base of <upstream> and <branch>. Running
 	'git rebase --keep-base <upstream> <branch>' is equivalent to
-	running 'git rebase --onto <upstream>... <upstream>'.
+	running
+	'git rebase --onto <upstream>...<branch> <upstream> <branch>'.
 +
 This option is useful in the case where one is developing a feature on
 top of an upstream branch. While the feature is being worked on, the
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 27fde7bf28..7f3bffc0a2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1583,33 +1583,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.upstream_arg = "--root";
 	}
 
-	/* Make sure the branch to rebase onto is valid. */
-	if (keep_base) {
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, options.upstream_name);
-		strbuf_addstr(&buf, "...");
-		options.onto_name = xstrdup(buf.buf);
-	} else if (!options.onto_name)
-		options.onto_name = options.upstream_name;
-	if (strstr(options.onto_name, "...")) {
-		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
-			if (keep_base)
-				die(_("'%s': need exactly one merge base with branch"),
-				    options.upstream_name);
-			else
-				die(_("'%s': need exactly one merge base"),
-				    options.onto_name);
-		}
-		options.onto = lookup_commit_or_die(&merge_base,
-						    options.onto_name);
-	} else {
-		options.onto =
-			lookup_commit_reference_by_name(options.onto_name);
-		if (!options.onto)
-			die(_("Does not point to a valid commit '%s'"),
-				options.onto_name);
-	}
-
 	/*
 	 * If the branch to rebase is given, that is the branch we will rebase
 	 * branch_name -- branch/commit being rebased, or
@@ -1659,6 +1632,34 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else
 		BUG("unexpected number of arguments left to parse");
 
+	/* Make sure the branch to rebase onto is valid. */
+	if (keep_base) {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, options.upstream_name);
+		strbuf_addstr(&buf, "...");
+		strbuf_addstr(&buf, branch_name);
+		options.onto_name = xstrdup(buf.buf);
+	} else if (!options.onto_name)
+		options.onto_name = options.upstream_name;
+	if (strstr(options.onto_name, "...")) {
+		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
+			if (keep_base)
+				die(_("'%s': need exactly one merge base with branch"),
+				    options.upstream_name);
+			else
+				die(_("'%s': need exactly one merge base"),
+				    options.onto_name);
+		}
+		options.onto = lookup_commit_or_die(&merge_base,
+						    options.onto_name);
+	} else {
+		options.onto =
+			lookup_commit_reference_by_name(options.onto_name);
+		if (!options.onto)
+			die(_("Does not point to a valid commit '%s'"),
+				options.onto_name);
+	}
+
 	if (options.fork_point > 0) {
 		struct commit *head =
 			lookup_commit_reference(the_repository,
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index 3716a42e81..d1db528e25 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -129,6 +129,22 @@ test_expect_success 'rebase --keep-base main from topic' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase --keep-base main topic from main' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+	git checkout main &&
+
+	git rebase --keep-base main topic &&
+	git rev-parse C >base.expect &&
+	git merge-base main HEAD >base.actual &&
+	test_cmp base.expect base.actual &&
+
+	git rev-parse HEAD~2 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase --keep-base main from side' '
 	git reset --hard &&
 	git checkout side &&
@@ -153,6 +169,23 @@ test_expect_success 'rebase -i --keep-base main from topic' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase -i --keep-base main topic from main' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+	git checkout main &&
+
+	set_fake_editor &&
+	EXPECT_COUNT=2 git rebase -i --keep-base main topic &&
+	git rev-parse C >base.expect &&
+	git merge-base main HEAD >base.actual &&
+	test_cmp base.expect base.actual &&
+
+	git rev-parse HEAD~2 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase -i --keep-base main from side' '
 	git reset --hard &&
 	git checkout side &&
-- 
2.35.3

