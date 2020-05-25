Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB61C433E2
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B5C2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WhDo629x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390645AbgEYUAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38854 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390608AbgEYUAb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3064760D1D;
        Mon, 25 May 2020 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436800;
        bh=/DV+zliFMgvjyMrzpHbzlFIwrj3WnjgN0b/139NAErw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WhDo629xpwNUZHR6JatbFTvG0Lz2HOs5ixBkoezlFeLZi27c3SxrqmNwqE19QmMqJ
         ckBXh1osid4Paa9wBSQaDfpMhyhmVDL7RPNVR017V26ykOEqRGYtVorR6aCrxjc43X
         hzw+XE5XVNkWSRUUbpmdaaQMsQGaUpuD2Bn/OXqMfZx74aaHXTtQHYzWNW8/4Sn2JW
         AGMLxMEYTYjPqMTxBANzAQvVF+TOPLZMwrZHUizRzYvdSmdLob1YU77hxho3umlZvo
         3u/XTtmWnNvEfLRKIddtSJYei9h5VNjQegY71TLAOA2QlefmU7RLRlE5AbJruRWdWh
         /RvYHyKWmuq3WWRXLXQcyIuaECtz3KAqGOzGoA38d0rBFVfWWQD4gKZQOlAHMOyXZG
         GVaBkLRRqgQgYPvKsB5+iGPAwH2a3pVrgQ5Y+K3qKPhn29TMR5pgM9rGl+dMB8XQ5R
         pXfLOkv4yZStpQ7KYGAgM07DgON1ORZnCKbsF+hgWoOLNhd9yk7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 40/44] t5703: use object-format serve option
Date:   Mon, 25 May 2020 19:59:26 +0000
Message-Id: <20200525195930.309665-41-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're using an algorithm other than SHA-1, we need to specify the
algorithm in use so we don't get a failure with an "unknown format"
message. Add a wrapper function that specifies this header if required.
Skip specifying this header for SHA-1 to test that it works both with an
without this header.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5703-upload-pack-ref-in-want.sh | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index a34460f7d8..afe7f7f919 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -27,6 +27,15 @@ check_output () {
 	test_cmp sorted_commits actual_commits
 }
 
+write_command () {
+	echo "command=$1"
+
+	if test "$(test_oid algo)" != sha1
+	then
+		echo "object-format=$(test_oid algo)"
+	fi
+}
+
 # c(o/foo) d(o/bar)
 #        \ /
 #         b   e(baz)  f(master)
@@ -62,7 +71,7 @@ test_expect_success 'config controls ref-in-want advertisement' '
 
 test_expect_success 'invalid want-ref line' '
 	test-tool pkt-line pack >in <<-EOF &&
-	command=fetch
+	$(write_command fetch)
 	0001
 	no-progress
 	want-ref refs/heads/non-existent
@@ -83,7 +92,7 @@ test_expect_success 'basic want-ref' '
 
 	oid=$(git rev-parse a) &&
 	test-tool pkt-line pack >in <<-EOF &&
-	command=fetch
+	$(write_command fetch)
 	0001
 	no-progress
 	want-ref refs/heads/master
@@ -107,7 +116,7 @@ test_expect_success 'multiple want-ref lines' '
 
 	oid=$(git rev-parse b) &&
 	test-tool pkt-line pack >in <<-EOF &&
-	command=fetch
+	$(write_command fetch)
 	0001
 	no-progress
 	want-ref refs/heads/o/foo
@@ -129,7 +138,7 @@ test_expect_success 'mix want and want-ref' '
 	git rev-parse e f >expected_commits &&
 
 	test-tool pkt-line pack >in <<-EOF &&
-	command=fetch
+	$(write_command fetch)
 	0001
 	no-progress
 	want-ref refs/heads/master
@@ -152,7 +161,7 @@ test_expect_success 'want-ref with ref we already have commit for' '
 
 	oid=$(git rev-parse c) &&
 	test-tool pkt-line pack >in <<-EOF &&
-	command=fetch
+	$(write_command fetch)
 	0001
 	no-progress
 	want-ref refs/heads/o/foo
