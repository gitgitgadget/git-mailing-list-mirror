Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C37C4332F
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbhLPNpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbhLPNpY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:45:24 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092FBC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:24 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y83-20020a1c7d56000000b003456dfe7c5cso844408wmc.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYdGryJYvlho+9+fqSCE0zqDpcU3+XhdOMIhuQzISYs=;
        b=ZRULjKmj08rI3swqNi61ysb7b+FyLgglOkdQCmFubDDGS8Si44LV9BkJ4mxW40hPjC
         5Jvc5IUto2W5SoJnFTpZIz0QO9Mr1YqiZlRTPcEiNNXkuOVr72xI7bZJzkLDl1oLJb0n
         42BkTNp8rFOhkffAvaSKKwyEn7dusuzjdo6gUa3/HG4d0vKoVE1PrJU/+mKzbaSR8les
         6ix4L68JCKxi3bz1AqDL6CeajTTGEo7eNTPscm16LFavOeP2ny6sXlsiOHREBByvDRAa
         da+bfPBKM6SKkNq1H10qFjzsEONEc398KlargXbVfIS6aXl+dzm/Dt8TWTCduNNMEfjY
         IqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYdGryJYvlho+9+fqSCE0zqDpcU3+XhdOMIhuQzISYs=;
        b=NCSTG5zEANv3148S2EJYBoTMTCJfSoboOvWBPpin6Vj1gY1C4pIZYEsS/P0UhxGuuP
         H1dZ+O3yPVEnqxSVY60uywlusyJsZLtsSGy7a4gxvVuzuPft4BWvKzKL50gzRI8CQVLw
         O13jwTyrJq93WO0lSb8+lBXmDKXEuguq8qBKWB6VeC/o5e/CF7dAgXIW6A5jcCBG/COp
         A6pfbhKr2jBGbYQtjRazE8GMhS3xV6Ysq8ISJZENoY8L9WIfLyUniIo3efkWwzQKBnFK
         UfZZi7JEXijWl8+PaXUrshEYEGZ15llKPBwoh4fIGe5wO458fBeplZ+bzO67jw6hQ+8S
         USow==
X-Gm-Message-State: AOAM530Wov/kF7OhHtKlA8pZ7fifoZpkK5qPYjqV/aG1lbUiK9ePRi98
        lVVwwgeEn6fnGXZUZIb2JUwKLxWSXzeXUA==
X-Google-Smtp-Source: ABdhPJza4WpHHc2ICXnI0sHvst4VTwWdZRcvlVJq75iSSV7uFNPRT2JrevU5ov6JETbOMcoVxOdkZw==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr5105811wmh.3.1639662322360;
        Thu, 16 Dec 2021 05:45:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm4866821wrn.73.2021.12.16.05.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:45:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/9] reflog expire: narrow scope of "cb" in cmd_reflog_expire()
Date:   Thu, 16 Dec 2021 14:45:11 +0100
Message-Id: <patch-v2-2.9-b8e84538427-20211216T134028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gc80c40b6642
In-Reply-To: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
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
2.34.1.1020.gc80c40b6642

