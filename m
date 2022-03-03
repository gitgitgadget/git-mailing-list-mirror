Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AA4C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiCCAWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiCCAWN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:22:13 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACE813EFBD
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:21:24 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r8so3957883ioj.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GbMtn1wIABDD8QqxsvpZwEuZ0pUcuggUzT+M8lobtzM=;
        b=ayokqT15xEhRQz+9MCr5rtGrtgK85mERwOqXcUxEpG92Rs95NCt55E/IwbuP+wXsnn
         OoK4gVsm+mfLTHlvXZRzGjjxefAblfcsOJYP8sdMsmkO3+GROEeDpIfchrGTpbavPYzj
         qQS6x6vbYgNjreeSiQiWOLp6NGkEUhIffynQvM7I/7gafQTCdNbM+ArfRZ8I5QImxkwq
         I85l8fWQuhtPKKQIe4fGPos2gndyL/YHEIrAty2Tgu4Aly4XVQ5kiSt3cw0XP82rpFA5
         avt4YF/6rDCo8FkoC2xw142ULrV+8pZBKb/2GRhxVlkFbYlGvG8kdT+YbmiXdahmeZNF
         Nf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GbMtn1wIABDD8QqxsvpZwEuZ0pUcuggUzT+M8lobtzM=;
        b=1Ef5i2wfyL005XkzEC6SVCAIhD/0j+edXCe9ANukySFzvddy8lolwydo9fyOk2xyQ0
         7mkP55kekuDv2stYI/CAeCXbZkw6FQkVJxqVKX0oLAZGRQEZLDFIEvUw4YculAWz+6eb
         Qx8lPWmDyMLSTTYpfG+qOE6zAXdtFEwWz0R6r+x4MBzfrU4vmCZ5Ve234/J7StJc7Fr0
         MP28PSQdOfjkdhCSJebYkvP2CrSlIyeidDDloK4EsPIgr+0HWtdFtd4NtCLe6BM9AA0/
         ngJOiJvAARHWmHfbeK7qWW3w0LCJOw87HmfGlFB7OTHuztiRcR2ayIqwZZI/aGherJyo
         pCaw==
X-Gm-Message-State: AOAM532rPobro4+PFLLf/E3OMRrnpMVbnMrwPqG2U9M0MrSCxx1xff69
        SzbAIiSRWJ2tUNNiK9Z6tYoLOP8b9jXlnaV1
X-Google-Smtp-Source: ABdhPJzS6BiR8PcZ92KAlF6gW9pqVGj2RXNhhJHfYCWmKb4GmfECA44YUSTHFCUu9tBEvlnNF4sROA==
X-Received: by 2002:a05:6602:204c:b0:641:8fe3:1253 with SMTP id z12-20020a056602204c00b006418fe31253mr24677488iod.189.1646266883888;
        Wed, 02 Mar 2022 16:21:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o7-20020a056e02092700b002bdf00b573esm335972ilt.6.2022.03.02.16.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:21:23 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:21:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 16/17] builtin/gc.c: conditionally avoid pruning objects
 via loose
Message-ID: <1d5f334138998a3e078aba9c105bc89b71045bd1.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
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
index ffaf0daf5d..11f5150234 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -43,6 +43,7 @@ static const char * const builtin_gc_usage[] = {
 
 static int pack_refs = 1;
 static int prune_reflogs = 1;
+static int cruft_packs = 0;
 static int aggressive_depth = 50;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
@@ -153,6 +154,7 @@ static void gc_config(void)
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
+	git_config_get_bool("gc.cruftpacks", &cruft_packs);
 	git_config_get_expiry("gc.pruneexpire", &prune_expire);
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
@@ -332,7 +334,11 @@ static void add_repack_all_option(struct string_list *keep_pack)
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
@@ -552,6 +558,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 0, "prune", &prune_expire, N_("date"),
 			N_("prune unreferenced objects"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
+		OPT_BOOL(0, "cruft", &cruft_packs, N_("pack unreferenced objects separately")),
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL_F(0, "auto", &auto_gc, N_("enable auto-gc mode"),
 			   PARSE_OPT_NOCOMPLETE),
@@ -671,6 +678,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			die(FAILED_RUN, repack.v[0]);
 
 		if (prune_expire) {
+			/* run `git prune` even if using cruft packs */
 			strvec_push(&prune, prune_expire);
 			if (quiet)
 				strvec_push(&prune, "--no-progress");
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 13158e4ab7..3910e186ef 100755
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
2.35.1.73.gccc5557600

