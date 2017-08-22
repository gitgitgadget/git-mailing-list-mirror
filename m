Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899731F667
	for <e@80x24.org>; Tue, 22 Aug 2017 21:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbdHVVrC (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 17:47:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58966 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752742AbdHVVq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 17:46:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13CB9AA239;
        Tue, 22 Aug 2017 17:46:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=sYHo
        /Ped3oPQ7ix5Xv/2znqYPds=; b=NTeIoEelayLU2vW/Lgv/aVTmVEKe/FGoDs8E
        7Ov8i3oqRjs/GhM4RdTaSvZda+3qbrpeLIAfloW+e8dmRrZ2Il83DA+v5tYu1AkI
        zkSBkEoIyMzYM5QkV+ePD2LEwMzdkyd5vIUh7thE49au/+wJp3yckgRAmJSJ1mjv
        7M0jXOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=ryXPof
        4OwZuW02Ex+YxQVVzHulnGCoL4AldJPpm3SHIOiKd5EcWYLpOZxCSx6KzFYQ39+c
        aGoI5l9jtJHZeBZveSRMWQpdwYYXx7A4UaCSp9MgSyQzf1k74PHnKE4/Zp0X2LlB
        tjFUzUyYEuB6Jl1vKbmfvzo+DIUgDlDeiBTYA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C1C9AA238;
        Tue, 22 Aug 2017 17:46:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66C3EAA232;
        Tue, 22 Aug 2017 17:46:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/6] t4200: make "rerere gc" test more robust
Date:   Tue, 22 Aug 2017 14:46:48 -0700
Message-Id: <20170822214652.31626-3-gitster@pobox.com>
X-Mailer: git-send-email 2.14.1-427-g5711bb0564
In-Reply-To: <20170822214652.31626-1-gitster@pobox.com>
References: <20170819203013.3053-1-gitster@pobox.com>
 <20170822214652.31626-1-gitster@pobox.com>
X-Pobox-Relay-ID: 6BA2335C-8783-11E7-BCAD-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test blindly trusted that there may be _some_ entries left in
the rerere database, and used them by updating their timestamps to
see if the gc threshold variables are honoured correctly.  This
won't work if there is no entries in the database when the test
begins.

Instead, clear the rerere database, and populate it with a few known
entries (which are bogus, but for the purpose of testing "garbage
collection", it does not matter---we want to make sure we collect
old cruft, even if the files are corrupt rerere database entries),
and use them for the expiry test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4200-rerere.sh | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 8f5f268baf..1e23031cdb 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -420,19 +420,28 @@ count_pre_post () {
 }
 
 test_expect_success 'rerere gc' '
-	find .git/rr-cache -type f >original &&
-	xargs test-chmtime -172800 <original &&
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
 
 	git -c gc.rerereresolved=5 -c gc.rerereunresolved=5 rerere gc &&
-	find .git/rr-cache -type f >actual &&
+	find .git/rr-cache -type f | sort >actual &&
 	test_cmp original actual &&
 
 	git -c gc.rerereresolved=5 -c gc.rerereunresolved=0 rerere gc &&
-	find .git/rr-cache -type f >actual &&
+	find .git/rr-cache -type f | sort >actual &&
 	test_cmp original actual &&
 
 	git -c gc.rerereresolved=0 -c gc.rerereunresolved=0 rerere gc &&
-	find .git/rr-cache -type f >actual &&
+	find .git/rr-cache -type f | sort >actual &&
 	>expect &&
 	test_cmp expect actual
 '
-- 
2.14.1-427-g5711bb0564

