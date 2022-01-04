Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA93AC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 21:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiADVBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 16:01:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58268 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiADVBV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 16:01:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59977115550;
        Tue,  4 Jan 2022 16:01:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kAfwmcYnkOvpfLtD6C9vacGnxD5tPcoBaFJSor
        JBQMs=; b=tId/Z/1qd6CEn2PEyKA2Zof/6bQouEVN6BYEaKADMbRDZuKOpofpit
        lmMAHMmQAHooc4PMSXsrNXND1VZsAzMrWDgMfbSQHg0vAnWJmldXbT+gaGngkxxP
        B1d5sGxUFRTdYCELRGej/bhV1IFBfLtCF2Z5kXylE+gSsR6c8ITKw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 506F111554F;
        Tue,  4 Jan 2022 16:01:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A333E11554E;
        Tue,  4 Jan 2022 16:01:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
        <20220104015555.3387101-2-sandals@crustytoothpaste.net>
Date:   Tue, 04 Jan 2022 13:01:19 -0800
In-Reply-To: <20220104015555.3387101-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 4 Jan 2022 01:55:54 +0000")
Message-ID: <xmqqsfu3b4gw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77B0B778-6DA1-11EC-9BE9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +# Define CSPRNG_METHOD to "arc4random" if your system has arc4random and
> +# arc4random_buf, "arc4random-libbsd" if your system has those functions from
> +# libbsd, "getrandom" if your system has getrandom, "getentropy" if your
> +# system has getentropy, "rtlgenrandom" for RtlGenRandom (Windows only), or
> +# "openssl" if you'd want to use the OpenSSL CSPRNG.  If unset or set to
> +# anything else, defaults to using "/dev/urandom".
> +#

OK.

> +ifeq ($(strip $(CSPRNG_METHOD)),arc4random)
> +	BASIC_CFLAGS += -DHAVE_ARC4RANDOM
> +endif
> +
> +ifeq ($(strip $(CSPRNG_METHOD)),arc4random-libbsd)
> +	BASIC_CFLAGS += -DHAVE_ARC4RANDOM_LIBBSD
> +	EXTLIBS += -lbsd
> +endif
> +
> +ifeq ($(strip $(CSPRNG_METHOD)),getrandom)
> +	BASIC_CFLAGS += -DHAVE_GETRANDOM
> +endif
> +
> +ifeq ($(strip $(CSPRNG_METHOD)),getentropy)
> +	BASIC_CFLAGS += -DHAVE_GETENTROPY
> +endif
> +
> +ifeq ($(strip $(CSPRNG_METHOD)),rtlgenrandom)
> +	BASIC_CFLAGS += -DHAVE_RTLGENRANDOM
> +endif
> +
> +ifeq ($(strip $(CSPRNG_METHOD)),openssl)
> +	BASIC_CFLAGS += -DHAVE_OPENSSL_CSPRNG
> +endif

Use of $(strip ($VAR)) looks a bit different from what everybody
else does with ifeq in this Makefile.  Was there a particular reason
to use it that I am missing?

When we see something unrecognized in CSPRNG_METHOD, we do not touch
BASIC_CFLAGS (or EXTLIBS) here.  I wonder how easy a clue we would
have to decide that we need to fall back to urandom.  IOW, I would
have expected a if/else if/... cascade that has "no we do not have
anything else and need to fall back to urandom" at the end.

