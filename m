Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98EFC77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 12:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbjD1M44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 08:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjD1M4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 08:56:52 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028942D58
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 05:56:50 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 812DB23FF7;
        Fri, 28 Apr 2023 08:56:49 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1psNeb-DOp-00; Fri, 28 Apr 2023 14:56:49 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] advice: handle "rebase" in error_resolve_conflict()
Date:   Fri, 28 Apr 2023 14:56:47 +0200
Message-Id: <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes sure that we get a properly translated message rather than
inserting the command (which we failed to translate) into a generic
fallback message.

We now also BUG() out when encountering an unexpected command.

Arguably, it would be cleaner to pass the command as an enum in the
first place ...

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>
---
 advice.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index d6232439c3..c35ae82e7d 100644
--- a/advice.c
+++ b/advice.c
@@ -190,9 +190,10 @@ int error_resolve_conflict(const char *me)
 		error(_("Pulling is not possible because you have unmerged files."));
 	else if (!strcmp(me, "revert"))
 		error(_("Reverting is not possible because you have unmerged files."));
+	else if (!strcmp(me, "rebase"))
+		error(_("Rebasing is not possible because you have unmerged files."));
 	else
-		error(_("It is not possible to %s because you have unmerged files."),
-			me);
+		BUG("Unhandled conflict reason '%s'", me);
 
 	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 		/*
-- 
2.40.0.152.g15d061e6df

