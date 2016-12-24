Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C1B2070D
	for <e@80x24.org>; Sat, 24 Dec 2016 01:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755214AbcLXBJH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 20:09:07 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:60959 "EHLO
        homiemail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752960AbcLXBJG (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Dec 2016 20:09:06 -0500
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id 4208F262069;
        Fri, 23 Dec 2016 17:09:05 -0800 (PST)
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id C0EA7262062;
        Fri, 23 Dec 2016 17:09:04 -0800 (PST)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, peff@peff.net
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v3 1/2] auto gc: don't write bitmaps for incremental repacks
Date:   Fri, 23 Dec 2016 20:08:54 -0500
Message-Id: <1482541735-21346-2-git-send-email-dturner@twosigma.com>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
In-Reply-To: <1482541735-21346-1-git-send-email-dturner@twosigma.com>
References: <1482541735-21346-1-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git gc --auto does an incremental repack of loose objects, we do
not expect to be able to write a bitmap; it is very likely that
objects in the new pack will have references to objects outside of the
pack.  So we shouldn't try to write a bitmap, because doing so will
likely issue a warning.

This warning was making its way into gc.log.  When the gc.log was
present, future auto gc runs would refuse to run.

Patch by Jeff King.
Bug report, test, and commit message by David Turner.

Signed-off-by: David Turner <dturner@twosigma.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/gc.c  |  9 ++++++++-
 t/t6500-gc.sh | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 069950d..331f219 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -191,6 +191,11 @@ static void add_repack_all_option(void)
 	}
 }
 
+static void add_repack_incremental_option(void)
+{
+       argv_array_push(&repack, "--no-write-bitmap-index");
+}
+
 static int need_to_gc(void)
 {
 	/*
@@ -208,7 +213,9 @@ static int need_to_gc(void)
 	 */
 	if (too_many_packs())
 		add_repack_all_option();
-	else if (!too_many_loose_objects())
+	else if (too_many_loose_objects())
+		add_repack_incremental_option();
+	else
 		return 0;
 
 	if (run_hook_le(NULL, "pre-auto-gc", NULL))
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 5d7d414..def2aca 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -43,4 +43,29 @@ test_expect_success 'gc is not aborted due to a stale symref' '
 	)
 '
 
+test_expect_success 'auto gc with too many loose objects does not attempt to create bitmaps' '
+	test_config gc.auto 3 &&
+	test_config gc.autodetach false &&
+	test_config pack.writebitmaps true &&
+	# We need to create two object whose sha1s start with 17
+	# since this is what git gc counts.  As it happens, these
+	# two blobs will do so.
+	test_commit 263 &&
+	test_commit 410 &&
+	# Our first gc will create a pack; our second will create a second pack
+	git gc --auto &&
+	ls .git/objects/pack | grep -v bitmap | sort >existing_packs &&
+	test_commit 523 &&
+	test_commit 790 &&
+
+	git gc --auto 2>err &&
+	test_i18ngrep ! "^warning:" err &&
+	ls .git/objects/pack/ | grep -v bitmap | sort >post_packs &&
+	comm --output-delimiter , -1 -3 existing_packs post_packs >new &&
+	comm --output-delimiter , -2 -3 existing_packs post_packs >del &&
+	test_line_count = 0 del && # No packs are deleted
+	test_line_count = 2 new # There is one new pack and its .idx
+'
+
+
 test_done
-- 
2.8.0.rc4.22.g8ae061a

