Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1AFC433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbhK3VmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344287AbhK3VmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:42:10 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1974FC0613FD
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:31 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o13so47334874wrs.12
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyj3qx543nkSIsnA9fp5SPnHtkvC5sZOGjLpkPrDfog=;
        b=ULgjCstqjBKFa6mEbYqduWV7Jw7NUwAehFQpeHmM2/OvnSLwr3nMne8hrZibkfVr1Y
         2SE4vKgLO8bGhcTbim+1UysiCnbN0Tg5vePxQR/Q2N0CtPAfjHrHRbqHDB3VEgOfEgjP
         TAjMTrJ589FvYmQirsMgdyDRufhQSa5dpt63nHgLxvbx9fBLxFrTqf25fAkEXQc4T/wd
         JA1nCV6I2ShTIf6dPFd6fTiI8osEYgKf+FLwUIwTymmeqxhbayU6XNEXYrqS8VcDD7/Q
         MffLo0W4FskosU5ccxNfWLh9lmHVrw52wXPJWhzFqfAeXg2Px7486obgxUc2XJ+NOO79
         GVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyj3qx543nkSIsnA9fp5SPnHtkvC5sZOGjLpkPrDfog=;
        b=5hf1POCNlCZ4oOIybbwdSVGo/CN9Rtrzkf4ahM5lvWTvuK52nJSTxzwvYOEeTd43ah
         XwuXzvwfgQH13ennKc4LngHtf9kVRVc4Q9gz21aIYMquzjoY/mfXNw+WI+dWQ2W4v4It
         A59nA7fHZxLXk9+M6Xz9v/gFYwhLALPO3rn56sN6wMFvbsm0GyAtUl2CUAziGroe2QYz
         uFKfedx2N2kCnmulWbLgjEL1DNgDKysz42RUd9sn6QWg/ER1S3tzP6borHij7UZVLGvR
         kI9vnm2nDUHL2Bz/WEjyJiMITfFDZAI/qfvQCwMQVwwgnvdemYfMa0qukeTAy9AwKeOO
         WGzQ==
X-Gm-Message-State: AOAM531rBajfRhQ1W6pCEvonsaJFlNa8kXGN+jeT0nChLZvOCMddItVm
        sp553X2eM6wAWF8mWPFZeJlBLdBTfC3xbw==
X-Google-Smtp-Source: ABdhPJxpCw+3cslnlqo7aAwzDGQx9vob05NBuH4+IgBig0PkDuYeYcMFawwe678iOe5TxyFvbnduoQ==
X-Received: by 2002:a05:6000:18ac:: with SMTP id b12mr1766843wri.355.1638308309709;
        Tue, 30 Nov 2021 13:38:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.28
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
Subject: [PATCH 12/12] gc + reflog: don't stall before initial "git gc" progress output
Date:   Tue, 30 Nov 2021 22:38:14 +0100
Message-Id: <patch-12.12-fc2b15d0abe-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "git reflog expire --all" progress output to show progress
on mark_reachable() in addition to the "Expiring reflogs" output added
in the preceding commit.

This is a major UI improvement to the "git gc" progress output, which
in large repositories would seem to hang before the "initial"
"Enumerating objects" phase. E.g. on a linux.git checkout I've got it
previously took me around 10 seconds before I saw any output.

With the change to add the "Expiring reflogs" output in the preceding
commit that ~10 second delay was perhaps ~8-9, now it's pretty much
guaranteed to show output within the first couple of seconds (our
default progress delay).

Why? Because as we iterate through our reflogs to expire in
reflog_exire() we'd always check the reflog for "HEAD" first, and as
we hadn't previously marked anything REACHABLE in mark_reachable()
would almost certainly end up needing to walk a substantial amount of
history to mark commits. In linux.git north of 1 million commits.

Now we'll instead show:

    $ git gc
    Iterating (un)reachable HEAD: 1137354, done.
    Expiring reflogs: 100% (45/45), done.
    ^Enmerating objects: 662499^C
    [...]

The implementation is a bit of a hack. Ideally we'd support nested
progress bars, and the ability to "attach" a sub-progress bar to a
running one. I.e. to optimistically show either:

    Expiring reflogs: X (Y/Z)

Or:

    Expiring reflogs: X (Y/Z) iterating unreachable HEAD: 123456

In this case the problem is that if we have done our initial big
"REACHABLE" iteration we're usually going to process the reflog quite
quickly, but if we haven't we'd stall.

So as a hack pass down a "show_progress" to reflog_expiry_prepare(),
which will only be shown if we haven't processed the UE_HEAD
case. We'll then start a progress bar, which when passed through to
mark_reachable() will almost certainly result in a substantial initial
iteration.

Then when we've done that initial walk we'll stop that progress bar in
our main loop, and start the "Expiring reflogs" progress bar. We'll
usually start it at 2/X, since our "HEAD" was the 1/X usurped by the
"Iterating (un)reachable HEAD" progress bar.

