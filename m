Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F59320196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbcGNUty (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:49:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752270AbcGNUtv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:49:51 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jul 2016 16:49:51 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E3AE2AE3D;
	Thu, 14 Jul 2016 16:44:05 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rhTI
	r8ySDGKwXxjZ4jEgw1Yhffs=; b=JMuem0SDhbD60lermoYmDKHRADRqGhYjHOT3
	2GK2ncu9l2w2WRM2ezFfZ8T8wtZrTOfBYz7ptW3neote5oNuOc9BQxSP+DPKvPzO
	XXNQpFKrWIy8I8EAEaFfmkpQYO/ASUFRm0x2rgDTs5uh57leJsW51r7ufHi5iQLh
	IpZeZ9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	dEH5d6kTX1A8TkGV/MA4iCJnm8sZ87q7S4ApIw42gl5Ed5Eu24KworPNbW9IDEuC
	AmBee/Xi6E+FoqSDXtVaPrj2ilaqc45O6gcAjI7kvR/A9khqH8hrYOpeQr6Dl45T
	J1wZQP8s90I9Z047v8m/3Wnf0f+GI03qz2MVSil+kEo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76C0B2AE3C;
	Thu, 14 Jul 2016 16:44:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E453D2AE3B;
	Thu, 14 Jul 2016 16:44:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Cc:	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 2/2] archive-tar: huge offset and future timestamps would not work on 32-bit
Date:	Thu, 14 Jul 2016 13:43:57 -0700
Message-Id: <20160714204357.2628-3-gitster@pobox.com>
X-Mailer: git-send-email 2.9.1-545-g8c0a069
In-Reply-To: <20160714204357.2628-1-gitster@pobox.com>
References: <xmqq7fcoot6t.fsf@gitster.mtv.corp.google.com>
 <20160714204357.2628-1-gitster@pobox.com>
X-Pobox-Relay-ID: B42B4C12-4A03-11E6-A37E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

As we are not yet moving everything to size_t but still using ulong
internally when talking about the size of object, platforms with
32-bit long will not be able to produce tar archive with 4GB+ file,
and cannot grok 077777777777UL as a constant.  Disable the extended
header feature and do not test it on them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive-tar.c       |  5 +++++
 t/t5000-tar-tree.sh | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 7ea4e90..5568240 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -25,8 +25,13 @@ static int write_tar_filter_archive(const struct archiver *ar,
  *
  * Likewise for the mtime (which happens to use a buffer of the same size).
  */
+#if ULONG_MAX == 0xFFFFFFFF
+#define USTAR_MAX_SIZE ULONG_MAX
+#define USTAR_MAX_MTIME ULONG_MAX
+#else
 #define USTAR_MAX_SIZE 077777777777UL
 #define USTAR_MAX_MTIME 077777777777UL
+#endif
 
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 96d208d..699355b 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -360,7 +360,7 @@ test_expect_success 'set up repository with huge blob' '
 
 # We expect git to die with SIGPIPE here (otherwise we
 # would generate the whole 64GB).
-test_expect_success 'generate tar with huge size' '
+test_expect_success LONG_IS_64BIT 'generate tar with huge size' '
 	{
 		git archive HEAD
 		echo $? >exit-code
@@ -369,13 +369,13 @@ test_expect_success 'generate tar with huge size' '
 	test_cmp expect exit-code
 '
 
-test_expect_success TAR_HUGE 'system tar can read our huge size' '
+test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can read our huge size' '
 	echo 68719476737 >expect &&
 	tar_info huge.tar | cut -d" " -f1 >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'set up repository with far-future commit' '
+test_expect_success LONG_IS_64BIT 'set up repository with far-future commit' '
 	rm -f .git/index &&
 	echo content >file &&
 	git add file &&
@@ -383,11 +383,11 @@ test_expect_success 'set up repository with far-future commit' '
 		git commit -m "tempori parendum"
 '
 
-test_expect_success 'generate tar with future mtime' '
+test_expect_success LONG_IS_64BIT 'generate tar with future mtime' '
 	git archive HEAD >future.tar
 '
 
-test_expect_success TAR_HUGE 'system tar can read our future mtime' '
+test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can read our future mtime' '
 	echo 4147 >expect &&
 	tar_info future.tar | cut -d" " -f2 >actual &&
 	test_cmp expect actual
-- 
2.9.1-545-g8c0a069

