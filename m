Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D460C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 23:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiGFXFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 19:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGFXFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 19:05:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B540626575
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 16:05:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 106F91B2AAA;
        Wed,  6 Jul 2022 19:05:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mn4kkdBMD4jjqpzfjaqopTRC9HDb1jbQqOd3vf
        g+p1c=; b=B7rv1U/tdoWWYINPL8K3hs3aQhC6/EgmdHroZfq/pRB+oSl9v0AlVl
        UWXcN3EgfexO3mqXm+DtVeUHN3BAJDTPW3FBz6eZAz42XdwmENNwC2sr3a/aJF7k
        7wpya5/maaka72cZGA68LmHqchVJNoxFL1aycY9Qs5y7059kaJUrA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F244B1B2AA9;
        Wed,  6 Jul 2022 19:05:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D8FA1B2AA8;
        Wed,  6 Jul 2022 19:05:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] sha256: add support for Nettle
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
        <xmqqedyyi11y.fsf@gitster.g>
Date:   Wed, 06 Jul 2022 16:05:01 -0700
In-Reply-To: <xmqqedyyi11y.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Jul 2022 10:49:29 -0700")
Message-ID: <xmqqilo94zc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 119AAD8A-FD80-11EC-973B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps "Let's add another option ..., which is Nettle, and give it
> preference over all others when multiple libraries are availalble"
> or something along that line?
>
>> diff --git a/sha256/nettle.h b/sha256/nettle.h
>> new file mode 100644
>> index 0000000000..9b2845babc
>> --- /dev/null
>> +++ b/sha256/nettle.h
>> @@ -0,0 +1,28 @@
>> +#ifndef SHA256_GCRYPT_H
>> +#define SHA256_GCRYPT_H
>
> Not really ;-)

FWIW, I needed the following to successfully build with
NETTLE_SHA256=YesPlease defined.  The final linkage step complained
about missing nettle_SHA256_{Init,Update,Final}() functions without
the tweak.

diff --git c/sha256/nettle.h w/sha256/nettle.h
index 9b2845babc..8c93f29dda 100644
--- c/sha256/nettle.h
+++ w/sha256/nettle.h
@@ -1,21 +1,21 @@
-#ifndef SHA256_GCRYPT_H
-#define SHA256_GCRYPT_H
+#ifndef SHA256_NETTLE_H
+#define SHA256_NETTLE_H
 
 #include <nettle/sha2.h>
 
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


