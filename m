Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F6B1F404
	for <e@80x24.org>; Sat,  1 Sep 2018 23:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbeIBEGl (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 00:06:41 -0400
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:46428 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeIBEGk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 00:06:40 -0400
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180901235257.CHRD4136.fed1rmfepo103.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Sat, 1 Sep 2018 19:52:57 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo305.cox.net with cox
        id WPsw1y00b59yGBo01PsxYB; Sat, 01 Sep 2018 19:52:57 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090202.5B8B2659.0023,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=IdH3YSia c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=5rxgeBVgAAAA:8 a=1XWaLZrsAAAA:8
 a=kviXuzpPAAAA:8 a=4Z1IslZjDeIKamBZz-8A:9 a=PwKx63F5tFurRwaNxrlG:22
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id A36C329A012D;
        Sat,  1 Sep 2018 16:52:56 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] wt-status.c: Set the commitable flag in the collect phase.
Date:   Sat,  1 Sep 2018 16:52:56 -0700
Message-Id: <20180901235256.4260-4-ischis2@cox.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180901235256.4260-1-ischis2@cox.net>
References: <20180901235256.4260-1-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an update to fix a bug with "commit --dry-run" it was found that
the commitable flag was broken. The update was, at the time, accepted
as it was better than the previous version. [1]

Since the setting of the commitable flag had been done in
wt_longstatus_print_updated, move it to wt_status_collect_updated_cb.

Set the commitable flag in wt_status_collect_changes_initial to keep
from introducing a rebase regression.

Instead of setting the commitable flag in show_merge_in_progress, in
wt_status_cllect check for a merge that has not been committed. If
present then set the commitable flag.

Change the tests to expect success since updates to the wt-status
broken code section is being fixed.

[1] https://public-inbox.org/git/xmqqr3gcj9i5.fsf@gitster.mtv.corp.google.com/

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 t/t7501-commit.sh |  6 +++---
 wt-status.c       | 13 +++++++++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 5812dc2f8..4cda088cc 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -99,12 +99,12 @@ test_expect_success '--dry-run with stuff to commit returns ok' '
 	git commit -m next -a --dry-run
 '
 
-test_expect_failure '--short with stuff to commit returns ok' '
+test_expect_success '--short with stuff to commit returns ok' '
 	echo bongo bongo bongo >>file &&
 	git commit -m next -a --short
 '
 
-test_expect_failure '--porcelain with stuff to commit returns ok' '
+test_expect_success '--porcelain with stuff to commit returns ok' '
 	echo bongo bongo bongo >>file &&
 	git commit -m next -a --porcelain
 '
@@ -682,7 +682,7 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
 	git commit -m "conflicts fixed from merge."
 '
 
-test_expect_failure '--dry-run --short' '
+test_expect_success '--dry-run --short' '
 	# setup two branches with conflicting information
 	# in the same file, resolve the conflict
 	>test-file &&
diff --git a/wt-status.c b/wt-status.c
index 180faf6ba..578328979 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -540,10 +540,12 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 			/* Leave {mode,oid}_head zero for an add. */
 			d->mode_index = p->two->mode;
 			oidcpy(&d->oid_index, &p->two->oid);
+			s->commitable = 1;
 			break;
 		case DIFF_STATUS_DELETED:
 			d->mode_head = p->one->mode;
 			oidcpy(&d->oid_head, &p->one->oid);
+			s->commitable = 1;
 			/* Leave {mode,oid}_index zero for a delete. */
 			break;
 
@@ -561,6 +563,7 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 			d->mode_index = p->two->mode;
 			oidcpy(&d->oid_head, &p->one->oid);
 			oidcpy(&d->oid_index, &p->two->oid);
+			s->commitable = 1;
 			break;
 		case DIFF_STATUS_UNMERGED:
 			d->stagemask = unmerged_mask(p->two->path);
@@ -665,11 +668,13 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 			 * code will output the stage values directly and not use the
 			 * values in these fields.
 			 */
+			s->commitable = 1;
 		} else {
 			d->index_status = DIFF_STATUS_ADDED;
 			/* Leave {mode,oid}_head zero for adds. */
 			d->mode_index = ce->ce_mode;
 			oidcpy(&d->oid_index, &ce->oid);
+			s->commitable = 1;
 		}
 	}
 }
@@ -739,6 +744,7 @@ static int has_unmerged(struct wt_status *s)
 
 void wt_status_collect(struct wt_status *s)
 {
+	struct wt_status_state state;
 	wt_status_collect_changes_worktree(s);
 
 	if (s->is_initial)
@@ -746,6 +752,11 @@ void wt_status_collect(struct wt_status *s)
 	else
 		wt_status_collect_changes_index(s);
 	wt_status_collect_untracked(s);
+
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
+	if (state.merge_in_progress && !has_unmerged(s))
+		s->commitable = 1;
 }
 
 static void wt_longstatus_print_unmerged(struct wt_status *s)
@@ -786,7 +797,6 @@ static void wt_longstatus_print_updated(struct wt_status *s)
 			continue;
 		if (!shown_header) {
 			wt_longstatus_print_cached_header(s);
-			s->commitable = 1;
 			shown_header = 1;
 		}
 		wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
@@ -1089,7 +1099,6 @@ static void show_merge_in_progress(struct wt_status *s,
 					 _("  (use \"git merge --abort\" to abort the merge)"));
 		}
 	} else {
-		s-> commitable = 1;
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
 		if (s->hints)
-- 
2.18.0

