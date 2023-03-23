Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40564C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjCWQrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjCWQrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:04 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AF2D31E
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:33 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 6C8DF24221
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-AzJ-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH] sequencer: rewrite save_head() in terms of write_message()
Date:   Thu, 23 Mar 2023 17:22:35 +0100
Message-Id: <20230323162235.995544-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Saves some code duplication.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sequencer.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca2..ff985fb2e9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3187,25 +3187,7 @@ static int create_seq_dir(struct repository *r)
 
 static int save_head(const char *head)
 {
-	struct lock_file head_lock = LOCK_INIT;
-	struct strbuf buf = STRBUF_INIT;
-	int fd;
-	ssize_t written;
-
-	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
-	if (fd < 0)
-		return error_errno(_("could not lock HEAD"));
-	strbuf_addf(&buf, "%s\n", head);
-	written = write_in_full(fd, buf.buf, buf.len);
-	strbuf_release(&buf);
-	if (written < 0) {
-		error_errno(_("could not write to '%s'"), git_path_head_file());
-		rollback_lock_file(&head_lock);
-		return -1;
-	}
-	if (commit_lock_file(&head_lock) < 0)
-		return error(_("failed to finalize '%s'"), git_path_head_file());
-	return 0;
+	return write_message(head, strlen(head), git_path_head_file(), 1);
 }
 
 static int rollback_is_safe(void)
-- 
2.40.0.152.g15d061e6df