But that's OK, as long as the fallback logic is cleanly done.  Let's
keep reading...

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5fa54a7afe..50597c76be 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1421,4 +1433,11 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
>  
>  void sleep_millisec(int millisec);
>  
> +/*
> + * Generate len bytes from the system cryptographically secure PRNG.
> + * Returns 0 on success and -1 on error, setting errno.  The inability to
> + * satisfy the full request is an error.
> + */
> +int csprng_bytes(void *buf, size_t len);
> +
>  #endif
> diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
> new file mode 100644
> index 0000000000..65d14973c5
> --- /dev/null
> +++ b/t/helper/test-csprng.c
> @@ -0,0 +1,29 @@
> +#include "test-tool.h"
> +#include "git-compat-util.h"
> +
> +
> +int cmd__csprng(int argc, const char **argv)
> +{
> +	unsigned long count;
> +	unsigned char buf[1024];
> +
> +	if (argc > 2) {
> +		fprintf(stderr, "usage: %s [<size>]\n", argv[0]);
> +		return 2;
> +	}
> +
> +	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : -1L;
> +
> +	while (count) {
> +		unsigned long chunk = count < sizeof(buf) ? count : sizeof(buf);

"chunk" should be of type "size_t", no?

> diff --git a/wrapper.c b/wrapper.c
> index 36e12119d7..1052356703 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -702,3 +702,69 @@ int open_nofollow(const char *path, int flags)
>  	return open(path, flags);
>  #endif
>  }
> +
> +int csprng_bytes(void *buf, size_t len)
> +{
> +#if defined(HAVE_ARC4RANDOM) || defined(HAVE_ARC4RANDOM_LIBBSD)

Shouldn't HAVE_ARC4RANDOM mean "we have arc4random_buf() function
available; please use that.", i.e. wouldn't this give us cleaner
result in the change to the Makefile?

 ifeq ($(strip $(CSPRNG_METHOD)),arc4random)
 	BASIC_CFLAGS += -DHAVE_ARC4RANDOM
 endif
 
 ifeq ($(strip $(CSPRNG_METHOD)),arc4random-libbsd)
-	BASIC_CFLAGS += -DHAVE_ARC4RANDOM_LIBBSD
+	BASIC_CFLAGS += -DHAVE_ARC4RANDOM
 	EXTLIBS += -lbsd
 endif

To put it differently, C source, via BASIC_CFLAGS, would not have to
care where the function definition comes from.  It is linker's job
to care and we are already telling it via EXTLIBS, so I am not sure
the value of having HAVE_ARC4RANDOM_LIBBSD as a separate symbol.

> +	/* This function never returns an error. */
> +	arc4random_buf(buf, len);
> +	return 0;
> +#elif defined(HAVE_GETRANDOM)
> +	ssize_t res;
> +	char *p = buf;
> +	while (len) {
> +		res = getrandom(p, len, 0);
> +		if (res < 0)
> +			return -1;
> +		len -= res;
> +		p += res;
> +	}
> +	return 0;
> +#elif defined(HAVE_GETENTROPY)
> +	int res;
> +	char *p = buf;
> +	while (len) {
> +		/* getentropy has a maximum size of 256 bytes. */
> +		size_t chunk = len < 256 ? len : 256;
> +		res = getentropy(p, chunk);
> +		if (res < 0)
> +			return -1;
> +		len -= chunk;
> +		p += chunk;
> +	}
> +	return 0;
> +#elif defined(HAVE_RTLGENRANDOM)
> +	if (!RtlGenRandom(buf, len))
> +		return -1;
> +	return 0;
> +#elif defined(HAVE_OPENSSL_CSPRNG)
> +	int res = RAND_bytes(buf, len);
> +	if (res == 1)
> +		return 0;
> +	if (res == -1)
> +		errno = ENOTSUP;
> +	else
> +		errno = EIO;
> +	return -1;
> +#else
> +	ssize_t res;
> +	char *p = buf;
> +	int fd, err;
> +	fd = open("/dev/urandom", O_RDONLY);
> +	if (fd < 0)
> +		return -1;
> +	while (len) {
> +		res = xread(fd, p, len);
> +		if (res < 0) {
> +			err = errno;
> +			close(fd);
> +			errno = err;
> +			return -1;
> +		}
> +		len -= res;
> +		p += res;
> +	}
> +	close(fd);
> +	return 0;
> +#endif
> +}

OK, I earlier worried about the lack of explicit "we are using
urandom" at the Makefile level, but as long as this will remain the
only place that needs to care about the fallback, the above is
perfectly fine.

Thanks.
