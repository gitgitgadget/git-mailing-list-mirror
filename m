Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE020641
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tuvpq/q5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 247CA1DC6DE;
	Tue, 26 Dec 2023 13:46:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PsTzxyTuCzJKBCeWBQYgDo09ELT1iizNZRYp1y
	sfZYs=; b=tuvpq/q5wDD8p5o/FN+VQcOt/pIV85/z1T+u8x/vdcNWoOUeKy9dvx
	JHG3UZgSj7CjIGG61Y3F9pPWysT1gU3owNImg2PjCAjU6onQ+1xJeIXYBf88c/UH
	Ak6T8jGMQrehSJDU1bgK+K+7jZclaT2xNSJD6j8EFZj6iBesL5pW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1120F1DC6DD;
	Tue, 26 Dec 2023 13:46:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D3411DC6DC;
	Tue, 26 Dec 2023 13:46:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Achu Luma <ach.lumap@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Port helper/test-ctype.c to unit-tests/t-ctype.c
In-Reply-To: <20231221231527.8130-1-ach.lumap@gmail.com> (Achu Luma's message
	of "Fri, 22 Dec 2023 00:15:27 +0100")
References: <20231221231527.8130-1-ach.lumap@gmail.com>
Date: Tue, 26 Dec 2023 10:45:59 -0800
Message-ID: <xmqqsf3ohkew.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0381090A-A41F-11EE-BF46-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Achu Luma <ach.lumap@gmail.com> writes:

> diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
> deleted file mode 100644
> index e5659df40b..0000000000
> --- a/t/helper/test-ctype.c
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -#include "test-tool.h"
> -
> -static int rc;
> -
> -static void report_error(const char *class, int ch)
> -{
> -	printf("%s classifies char %d (0x%02x) wrongly\n", class, ch, ch);
> -	rc = 1;
> -}

So, if we have a is_foo() that characterises a byte that ought to
be "foo" but gets miscategorised not to be "foo", we used to
pinpoint exactly the byte value that was an issue.  We did not do
any early return ...

> ...
> -#define TEST_CLASS(t,s) {			\
> -	int i;					\
> -	for (i = 0; i < 256; i++) {		\
> -		if (is_in(s, i) != t(i))	\
> -			report_error(#t, i);	\
> -	}					\
> -	if (t(EOF))				\
> -		report_error(#t, EOF);		\
> -}

... and reported for all errors in the "class".

> diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
> new file mode 100644
> index 0000000000..41189ba9f9
> --- /dev/null
> +++ b/t/unit-tests/t-ctype.c
> @@ -0,0 +1,76 @@
> +#include "test-lib.h"
> +
> +static int is_in(const char *s, int ch)
> +{
> +	/*
> +	 * We can't find NUL using strchr. Accept it as the first
> +	 * character in the spec -- there are no empty classes.
> +	 */
> +	if (ch == '\0')
> +		return ch == *s;
> +	if (*s == '\0')
> +		s++;
> +	return !!strchr(s, ch);
> +}
> +
> +/* Macro to test a character type */
> +#define TEST_CTYPE_FUNC(func, string)			\
> +static void test_ctype_##func(void)				\
> +{								\
> +	int i;                                     	 	\
> +	for (i = 0; i < 256; i++)                 		\
> +		check_int(func(i), ==, is_in(string, i)); 	\
> +}

Now, we let check_int() to do the checking for each and every byte
value for the class.  check_int() uses different reporting and shows
the problematic value in a way that is more verbose and at the same
time is a less specific and harder to understand:

		test_msg("   left: %"PRIdMAX, a);
		test_msg("  right: %"PRIdMAX, b);

But that is probably the price to pay to use a more generic
framework, I guess.

> +int cmd_main(int argc, const char **argv) {
> +	/* Run all character type tests */
> +	TEST(test_ctype_isspace(), "isspace() works as we expect");
> +	TEST(test_ctype_isdigit(), "isdigit() works as we expect");
> +	TEST(test_ctype_isalpha(), "isalpha() works as we expect");
> +	TEST(test_ctype_isalnum(), "isalnum() works as we expect");
> +	TEST(test_ctype_is_glob_special(), "is_glob_special() works as we expect");
> +	TEST(test_ctype_is_regex_special(), "is_regex_special() works as we expect");
> +	TEST(test_ctype_is_pathspec_magic(), "is_pathspec_magic() works as we expect");
> +	TEST(test_ctype_isascii(), "isascii() works as we expect");
> +	TEST(test_ctype_islower(), "islower() works as we expect");
> +	TEST(test_ctype_isupper(), "isupper() works as we expect");
> +	TEST(test_ctype_iscntrl(), "iscntrl() works as we expect");
> +	TEST(test_ctype_ispunct(), "ispunct() works as we expect");
> +	TEST(test_ctype_isxdigit(), "isxdigit() works as we expect");
> +	TEST(test_ctype_isprint(), "isprint() works as we expect");
> +
> +	return test_done();
> +}

As a practice to use the unit-tests framework, the patch looks OK.
helper/test-ctype.c indeed is an oddball that runs once and checks
everything it wants to check, for which the unit tests framework is
much more suited.

Let's see how others react and then queue.

Thanks.
