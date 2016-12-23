Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9926D1FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 19:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935162AbcLWTof (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 14:44:35 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:39273 "EHLO
        homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757685AbcLWTod (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Dec 2016 14:44:33 -0500
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id F3F12258065;
        Fri, 23 Dec 2016 11:43:46 -0800 (PST)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id 76BA6258067;
        Fri, 23 Dec 2016 11:43:46 -0800 (PST)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, peff@peff.net, novalis@novalis.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v2 2/2] repack: die on incremental + write-bitmap-index
Date:   Fri, 23 Dec 2016 14:43:35 -0500
Message-Id: <1482522215-13401-2-git-send-email-dturner@twosigma.com>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
In-Reply-To: <1482522215-13401-1-git-send-email-dturner@twosigma.com>
References: <1482522215-13401-1-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bitmap index only works for single packs, so requesting an
incremental repack with bitmap indexes makes no sense.

Signed-off-by: David Turner <dturner@twosigma.com>
---
 builtin/repack.c        | 9 +++++++++
 t/t5310-pack-bitmaps.sh | 5 +++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 80dd06b..9c3dd09 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -18,6 +18,12 @@ static const char *const git_repack_usage[] = {
 	NULL
 };
 
+static const char incremental_bitmap_conflict_error[] = N_(
+"Incremental repacks are incompatible with bitmap indexes.  Use \n"
+"--no-write-bitmap-index or disable the pack.writebitmaps configuration."
+);
+
+
 static int repack_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "repack.usedeltabaseoffset")) {
@@ -206,6 +212,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
 
+	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
+		die(incremental_bitmap_conflict_error);
+
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index b4c7a6f..e9a2771 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -118,10 +118,11 @@ test_expect_success 'fetch (partial bitmap)' '
 	test_cmp expect actual
 '
 
-test_expect_success 'incremental repack cannot create bitmaps' '
+test_expect_success 'incremental repack fails when bitmaps are requested' '
 	test_commit more-1 &&
 	find .git/objects/pack -name "*.bitmap" >expect &&
-	git repack -d &&
+	test_must_fail git repack -d 2>err &&
+	test_i18ngrep "Incremental repacks are incompatible with bitmap" err &&
 	find .git/objects/pack -name "*.bitmap" >actual &&
 	test_cmp expect actual
 '
-- 
2.8.0.rc4.22.g8ae061a

