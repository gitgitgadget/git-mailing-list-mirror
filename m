Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0064FCCA473
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 17:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiGFRti (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 13:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiGFRth (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 13:49:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB251DA49
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 10:49:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12BCD1A63E5;
        Wed,  6 Jul 2022 13:49:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QOxc6XLT6ATTIb0Hx0JyZQ6wAUZpx7a41/sF8W
        1AQ70=; b=A6xUDdx9IDjerY4alOz5oCdlUTS6lIae1f5TyseiHBzP1yXxNeo8Y4
        hJk0C8lmSPKqKRGj+HBjIfB4bfqLs7kFlzXKKt5p9KptDbK4aMv4qXfuHMZnsRML
        xj9Cc8TNVUuq3PVRFl3JOsGJn9SB6uzUwi/q/4PPlJBUQ6HpNEbHQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AC7D1A63E4;
        Wed,  6 Jul 2022 13:49:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 04C6B1A63E0;
        Wed,  6 Jul 2022 13:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] sha256: add support for Nettle
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
Date:   Wed, 06 Jul 2022 10:49:29 -0700
In-Reply-To: <20220705230518.713218-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 5 Jul 2022 23:05:18 +0000")
Message-ID: <xmqqedyyi11y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCFF4498-FD53-11EC-B5C5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/hash.h b/hash.h
> index 5d40368f18..ea87ae9d92 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -16,7 +16,9 @@
>  #include "block-sha1/sha1.h"
>  #endif
>  
> -#if defined(SHA256_GCRYPT)
> +#if defined(SHA256_NETTLE)
> +#include "sha256/nettle.h"
> +#elif defined(SHA256_GCRYPT)
>  #define SHA256_NEEDS_CLONE_HELPER
>  #include "sha256/gcrypt.h"
>  #elif defined(SHA256_OPENSSL)

When it does not make any semantic difference, it is preferrable to
add a new thing after existing things.  But this sequence is meant
to list them in the order of preference when multiple choices are
availble, so it is OK to prepend nettle IF our intention is to favor
it over all others.

I am OK with that design choice, and I think the first paragraph of
the proposed log message adequately justifies why, but I'd prefer to
see it a bit more explicitly stated in the log message.

> For SHA-256, we currently have support for OpenSSL and libgcrypt because
> these two libraries contain optimized implementations that can take
> advantage of native processor instructions.  However, OpenSSL is not
> suitable for linking against for Linux distros due to licensing
> incompatibilities with the GPLv2, and libgcrypt has been less favored
> by cryptographers due to some security-related implementation issues.
>
> Let's add another option that's compatible with the GPLv2, which is
> Nettle.  It also has recently gained support for Intel's SHA-NI
> instructions, which compare very favorably to other implementations.
> For example, using this implementation and SHA-1 DC on a machine with
> SHA-NI, hashing a 2 GiB file with SHA-1 takes 7.582 seconds, while
> hashing the same file with SHA-256 takes 2.278 seconds.

Perhaps "Let's add another option ..., which is Nettle, and give it
preference over all others when multiple libraries are availalble"
or something along that line?

> diff --git a/sha256/nettle.h b/sha256/nettle.h
> new file mode 100644
> index 0000000000..9b2845babc
> --- /dev/null
> +++ b/sha256/nettle.h
> @@ -0,0 +1,28 @@
> +#ifndef SHA256_GCRYPT_H
> +#define SHA256_GCRYPT_H

Not really ;-)

> +
> +#include <nettle/sha2.h>



