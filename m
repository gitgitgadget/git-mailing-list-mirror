Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F0C04FE0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjHIRPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjHIRPh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:37 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A511FF7
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:35 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 0467D24313;
        Wed,  9 Aug 2023 13:15:32 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmR-lEM-00; Wed, 09 Aug 2023 19:15:31 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] sequencer: rectify empty hint in call of require_clean_work_tree()
Date:   Wed,  9 Aug 2023 19:15:31 +0200
Message-Id: <20230809171531.2564829-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <xmqqa5v2ehba.fsf@gitster.g>
References: <xmqqa5v2ehba.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The canonical way to represent "no error hint" is making it NULL, which
shortcuts the error() call altogether. This fixes the output by removing
the line which said just "error:", which would appear when starting a
rebase whose initial checkout worked fine despite a dirty worktree. This
was introduced by 97e1873 (rebase -i: rewrite complete_action() in C,
2018-08-28), which did a somewhat inaccurate conversion from shell.

To avoid that such bugs re-appear, test for the condition in
require_clean_work_tree().

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
v3:
- added BUG()
- rewrote commit message again
v2:
- expanded commit message

Cc: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c | 2 +-
 wt-status.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cc9821ece2..d15a7409d8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6182,7 +6182,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
 		goto cleanup;
 
-	if (require_clean_work_tree(r, "rebase", "", 1, 1))
+	if (require_clean_work_tree(r, "rebase", NULL, 1, 1))
 		goto cleanup;
 
 	todo_list_write_total_nr(&new_todo);
diff --git a/wt-status.c b/wt-status.c
index 8a1a4fb1f0..c8c1780566 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2654,8 +2654,12 @@ int require_clean_work_tree(struct repository *r,
 	}
 
 	if (err) {
-		if (hint)
+		if (hint) {
+			if (!*hint)
+				BUG("empty hint passed to require_clean_work_tree();"
+				    " use NULL instead");
 			error("%s", hint);
+		}
 		if (!gently)
 			exit(128);
 	}
-- 
2.40.0.152.g15d061e6df

