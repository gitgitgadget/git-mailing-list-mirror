Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1539C1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 05:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeIMK0O (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 06:26:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54448 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeIMK0O (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Sep 2018 06:26:14 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8DFB26046C;
        Thu, 13 Sep 2018 05:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536815902;
        bh=/RJTG5P1aATLGhJ+UYNOQgC+lRFidWGNNxnUFfDEblE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=LaVNOWkEMBa1TOUZC+o6KsT+F+AdmjX2r+kP5pIrZJuLVFUPpOv9Soo8YiVcixpxB
         keB5mkUKTIsexolYNQKn1z6Qhy7M0QMakOMH8AJhBpdLHQTFSFDRAJxDOaeXoc/gJb
         dC6E6htFa2c+3gSDrU5dIuAbT5+miYwZtpRc8eDv6atwW5pGkfKkDon0S2hugAIZaA
         BlIxSHmEgft936CnCnSykngANWq/XCS7PoZM+cHMGp/BC7P1zQuQ4fsbaXxnOY/Iwb
         0ja/kzdGAGQT80nbC8UhbrKIpxVRM5gnnihQNadPeqDJo/UAfGb0bHCmyHsrTTIlDE
         xZGHDRmRaHx0jQXH3919eFL5kiB25HEXTx2EV+PxUGTKnyfZ9PMum3L+cqIJtMBpYY
         TrfxkbzO9Sd/BA4sSD1wshG0E8NjoU9+sS+8Zc9pzmwNtfXiOgbKp27E48vuhPapee
         v1blQigC/pTNmKhWRo0vrRzxNX3UbH3JlqviA6PUcGnfTHrjh/a
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 07/12] t1006: make hash size independent
Date:   Thu, 13 Sep 2018 05:17:37 +0000
Message-Id: <20180913051742.252276-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a
In-Reply-To: <20180913051742.252276-1-sandals@crustytoothpaste.net>
References: <20180913051742.252276-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute the size of the tree and commit objects we're creating by
checking for the size of an object ID and computing the resulting sizes
accordingly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1006-cat-file.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 7f19d591f2..a7c95bb785 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -140,15 +140,17 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
 	test_cmp expect actual
 '
 
+test_oid_init
+
 tree_sha1=$(git write-tree)
-tree_size=33
+tree_size=$(($(test_oid rawsz) + 13))
 tree_pretty_content="100644 blob $hello_sha1	hello"
 
 run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
 
 commit_message="Initial commit"
 commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
-commit_size=177
+commit_size=$(($(test_oid hexsz) + 137))
 commit_content="tree $tree_sha1
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 0000000000 +0000
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 0000000000 +0000
