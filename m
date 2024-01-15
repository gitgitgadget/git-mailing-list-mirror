Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8817546
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XYtoam+a"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EC2421D47C;
	Mon, 15 Jan 2024 12:27:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9vuLjBtA39Kd
	p04Fy3IMBxPHSz6iwPP8ynFuOdP0lEM=; b=XYtoam+aqZB7XSpryNHmfTQjuKWp
	B+7ky1nSHyORbe35RupU6SAM8M6oi5kuR/+NDUOBfRz+M0JJP7toQFUNUFk/6r3X
	IXEceykA0XqmVdeTjWDvmQQP1z33OX4SEpIB26FH/JYhgVPhJ0G8/jAcVOiVqdvV
	E5CbRWFjnHv5kks=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E48951D47B;
	Mon, 15 Jan 2024 12:27:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 63A431D47A;
	Mon, 15 Jan 2024 12:27:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Achu Luma <ach.lumap@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Outreachy][PATCH] Port helper/test-advise.c to
 unit-tests/t-advise.c
In-Reply-To: <93468f5c-5f62-4f22-85ce-b60621852430@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 15 Jan 2024 12:37:36 +0100")
References: <20240112102122.1422-1-ach.lumap@gmail.com>
	<xmqqmsta6uju.fsf@gitster.g>
	<93468f5c-5f62-4f22-85ce-b60621852430@gmail.com>
Date: Mon, 15 Jan 2024 09:27:25 -0800
Message-ID: <xmqqy1cq4ide.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5A90F2DA-B3CB-11EE-96FB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> To test the effect of setting one configuration variable, and ensure
>> it results in a slightly different advice message output to the
>> standard error stream, "test-tool advice" needs only a single line
>> of patch, but if we started with this version, how much work does it
>> take to run the equivalent test in the other patch if it were to be
>> rebased on top of this change?  It won't be just the matter of
>> adding a new TEST(check_advise_if_enabled()) call to cmd_main(),
>> will it?
>
> Maybe something like this will do the trick:
>
> diff --git a/t/unit-tests/t-advise.c b/t/unit-tests/t-advise.c
> index 15df29c955..ac7d2620ef 100644
> --- a/t/unit-tests/t-advise.c
> +++ b/t/unit-tests/t-advise.c
> @@ -6,6 +6,7 @@
>
>  static const char expect_advice_msg[] =3D "hint: This is a piece of ad=
vice\n"
>                                         "hint: Disable this message wit=
h \"git config advice.nestedTag false\"\n";
> +static const char expect_advice_msg_without_disable_hint[] =3D "hint: =
This is a piece of advice\n";
>  static const char advice_msg[] =3D "This is a piece of advice";
>  static const char out_file[] =3D "./output.txt";

Yup, but ...

> @@ -44,7 +45,7 @@ int cmd_main(int argc, const char **argv) {
>
>         TEST(check_advise_if_enabled(advice_msg, NULL, expect_advice_ms=
g),
>                 "advice should be printed when config variable is unset=
");
> -       TEST(check_advise_if_enabled(advice_msg, "true", expect_advice_=
msg),
> +       TEST(check_advise_if_enabled(advice_msg, "true", expect_advice_=
msg_without_disable_hint),
>                 "advice should be printed when config variable is set t=
o true");
>         TEST(check_advise_if_enabled(advice_msg, "false", ""),
>                 "advice should not be printed when config variable is s=
et to false");

... I cannot shake this feeling that the next person who comes to
this code and stares at advice.c would be very tempted to "refactor"
the messages, so that there is only one instance of the same string
in advice.c that is passed to TEST() above.  After all, you can
change only one place to update the message and avoid triggering
test failures that way, right?  But that line of thinking obviously
reduces the value of having tests.

What if messages from plumbing that should not be modified are being
tested with unit tests?  These messages are part of contract with
users, and it is very much worth our time to write and maintain the
tests to ensure they will not be modified by accident.  Obviously
such a refactoring of test messages to reuse the production strings
would destroy the value of having such a test in the first place.

So, I dunno.

>> I doubt the issue is not about "picking the right moment" to
>> transition from the test-tool to unit testing framework in this
>> particular case.  Is "check-advice-if-enabled" a bit too high level
>> a feature to be a good match to "unit" testing, I have to wonder?
>
> I don't have a formed opinion on the change, but I don't see it making
> things worse.  I share your doubts, though.
>
> Thanks.