The "usually" would assume that we wouldn't hit the
"cb->no_reachable_progress = 1" case being added here. I.e. if our
configuration is such that we're not going to do the UE_HEAD walk
we'll just fall back on only using "Expiring reflogs". We'll still
start the count at the 2nd reflog, but it shouldn't matter, on e.g. my
linux.git checkout it doesn't, the progress bar goes by too fast to
notice.

It would have been nicer to be able to compute the
"cb->unreachable_expire_kind" before we call reflog_expire(), but to
do that we'd need the "oid", which we'll only know once we lock it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 53 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 1a2a210ecf1..ef4f039a20c 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -47,7 +47,11 @@ struct expire_reflog_policy_cb {
 	struct commit *tip_commit;
 	struct commit_list *tips;
 	unsigned int dry_run:1,
-		     verbose:1;
+		     verbose:1,
+		     show_progress:1,
+		     no_reachable_progress:1;
+	struct progress *reachable_progress;
+	uint64_t reachable_progress_cnt;
 };
 
 struct worktree_reflogs {
@@ -235,6 +239,8 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
 	while (pending) {
 		struct commit_list *parent;
 		struct commit *commit = pop_commit(&pending);
+
+		display_progress(cb->reachable_progress, ++cb->reachable_progress_cnt);
 		if (commit->object.flags & REACHABLE)
 			continue;
 		if (parse_commit(commit))
@@ -375,16 +381,27 @@ static void reflog_expiry_prepare(const char *refname,
 		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
 	}
 
-	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
+	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total) {
+		if (cb->show_progress &&
+		    cb->unreachable_expire_kind == UE_HEAD)
+			cb->no_reachable_progress = 1;
 		cb->unreachable_expire_kind = UE_ALWAYS;
+	}
 
 	switch (cb->unreachable_expire_kind) {
 	case UE_ALWAYS:
 		return;
 	case UE_HEAD:
+		if (cb->show_progress) {
+			const char *s = _("Iterating (un)reachable HEAD");
+			cb->reachable_progress = start_delayed_progress(s, 0);
+		}
 		for_each_ref(push_tip_to_list, &cb->tips);
-		for (elem = cb->tips; elem; elem = elem->next)
+		for (elem = cb->tips; elem; elem = elem->next) {
+			display_progress(cb->reachable_progress,
+					 ++cb->reachable_progress_cnt);
 			commit_list_insert(elem->item, &cb->mark_list);
+		}
 		break;
 	case UE_NORMAL:
 		commit_list_insert(commit, &cb->mark_list);
@@ -633,9 +650,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		struct worktree_reflogs collected = {
 			.reflogs = STRING_LIST_INIT_NODUP,
 		};
-		struct string_list_item *item;
 		struct worktree **worktrees, **p;
-		uint64_t progress_cnt;
+		int show_head_progress = show_progress;
+		size_t j;
 
 		if (show_progress)
 			collected.progress = start_delayed_progress(_("Enumerating reflogs"),
@@ -652,27 +669,31 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		free_worktrees(worktrees);
 		stop_progress(&collected.progress);
 
-		if (show_progress) {
-			progress_cnt = 0;
-			progress = start_delayed_progress(_("Expiring reflogs"),
-							  collected.reflogs.nr);
-		}
-
-		for_each_string_list_item(item, &collected.reflogs) {
+		for (j = 0; j < collected.reflogs.nr; j++) {
+			const char *string = collected.reflogs.items[j].string;
 			struct expire_reflog_policy_cb cb = {
 				.cmd = cmd,
 				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
 				.verbose = verbose,
+				.show_progress = show_head_progress,
 			};
-
-			display_progress(progress, ++progress_cnt);
-			set_reflog_expiry_param(&cb.cmd, explicit_expiry, item->string);
-			status |= reflog_expire(item->string, flags,
+			display_progress(progress, j + 1);
+			set_reflog_expiry_param(&cb.cmd, explicit_expiry, string);
+			status |= reflog_expire(string, flags,
 						reflog_expiry_prepare,
 						should_expire_reflog_ent,
 						reflog_expiry_cleanup,
 						&cb);
+
+			if (show_head_progress &&
+			    (cb.reachable_progress || cb.no_reachable_progress)) {
+				stop_progress(&cb.reachable_progress);
+				show_head_progress = 0;
+				progress = start_delayed_progress(_("Expiring reflogs"),
+								  collected.reflogs.nr);
+			}
 		}
+		display_progress(progress, collected.reflogs.nr); /* only HEAD? */
 		stop_progress(&progress);
 		collected.reflogs.strdup_strings = 1;
 		string_list_clear(&collected.reflogs, 0);
-- 
2.34.1.877.g7d5b0a3b8a6

