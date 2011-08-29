From: sdaoden@googlemail.com
Subject: [PATCH 2/2] unpack-trees: divert check_updates() output via update_progress()
Date: Mon, 29 Aug 2011 22:17:40 +0200
Message-ID: <a768a89aa9e98435030631d6a19d6524c352acde.1314647163.git.sdaoden@gmail.com>
References: <cover.1314647163.git.sdaoden@gmail.com>
 <bc530ff857b92ad58bfd6f331cf6732ed86c42b0.1314647163.git.sdaoden@gmail.com>
Cc: Steffen Daode Nurpmeso <sdaoden@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 22:19:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy8Ic-0000ot-5R
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab1H2UTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:19:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37959 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018Ab1H2UTG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:19:06 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4798916fxh.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 13:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=ZcFSFqYeBkP7L2mA6hZ+UmvG0l+emNpz4ASt9k19nTs=;
        b=aYqGMqCNuS5UeaZi9V/owtfCJBlwhyeHbnTccVchz0ljiyAnEiN9ScI7fU/y4SA9Ce
         e5HEyNHnc0tNMlv1zYWn8fdmaIp49LOVjtxeuzxy2fV2FVeT+eywvGtxqO8tjisgF1Rk
         h/83wVHKk+2UBJzFT323A9OlgNgFEgBs8PvfA=
Received: by 10.223.7.10 with SMTP id b10mr7680006fab.76.1314649145665;
        Mon, 29 Aug 2011 13:19:05 -0700 (PDT)
Received: from localhost.localdomain ([89.204.137.171])
        by mx.google.com with ESMTPS id 11sm4034094fav.34.2011.08.29.13.19.02
        (version=SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 13:19:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.dirty
In-Reply-To: <bc530ff857b92ad58bfd6f331cf6732ed86c42b0.1314647163.git.sdaoden@gmail.com>
In-Reply-To: <cover.1314647163.git.sdaoden@gmail.com>
References: <cover.1314647163.git.sdaoden@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180345>

From: Steffen Daode Nurpmeso <sdaoden@gmail.com>

The progress shown by check_updates() yet always printed
"Checking out files", even if basically files were only
unlinked.

This commit diverts that into "Updating working tree:" plus the
actual action which currently is performed (i.e. "removing
files" or "checking out files").

Inspired-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>
---
 unpack-trees.c |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index cc616c3..95cd8a6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -178,26 +178,34 @@ static void unlink_entry(struct cache_entry *ce)
 static struct checkout state;
 static int check_updates(struct unpack_trees_options *o)
 {
-	unsigned cnt = 0, total = 0;
+	unsigned rm_cnt, co_cnt, cnt;
 	struct progress *progress = NULL;
 	struct index_state *index = &o->result;
 	int i;
 	int errs = 0;
 
 	if (o->update && o->verbose_update) {
-		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
+		rm_cnt = co_cnt = 0;
+		for (cnt = 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce = index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
-				total++;
+			switch (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE)) {
+			case CE_UPDATE:
+				co_cnt++;
+				break;
+			default:
+				rm_cnt++;
+				break;
+			}
 		}
 
-		progress = start_progress_delay("Checking out files",
-						total, 50, 1);
+		progress = start_progress_delay("Updating work tree: "
+						"removing files",
+						rm_cnt, 64, 1);
 		cnt = 0;
 	}
-
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKOUT, &o->result);
+
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -211,6 +219,13 @@ static int check_updates(struct unpack_trees_options *o)
 	remove_marked_cache_entries(&o->result);
 	remove_scheduled_dirs();
 
+	if (co_cnt > 0) {
+		update_progress(progress,
+				"Updating work tree: checking out files",
+				co_cnt);
+		cnt = 0;
+	}
+
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -222,6 +237,7 @@ static int check_updates(struct unpack_trees_options *o)
 			}
 		}
 	}
+
 	stop_progress(&progress);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
-- 
1.7.7.rc0.dirty
