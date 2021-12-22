Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932CEC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbhLVEHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbhLVEHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:07:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CC1C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so2074085wrg.7
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BYnUlKn2eNIYmWEMZ6Z2/eS1UBm1ZPbK7ei5q2mk3Rc=;
        b=AmXdcOS+qwXvMSGrynsrxhXzFQxx2bRR8oRDeMDjebS1BaqJsFHSsfGuiP6XJrRFIS
         A1P5iQar998FgOedKPg6HcfeeRyqND/mtSwVOuIFZsCrsNwoWCeNP2Ok+CPmIdsCG4LA
         mOIu9luvrNCNH3qR5GFdecj5twNo26zU2MLtRe/1k+icAWuHKijMcGU4o8H5M448NFcp
         Zyyt4IA1QBa9mpif62BR9X+lTP4pId1UNNZYuDQDMkp7uXASyQTaW4LBxJdnNWZVcKWE
         ae4u+D5sCkX7mH7YY+WbIBMfY/nsLDX0SYF2XAp94abQdIFkeB1MbQLmRwj+Bh4WX6nP
         ACZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYnUlKn2eNIYmWEMZ6Z2/eS1UBm1ZPbK7ei5q2mk3Rc=;
        b=y0opx9cBqmz7GiSrRwyEU3I1b9WW6CWmryjbKQc0vCgRe6VyS9OzS42OvdTM2fMI+o
         nWdeU2f5mAhQrWEkhovslgh1O3+x6QE/CF5n7bJFC2A9liCGjwY8uXD7Ha8Y1GWKVapJ
         LfdwcGDlr5OHKZQOyJwI4th6KJDwox39ZQ+9ObN7TVZByCpDL96aglPs3zuxSC8klYmt
         yB+AFSEfpiBLLsszm6LAd8HxCUfJe36amIlsp6T2ec9TzqOvUbQICzWo/JthzTFci8/J
         /O6MK/qmrbkLrtCTYmy+hGTn3ZW4bKykzm1NC03dxnHSQA1470C+rALDyee1mUKwmfs+
         aaXw==
X-Gm-Message-State: AOAM533Y/SL8FB5AaOSonZe55ExZTsLoplfwsInJGlDLrw2brO0Fo8NL
        vBYP0s7hH17W0TfVwCXsI/v3VlIXR5fDQg==
X-Google-Smtp-Source: ABdhPJyJ/xZyefkPf3uX1SQPV0/dt31qQM4VB2LsuJUfk5+cGDsBGtMaNJvFOL56BzPvvqcV+o+3EQ==
X-Received: by 2002:adf:a152:: with SMTP id r18mr758273wrr.230.1640146026468;
        Tue, 21 Dec 2021 20:07:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm710484wru.87.2021.12.21.20.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:07:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/9] reflog expire: narrow scope of "cb" in cmd_reflog_expire()
Date:   Wed, 22 Dec 2021 05:06:41 +0100
Message-Id: <patch-v3-2.9-1ffc8ef8a8b-20211222T040557Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the preceding change for "reflog delete", change the "cb_data"
we pass to callbacks to be &cb.cmd itself, instead of passing &cb and
having the callback lookup cb->cmd.

This makes it clear that the "cb" itself is the same memzero'd
structure on each iteration of the for-loops that use &cb, except for
the "cmd" member.

The "struct expire_reflog_policy_cb" we pass to reflog_expire() will
have the members that aren't "cmd" modified by the callbacks, but
before we invoke them everything except "cmd" is zero'd out.

