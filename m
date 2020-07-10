Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA9BC433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE8E20708
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1GRDTGQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGJCsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40368 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgGJCs0 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 645C760A5E;
        Fri, 10 Jul 2020 02:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349305;
        bh=xt7+S0YGkL78M65P52Ea3illT0Bx0Eyn9uNik2bjA/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=1GRDTGQ/F9oRxlfwv4VmS0NmX0MLvxrKp/M4msGHiqPXKu340ZRrtbg3iBMSDA3YS
         DH81SfyTUWktJsBJ7jmKnPH/whE162P2PkpVrqhLp2W8+26FzXNaHpY9jwLnXYPdW0
         AzMdoo51GYCx8kvyltjwnHwt3bUeze/WmAN1gm4K/7B1ON2vCFpcNwedFuM4Ko344E
         E835l7fLSmqvXqWp5cJLbraoKZzuxi/3KqgE3lP/+TyL3BbslzFBlSVVx+lsgMQD8R
         r1KLcTY8fYBtTbd42w8kJT8M5s3JFmw+iM6bidXO51GJ8mrHecGylVqcfHIzjYOYVh
         CUF7QPBuOCCcbXyAGLlBcq5mTmXDVGKas+o0j0SGVaYjfdnBfgM0ZQdhJ+j/hHTzA+
         MR2wavZgmYR1jbJAjALPknlVnqSnY0iomnIW2fWrlX4mXtVTtznqSWe3nM48y/hwla
         xGRL1oli1Ls9jXVCf2I/RLmne23f+yrGNoyewxpXU7iMwAQHCGC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 04/38] t3404: prepare 'short SHA-1 collision' tests for SHA-256
Date:   Fri, 10 Jul 2020 02:46:54 +0000
Message-Id: <20200710024728.3100527-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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

The `t/oid-info/oid` file now lists the values found in that way, and
the test cases are modified to use those values.

As the tests are no longer dependent on SHA-1, we also rename their
titles to talk about "commit IDs" instead of "SHA-1s".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3404-rebase-interactive.sh | 50 ++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4a7d21f898..2fb2c581cb 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -30,6 +30,7 @@ Initial setup:
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
 test_expect_success 'setup' '
+	test_oid_init &&
 	test_commit A file1 &&
 	test_commit B file1 &&
 	test_commit C file2 &&
@@ -1250,7 +1251,7 @@ test_expect_success 'rebase -i error on commits with \ in message' '
 	test_expect_code 1 grep  "	emp" error
 '
 
-test_expect_success SHA1 'short SHA-1 setup' '
+test_expect_success 'short commit ID setup' '
 	test_when_finished "git checkout master" &&
 	git checkout --orphan collide &&
 	git rm -rf . &&
@@ -1262,23 +1263,54 @@ test_expect_success SHA1 'short SHA-1 setup' '
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
