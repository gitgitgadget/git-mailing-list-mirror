Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28997201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 01:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdBUBKy (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 20:10:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52059 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750923AbdBUBKw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 20:10:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 979A0696C7;
        Mon, 20 Feb 2017 20:10:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=7HFa
        wU8Dc7zSLJEP0iCpeqhP8+E=; b=faV1riIHvng1om8WLSAC9mLUN0lfRaAdCmgS
        98UPwVc0XfV7X1a1c1Ik0SaCbXtJoNz6zjOWMNPRP5eK3aPGYZghqzZd8HR3eFSw
        tJNqujaYSufEFuo0CcOnQ2Vx16HwNAKgZf9C0fmfrpnLYhGxLxAUM2V97jKU4YMx
        6E4OxHM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E8C3696C5;
        Mon, 20 Feb 2017 20:10:50 -0500 (EST)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E481696BE;
        Mon, 20 Feb 2017 20:10:48 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH v2 2/4] update-ref: pass reflog message to delete_ref()
Date:   Mon, 20 Feb 2017 20:10:33 -0500
Message-Id: <20170221011035.847-3-kyle@kyleam.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170221011035.847-1-kyle@kyleam.com>
References: <20170217035800.13214-1-kyle@kyleam.com>
 <20170221011035.847-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 94F7887E-F7D2-11E6-85AD-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=7HFawU8Dc7zSLJEP0iCpeqhP8+E=;
 b=BpfKi7KYXQnAV+M+OYTCYnT1iGctU1doD1dtuinlkcGK0MBK/0DBoQxsAa5F01GXVrOslxlMA8lagb3Zjh0ttlGNh+ttu0EvxkYfMGD1Fng7b13ch4XKo50jby2B/kexVxCc0x3nR5Kzgyk2IOr206Eml7ts6MerI3n1eEYO1Rs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that delete_ref() accepts a reflog message, pass the user-provided
message to delete_ref() rather than silently dropping it.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 builtin/update-ref.c  |  2 +-
 t/t1400-update-ref.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 86d006d36..0b2ecf41a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -433,7 +433,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		 * For purposes of backwards compatibility, we treat
 		 * NULL_SHA1 as "don't care" here:
 		 */
-		return delete_ref(NULL, refname,
+		return delete_ref(msg, refname,
 				  (oldval && !is_null_sha1(oldsha1)) ? oldsha1 : NULL,
 				  flags);
 	else
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b0ffc0b57..6e112fb5f 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -85,6 +85,24 @@ test_expect_success "delete $m (by HEAD)" '
 '
 rm -f .git/$m
 
+test_expect_success "deleting current branch adds message to HEAD's log" '
+	git update-ref $m $A &&
+	git symbolic-ref HEAD $m &&
+	git update-ref -m delete-$m -d $m &&
+	! test -f .git/$m &&
+	grep "delete-$m$" .git/logs/HEAD
+'
+rm -f .git/$m
+
+test_expect_success "deleting by HEAD adds message to HEAD's log" '
+	git update-ref $m $A &&
+	git symbolic-ref HEAD $m &&
+	git update-ref -m delete-by-head -d HEAD &&
+	! test -f .git/$m &&
+	grep "delete-by-head$" .git/logs/HEAD
+'
+rm -f .git/$m
+
 test_expect_success 'update-ref does not create reflogs by default' '
 	test_when_finished "git update-ref -d $outside" &&
 	git update-ref $outside $A &&
-- 
2.11.1

