Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FC1C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiETXTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354072AbiETXSl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:18:41 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3B9195791
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:16 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id 11so6619003qtp.9
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TLAI6AapyICFrZE3Dp4HZ8wn8NF8mlfweZiTnvsh/zQ=;
        b=bvHwvv5E2e/buDC6sqmdZybR6P8DZlq2N+etRWvnUZh/tem1x7gNIOYxuwIKCvfn2p
         aQdPqVjBKyzWgY5XYbOYFouatKu5h81DYS9y4ZaPR82dI0ASwOPc7DVl47dgdmdmBzzu
         /ZaePTrDjXgsLeuxTdFVVfk+2SS58cxEQN3DFbsbFH5H9C3J9s2MbO35tbavgbmHcz7Z
         XtjM34IyF/0oDMJ9sFPeXJndY6Vs9iAAp0fULmbCg7sPR2RvldX/gNBAiZgqD5mnDLdK
         OHoX/iqfa2FYZqHaFAbc9srYZ48xccd3unopSkjuhMIpVXpLyMmebQ1/rFjlBjphBJth
         bYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TLAI6AapyICFrZE3Dp4HZ8wn8NF8mlfweZiTnvsh/zQ=;
        b=38zHfg5/j4xv3/KYk8ISw+UOP6OGrHwYh/hBn7sif5ZdzUCoi+yojWZ4PAs86Ke0de
         sxXu4hexrmZqv4pkIsphPD0/Qhuz2NdJD24to2hsVjQVHQCBWqOpCMr9LUnljmO9SqQu
         T4sXoJuicQmA0X6Q/EWiH3U5w2oYe7oX/lJy6UxAZxWDRjJFhbu2fooSkZ2z+6M/zxIz
         3aYXAtOVhQPXUN7uDoEx8G9TiFibPfIwUVuansLb2mXx5hAlxfo+uIi9rTMgcjymFGlg
         8rcMBtWZEamzwxSMlE8LXhJIzVGa6Lkk8vmY7cljl2pItmYzrSuu8r3NWzn3QyOPd6F/
         jejA==
X-Gm-Message-State: AOAM532D15YRwEC4k8fYmwfdfXTJHe5jhfsSuEuqHjxWIa+zK/fZLRK/
        4Zu6Udu8bwCqnycSfmTtr7a6SSrgTFSj1Blr
X-Google-Smtp-Source: ABdhPJwgd2Dimj5Uk117tjZiDTW6igwq0FEq1BsgAQrVpzZ3I2wm1xZwemsXJu/47XeS8v0GxKOfqw==
X-Received: by 2002:ac8:5f8d:0:b0:2f3:e172:631d with SMTP id j13-20020ac85f8d000000b002f3e172631dmr9628169qta.248.1653088695647;
        Fri, 20 May 2022 16:18:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h143-20020a379e95000000b0069fc13ce226sm424668qke.87.2022.05.20.16.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:18:15 -0700 (PDT)
Date:   Fri, 20 May 2022 19:18:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 16/17] builtin/gc.c: conditionally avoid pruning objects
 via loose
Message-ID: <43c14eec0762170393c5e9681c3d5ef8fa60c96c.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expose the new `git repack --cruft` mode from `git gc` via a new opt-in
flag. When invoked like `git gc --cruft`, `git gc` will avoid exploding
unreachable objects as loose ones, and instead create a cruft pack and
`.mtimes` file.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/gc.txt   | 21 +++++++++++++-------
 Documentation/git-gc.txt      |  5 +++++
 builtin/gc.c                  | 10 +++++++++-
 t/t5329-pack-objects-cruft.sh | 37 +++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index c834e07991..38fea076a2 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -81,14 +81,21 @@ gc.packRefs::
 	to enable it within all non-bare repos or it can be set to a
 	boolean value.  The default is `true`.
 
+gc.cruftPacks::
+	Store unreachable objects in a cruft pack (see
+	linkgit:git-repack[1]) instead of as loose objects. The default
+	is `false`.
+
 gc.pruneExpire::
