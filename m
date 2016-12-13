Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AC12042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934203AbcLMPci (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:54544 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934063AbcLMPb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:56 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0QLp-1ccCxW3FZl-00ubb9; Tue, 13
 Dec 2016 16:31:51 +0100
Date:   Tue, 13 Dec 2016 16:31:51 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 25/34] sequencer (rebase -i): allow rescheduling
 commands
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <afe09db26dd4d7a9adbff25f051cdf3402570a69.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PIwgZYAgf9+7GuUNhgiMmXx+9mpiUAJaGE807QTqAxfDHgXY85e
 95A9YPupnLYm+UJzqOHXdf3hiRGALzGOPRjIAH7LycnQbOwW/vjz1IBxyg8cN+blbXA0vC7
 LvafqPpUqXdY7LaOrX+gqE9fWt4L19goLsaNKxJ2yMGK7DRbAYRyYDnelHuZ/qU0xJxcrtk
 XmMopkKfWuOclAHrupAcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ylaK5exIZXo=:Bl+mZcdjFwXDYFEbV79WtB
 WFkToLMJkR7EiLEgRPBYzRgWHPTJpmf/uquB9xTEGkQKQtiGQ/B7Tl9X1TEvEvyZ8mSqSr980
 K8WmPfbvGTSu5gwLd/ZFh88yOmxqsRaPvVuCeX1PX7xDAXRhoU7PMRgMHa7SWWqcYuWwhpTiv
 B6zkTvXXStD7IfCchb/H+JsxzL+GS/7nqzY1zejDshAUqUebByu4WeZnSNmifUXqwY81+qAA+
 kJQh7niWfyZn6judLb5SJAlCn4VtPhliyxdHZoq3eca7Ruoyp8UpFp4HXVU5oFfEpGhJKYoLH
 WZlFpMKU5zUMqe91OsNZbMtWpF+VILuZxCI/oBpzjGo6aoz5J6+LB6SJ2S3ynoBR6SMXbECdQ
 UyENJuRAx9ahsIPTNxW9tt/fLlxF8Pw96BO6Q0lrjlhlx6Ixgqb19i+Ez2RQ2N7YdtxuUqABq
 Q5eEBmRgEG8JpBr8KbUPwPmjZPdgPodXvPOkzBAeAyCHnKw5NPksvvoEBf2+MSFb7o4m+uDDi
 BEGr3moUXkofmTMyWs377mUmwwydN41Shc++fBdcdDC+pc939na3qCmDGoHYGzaNRDrpvF0mX
 lk3BVD1U40ceD+zxqXhSSReJTRaasFvwxzvhmbEuuFAqAtkM5HTYlERCo7vUzx0UtlwNMnvtv
 bNWqUoz27QoOUTnQt1FYtxtYsitbwU5iXceQ5IJNPMHuHMULX6eV+QaubkVKqjmc+1mg0qRZL
 60XtgeODfoEArcZVZ0ql3l8aAD3BtxoDAh3aj8z6d06Uu4Qak6JV0xAM7SzJNsC29PLzrOfO/
 1oq8aAJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interactive rebase has the very special magic that a cherry-pick
that exits with a status different from 0 and 1 signifies a failure to
even record that a cherry-pick was started.

This can happen e.g. when a fast-forward fails because it would
overwrite untracked files.

In that case, we must reschedule the command that we thought we already
had at least started successfully.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index a67ecec961..03256b5b1d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1922,6 +1922,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					1);
 			res = do_pick_commit(item->command, item->commit,
 					opts, is_final_fixup(todo_list));
+			if (is_rebase_i(opts) && res < 0) {
+				/* Reschedule */
+				todo_list->current--;
+				if (save_todo(todo_list, opts))
+					return -1;
+			}
 			if (item->command == TODO_EDIT) {
 				struct commit *commit = item->commit;
 				if (!res)
-- 
2.11.0.rc3.windows.1


