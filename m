Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7D220986
	for <e@80x24.org>; Tue,  4 Oct 2016 22:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbcJDWy5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 18:54:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62972 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751602AbcJDWy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 18:54:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD23743EB7;
        Tue,  4 Oct 2016 18:54:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=jl33
        KKuuEF0AkBJroK43ekBPXzE=; b=VYn++yjLE7v+u1h9DW66O8fzTzDEcOCv97NV
        zp6hdbPPbjuPJUDQi5F/iPYtqyO5OLJhIXnmATIeUgNGfGDV0+FXRC0PhFxfd46T
        sSpauw57rEkrBHmjU3I1IrKt4iiqP9n+PkaXpWljnctarx/QKACxiIgtA/FuEFh2
        WNjRqlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        LO8zF8KFVjRTbjwz2kjPn0HCEx9GpChrMKEfrcQeArTVntnW6aFWesZyBZIylogR
        tEErsa9gEQsKSYW9VQV8oB+XfHkKYuIEP/6BnjFOsbQd0/W3DG2kpkt8HN073tny
        jcZOSitxQintSBsHxiYJjEDV5LPxn6Ppp2qpeasu6TU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6FDB43EB6;
        Tue,  4 Oct 2016 18:54:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BA3343EB3;
        Tue,  4 Oct 2016 18:54:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, strk@kbt.io
Subject: [PATCH 1/4] t4015: split out the "setup" part of ws-error-highlight test
Date:   Tue,  4 Oct 2016 15:54:46 -0700
Message-Id: <20161004225449.6759-2-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-510-g1ef781f2c1
In-Reply-To: <20161004225449.6759-1-gitster@pobox.com>
References: <xmqqk2douhe0.fsf@gitster.mtv.corp.google.com>
 <20161004225449.6759-1-gitster@pobox.com>
X-Pobox-Relay-ID: 9084E9D6-8A85-11E6-A848-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'd want to run this same set of test twice, once with the option
and another time with an equivalent configuration setting.  Split
out the step that prepares the test data and expected output and
move the test for the command line option into a separate test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4015-diff-whitespace.sh | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 2434157aa7..4a4f374824 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -869,7 +869,8 @@ test_expect_success 'diff that introduces and removes ws breakages' '
 	test_cmp expected current
 '
 
-test_expect_success 'the same with --ws-error-highlight' '
+test_expect_success 'ws-error-highlight test setup' '
+
 	git reset --hard &&
 	{
 		echo "0. blank-at-eol " &&
@@ -882,10 +883,7 @@ test_expect_success 'the same with --ws-error-highlight' '
 		echo "2. and a new line "
 	} >x &&
 
-	git -c color.diff=always diff --ws-error-highlight=default,old |
-	test_decode_color >current &&
-
-	cat >expected <<-\EOF &&
+	cat >expect.default-old <<-\EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
 	<BOLD>index d0233a2..700886e 100644<RESET>
 	<BOLD>--- a/x<RESET>
@@ -897,12 +895,7 @@ test_expect_success 'the same with --ws-error-highlight' '
 	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
 	EOF
 
-	test_cmp expected current &&
-
-	git -c color.diff=always diff --ws-error-highlight=all |
-	test_decode_color >current &&
-
-	cat >expected <<-\EOF &&
+	cat >expect.all <<-\EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
 	<BOLD>index d0233a2..700886e 100644<RESET>
 	<BOLD>--- a/x<RESET>
@@ -914,12 +907,7 @@ test_expect_success 'the same with --ws-error-highlight' '
 	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
 	EOF
 
-	test_cmp expected current &&
-
-	git -c color.diff=always diff --ws-error-highlight=none |
-	test_decode_color >current &&
-
-	cat >expected <<-\EOF &&
+	cat >expect.none <<-\EOF
 	<BOLD>diff --git a/x b/x<RESET>
 	<BOLD>index d0233a2..700886e 100644<RESET>
 	<BOLD>--- a/x<RESET>
@@ -931,7 +919,22 @@ test_expect_success 'the same with --ws-error-highlight' '
 	<GREEN>+2. and a new line <RESET>
 	EOF
 
-	test_cmp expected current
+'
+
+test_expect_success 'test --ws-error-highlight option' '
+
+	git -c color.diff=always diff --ws-error-highlight=default,old |
+	test_decode_color >current &&
+	test_cmp expect.default-old current &&
+
+	git -c color.diff=always diff --ws-error-highlight=all |
+	test_decode_color >current &&
+	test_cmp expect.all current &&
+
+	git -c color.diff=always diff --ws-error-highlight=none |
+	test_decode_color >current &&
+	test_cmp expect.none current
+
 '
 
 test_done
-- 
2.10.1-510-g1ef781f2c1

