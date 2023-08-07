Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4424AC001DE
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 17:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjHGRJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjHGRJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 13:09:39 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5865FB1
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 10:09:38 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 050FD242B6;
        Mon,  7 Aug 2023 13:09:36 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qT3jb-ntL-00; Mon, 07 Aug 2023 19:09:35 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] sequencer: rectify empty hint in call of require_clean_work_tree()
Date:   Mon,  7 Aug 2023 19:09:35 +0200
Message-Id: <20230807170935.2336730-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162234.995514-1-oswald.buddenhagen@gmx.de>
References: <20230323162234.995514-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The canonical way to represent "no error hint" is making it null, which
shortcuts the error() call altogether. This fixes the output by removing
the line which said just "error:".

Alternatively, one could make the function treat empty strings like null
strings, which would make it resemble its original script implementation
more closely, but that doesn't seem like a worthwhile goal. If anything,
I'd go in the opposite direction and assert() that the argument is not
an empty string.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
v2:
- expanded commit message

Cc: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.40.0.152.g15d061e6df

