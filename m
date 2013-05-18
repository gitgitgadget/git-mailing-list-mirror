From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 3/3] imap-send: eliminate HMAC deprecation warnings on Mac OS X
Date: Fri, 17 May 2013 18:58:44 -0700
Message-ID: <7v4ne1vyjv.fsf@alter.siamese.dyndns.org>
References: <1368837158-13915-1-git-send-email-sunshine@sunshineco.com>
	<1368837158-13915-4-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, Git List <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat May 18 03:59:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdWQJ-0006nk-Ck
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 03:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab3ERB6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 21:58:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50146 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab3ERB6r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 21:58:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45412104A6;
	Sat, 18 May 2013 01:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fl1XtXJEUw9pjdJRpbDwCAoZNEI=; b=WiuzS/
	6bI2904YvABTw1dRvunkDwwiAUJteqHkJNnZe5vaRd8Z0tUHprlB/NI3K1Z7CxrN
	I0MfUtpUgPoD/m+SuQsiWu2HnTS+nnZCnf/9qISuVEnYgM8W4YnCVbVpwBowTZXU
	X45zCdhRP7wL4jX5kFHQbwceEfHiKAqyu7qZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SzoX2G5t7Q7NN5oVK3XmqFvkSNWYBgAV
	0YW/sUGoJQLW2eMMaESAHBGMHzicJi4eDcXOm9CHOC32d+H7T/s4fgietE12Hvid
	Vn+UL+5Sdv3AwcwXgfJfcWJ+4QP0Tyhja0QrH1i2MmZ4qvA/5C4why1N500q5dgI
	LI96JrmfWfc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B1A7104A5;
	Sat, 18 May 2013 01:58:46 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90955104A4;
	Sat, 18 May 2013 01:58:45 +0000 (UTC)
In-Reply-To: <1368837158-13915-4-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Fri, 17 May 2013 20:32:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 793774D8-BF5E-11E2-8AD1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224750>

Eric Sunshine <sunshine@sunshineco.com> writes:

> From: David Aguilar <davvid@gmail.com>
>
> As of Mac OS X 10.7, Apple deprecated all OpenSSL functions due to
> OpenSSL ABI instability.  Silence the warnings by using Apple's
> CommonCrypto HMAC replacement functions.
>
> [es: reworded commit message; eliminated abuse of
> COMMON_DIGEST_FOR_OPENSSL by checking NO_APPLE_COMMON_CRYPTO instead]
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  imap-send.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/imap-send.c b/imap-send.c
> index d9bcfb4..642448c 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -29,8 +29,18 @@
>  #ifdef NO_OPENSSL
>  typedef void *SSL;
>  #else
> +#ifndef NO_APPLE_COMMON_CRYPTO
> +#include <CommonCrypto/CommonHMAC.h>
> +#define HMAC_CTX CCHmacContext
> +#define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, len)
> +#define HMAC_Update CCHmacUpdate
> +#define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
> +#define HMAC_CTX_cleanup
> +#define EVP_md5() kCCHmacAlgMD5
> +#else
>  #include <openssl/evp.h>
>  #include <openssl/hmac.h>
> +#endif

Doesn't this mean people on platforms that do not care what Apple
does have to define NO_APPLE_COMMON_CRYPTO?

How about stopping this double-negation and do it more like this?

 * In Makefile (1/3), in uname_S == Darwin section, define
   COMPAT_CFLAGS += DAPPLE_COMMON_CRYPTO by default, unless the
   builder declines it with "make NO_APPLE_COMMON_CRYPTO=NoThanks"

 * Express this part as

    #ifdef APPLE_COMMON_CRYPTO
    ... do the common crypto thing ...
    #else
    ... everybody else ...
    #endif

>  #include <openssl/x509v3.h>
>  #endif
