Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEAB11F404
	for <e@80x24.org>; Fri, 31 Aug 2018 05:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeHaJpY (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 05:45:24 -0400
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:45327 "EHLO
        fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeHaJpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 05:45:23 -0400
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180831053935.PJYM4163.fed1rmfepo203.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Fri, 31 Aug 2018 01:39:35 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo110.cox.net with cox
        id Vhfa1y00S59yGBo01hfaf7; Fri, 31 Aug 2018 01:39:35 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090206.5B88D497.0021,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=Zc1tDodA c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=x7bEGLp0ZPQA:10 a=dapMudl6Dx4A:10 a=WDhBSedXqNQA:10 a=kviXuzpPAAAA:8
 a=Wjvu7L9REsY3TxSKvO0A:9 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 844F129A0124;
        Thu, 30 Aug 2018 22:39:34 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH 3/3] wt-status.c: Set the commitable flag in the collect phase.
Date:   Thu, 30 Aug 2018 22:39:21 -0700
Message-Id: <20180831053921.8083-4-ischis2@cox.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831053921.8083-1-ischis2@cox.net>
References: <20180831053921.8083-1-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an update to fix a bug with "commit --dry-run" it was found that
the commitable flag was broken.  The update was, at the time,
accepted as it was better than the previous version.

Since the set of the flag had been done in wt_longstatus_print_updated,
set the flag in wt_status_collect_updated_cb.

Set the commitable flag in wt_status_collect_changes_initial to keep
from introducing a rebase regression.

Leave the setting of the commitable flag in show_merge_in_progress. If
a check for merged commits is moved to the collect phase then other
--dry-run tests fail.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 wt-status.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 5ffab6101..d50798425 100644
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
@@ -773,7 +778,6 @@ static void wt_longstatus_print_updated(struct wt_status *s)
 			continue;
 		if (!shown_header) {
 			wt_longstatus_print_cached_header(s);
-			s->commitable = 1;
 			shown_header = 1;
 		}
 		wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
-- 
2.18.0

