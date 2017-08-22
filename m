Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0351F667
	for <e@80x24.org>; Tue, 22 Aug 2017 21:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbdHVVrG (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 17:47:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63338 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752801AbdHVVrC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 17:47:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9B04AA23E;
        Tue, 22 Aug 2017 17:47:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=CQ6A
        hGiW2OwGvhMYcTajaCPUNto=; b=YH9aC8e64KjG/xVukP8JaCiC4PDzNHZKvvpg
        Dz+XqURYCnNxqtzJXmNZlkyq5sBvXNBMlIbSdU1QwqXW+fgtQKUha5cJmDolEn2h
        dmKJLvi0ZjgQAKqiO4Fro3n9bgd4FpkD+WPBU1TI8+6d/3qr/D8ug/n1OUl3OSfi
        JnNK9SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=ALXm0t
        MqO0CkPIMFEiREW/aSvBzcRbQjP076NQM6McwUnmB+nsBIajSDPSbLa5ic+ORFjU
        77mRyKnp3vdQCCHilGI/YBhBNJqct7Dv+QUuhzUySB6aPWxjpvnJOPx9IzNBRaRH
        GTs24CfOMHbAokaYimJxRMCzPcSTc7gV0uy8I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2DB2AA23B;
        Tue, 22 Aug 2017 17:47:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD95BAA23A;
        Tue, 22 Aug 2017 17:47:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 4/6] t4200: parameterize "rerere gc" custom expiry test
Date:   Tue, 22 Aug 2017 14:46:50 -0700
Message-Id: <20170822214652.31626-5-gitster@pobox.com>
X-Mailer: git-send-email 2.14.1-427-g5711bb0564
In-Reply-To: <20170822214652.31626-1-gitster@pobox.com>
References: <20170819203013.3053-1-gitster@pobox.com>
 <20170822214652.31626-1-gitster@pobox.com>
X-Pobox-Relay-ID: 6DA3E9C0-8783-11E7-925E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test creates a rerere database entry that is two days old, and
tries to expire with three different custom expiry configuration
(keep ones less than 5 days old, keep ones used less than 5 days
ago, and expire everything right now).

We'll be introducing a different way to spell the same "5 days" and
"right now" parameter in a later step; parameterize the test to make
it easier to test the new spelling when it happens.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4200-rerere.sh | 58 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index b007b67e9a..8d437534f2 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -239,32 +239,40 @@ test_expect_success 'old records rest in peace' '
 	! test -f $rr2/preimage
 '
 
-test_expect_success 'rerere gc with custom expiry' '
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
+rerere_gc_custom_expiry_test () {
+	five_days="$1" right_now="$2"
+	test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '
+		rm -fr .git/rr-cache &&
+		rr=.git/rr-cache/$_z40 &&
+		mkdir -p "$rr" &&
+		>"$rr/preimage" &&
+		>"$rr/postimage" &&
+
+		two_days_ago=$((-2*86400)) &&
+		test-chmtime =$two_days_ago "$rr/preimage" &&
+		test-chmtime =$two_days_ago "$rr/postimage" &&
+
+		find .git/rr-cache -type f | sort >original &&
+
+		git -c "gc.rerereresolved=$five_days" \
+		    -c "gc.rerereunresolved=$five_days" rerere gc &&
+		find .git/rr-cache -type f | sort >actual &&
+		test_cmp original actual &&
+
+		git -c "gc.rerereresolved=$five_days" \
+		    -c "gc.rerereunresolved=$right_now" rerere gc &&
+		find .git/rr-cache -type f | sort >actual &&
+		test_cmp original actual &&
+
+		git -c "gc.rerereresolved=$right_now" \
+		    -c "gc.rerereunresolved=$right_now" rerere gc &&
+		find .git/rr-cache -type f | sort >actual &&
+		>expect &&
+		test_cmp expect actual
+	'
+}
 
-	git -c gc.rerereresolved=0 -c gc.rerereunresolved=0 rerere gc &&
-	find .git/rr-cache -type f | sort >actual &&
-	>expect &&
-	test_cmp expect actual
-'
+rerere_gc_custom_expiry_test 5 0
 
 test_expect_success 'setup: file2 added differently in two branches' '
 	git reset --hard &&
-- 
2.14.1-427-g5711bb0564

