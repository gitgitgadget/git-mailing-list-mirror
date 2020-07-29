Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65923C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F0E207F5
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ibWbBOjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgG2XOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:14:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41044 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbgG2XOt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:14:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AA6516079A;
        Wed, 29 Jul 2020 23:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064487;
        bh=/7JY2zYnMWAyizSEiCqVtpsg7RZIoduRK486w/OzXs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ibWbBOjVdIKvI6YXeeZ3uPAYjb0VVh6mYLlaX2Yx/KV/lNnEDXZZPtjdjZY1GpDXj
         EBDPbRxPPmRdfFv4RF2aPkm02RAmmumfTNVRHY4zi4DztRgbk6qRaxXziFir9bArSZ
         9GwuZexqRjGPPxHl+yqoU8nwYIwj0eLVCkPEAeS8NeEBv88xG1W0LLoSUfGWNUg6ZY
         kx/i0leYthTx90NsfA7NW11PKC0l1QYDDBVCwTe2a055te+yQQPBim8GtZK9NKkgEm
         G4xCi0B/Nokx6r4qqAa9vFV3hrDe1w4ZGN3DDihAr573w1cS/4kpnV5A3baT4x4KCY
         19Dxe0XAb3P38V4gYpD+n0kQP+dyZmdmefk6P+Y3jiRxQdIbSW4LxFaCoasbDgTs5H
         sZChfa8tOr3+qFCiZbFHPzbw7Wjs3kj1cWRbfNGcKbddXO7C1HcZcxC1fk9PySMToF
         uPVc9KCcTsMIKV9A65paPrmjEt4UGfFd6Q7u43LmyQCynf9Sx1D
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 04/39] t3404: prepare 'short SHA-1 collision' tests for SHA-256
Date:   Wed, 29 Jul 2020 23:13:53 +0000
Message-Id: <20200729231428.3658647-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The idea of the magic value "ac4f2ee" in this test is to make the
reworded commit `collide2` have the same shortened ID as the commit
`collide3`.

To port the same idea to the SHA-256 version of Git, we therefore need
another magic value that causes the same collision, but this time with
the SHA-256 version of the commit IDs.

In this patch, we add code guarded by `GIT_TEST_FIND_COLLIDER` to do
exactly that. Essentially, a large number of integers is appended to the
commit message "collide2" to find such a collision. To make it easier to
find such a collision, we reduce the number of digits to 4.

As the tests are no longer dependent on SHA-1, we also rename their
titles to talk about "commit IDs" instead of "SHA-1s".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3404-rebase-interactive.sh | 49 ++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4a7d21f898..9744e88760 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1250,7 +1250,7 @@ test_expect_success 'rebase -i error on commits with \ in message' '
 	test_expect_code 1 grep  "	emp" error
 '
 
-test_expect_success SHA1 'short SHA-1 setup' '
+test_expect_success 'short commit ID setup' '
 	test_when_finished "git checkout master" &&
 	git checkout --orphan collide &&
 	git rm -rf . &&
@@ -1262,23 +1262,54 @@ test_expect_success SHA1 'short SHA-1 setup' '
 	)
 '
 
-test_expect_success SHA1 'short SHA-1 collide' '
+if test -n "$GIT_TEST_FIND_COLLIDER"
+then
+	author="$(unset test_tick; test_tick; git var GIT_AUTHOR_IDENT)"
+	committer="$(unset test_tick; test_tick; git var GIT_COMMITTER_IDENT)"
+	blob="$(git rev-parse collide2:collide)"
+	from="$(git rev-parse collide1^0)"
+	repl="commit refs/heads/collider-&\\n"
+	repl="${repl}author $author\\ncommitter $committer\\n"
+	repl="${repl}data <<EOF\\ncollide2 &\\nEOF\\n"
+	repl="${repl}from $from\\nM 100644 $blob collide\\n"
+	test_seq 1 32768 | sed "s|.*|$repl|" >script &&
+	git fast-import <script &&
+	git pack-refs &&
+	git for-each-ref >refs &&
+	grep "^$(test_oid t3404_collision)" <refs >matches &&
+	cat matches &&
+	test_line_count -gt 2 matches || {
+		echo "Could not find a collider" >&2
+		exit 1
+	}
+fi
+
+test_expect_success 'short commit ID collide' '
+	test_oid_cache <<-EOF &&
+	# collision-related constants
+	t3404_collision	sha1:6bcd
+	t3404_collision	sha256:0161
+	t3404_collider	sha1:ac4f2ee
+	t3404_collider	sha256:16697
+	EOF
 	test_when_finished "reset_rebase && git checkout master" &&
 	git checkout collide &&
-	colliding_sha1=6bcda37 &&
-	test $colliding_sha1 = "$(git rev-parse HEAD | cut -c 1-7)" &&
+	colliding_id=$(test_oid t3404_collision) &&
+	hexsz=$(test_oid hexsz) &&
+	test $colliding_id = "$(git rev-parse HEAD | cut -c 1-4)" &&
+	test_config core.abbrev 4 &&
 	(
 		unset test_tick &&
 		test_tick &&
 		set_fake_editor &&
-		FAKE_COMMIT_MESSAGE="collide2 ac4f2ee" \
+		FAKE_COMMIT_MESSAGE="collide2 $(test_oid t3404_collider)" \
 		FAKE_LINES="reword 1 break 2" git rebase -i HEAD~2 &&
-		test $colliding_sha1 = "$(git rev-parse HEAD | cut -c 1-7)" &&
-		grep "^pick $colliding_sha1 " \
+		test $colliding_id = "$(git rev-parse HEAD | cut -c 1-4)" &&
+		grep "^pick $colliding_id " \
 			.git/rebase-merge/git-rebase-todo.tmp &&
-		grep "^pick [0-9a-f]\{40\}" \
+		grep "^pick [0-9a-f]\{$hexsz\}" \
 			.git/rebase-merge/git-rebase-todo &&
-		grep "^pick [0-9a-f]\{40\}" \
+		grep "^pick [0-9a-f]\{$hexsz\}" \
 			.git/rebase-merge/git-rebase-todo.backup &&
 		git rebase --continue
 	) &&
