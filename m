Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FED21F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 17:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeFARqx (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 13:46:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59410 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751801AbeFARqw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 Jun 2018 13:46:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:cc62:bd61:abbd:bc4b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 88F2E60732;
        Fri,  1 Jun 2018 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1527875207;
        bh=8ohSw6TlUh2qMynHgDLnLCMNHZR/aLSxUiCN0r8Uw3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cWvrmX9dzNMD+yaGSlTGMgjrLhyXcolhs81CLOp+tlz5Dh0UF4QQNA7qYHF7nHXNK
         UuJ/mHfiYE5gy5JpIT+Z+e9ETEM8h3B+0Kp3XCnPyjNu1b8EwYe4RLOYeWr5nYJ7jq
         dIHwKW4tfdeG7xfx8YuEnX8M+NEuW/lpYlxu7hsjb2zyOMTGBfoDuZBOI0Zg0gXKm2
         CBt19+uHblwjL1L4qJ5De2RBGbatPwHlFyqRuJbn2pHy6yBDcC3ZovZ7orDc3NDiCI
         BzqoF2LAHgXI3uD6RR4k7GtRZTlyb4dvTYw4ZmBTidMqxcp74saVat+xUXgO7ntaJC
         uc50nGvaDKPjF8Dxu371lvAnFOY6tG03kBZwlTiYsaySB3xVg1dJcZ6lH0rguC2non
         5Kl2j0U43+T9rli6W6md7puba1nvvCg72rNw5zbHSswBWAp996u9Myw5DXo3JzfbuZ
         411fBjpnxd3fr1mI1iwkMTe2sRHR6/ER9geWo3KYjMDiDuPBgUd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] sequencer: ensure labels that are object IDs are rewritten
Date:   Fri,  1 Jun 2018 17:46:39 +0000
Message-Id: <20180601174639.875215-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.1.1185.g55be947832
In-Reply-To: <20180529163236.646275-1-sandals@crustytoothpaste.net>
References: <20180529163236.646275-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing the todo script for --rebase-merges, we try to find a label
for certain commits.  If the label ends up being a valid object ID, such
as when we merge a detached commit, we want to rewrite it so it is no
longer a valid object ID.

However, the code path that does this checks for its length to be
equivalent to GIT_SHA1_RAWSZ, which isn't correct, since what we are
reading is a hex object ID.  Instead, check for the length being
equivalent to that of a hex object ID.  Use the_hash_algo so this code
works regardless of the hash size.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sequencer.c              |  2 +-
 t/t3430-rebase-merges.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 1ce63261a3..75ed86a94e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3636,7 +3636,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
 				p[i] = save;
 			}
 		}
-	} else if (((len = strlen(label)) == GIT_SHA1_RAWSZ &&
+	} else if (((len = strlen(label)) == the_hash_algo->hexsz &&
 		    !get_oid_hex(label, &dummy)) ||
 		   (len == 1 && *label == '#') ||
 		   hashmap_get_from_hash(&state->labels,
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 3d4dfdf7be..9fc4648ff8 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -241,4 +241,20 @@ test_expect_success 'refuse to merge ancestors of HEAD' '
 	test_cmp_rev HEAD $before
 '
 
+test_expect_success 'labels that are object IDs are rewritten' '
+	git checkout -b third B &&
+	test_commit I &&
+	third=$(git rev-parse HEAD) &&
+	git checkout -b labels master &&
+	git merge --no-commit third &&
+	test_tick &&
+	git commit -m "Merge commit '\''$third'\'' into labels" &&
+	echo noop >script-from-scratch &&
+	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
+	test_tick &&
+	git rebase -i -r A &&
+	grep "^label $third-" .git/ORIGINAL-TODO &&
+	! grep "^label $third$" .git/ORIGINAL-TODO
+'
+
 test_done
