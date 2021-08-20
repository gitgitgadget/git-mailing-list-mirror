Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BF2C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 19:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F318B6113E
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 19:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhHTTfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 15:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbhHTTfr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 15:35:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AADC061756
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=nEq3rMyZ4qLpOe+9odWiOSe4HKSfrIUDYQMZk2Jm5iU=; t=1629488108; x=1630697708; 
        b=FLxBI8+sW7oh8J3j6AIWupw9mSwMnwLkdNUEzPpmUIR/oJEwSRnHaJJQgFzWsFpsDouxhIBoTiZ
        CWyukrL0BSVaRsOYZt8G8nl1lzKdzR+RQE4FKb9vRugaT1SDe2ko791dabTe8tSAmiwKAaCWmP111
        +4s9tLB1DsYWMD9dSgILRbuP0QXH6vmeMDChMk28P1LnwwE3kx8y5EqeEcHTjoc37aZSHlvv1pTH9
        Z7dOjfcku9n4zN2UfBnu+xWgmObWTIy8UwQGrybo00ODTjZ7fUqjOgTvS35tjmfaVRvm87t7BFbHM
        HHEr38OvFcT4dfmvol4nzxfCWsPrQw57jlpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mHAIE-00Dj7n-Bb; Fri, 20 Aug 2021 21:35:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     git@vger.kernel.org
Cc:     "Signed-off-by : Taylor Blau" <me@ttaylorr.com>
Subject: [PATCH] multi-pack-index: fix --object-dir from outside repo
Date:   Fri, 20 Aug 2021 21:35:04 +0200
Message-Id: <20210820193504.37044-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If using --object-dir to point into a repo, 'write' will
segfault trying to access the object-dir via the repo it
found, but that's not fully initialized. Fix it to use
the object_dir properly.

Fixes: 38ff7cabb6b8 ("pack-revindex: write multi-pack reverse indexes")
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 midx.c                      | 10 +++++-----
 t/t5319-multi-pack-index.sh |  8 ++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index 321c6fdd2f18..902e1a7a7d9d 100644
--- a/midx.c
+++ b/midx.c
@@ -882,7 +882,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	strbuf_release(&buf);
 }
 
-static void clear_midx_files_ext(struct repository *r, const char *ext,
+static void clear_midx_files_ext(const char *object_dir, const char *ext,
 				 unsigned char *keep_hash);
 
 static int midx_checksum_valid(struct multi_pack_index *m)
@@ -1086,7 +1086,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name, midx_hash, &ctx);
-	clear_midx_files_ext(the_repository, ".rev", midx_hash);
+	clear_midx_files_ext(object_dir, ".rev", midx_hash);
 
 	commit_lock_file(&lk);
 
@@ -1135,7 +1135,7 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len,
 		die_errno(_("failed to remove %s"), full_path);
 }
 
-static void clear_midx_files_ext(struct repository *r, const char *ext,
+static void clear_midx_files_ext(const char *object_dir, const char *ext,
 				 unsigned char *keep_hash)
 {
 	struct clear_midx_data data;
@@ -1146,7 +1146,7 @@ static void clear_midx_files_ext(struct repository *r, const char *ext,
 				    hash_to_hex(keep_hash), ext);
 	data.ext = ext;
 
-	for_each_file_in_pack_dir(r->objects->odb->path,
+	for_each_file_in_pack_dir(object_dir,
 				  clear_midx_file_ext,
 				  &data);
 
@@ -1165,7 +1165,7 @@ void clear_midx_file(struct repository *r)
 	if (remove_path(midx))
 		die(_("failed to clear multi-pack-index at %s"), midx);
 
-	clear_midx_files_ext(r, ".rev", NULL);
+	clear_midx_files_ext(r->objects->odb->path, ".rev", NULL);
 
 	free(midx);
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 3d4d9f10c31b..7f393e52409d 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -201,6 +201,14 @@ test_expect_success 'write midx with twelve packs' '
 
 compare_results_with_midx "twelve packs"
 
+test_expect_success 'multi-pack-index with --object-dir need not be in repo' '
+	p="$(pwd)" &&
+	rm -f $objdir/multi-pack-index &&
+	cd / &&
+	git multi-pack-index --object-dir="$p/$objdir" write &&
+	cd "$p"
+'
+
 test_expect_success 'warn on improper hash version' '
 	git init --object-format=sha1 sha1 &&
 	(
-- 
2.31.1