-	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'.
-	Override the grace period with this config variable.  The value
-	"now" may be used to disable this grace period and always prune
-	unreachable objects immediately, or "never" may be used to
-	suppress pruning.  This feature helps prevent corruption when
-	'git gc' runs concurrently with another process writing to the
-	repository; see the "NOTES" section of linkgit:git-gc[1].
+	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'
+	(and 'repack --cruft --cruft-expiration 2.weeks.ago' if using
+	cruft packs via `gc.cruftPacks` or `--cruft`).  Override the
+	grace period with this config variable.  The value "now" may be
+	used to disable this grace period and always prune unreachable
+	objects immediately, or "never" may be used to suppress pruning.
+	This feature helps prevent corruption when 'git gc' runs
+	concurrently with another process writing to the repository; see
+	the "NOTES" section of linkgit:git-gc[1].
 
 gc.worktreePruneExpire::
 	When 'git gc' is run, it calls
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 853967dea0..ba4e67700e 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -54,6 +54,11 @@ other housekeeping tasks (e.g. rerere, working trees, reflog...) will
 be performed as well.
 
 
+--cruft::
+	When expiring unreachable objects, pack them separately into a
+	cruft pack instead of storing the loose objects as loose
+	objects.
+
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
 	overridable by the config variable `gc.pruneExpire`).
diff --git a/builtin/gc.c b/builtin/gc.c
index b335cffa33..4d995e85e9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -42,6 +42,7 @@ static const char * const builtin_gc_usage[] = {
 
 static int pack_refs = 1;
 static int prune_reflogs = 1;
+static int cruft_packs = 0;
 static int aggressive_depth = 50;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
@@ -152,6 +153,7 @@ static void gc_config(void)
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
+	git_config_get_bool("gc.cruftpacks", &cruft_packs);
 	git_config_get_expiry("gc.pruneexpire", &prune_expire);
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
@@ -331,7 +333,11 @@ static void add_repack_all_option(struct string_list *keep_pack)
 {
 	if (prune_expire && !strcmp(prune_expire, "now"))
 		strvec_push(&repack, "-a");
-	else {
+	else if (cruft_packs) {
+		strvec_push(&repack, "--cruft");
+		if (prune_expire)
+			strvec_pushf(&repack, "--cruft-expiration=%s", prune_expire);
+	} else {
 		strvec_push(&repack, "-A");
 		if (prune_expire)
 			strvec_pushf(&repack, "--unpack-unreachable=%s", prune_expire);
@@ -551,6 +557,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 0, "prune", &prune_expire, N_("date"),
 			N_("prune unreferenced objects"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
+		OPT_BOOL(0, "cruft", &cruft_packs, N_("pack unreferenced objects separately")),
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL_F(0, "auto", &auto_gc, N_("enable auto-gc mode"),
 			   PARSE_OPT_NOCOMPLETE),
@@ -670,6 +677,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			die(FAILED_RUN, repack.v[0]);
 
 		if (prune_expire) {
+			/* run `git prune` even if using cruft packs */
 			strvec_push(&prune, prune_expire);
 			if (quiet)
 				strvec_push(&prune, "--no-progress");
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 8de87afce2..70a6a9553c 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -429,6 +429,43 @@ test_expect_success 'loose objects mtimes upsert others' '
 	)
 '
 
+test_expect_success 'expiring cruft objects with git gc' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit reachable &&
+		git branch -M main &&
+		git checkout --orphan other &&
+		test_commit unreachable &&
+
+		git checkout main &&
+		git branch -D other &&
+		git tag -d unreachable &&
+		# objects are not cruft if they are contained in the reflogs
+		git reflog expire --all --expire=all &&
+
+		git rev-list --objects --all --no-object-names >reachable.raw &&
+		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
+		sort <reachable.raw >reachable &&
+		comm -13 reachable objects >unreachable &&
+
+		git repack --cruft -d &&
+
+		mtimes=$(ls .git/objects/pack/pack-*.mtimes) &&
+		test_path_is_file $mtimes &&
+
+		git gc --cruft --prune=now &&
+
+		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
+
+		comm -23 unreachable objects >removed &&
+		test_cmp unreachable removed &&
+		test_path_is_missing $mtimes
+	)
+'
+
 test_expect_success 'cruft packs are not included in geometric repack' '
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
-- 
2.36.1.94.gb0d54bedca

