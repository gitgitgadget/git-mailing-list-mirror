Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B380C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 06:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiGGGn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 02:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiGGGn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 02:43:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158452AE0A
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 23:43:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 764E21AA9C9;
        Thu,  7 Jul 2022 02:43:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b8NKgg5WqPK8xRceht6fopYJi2QwmKG+1hmHAY
        xCacI=; b=HIKBujM0ZaGnKPNBpnwijjDPy95cxXYtvm+Igt9ZEPqfFrm7qYI/nv
        vwR4NZxVpqhppmaqt2yO6xvxlzG2ArJCN7hG/E1cMG8Ge4NBU/G7q8hMm0sQh+bh
        PxQdCNLGF/NGuJ5HQ/w8y7xIsg47g1++u6v6uu30wAPMiy1Ked6D4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F3421AA9C8;
        Thu,  7 Jul 2022 02:43:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 262DF1AA9C6;
        Thu,  7 Jul 2022 02:43:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] sha256: add support for Nettle
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
        <xmqqedyyi11y.fsf@gitster.g> <xmqqilo94zc2.fsf@gitster.g>
Date:   Wed, 06 Jul 2022 23:43:50 -0700
In-Reply-To: <xmqqilo94zc2.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Jul 2022 16:05:01 -0700")
Message-ID: <xmqqpmih2zix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29FE6840-FDC0-11EC-BE4C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> FWIW, I needed the following to successfully build with
> NETTLE_SHA256=YesPlease defined.  The final linkage step complained
> about missing nettle_SHA256_{Init,Update,Final}() functions without
> the tweak.
> ...

Another glitch.

As "make hdr-check" is pretty much indiscriminatory, my build failed
on a box without libnettle-dev (hence /usr/include/nettle/sha2.h
missing).

diff --git a/Makefile b/Makefile
index ce99aecc31..52a9f97997 100644
--- a/Makefile
+++ b/Makefile
@@ -3098,6 +3098,9 @@ $(SP_OBJ): %.sp: %.c %.o
 sparse: $(SP_OBJ)
 
 EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
+ifndef NETTLE_SHA256
+	EXCEPT_HDRS += sha256/nettle.h
+endif
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
diff --git a/sha256/nettle.h b/sha256/nettle.h
index 159239a785..8c93f29dda 100644
--- a/sha256/nettle.h
+++ b/sha256/nettle.h
@@ -5,17 +5,17 @@
 
 typedef struct sha256_ctx nettle_SHA256_CTX;
 
-inline void nettle_SHA256_Init(nettle_SHA256_CTX *ctx)
+static inline void nettle_SHA256_Init(nettle_SHA256_CTX *ctx)
 {
 	sha256_init(ctx);
 }
 
-inline void nettle_SHA256_Update(nettle_SHA256_CTX *ctx, const void *data, size_t len)
+static inline void nettle_SHA256_Update(nettle_SHA256_CTX *ctx, const void *data, size_t len)
 {
 	sha256_update(ctx, len, data);
 }
 
-inline void nettle_SHA256_Final(unsigned char *digest, nettle_SHA256_CTX *ctx)
+static inline void nettle_SHA256_Final(unsigned char *digest, nettle_SHA256_CTX *ctx)
 {
 	sha256_digest(ctx, SHA256_DIGEST_SIZE, digest);
 }
