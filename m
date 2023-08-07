Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C82C04A6A
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 17:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjHGRJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjHGRJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 13:09:37 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C381A3
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 10:09:36 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id DA50B242B4;
        Mon,  7 Aug 2023 13:09:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qT3jb-nt6-00; Mon, 07 Aug 2023 19:09:35 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] advice: handle "rebase" in error_resolve_conflict()
Date:   Mon,  7 Aug 2023 19:09:35 +0200
Message-Id: <20230807170935.2336715-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
References: <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes sure that we get a properly translated message rather than
inserting the command (which we failed to translate) into a generic
fallback message.

The function is called indirectly via die_resolve_conflict() with fixed
strings, and directly with the string obtained via action_name(), which
in turn returns a string from a fixed set. Hence we know that the now
covered set of strings is exhausitive, and will therefore BUG() out when
encountering an unexpected string. We also know that all covered strings
are actually used.

Arguably, the above suggests that it would be cleaner to pass the
command as an enum in the first place, but that's left for another time.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
v2:
- more verbose description

Cc: Junio C Hamano <gitster@pobox.com>
---
 advice.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index e5a9bb9b44..50c79443ba 100644
--- a/advice.c
+++ b/advice.c
@@ -191,9 +191,10 @@ int error_resolve_conflict(const char *me)
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

