Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4C81F42D
	for <e@80x24.org>; Tue, 29 May 2018 16:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936888AbeE2Qc5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 12:32:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57506 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936869AbeE2Qcw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 May 2018 12:32:52 -0400
Received: from genre.crustytoothpaste.net (unknown [207.126.212.32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 12F9260444;
        Tue, 29 May 2018 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1527611569;
        bh=e0Xr+ZXNix/pIIkPoEzja+6iMerZUW//LYQUVImMjwQ=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jTSp/RRXNGoTJfj2O1ExXPupVFd4znz5FfCQiuRw7DVnDEzu4koMA2YH/0KpsffMS
         rm0mkXiZLOQLiEJUDBkcqtpqJEr4ZFD7On6AkZmSLa14OfpbGeAcRKJvGeleH2yJl/
         cBf9Sj0m8GF0TWBz5vbmOLSZo+oaeLZDZKe7+92wI01oOyBSAWar69R6dfiQdbeRKw
         BMgi2jhrMt09XmKTpv42OT2c2pr/GUW+DclGLpKcKm7vxt9m3CrhuowqptSjuYNg+8
         6qv476RoS7xXbhPXdukJaa6Qs4OP/7UQkgJgSMwRmQPt6lH5DbYLFPJ9DnwVCyhgdD
         RziBfo5vF8KW4y4r0Kz2bvmT55SL7pAhdfwWMIpEeEXgyH+Z+o8Ni5YKDJ0Vn2BJ9x
         kNtwA09gmaz6O1CiwiKiIUYXb3uhz4DJz47nhjx/Q2O1Zmhn9eYIFeMHLD8eKVFxy/
         FYFXxVfdJBsak30ToM9zM0ZfqK+tKx8xdeZY6hLkBdQWMF+aQOr
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] sequencer: ensure labels that are object IDs are rewritten
Date:   Tue, 29 May 2018 16:32:36 +0000
Message-Id: <20180529163236.646275-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.625.g4582c99ba8
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

I noticed this while cleaning up a few instances of GIT_SHA1_* constants
and thought I'd send a patch.

 sequencer.c              |  2 +-
 t/t3430-rebase-merges.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

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
index 3d4dfdf7be..472ad9463c 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -70,6 +70,7 @@ test_expect_success 'create completely different structure' '
 	merge -C H second
 	merge onebranch # Merge the topic branch '\''onebranch'\''
 	EOF
+	cp script-from-scratch script-from-scratch-orig &&
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 	test_tick &&
 	git rebase -i -r A &&
@@ -241,4 +242,20 @@ test_expect_success 'refuse to merge ancestors of HEAD' '
 	test_cmp_rev HEAD $before
 '
 
+test_expect_success 'labels that are object IDs are rewritten' '
+	git checkout -b third B &&
+	test_tick &&
+	test_commit I &&
+	third=$(git rev-parse HEAD) &&
+	git checkout -b labels master &&
+	git merge --no-commit third &&
+	test_tick &&
+	git commit -m "Merge commit '\''$third'\'' into labels" &&
+	cp script-from-scratch-orig script-from-scratch &&
+	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
+	test_tick &&
+	git rebase -i -r A &&
+	! grep "^label $third$" .git/ORIGINAL-TODO
+'
+
 test_done
