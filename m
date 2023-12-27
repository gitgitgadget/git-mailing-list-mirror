Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD1498A6
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fp7hmFL1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DF006187E3;
	Wed, 27 Dec 2023 18:48:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hmnZUsf41I4s
	Oj6TEzhEeXCUsEsBMUOxh/Dw3EoLMeM=; b=Fp7hmFL12nMDJNrCEKLwQs5xeBRV
	0gyiWn5WqIouphgmlm52RUsVmfHJPXHEQFv/6NwUeXwho4fh+//gBw/PR5r74GLq
	Ve1LH50CSdShQkqtbzXGA2ia6BN8oxjVUczaZoSwH6fsl8DcYtmOPQFQz21HwF/B
	gRuml9rZDyt08mo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D1C0B187AA;
	Wed, 27 Dec 2023 18:48:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 798C3187A2;
	Wed, 27 Dec 2023 18:48:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Christian Couder <christian.couder@gmail.com>,  Achu Luma
 <ach.lumap@gmail.com>,  git@vger.kernel.org,  Christian Couder
 <chriscool@tuxfamily.org>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] Port helper/test-ctype.c to unit-tests/t-ctype.c
In-Reply-To: <f743b473-40f8-423d-bf5b-d42b92e5aa1b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 27 Dec 2023 12:57:26 +0100")
References: <20231221231527.8130-1-ach.lumap@gmail.com>
	<xmqqsf3ohkew.fsf@gitster.g>
	<CAP8UFD1vC6=7ESx1w7S9Q9P0Bsc+c03wgHToNBaP+ivvm9BKBg@mail.gmail.com>
	<f743b473-40f8-423d-bf5b-d42b92e5aa1b@web.de>
Date: Wed, 27 Dec 2023 15:48:47 -0800
Message-ID: <xmqqcyurky00.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7B817C0C-A512-11EE-A151-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> Also it might not be a big issue here, but when the new unit test
>> framework was proposed, I commented on the fact that "left" and
>> "right" were perhaps a bit less explicit than "actual" and "expected".
>
> True.
> ...
> The added repetition is a bit grating.  With a bit of setup, loop
> unrolling and stringification you can retain the property of only havin=
g
> to mention the class name once.  Demo patch below.

Nice.

This (and your mempool thing) being one of the early efforts to
adopt the unit-test framework outside the initial set of sample
tests, it is understandable that we might find what framework offers
is still lacking.  But at the same time, while the macro tricks
demonstrated here are all amusing to read and admire, it feels a bit
too much to expect that the test writers are willing to invent
something like these every time they want to test.

Being a relatively faithful conversion of the original ctype tests,
with its thorough enumeration of test samples and expected output,
is what makes this test program require these macro tricks, and it
does not have much to do with the features (or lack thereof) of the
framework, I guess.

> +struct ctype {
> +	const char *name;
> +	const char *expect;
> +	int actual[256];
> +};
> +
> +static void test_ctype(const struct ctype *class)
> +{
> +	for (int i =3D 0; i < 256; i++) {
> +		int expect =3D is_in(class->expect, i);
> +		int actual =3D class->actual[i];
> +		int res =3D test_assert(TEST_LOCATION(), class->name,
> +				      actual =3D=3D expect);
> +		if (!res)
> +			test_msg("%s classifies char %d (0x%02x) wrongly",
> +				 class->name, i, i);
> +	}
>  }

Somehow, the "test_assert" does not seem to be adding much value
here (i.e. we can do "res =3D (actual =3D=3D expect)" there).  Is this
because we want to be able to report success, too?

    ... goes and looks at test_assert() ...

Ah, is it because we want to be able to "skip" (which pretends that
the assert() was satisified).  OK, but then the error reporting from
it is redundant with our own test_msg(). =20

Everything below this line was a fun read ;-)

Thanks.

> ...
> +#define APPLY16(f, n) \
> +	f(n + 0x0), f(n + 0x1), f(n + 0x2), f(n + 0x3), \
> +	f(n + 0x4), f(n + 0x5), f(n + 0x6), f(n + 0x7), \
> +	f(n + 0x8), f(n + 0x9), f(n + 0xa), f(n + 0xb), \
> +	f(n + 0xc), f(n + 0xd), f(n + 0xe), f(n + 0xf)
> +#define APPLY256(f) \
> +	APPLY16(f, 0x00), APPLY16(f, 0x10), APPLY16(f, 0x20), APPLY16(f, 0x30=
),\
> +	APPLY16(f, 0x40), APPLY16(f, 0x50), APPLY16(f, 0x60), APPLY16(f, 0x70=
),\
> +	APPLY16(f, 0x80), APPLY16(f, 0x90), APPLY16(f, 0xa0), APPLY16(f, 0xb0=
),\
> +	APPLY16(f, 0xc0), APPLY16(f, 0xd0), APPLY16(f, 0xe0), APPLY16(f, 0xf0=
),\
> +
> +#define CTYPE(name, expect) { #name, expect, { APPLY256(name) }  }
>
>  int cmd_main(int argc, const char **argv) {
> +	struct ctype classes[] =3D {
> +		CTYPE(isdigit, DIGIT),
> +		CTYPE(isspace, " \n\r\t"),
> +		CTYPE(isalpha, LOWER UPPER),
> +		CTYPE(isalnum, LOWER UPPER DIGIT),
> +		CTYPE(is_glob_special, "*?[\\"),
> +		CTYPE(is_regex_special, "$()*+.?[\\^{|"),
> +		CTYPE(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~"),
> +		CTYPE(isascii, ASCII),
> +		CTYPE(islower, LOWER),
> +		CTYPE(isupper, UPPER),
> +		CTYPE(iscntrl, CNTRL),
> +		CTYPE(ispunct, PUNCT),
> +		CTYPE(isxdigit, DIGIT "abcdefABCDEF"),
> +		CTYPE(isprint, LOWER UPPER DIGIT PUNCT " "),
> +	};
>  	/* Run all character type tests */
> -	TEST(test_ctype_isspace(), "isspace() works as we expect");
> -	TEST(test_ctype_isdigit(), "isdigit() works as we expect");
> -	TEST(test_ctype_isalpha(), "isalpha() works as we expect");
> -	TEST(test_ctype_isalnum(), "isalnum() works as we expect");
> -	TEST(test_ctype_is_glob_special(), "is_glob_special() works as we exp=
ect");
> -	TEST(test_ctype_is_regex_special(), "is_regex_special() works as we e=
xpect");
> -	TEST(test_ctype_is_pathspec_magic(), "is_pathspec_magic() works as we=
 expect");
> -	TEST(test_ctype_isascii(), "isascii() works as we expect");
> -	TEST(test_ctype_islower(), "islower() works as we expect");
> -	TEST(test_ctype_isupper(), "isupper() works as we expect");
> -	TEST(test_ctype_iscntrl(), "iscntrl() works as we expect");
> -	TEST(test_ctype_ispunct(), "ispunct() works as we expect");
> -	TEST(test_ctype_isxdigit(), "isxdigit() works as we expect");
> -	TEST(test_ctype_isprint(), "isprint() works as we expect");
> +	for (int i =3D 0; i < ARRAY_SIZE(classes); i++)
> +		TEST(test_ctype(&classes[i]), "%s works", classes[i].name);
>
>  	return test_done();
>  }
