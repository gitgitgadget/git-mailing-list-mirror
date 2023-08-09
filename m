Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD02C04E69
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjHIRPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjHIRPi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:38 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813D71FFA
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:38 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 33AF324316;
        Wed,  9 Aug 2023 13:15:32 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmR-lEk-00; Wed, 09 Aug 2023 19:15:31 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/3] rebase: simplify code related to imply_merge()
Date:   Wed,  9 Aug 2023 19:15:29 +0200
Message-Id: <20230809171531.2564844-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
References: <xmqqiler8cga.fsf@gitster.g>
 <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
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

enum rebase_type had more values until commit a74b35081c ("rebase: drop
support for `--preserve-merges`") and commit 10cdb9f38a ("rebase: rename
the two primary rebase backends"). The latter commit also renamed
imply_interactive() to imply_merge().

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
v2:
- more verbose commit message

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 builtin/rebase.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 50cb85751f..44cc1eed12 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -386,7 +386,6 @@ static int parse_opt_keep_empty(const struct option *opt, const char *arg,
 
 	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
 	opts->keep_empty = !unset;
-	opts->type = REBASE_MERGE;
 	return 0;
 }
 
@@ -1505,9 +1504,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (options.type == REBASE_MERGE)
-		imply_merge(&options, "--merge");
-
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
 
@@ -1552,7 +1548,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
-			imply_merge(&options, "--merge");
+			options.type = REBASE_MERGE;
 		else if (!strcmp(options.default_backend, "apply"))
 			options.type = REBASE_APPLY;
 		else
-- 
2.40.0.152.g15d061e6df

