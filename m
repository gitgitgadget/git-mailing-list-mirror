Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B5F1FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 23:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758067AbcLPX7p (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 18:59:45 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:60336 "EHLO
        homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758027AbcLPX7o (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Dec 2016 18:59:44 -0500
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id CCFB6258067;
        Fri, 16 Dec 2016 15:59:42 -0800 (PST)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id 5C4AB258066;
        Fri, 16 Dec 2016 15:59:42 -0800 (PST)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, peff@peff.net
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH] pack-objects: don't warn about bitmaps on incremental pack
Date:   Fri, 16 Dec 2016 18:59:35 -0500
Message-Id: <1481932775-12952-1-git-send-email-dturner@twosigma.com>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
In-Reply-To: <20161216214906.z53yp2x4n6hdc27m@sigill.intra.peff.net>
References: <20161216214906.z53yp2x4n6hdc27m@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running git pack-objects --incremental, we do not expect to be
able to write a bitmap; it is very likely that objects in the new pack
will have references to objects outside of the pack.  So we don't need
to warn the user about it.

This warning was making its way into gc.log because auto-gc will do an
incremental repack when there are too many loose objects but not too
many packs.  When the gc.log was present, future auto gc runs would
refuse to run.

Signed-off-by: David Turner <dturner@twosigma.com>
---
 builtin/pack-objects.c  |  3 ++-
 t/t5310-pack-bitmaps.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fd52bd..96de213 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1083,7 +1083,8 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset)) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
-			warning(_(no_closure_warning));
+			if (!incremental)
+				warning(_(no_closure_warning));
 			write_bitmap_index = 0;
 		}
 		return 0;
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index b4c7a6f..d81636e 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -247,6 +247,18 @@ test_expect_success 'pack-objects respects --incremental' '
 	test_cmp 4.objects objects
 '
 
+test_expect_success 'incremental repack does not create bitmaps' '
+	test_commit 11 &&
+	ls .git/objects/pack/ | grep bitmap >existing_bitmaps &&
+	ls .git/objects/pack/ | grep -v bitmap >existing_packs &&
+	git repack -d 2>err &&
+	test_line_count = 0 err &&
+	ls .git/objects/pack/ | grep bitmap >output &&
+	ls .git/objects/pack/ | grep -v bitmap >post_packs &&
+	test_cmp existing_bitmaps output &&
+	! test_cmp existing_packs post_packs
+'
+
 test_expect_success 'pack with missing blob' '
 	rm $(objpath $blob) &&
 	git pack-objects --stdout --revs <revs >/dev/null
-- 
2.8.0.rc4.22.g8ae061a

