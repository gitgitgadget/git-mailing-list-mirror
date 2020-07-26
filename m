Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CC0C43465
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475852065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sAOW1v7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgGZTz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40794 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728095AbgGZTzZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:55:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 61FF96101B;
        Sun, 26 Jul 2020 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793293;
        bh=pybST+Ml60xM98F42OzVvvCAYKpI2wVMt8HjANV3VuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sAOW1v7HMeDi6gTLsbgjca8aMLi6fCvu5cwTXakAu9qpGR7escp0eYLeXLGLzXB3i
         VY3qVqG07xBEybpUZwFhbprWnrq8ZHNzJYMxcGiF21xnH1RrEAiaBM6A4tlNpnwKAz
         H0l9zHGP76SZuvc8RX7j1He1nAAOBZ99xC4tn/3LKUGhziHhuOWuqgnQLT9Ev2PITO
         ugNn717Dx68e/sdYo/0dEzH0tjJTgssdUkSi0Bp+MxXvZcVp77s61Uxxed33BDwPT/
         YmTELvOxVGb5d2OW99CSyUUOzoxmF7kV8+CGKLMmoZO59WrxbPo6wI89SNK/j+rfcz
         u7BiHMlitRSUoesCpH3nvt08B2HdpGET8U8Cba/xRZxro6pxX/yxUt9AaZ7wVZ6XxX
         31/QrbqFmkRBqDrtASZ7t0gIu+5Tu/aEJZcPWBEdXkIo3jJhxSfP+rf3sNZ5gukU4U
         LFNTSTnu08LsNWl959RZajcM9/Y5VMMFJYN+fOX+gW9P/LrChwu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 27/39] t5308: make test work with SHA-256
Date:   Sun, 26 Jul 2020 19:54:12 +0000
Message-Id: <20200726195424.626969-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test needs multiple object IDs that have the same first byte.
Update the pack test code to generate a suitable packed value for
SHA-256.  Update the test to use this value when using SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/lib-pack.sh                     |  8 ++++++++
 t/t5308-pack-detect-duplicates.sh | 20 ++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/t/lib-pack.sh b/t/lib-pack.sh
index f3463170b3..0c799d53c6 100644
--- a/t/lib-pack.sh
+++ b/t/lib-pack.sh
@@ -93,6 +93,14 @@ pack_obj () {
 			;;
 		esac
 		;;
+	# blob containing "\3\326"
+	471819e8c52bf11513f100b2810a8aa0622d5cd3d1c913758a071dd4b3bad8fe)
+		case "$2" in
+		'')
+			printf '\062\170\234\143\276\006\000\000\336\000\332'
+			return
+			;;
+		esac
 	esac
 
 	# If it's not a delta, we can convince pack-objects to generate a pack
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 6845c1f3c3..693b2411c8 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -4,23 +4,27 @@ test_description='handling of duplicate objects in incoming packfiles'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
-if ! test_have_prereq SHA1
-then
-       skip_all='not using SHA-1 for objects'
-       test_done
-fi
+test_expect_success 'setup' '
+	test_oid_cache <<-EOF
+	lo_oid sha1:e68fe8129b546b101aee9510c5328e7f21ca1d18
+	lo_oid sha256:471819e8c52bf11513f100b2810a8aa0622d5cd3d1c913758a071dd4b3bad8fe
+
+	missing_oid sha1:e69d000000000000000000000000000000000000
+	missing_oid sha256:4720000000000000000000000000000000000000000000000000000000000000
+	EOF
+'
 
 # The sha1s we have in our pack. It's important that these have the same
 # starting byte, so that they end up in the same fanout section of the index.
 # That lets us make sure we are exercising the binary search with both sets.
-LO_SHA1=e68fe8129b546b101aee9510c5328e7f21ca1d18
-HI_SHA1=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+LO_SHA1=$(test_oid lo_oid)
+HI_SHA1=$EMPTY_BLOB
 
 # And here's a "missing sha1" which will produce failed lookups. It must also
 # be in the same fanout section, and should be between the two (so that during
 # our binary search, we are sure to end up looking at one or the other of the
 # duplicate runs).
-MISSING_SHA1='e69d000000000000000000000000000000000000'
+MISSING_SHA1=$(test_oid missing_oid)
 
 # git will never intentionally create packfiles with
 # duplicate objects, so we have to construct them by hand.
