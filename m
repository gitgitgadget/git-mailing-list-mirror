Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E238C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjCWQrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjCWQrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:03 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE90661AE
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:32 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id C542224232
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-B01-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 1/8] rebase: simplify code related to imply_merge()
Date:   Thu, 23 Mar 2023 17:22:28 +0100
Message-Id: <20230323162235.995574-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code's evolution left in some bits surrounding enum rebase_type that
don't really make sense any more. In particular, it makes no sense to
invoke imply_merge() if the type is already known not to be
REBASE_APPLY, and it makes no sense to assign the type after calling
imply_merge().

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 builtin/rebase.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b7b908b66..8ffea0f0d8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -372,7 +372,6 @@ static int parse_opt_keep_empty(const struct option *opt, const char *arg,
 
 	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
 	opts->keep_empty = !unset;
-	opts->type = REBASE_MERGE;
 	return 0;
 }
 
@@ -1494,9 +1493,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (options.type == REBASE_MERGE)
-		imply_merge(&options, "--merge");
-
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
 
@@ -1534,7 +1530,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
-			imply_merge(&options, "--merge");
+			options.type = REBASE_MERGE;
 		else if (!strcmp(options.default_backend, "apply"))
 			options.type = REBASE_APPLY;
 		else
-- 
2.40.0.152.g15d061e6df