This included the "tip_commit", "mark_list" and "tips". It might have
looked as though we were re-using those between iterations, but the
first thing we did in reflog_expiry_prepare() was to either NULL them,
or clobber them with another value.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4c15d71f3e9..6989492bf5c 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -357,7 +357,6 @@ static void reflog_expiry_prepare(const char *refname,
 	struct expire_reflog_policy_cb *cb = cb_data;
 
 	if (!cb->cmd.expire_unreachable || is_head(refname)) {
-		cb->tip_commit = NULL;
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
 		cb->tip_commit = lookup_commit_reference_gently(the_repository,
@@ -371,8 +370,6 @@ static void reflog_expiry_prepare(const char *refname,
 	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
 		cb->unreachable_expire_kind = UE_ALWAYS;
 
-	cb->mark_list = NULL;
-	cb->tips = NULL;
 	if (cb->unreachable_expire_kind != UE_ALWAYS) {
 		if (cb->unreachable_expire_kind == UE_HEAD) {
 			struct commit_list *elem;
@@ -541,7 +538,7 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
-	struct expire_reflog_policy_cb cb;
+	struct cmd_reflog_expire_cb cmd = { 0 };
 	timestamp_t now = time(NULL);
 	int i, status, do_all, all_worktrees = 1;
 	int explicit_expiry = 0;
@@ -553,10 +550,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = 0;
 	do_all = status = 0;
-	memset(&cb, 0, sizeof(cb));
 
-	cb.cmd.expire_total = default_reflog_expire;
-	cb.cmd.expire_unreachable = default_reflog_expire_unreachable;
+	cmd.expire_total = default_reflog_expire;
+	cmd.expire_unreachable = default_reflog_expire_unreachable;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -564,17 +560,17 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			flags |= EXPIRE_REFLOGS_DRY_RUN;
 		else if (skip_prefix(arg, "--expire=", &arg)) {
-			if (parse_expiry_date(arg, &cb.cmd.expire_total))
+			if (parse_expiry_date(arg, &cmd.expire_total))
 				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |= EXPIRE_TOTAL;
 		}
 		else if (skip_prefix(arg, "--expire-unreachable=", &arg)) {
-			if (parse_expiry_date(arg, &cb.cmd.expire_unreachable))
+			if (parse_expiry_date(arg, &cmd.expire_unreachable))
 				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |= EXPIRE_UNREACH;
 		}
 		else if (!strcmp(arg, "--stale-fix"))
-			cb.cmd.stalefix = 1;
+			cmd.stalefix = 1;
 		else if (!strcmp(arg, "--rewrite"))
 			flags |= EXPIRE_REFLOGS_REWRITE;
 		else if (!strcmp(arg, "--updateref"))
@@ -600,14 +596,14 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	 * even in older repository.  We cannot trust what's reachable
 	 * from reflog if the repository was pruned with older git.
 	 */
-	if (cb.cmd.stalefix) {
-		repo_init_revisions(the_repository, &cb.cmd.revs, prefix);
-		cb.cmd.revs.do_not_die_on_missing_tree = 1;
-		cb.cmd.revs.ignore_missing = 1;
-		cb.cmd.revs.ignore_missing_links = 1;
+	if (cmd.stalefix) {
+		repo_init_revisions(the_repository, &cmd.revs, prefix);
+		cmd.revs.do_not_die_on_missing_tree = 1;
+		cmd.revs.ignore_missing = 1;
+		cmd.revs.ignore_missing_links = 1;
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf(_("Marking reachable objects..."));
-		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
+		mark_reachable_objects(&cmd.revs, 0, 0, NULL);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			putchar('\n');
 	}
@@ -629,6 +625,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		free_worktrees(worktrees);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
+			struct expire_reflog_policy_cb cb = { .cmd = cmd };
 
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
 			status |= reflog_expire(e->reflog, flags,
@@ -643,6 +640,8 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	for (; i < argc; i++) {
 		char *ref;
+		struct expire_reflog_policy_cb cb = { .cmd = cmd };
+
 		if (!dwim_log(argv[i], strlen(argv[i]), NULL, &ref)) {
 			status |= error(_("%s points nowhere!"), argv[i]);
 			continue;
-- 
2.34.1.1146.gb52885e7c44

