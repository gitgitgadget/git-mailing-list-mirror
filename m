Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBF4C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 20:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiKSUMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 15:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiKSUMO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 15:12:14 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC619C03
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 12:12:13 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 402081F910
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 20:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1668888733;
        bh=ZAzoofWCM0Rz4ydq9HT7uCW4wl0L2kNtTdVZRd3b0ac=;
        h=From:To:Subject:Date:From;
        b=5JxpxlZJKdrwq+gZpPCLpOZLf8tF+uFFktOUan9B2ymu7wEKp8keYZP83yXCds+s+
         LBa6hiokjBBqQL/I4+MmTEgggRh2nTDezhlVyLGFy9hmvQj5jHbdYoXQl25lSHnQaq
         3EQyqLo3Ck0j+0IASr7ZQLUkFravNnuj1PNAkR4g=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH] prune: quiet ENOENT on missing directories
Date:   Sat, 19 Nov 2022 20:12:13 +0000
Message-Id: <20221119201213.2398081-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$GIT_DIR/objects/pack may be removed to save inodes in shared
repositories.  Quiet down prune in cases where either
$GIT_DIR/objects or $GIT_DIR/objects/pack is non-existent,
but emit the system error in other cases to help users diagnose
permissions problems or resource constraints.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/prune.c  | 4 +++-
 t/t5304-prune.sh | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index df376b2ed1..2719220108 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -127,7 +127,9 @@ static void remove_temporary_files(const char *path)
 
 	dir = opendir(path);
 	if (!dir) {
-		fprintf(stderr, "Unable to open directory %s\n", path);
+		if (errno != ENOENT)
+			fprintf(stderr, "Unable to open directory %s: %s\n",
+				path, strerror(errno));
 		return;
 	}
 	while ((de = readdir(dir)) != NULL)
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 8ae314af58..d65a5f94b4 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -29,6 +29,14 @@ test_expect_success setup '
 	git gc
 '
 
+test_expect_success 'bare repo prune is quiet without $GIT_DIR/objects/pack' '
+	git clone -q --shared --template= --bare . bare.git &&
+	rmdir bare.git/objects/pack &&
+	git --git-dir=bare.git prune --no-progress 2>prune.err &&
+	test_must_be_empty prune.err &&
+	rm -r bare.git prune.err
+'
+
 test_expect_success 'prune stale packs' '
 	orig_pack=$(echo .git/objects/pack/*.pack) &&
 	>.git/objects/tmp_1.pack &&
