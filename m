Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233EC20951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdCQRJs (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:09:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55665 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751131AbdCQRJr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:09:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D54CB750E5;
        Fri, 17 Mar 2017 13:09:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=aEp9
        X3qFYWKqZR74qknkFz/DumI=; b=ttQlLh1dan85yKrH2FsCYshl8Xs22ZK9G/WE
        pqlBW/3y3OK+PCyK6Iz4Adq7EhDM5NT/Jo4uAFhql+uX1mcZSlHirq3bbrmDEGBM
        7rJUp2oaq6mDuoaGolvC+9Y9TirjnxogA1h8iPjhcHKqxax7cploG2bV3n+0dLPO
        EVku8QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        bjZ7i6izmTooipzdnoTuhoM1NZwkLm1URTaR8MxKmYmEwUDKnJDkFlvnfIxQFtdF
        pa7OQdJVejCPPB36CgPZc9d6Gi88QUFLL0X39OaPWK1FZ7bQWsH7jm1m7+sQhOdN
        hn5kkId9idZtD42CvUGJTuHYCshOykA7rQHUFGB7JLM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDB3F750E4;
        Fri, 17 Mar 2017 13:09:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 305BA750E3;
        Fri, 17 Mar 2017 13:09:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] Makefile: make DC_SHA1 the default
Date:   Fri, 17 Mar 2017 10:09:38 -0700
Message-Id: <20170317170938.20593-4-gitster@pobox.com>
X-Mailer: git-send-email 2.12.0-317-g32c43f595f
In-Reply-To: <20170317170938.20593-1-gitster@pobox.com>
References: <20170317111814.tkzeqfyr3aiyxsxr@sigill.intra.peff.net>
 <20170317170938.20593-1-gitster@pobox.com>
X-Pobox-Relay-ID: 84C9A944-0B34-11E7-A82A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We used to use the SHA1 implementation from the OpenSSL library by
default.  As we are trying to be careful against collision attacks
after the recent "shattered" announcement, switch the default to
encourage people to use DC_SHA1 implementation instead.  Those who
want to use the implementation from OpenSSL can explicitly ask for
it by OPENSSL_SHA1=YesPlease when running "make".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index fc9d89498b..fd4421eeb8 100644
--- a/Makefile
+++ b/Makefile
@@ -146,6 +146,9 @@ all::
 # algorithm. This is slower, but may detect attempted collision attacks.
 # Takes priority over other *_SHA1 knobs.
 #
+# Define OPENSSL_SHA1 environment variable when running make to link
+# with the SHA1 routine from openssl library.
+#
 # Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
 # in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
 # wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
@@ -1390,10 +1393,9 @@ ifdef APPLE_COMMON_CRYPTO
 	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
 endif
 
-ifdef DC_SHA1
-	LIB_OBJS += sha1dc/sha1.o
-	LIB_OBJS += sha1dc/ubc_check.o
-	BASIC_CFLAGS += -DSHA1_DC
+ifdef OPENSSL_SHA1
+	EXTLIBS += $(LIB_4_CRYPTO)
+	BASIC_CFLAGS += -DSHA1_OPENSSL
 else
 ifdef BLK_SHA1
 	LIB_OBJS += block-sha1/sha1.o
@@ -1407,8 +1409,10 @@ ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
-	EXTLIBS += $(LIB_4_CRYPTO)
-	BASIC_CFLAGS += -DSHA1_OPENSSL
+	DC_SHA1 := YesPlease
+	LIB_OBJS += sha1dc/sha1.o
+	LIB_OBJS += sha1dc/ubc_check.o
+	BASIC_CFLAGS += -DSHA1_DC
 endif
 endif
 endif
-- 
2.12.0-317-g32c43f595f

