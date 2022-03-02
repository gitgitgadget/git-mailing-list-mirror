Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C3BC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiCBA7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238857AbiCBA7V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:59:21 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C396821
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:38 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id x14so220215ill.12
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tJ5y9v0gXaKx24xZzUVGCytrnbRLdE4kNZ9zqtJ4x9U=;
        b=wgLtl3lrQKPy15wkW8hvtLnDTGAyygim0ILbaST7+aYjGkLdZUFYoYl9OsSMINUZJ1
         FaLmv6/KC1AQ5vMX1ZrwAaSjbX5Kd9J1cQHB9btdgN62Wa1SscvB5/DARqIaI/alTHHp
         bgx1IZF/Wtntr/fLajhBqRG8M5cRvLn5mstWh0gullwXec1+lLyFOX5oESD9TxRQ31tR
         dFayugQj4NDmU4Fcsot0wMftOFyeqcN8SCjLMj6rLmi///lzN3kRS/pNHyTUn5y2q1F/
         FbcrkjHGXia7BLKRrXMx7531ghpjDot8xE9Zb3G8wLKzHaBBywi+VkBWXvxelx/I74Ab
         Xp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJ5y9v0gXaKx24xZzUVGCytrnbRLdE4kNZ9zqtJ4x9U=;
        b=lx/XjNp/lJgu0ZXwsl0NYT4T2XpALAtfe9EiiRfK6MgIiQJLgmQAP9bgeaCf0zjPI2
         xTlVe6mThlxZZ7hb2Q9WsmdHoLy1F6a70d8B8d9zogaLC9eoT3qmiHUgMYolkWr7io8j
         XZFi6odsknoLlzXjQDCy62b501G8kzsyLspjE4buBWRM9h0pKpm7+Re6Uyp3yhJGo2p1
         Uoi6zQ+N57I/nH5iKxFzJrKr1gvbUZZMYq8C+po0mmd+x7+MqXj2EdubC0LFXNvm0cxf
         9IlVt3FW3ZM+4W55JLquSSO+T6xreOzmofrni5R4x4b3sd1IJFhYzFglc61GOW1wiHri
         S2YA==
X-Gm-Message-State: AOAM531IKFOLTLPsXG6m9gLX5qP/SWjWBA1I2E9bJXepfm/B3Yckyy+M
        LqoxLTpKGClyCsmdKdmygACNq2XZUYGimoYp
X-Google-Smtp-Source: ABdhPJwPzgSrjFtfDR9rTr7V4yH8g+tQ5RUUW5/g/Xd7TA31gCM7p1XO2xKEnravjsBEYaWt84Tf/A==
X-Received: by 2002:a05:6e02:2168:b0:2c1:a436:d18c with SMTP id s8-20020a056e02216800b002c1a436d18cmr24376955ilv.49.1646182717220;
        Tue, 01 Mar 2022 16:58:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o7-20020a056e02092700b002bdf00b573esm8312754ilt.6.2022.03.01.16.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:58:37 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:58:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 16/17] builtin/gc.c: conditionally avoid pruning objects
 via loose
Message-ID: <7a21ae1494eb59ab291b1c9cbdc2dcff93c4df9b.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
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
 t/t5328-pack-objects-cruft.sh | 37 +++++++++++++++++++++++++++++++++++
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
diff --git a/t/t5328-pack-objects-cruft.sh b/t/t5328-pack-objects-cruft.sh
index 13158e4ab7..3910e186ef 100755
--- a/t/t5328-pack-objects-cruft.sh
+++ b/t/t5328-pack-objects-cruft.sh
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

