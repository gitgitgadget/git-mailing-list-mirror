Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E23C433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbhK3VmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbhK3VmE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:42:04 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B39C0613DD
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so47419611wru.13
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gx5l/5AyhDJIXoMKtTIMSn+SDEEKAqgY84OQzXkG71U=;
        b=mzv5H34W93VqfJZ7Dmuulu4hkm3g7gDwn38v1lig6s6EF075Sh0LMWfDnZ1QDk7lP/
         dwqPhqNGQPBRiE/YxY4r19Sq4omExGzXFfvyxmNGpy7Ksi3FQhgdrDES89z7AVvlhXju
         onKvSsRmIOIM22yBGHwsjPqaSvBPInLCs92xY6QnNl6ydzxsT7SLRPJ19k3iOjIjdbLR
         jukYGb35rcWaPUERBocUbZiQv6kRCfhzCcGLCn0pnSUnK+YDd8CJAZA1+pAp8S/eNKpz
         wec301ozPa2nC+zAHFu8Eqn8tzDj83AmSGeyZxHZ+tJFfqfMTTBkkHL/Lgf5APzQZyb2
         sUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gx5l/5AyhDJIXoMKtTIMSn+SDEEKAqgY84OQzXkG71U=;
        b=zyUxRq8b5n6H2IrT3qsypt7ybUw85Ob1/KSGoRDy7cTvlLan/XlKzQJcn7IoTIiP3Y
         t4/MebAnE9r6XSFXZtFQtAWrwGwuoCH3w1nG4FW++n8/gLiBWIylFkmGIe1DZWsgzLtB
         5bOELMIBxQo6gmfJmd+UmrsrawWU46Y6c7sip3HHkw74Yhn2P0JO5vvyny0sccjnxX6y
         yt94OHAYIYquGpeQV8/n8MCtJqZYXlJ5S7O89Jtk7DTPPZ5Aw6xEj3kAxshFYBZ4VPWK
         XcUptLaWd89CKU66qXwZdlXTzKTRo3EHSadj8oKybq5ln19Tf3STiZ6YxsdglsEMu7X9
         8wKg==
X-Gm-Message-State: AOAM532kM5vZwj7JTMvuZKS9E7f80m4t60MHPJGOFmb03cAyQK0ZU4O1
        Hceu9dTLsDRxNyQ31Q+jAwDaoj6MvRAUPw==
X-Google-Smtp-Source: ABdhPJwbxYokp/04gE0ocilUDCMPM7dxC1O9UWaSC+DaN4Jh447j1G9IiNoP2jOw6SQFWvdzDE548A==
X-Received: by 2002:a5d:668f:: with SMTP id l15mr1783319wru.182.1638308308648;
        Tue, 30 Nov 2021 13:38:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:38:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/12] gc + reflog: emit progress output from "reflog expire --all"
Date:   Tue, 30 Nov 2021 22:38:13 +0100
Message-Id: <patch-11.12-794e6e677a8-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emit progress output on "git reflog expire --all", which is what "git
gc" runs. On my git.git checkout I'll now get:

    $ time GIT_PROGRESS_DELAY=0 ~/g/git/git reflog expire --all --dry-run
    Enumerating reflogs: 23782, done.
    Expiring reflogs: 100% (23782/23782), done.

    real    0m3.264s
    user    0m2.308s
    sys     0m0.941s

The "Enumerating reflogs" is too fast to appear for me except with
GIT_PROGRESS_DELAY=0. We'll also emit this at the top of "git gc"
output:

    $ ~/g/git/git --exec-path=$PWD gc
    Expiring reflogs: 100% (23782/23782), done.
    Enumerating objects: [...]

This goes a long way (but not quite, a subsequent commit will) to
addressing the seeming halting of "git gc" on startup. That usually
happens because of the "HEAD" case in "reflog expire --all" and
unreachable().

Note that this code isn't going to be affected by the sort of bug we
had to fix in 6b89a34c89f (gc: fix regression in 7b0f229222 impacting
--quiet, 2018-09-19).

This is because "git gc" even with "--auto" won't detach until after
it runs "git reflog -expire", so whatever output we emit will never
end up in the gc.log. We should still obey its --quiet to mean our
--no-progress, but we don't need a special-case for "daemonized" as
write_commit_graph_reachable() does.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c     |  4 +++-
 builtin/reflog.c | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bcef6a4c8da..872209e083e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -593,8 +593,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		if (aggressive_window > 0)
 			strvec_pushf(&repack, "--window=%d", aggressive_window);
 	}
-	if (quiet)
+	if (quiet) {
+		strvec_push(&reflog, "--no-progress");
 		strvec_push(&repack, "-q");
+	}
 
 	if (auto_gc) {
 		/*
diff --git a/builtin/reflog.c b/builtin/reflog.c
index cf0ef68d82d..1a2a210ecf1 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -53,6 +53,7 @@ struct expire_reflog_policy_cb {
 struct worktree_reflogs {
 	struct worktree *worktree;
 	struct string_list reflogs;
+	struct progress *progress;
 };
 
 /* Remember to update object flag allocation in object.h */
@@ -324,7 +325,7 @@ static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *no
 
 	return 0;
 expire:
-	if (cb->dry_run)
+	if (cb->verbose && cb->dry_run)
 		printf("would prune %s", message);
 	else if (cb->verbose)
 		printf("prune %s", message);
@@ -426,6 +427,7 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
 	if (!worktree->is_current && ref_type(ref) == REF_TYPE_NORMAL)
 		return 0;
 
+	display_progress(cb->progress, cb->reflogs.nr + 1);
 	strbuf_worktree_ref(worktree, &newref, ref);
 	string_list_append(&cb->reflogs, strbuf_detach(&newref, NULL));
 
@@ -627,11 +629,17 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	}
 
 	if (do_all) {
+		struct progress *progress = NULL;
 		struct worktree_reflogs collected = {
 			.reflogs = STRING_LIST_INIT_NODUP,
 		};
 		struct string_list_item *item;
 		struct worktree **worktrees, **p;
+		uint64_t progress_cnt;
+
+		if (show_progress)
+			collected.progress = start_delayed_progress(_("Enumerating reflogs"),
+								    0);
 
 		worktrees = get_worktrees();
 		for (p = worktrees; *p; p++) {
@@ -642,6 +650,13 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 					     collect_reflog, &collected);
 		}
 		free_worktrees(worktrees);
+		stop_progress(&collected.progress);
+
+		if (show_progress) {
+			progress_cnt = 0;
+			progress = start_delayed_progress(_("Expiring reflogs"),
+							  collected.reflogs.nr);
+		}
 
 		for_each_string_list_item(item, &collected.reflogs) {
 			struct expire_reflog_policy_cb cb = {
@@ -650,6 +665,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 				.verbose = verbose,
 			};
 
+			display_progress(progress, ++progress_cnt);
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, item->string);
 			status |= reflog_expire(item->string, flags,
 						reflog_expiry_prepare,
@@ -657,6 +673,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 						reflog_expiry_cleanup,
 						&cb);
 		}
+		stop_progress(&progress);
 		collected.reflogs.strdup_strings = 1;
 		string_list_clear(&collected.reflogs, 0);
 	}
-- 
2.34.1.877.g7d5b0a3b8a6

