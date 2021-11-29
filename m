Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D0C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhK2W3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhK2W3L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:29:11 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A236C09677C
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:45 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id x10so23587942ioj.9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXFYhkS+934u0YNkn8N8KeLFhqTMzOP0LbwQomp+tyM=;
        b=FouOZwT3PMsjnFCldvUwvrcDkTA0qhWKqKhgjUSaRUf5O5EHC4CVzQcfjluggw8uXQ
         t+c84wTNAoLmUvwM0eOC8QM5DEDe03tI7N9Vr3/2Zn6VMX14Acrd2NippxABGle4eZj7
         Flmst1yISDTekIW+rqxg/hnxU9m/Tmh0IhP3w7DxxxRPZe/JlxpCueqzLHu/6nB7YR7j
         aZVIP0KXz7IHRsSEbqh5sr8sgZbStwL1secv+0S/PbGuVPbk9A9qTQY0rM3J3qOnfI5n
         7fH4xMZhq4tuMndLc1oVPBZSp8joysfL9pHmm12Mrz7U4UBB4nVfPmt6bFQaDb/dAyXx
         Ei/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXFYhkS+934u0YNkn8N8KeLFhqTMzOP0LbwQomp+tyM=;
        b=NQdV6le9ic4UAO2irnUmKbQrt2pQUUbciYaXv6DTIO/hLKKKRkVleo0OpAvE6lUcNp
         uqRHwN9BVG2GAaIUk5Due/y5NDv47lw3pZnoRRSPKtQuLJgcU0H3WYLotap6BDjcuP4p
         XPwdr3BxLFkgfwDxpgP0juw8rbbLpdy/FHX6kaR5hJXRtqAGCaZkVo7Qg3FUIqxcXRes
         uxeHJX1Nzqi86crWsZKygMI1YpWLD20IT5ZqFXLSA4GO7STwJi8HJ73+O2NF/OKlK98x
         KG9xIPV8yBjVZ2uqhwI9f+ZiHwzd5AZMBFBw/if0DwtJZ/X21XcnpnLBet6G4AtjeZRW
         sbjQ==
X-Gm-Message-State: AOAM531t0zv/xM8Ig07TGBJj3XKkEXhX/vcu+lfYfKFtOKSb0oIAYKN/
        Ql/QrMEnzKTfB2inAQ8Y5xVB+WZiVByLXytM
X-Google-Smtp-Source: ABdhPJy1wPrMI7w1c1HbQCqNpBTaq+x5IVl9S+gHX+MH7hZ4D1d1SkdTQQyQOcFgGIA0T6xLJXTT5A==
X-Received: by 2002:a05:6638:35a0:: with SMTP id v32mr69990440jal.61.1638224744644;
        Mon, 29 Nov 2021 14:25:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o22sm11488498iow.52.2021.11.29.14.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:44 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 16/17] builtin/gc.c: conditionally avoid pruning objects via
 loose
Message-ID: <394de0199f9543208438b18a2c26b92c99f36d11.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
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
 t/t5327-pack-objects-cruft.sh | 37 +++++++++++++++++++++++++++++++++++
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
index bcef6a4c8d..c16cef0285 100644
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
@@ -550,6 +556,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 0, "prune", &prune_expire, N_("date"),
 			N_("prune unreferenced objects"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
+		OPT_BOOL(0, "cruft", &cruft_packs, N_("pack unreferenced objects separately")),
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL_F(0, "auto", &auto_gc, N_("enable auto-gc mode"),
 			   PARSE_OPT_NOCOMPLETE),
@@ -668,6 +675,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			die(FAILED_RUN, repack.v[0]);
 
 		if (prune_expire) {
+			/* run `git prune` even if using cruft packs */
 			strvec_push(&prune, prune_expire);
 			if (quiet)
 				strvec_push(&prune, "--no-progress");
diff --git a/t/t5327-pack-objects-cruft.sh b/t/t5327-pack-objects-cruft.sh
index 857f9e8855..4cd0f0cf57 100755
--- a/t/t5327-pack-objects-cruft.sh
+++ b/t/t5327-pack-objects-cruft.sh
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
+		rm -fr .git/logs &&
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
2.34.1.25.gb3157a20e6

