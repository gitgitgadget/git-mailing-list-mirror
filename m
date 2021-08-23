Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F06C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6752861391
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhHWRLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHWRLB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 13:11:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAB8C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=+i2s1j0MIegajbHbK8PdQKJjpdkntfynQh2vymUN3hs=; t=1629738619; x=1630948219; 
        b=wq6jm1m/SUVeAWVAprm++iKhky99k3/4VY8cGOzx81pKFQT4gpEYoTAhKqIbr5LD9EQ+SQ7WOge
        6fnLY9WTbinH109ot8BiJnRBXP8rw8gDADeNYQuFxg8Hd3GxH9T+cgQnoE82liE7kKwYyCDFbieDd
        yPNpqZWzxpRU7BOa6ttgKYb3dvTVTBrohgqG8fAGoIVXUwvdkF4ELL8J4XGQnCUncmb2qead6GN9d
        f/3XEn9i6eHJ7BcOlFj6GoT/xDGQG/ONgLMJhvcvj3UajUKZoXvreUBov7Kx7d6LTdEAWq+B5Xp0T
        M0J8hA6ZpCZ9/gR2/TBVgbS8BWhl0xsij7qQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mIDSj-00EwDT-0I; Mon, 23 Aug 2021 19:10:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3] multi-pack-index: fix *.rev cleanups with --object-dir
Date:   Mon, 23 Aug 2021 19:10:11 +0200
Message-Id: <20210823171011.80588-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If using --object-dir to point into a repo while the current
working dir is outside, such as

  git init /repo
  git -C /repo ... # add some objects
  cd /non-repo
  git multi-pack-index --object-dir /repo/.git/objects/ write

the binary will segfault trying to access the object-dir via
the repo it found, but that's not fully initialized. Fix it
to use the object_dir properly to clean up the *.rev files,
this avoids the crash and cleans up the *.rev files for the
now rewritten multi-pack-index properly.

Fixes: 38ff7cabb6b8 ("pack-revindex: write multi-pack reverse indexes")
Cc: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
v3:
 - use nongit
---
 midx.c                      | 10 +++++-----
 t/t5319-multi-pack-index.sh | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

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
index 3d4d9f10c31b..665c6d64a0ab 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -201,6 +201,21 @@ test_expect_success 'write midx with twelve packs' '
 
 compare_results_with_midx "twelve packs"
 
+test_expect_success 'multi-pack-index *.rev cleanup with --object-dir' '
+	git init objdir-test-repo &&
+	test_when_finished "rm -rf objdir-test-repo" &&
+	(
+		cd objdir-test-repo &&
+		test_commit base &&
+		git repack -d
+	) &&
+	rev="objdir-test-repo/$objdir/pack/multi-pack-index-abcdef123456.rev" &&
+	touch $rev &&
+	nongit git multi-pack-index --object-dir="$(pwd)/objdir-test-repo/$objdir" write &&
+	test_path_is_file objdir-test-repo/$objdir/pack/multi-pack-index &&
+	test_path_is_missing $rev
+'
+
 test_expect_success 'warn on improper hash version' '
 	git init --object-format=sha1 sha1 &&
 	(
-- 
2.31.1

