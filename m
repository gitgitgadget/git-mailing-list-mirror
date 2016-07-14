Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125BB20196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbcGNUuU (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:50:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751285AbcGNUuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DBE242AC52;
	Thu, 14 Jul 2016 16:44:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=aAFH
	0fzhiSU8hNsW9CjNofSCDuM=; b=fWGbN4A66ZW9Peq/c7LmN88fG/XvhP28nKbf
	69xzTIu10KfvWl28/omUoICCN/XAKOlgAbLcVRUJrQdWxNMGPzCLgJ+sXFnklOYm
	HMB1ce8yAy494CF1fTxjMiduQ9T4ocmI/w4JYnNFu+6mGf3/s4dU7xrtW6EzOmDK
	STdemLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	PsQEdQJSIQuglxPb1BTfPlHGnUnbFXrWVeKFO2OAPUDHx11U+G1snbOC2C6XJDJr
	tn7UB7S/pbwRvxEnYEhy4QoNFkzstN0RQm6HsJ7BbXrQKMOyOqAIwdQH73HRakkz
	7x2Bvz1FSV4AXbfw7B+AQBRkZpL1TOIshjybyc46ja0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3CC92AC50;
	Thu, 14 Jul 2016 16:44:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B66D2AC4F;
	Thu, 14 Jul 2016 16:44:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Cc:	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 1/2] t0006: skip "far in the future" test when unsigned long is not long enough
Date:	Thu, 14 Jul 2016 13:43:56 -0700
Message-Id: <20160714204357.2628-2-gitster@pobox.com>
X-Mailer: git-send-email 2.9.1-545-g8c0a069
In-Reply-To: <20160714204357.2628-1-gitster@pobox.com>
References: <xmqq7fcoot6t.fsf@gitster.mtv.corp.google.com>
 <20160714204357.2628-1-gitster@pobox.com>
X-Pobox-Relay-ID: B2AE9D62-4A03-11E6-96DF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff King <peff@peff.net>

Git's source code refers to timestamps as unsigned longs.  On 32-bit
platforms, as well as on Windows, unsigned long is not large enough
to capture dates that are "absurdly far in the future".

While we can fix this issue properly by replacing unsigned long with
a larger type, we want to be a bit more conservative and just skip
those tests on the maint track.

Signed-off-by: Jeff King <peff@peff.net>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 help.c          | 6 ++++++
 t/t0006-date.sh | 6 +++---
 t/test-lib.sh   | 9 +++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 19328ea..2ff3b5a 100644
--- a/help.c
+++ b/help.c
@@ -419,6 +419,12 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	 * with external projects that rely on the output of "git version".
 	 */
 	printf("git version %s\n", git_version_string);
+	while (*++argv) {
+		if (!strcmp(*argv, "--build-options")) {
+			printf("sizeof-long: %d\n", (int)sizeof(long));
+			/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
+		}
+	}
 	return 0;
 }
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 04ce535..4c8cf58 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -31,7 +31,7 @@ check_show () {
 	format=$1
 	time=$2
 	expect=$3
-	test_expect_${4:-success} "show date ($format:$time)" '
+	test_expect_success $4 "show date ($format:$time)" '
 		echo "$time -> $expect" >expect &&
 		test-date show:$format "$time" >actual &&
 		test_cmp expect actual
@@ -50,8 +50,8 @@ check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" LONG_IS_64BIT
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" LONG_IS_64BIT
 
 check_parse() {
 	echo "$1 -> $2" >expect
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0055ebb..11201e9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1111,3 +1111,12 @@ run_with_limited_cmdline () {
 }
 
 test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
+
+build_option () {
+	git version --build-options |
+	sed -ne "s/^$1: //p"
+}
+
+test_lazy_prereq LONG_IS_64BIT '
+	test 8 -le "$(build_option sizeof-long)"
+'
-- 
2.9.1-545-g8c0a069

