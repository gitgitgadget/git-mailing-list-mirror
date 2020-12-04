Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E9C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8347822CBE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgLDWWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 17:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgLDWWN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 17:22:13 -0500
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Dec 2020 14:21:33 PST
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4097AC061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 14:21:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 49987131B;
        Fri,  4 Dec 2020 23:15:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dt0XvN3FbO4H; Fri,  4 Dec 2020 23:15:00 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 80F511319;
        Fri,  4 Dec 2020 23:15:00 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1klJLv-00C3eY-GB; Fri, 04 Dec 2020 23:14:59 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     git@vger.kernel.org
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] fetch-pack: check result of index_pack_lockfile
Date:   Fri,  4 Dec 2020 23:14:57 +0100
Message-Id: <20201204221457.2873935-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fetch-pack command may fail (e.g. like in test 15 - fetch into corrupted
repo with index-pack), in which case index_pack_lockfile will return
NULL. We should then avoid adding it to pack_lockfiles, since the rest of
the code assumes that it is non-NULL. Notably transport_unlock_pack() calls
unlink_or_warn() with it, thus unlink() with it. On Linux that fortunately
only returns EFAULT, but other systems would segfault there.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 fetch-pack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index b10c432315..7d31232960 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -915,8 +915,9 @@ static int get_pack(struct fetch_pack_args *args,
 	if (start_command(&cmd))
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && pack_lockfiles) {
-		string_list_append_nodup(pack_lockfiles,
-					 index_pack_lockfile(cmd.out));
+		char *lockfile = index_pack_lockfile(cmd.out);
+		if (lockfile)
+			string_list_append_nodup(pack_lockfiles, lockfile);
 		close(cmd.out);
 	}
 
-- 
2.29.2

