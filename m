Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B438A1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 21:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbdHVVrB (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 17:47:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58831 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752801AbdHVVrA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 17:47:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81AFC9012F;
        Tue, 22 Aug 2017 17:46:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=B9JB
        MF2JcLBUM0kq3n17FccKFp8=; b=xRq5UQya8uInbzQtiZfAG1taBQLAku+yXaOn
        gLnmIhiGQ4xHB0ekkeQDkgmC7QsqUnqrBzDqJD25vMuOM4nNTdNJ3lf6z8gCV6QP
        uGPCrC9z7RD+O1L5Pecxlc5O/HpeUVD4r83J0ZcrAGKEGCLP5I8SKZAca3p0QORv
        96CUCPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=GguRpe
        wAgfAPAJY66zGaGQFwoQ3FTYVRTExfLrDyQQbwknALz/o0iAYew6WZ1ZcxwahvO9
        oI7/l5Pgqbf0XDMex+lzo/zLsYdnmD/+ULojEFX3uolyxaocxlT6VbFJMVBAszKT
        0Jrfm+yQQs3NkUwTXTUH2fw9QXjvTj9s1zIcg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 796D49012E;
        Tue, 22 Aug 2017 17:46:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E80CA9012D;
        Tue, 22 Aug 2017 17:46:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 3/6] t4200: gather "rerere gc" together
Date:   Tue, 22 Aug 2017 14:46:49 -0700
Message-Id: <20170822214652.31626-4-gitster@pobox.com>
X-Mailer: git-send-email 2.14.1-427-g5711bb0564
In-Reply-To: <20170822214652.31626-1-gitster@pobox.com>
References: <20170819203013.3053-1-gitster@pobox.com>
 <20170822214652.31626-1-gitster@pobox.com>
X-Pobox-Relay-ID: 6C8B4FBA-8783-11E7-932E-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "rerere gc with custom expiry" test up, so that it is close
to the more "rerere gc" tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4200-rerere.sh | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 1e23031cdb..b007b67e9a 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -239,6 +239,33 @@ test_expect_success 'old records rest in peace' '
 	! test -f $rr2/preimage
 '
 
+test_expect_success 'rerere gc with custom expiry' '
+	rm -fr .git/rr-cache &&
+	rr=.git/rr-cache/$_z40 &&
+	mkdir -p "$rr" &&
+	>"$rr/preimage" &&
+	>"$rr/postimage" &&
+
+	two_days_ago=$((-2*86400)) &&
+	test-chmtime =$two_days_ago "$rr/preimage" &&
+	test-chmtime =$two_days_ago "$rr/postimage" &&
+
+	find .git/rr-cache -type f | sort >original &&
+
+	git -c gc.rerereresolved=5 -c gc.rerereunresolved=5 rerere gc &&
+	find .git/rr-cache -type f | sort >actual &&
+	test_cmp original actual &&
+
+	git -c gc.rerereresolved=5 -c gc.rerereunresolved=0 rerere gc &&
+	find .git/rr-cache -type f | sort >actual &&
+	test_cmp original actual &&
+
+	git -c gc.rerereresolved=0 -c gc.rerereunresolved=0 rerere gc &&
+	find .git/rr-cache -type f | sort >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup: file2 added differently in two branches' '
 	git reset --hard &&
 
@@ -419,33 +446,6 @@ count_pre_post () {
 	test_line_count = "$2" actual
 }
 
-test_expect_success 'rerere gc' '
-	rm -fr .git/rr-cache &&
-	rr=.git/rr-cache/$_z40 &&
-	mkdir -p "$rr" &&
-	>"$rr/preimage" &&
-	>"$rr/postimage" &&
-
-	two_days_ago=$((-2*86400)) &&
-	test-chmtime =$two_days_ago "$rr/preimage" &&
-	test-chmtime =$two_days_ago "$rr/postimage" &&
-
-	find .git/rr-cache -type f | sort >original &&
-
-	git -c gc.rerereresolved=5 -c gc.rerereunresolved=5 rerere gc &&
-	find .git/rr-cache -type f | sort >actual &&
-	test_cmp original actual &&
-
-	git -c gc.rerereresolved=5 -c gc.rerereunresolved=0 rerere gc &&
-	find .git/rr-cache -type f | sort >actual &&
-	test_cmp original actual &&
-
-	git -c gc.rerereresolved=0 -c gc.rerereunresolved=0 rerere gc &&
-	find .git/rr-cache -type f | sort >actual &&
-	>expect &&
-	test_cmp expect actual
-'
-
 merge_conflict_resolve () {
 	git reset --hard &&
 	test_must_fail git merge six.1 &&
-- 
2.14.1-427-g5711bb0564

