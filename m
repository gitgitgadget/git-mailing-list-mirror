Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD20C18E5B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00A820727
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JcISFx8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgCJSWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:22:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51066 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbgCJSWN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Mar 2020 14:22:13 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 77F4E609CF;
        Tue, 10 Mar 2020 18:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1583864532;
        bh=THBqTLEH+ENJiBGtkyMZdeQIst+gXGjD8SbhOOCYMnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JcISFx8/VoBnukfNKFjX7Ly9K1NQ3e1rpl5x3iPVV6GcasZUXSlKCWkM85ogfPW4w
         iu04jQguCG10sDT+NBSYpHI/HJ8RBMB2/Xeox0OPb1FxYdFl+PJp1GNUpj7SRBVh1j
         lSKE+DlwujjYG6zqKwSp5QSJUCmULRMFJ7Nthzu3Ye8tFbNOlw0H5cvzbC12RAk7va
         2ryUP/4d+1+XyBndajg43/FHNmPsXPCzMnBZDbhVrDNAj4FftVWa7Xn3JyV5+KDufX
         HKch1nmBAWuSYzWC1qFK7ueV6rS+U3tWLP4konUeG4yf9Co9JSZf85Lpk4bQtv8c+g
         O3VDy06Slg4WNEAAAvh2RMrPThgI6RLbmVGxXVvYOdqIvKAM6xqWKZRF/xTwvSkizK
         Oy6cBmATKZ2woD1oSMp6SdsiihO0SMDQDl/NYjOj+Xsnm0N7kmWnhmcQ/QRxkApMyh
         L4kCYoSsRbrvWg46mYF/2mS6n6aDDMnPxM+DCnRldQLF1d+V8Ol
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 7/8] builtin/reset: compute checkout metadata for reset
Date:   Tue, 10 Mar 2020 18:20:45 +0000
Message-Id: <20200310182046.748959-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200310182046.748959-1-sandals@crustytoothpaste.net>
References: <20200310182046.748959-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

Pass the commit, and if we have it, the ref to the filters when we
perform a checkout.  This should only be the case when we invoke git
reset --hard; the metadata will be unused otherwise.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 builtin/reset.c       | 16 +++++++++++++---
 t/t0021-conversion.sh | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 18228c312e..4c634111bd 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -46,7 +46,7 @@ static inline int is_merge(void)
 	return !access(git_path_merge_head(the_repository), F_OK);
 }
 
-static int reset_index(const struct object_id *oid, int reset_type, int quiet)
+static int reset_index(const char *ref, const struct object_id *oid, int reset_type, int quiet)
 {
 	int i, nr = 0;
 	struct tree_desc desc[2];
@@ -60,6 +60,7 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 	opts.dst_index = &the_index;
 	opts.fn = oneway_merge;
 	opts.merge = 1;
+	init_checkout_metadata(&opts.meta, ref, oid, NULL);
 	if (!quiet)
 		opts.verbose_update = 1;
 	switch (reset_type) {
@@ -418,11 +419,20 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				}
 			}
 		} else {
-			int err = reset_index(&oid, reset_type, quiet);
+			struct object_id dummy;
+			char *ref = NULL;
+			int err;
+
+			dwim_ref(rev, strlen(rev), &dummy, &ref);
+			if (ref && !starts_with(ref, "refs/"))
+				ref = NULL;
+
+			err = reset_index(ref, &oid, reset_type, quiet);
 			if (reset_type == KEEP && !err)
-				err = reset_index(&oid, MIXED, quiet);
+				err = reset_index(ref, &oid, MIXED, quiet);
 			if (err)
 				die(_("Could not reset index file to revision '%s'."), rev);
+			free(ref);
 		}
 
 		if (write_locked_index(&the_index, &lock, COMMIT_LOCK))
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 3efb0dad20..a026fd46b4 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -447,7 +447,8 @@ test_expect_success PERL 'required process filter should filter data for various
 		git commit -m "test commit 3" &&
 		git checkout empty-branch &&
 		filter_git rebase --onto empty-branch master^^ master &&
-		META="ref=refs/heads/master treeish=$(git rev-parse --verify master)" &&
+		MASTER2=$(git rev-parse --verify master) &&
+		META="ref=refs/heads/master treeish=$MASTER2" &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
@@ -458,6 +459,35 @@ test_expect_success PERL 'required process filter should filter data for various
 			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $META blob=$M3 $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
+		test_cmp_exclude_clean expected.log debug.log &&
+
+		git reset --hard empty-branch &&
+		filter_git reset --hard $MASTER &&
+		META="treeish=$MASTER" &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: smudge test.r $META blob=$M $S [OK] -- OUT: $S . [OK]
+			IN: smudge test2.r $META blob=$M2 $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge test4-empty.r $META blob=$EMPTY 0 [OK] -- OUT: 0  [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $META blob=$M3 $S3 [OK] -- OUT: $S3 . [OK]
+			STOP
+		EOF
+		test_cmp_exclude_clean expected.log debug.log &&
+
+		git branch old-master $MASTER &&
+		git reset --hard empty-branch &&
+		filter_git reset --hard old-master &&
+		META="ref=refs/heads/old-master treeish=$MASTER" &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: smudge test.r $META blob=$M $S [OK] -- OUT: $S . [OK]
+			IN: smudge test2.r $META blob=$M2 $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge test4-empty.r $META blob=$EMPTY 0 [OK] -- OUT: 0  [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $META blob=$M3 $S3 [OK] -- OUT: $S3 . [OK]
+			STOP
+		EOF
 		test_cmp_exclude_clean expected.log debug.log
 	)
 '
