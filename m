Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D81772F
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ozVBAe5E"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DF61A1E5688;
	Fri, 12 Jan 2024 17:19:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=q758KItX//VI
	vMzD7Pw8oIRzBMBnqMauMLvla3iS3FI=; b=ozVBAe5E1EJvWiBd7+6OtBtAriGL
	wI/wl0u0f2vO7NR9XheT07GDp3se2hvHqawH26klYeJtJ2uYuR30sWqv/HFrqJwF
	0BQdHP3OKXiQhJpWxE8/MGNSSQvD9A77HaaLAmQyhZS/0PZqeXgi3Wn2Ey//8Y/J
	RYVhzLcHfKTaoGY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D79191E5687;
	Fri, 12 Jan 2024 17:19:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40C2A1E5686;
	Fri, 12 Jan 2024 17:19:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Taylor Blau <me@ttaylorr.com>,  Jeff
 King <peff@peff.net>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <c870a0b6-9fa8-4d00-a5a6-661ca175805f@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 12 Jan 2024 11:05:37 +0100")
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
	<c870a0b6-9fa8-4d00-a5a6-661ca175805f@gmail.com>
Date: Fri, 12 Jan 2024 14:19:32 -0800
Message-ID: <xmqqsf326vpn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A98D10C4-B198-11EE-BEF3-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>  advice.c          | 109 +++++++++++++++++++++++++---------------------
>  t/t0018-advice.sh |   1 -
>  2 files changed, 59 insertions(+), 51 deletions(-)
>
> diff --git a/advice.c b/advice.c
> index f6e4c2f302..8474966ce1 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -33,50 +33,56 @@ static const char *advise_get_color(enum color_advi=
ce ix)
>  	return "";
>  }
> =20
> +enum advice_level {
> +	ADVICE_LEVEL_DEFAULT =3D 0,

We may want to say "_NONE" not "_DEFAULT" to match the convention
used elsewhere, but I have no strong preference.  I do have a
preference to see that, when we explicitly say "In this enum, there
is ADVICE_LEVEL_DEFAULT and its value is zero" with "=3D 0" in the
definition, the places we use a variable of this enum type, we say

	if (!variable)

and not

	if (variable =3D=3D ADVICE_LEVEL_DEFAULT)

> +	ADVICE_LEVEL_DISABLED,
> +	ADVICE_LEVEL_ENABLED,
> +};
> +
>  static struct {
>  	const char *key;
> -	int enabled;
> +	enum advice_level level;
>  } advice_setting[] =3D {
> ...
> -	[ADVICE_WORKTREE_ADD_ORPHAN]			=3D { "worktreeAddOrphan", 1 },
> +	[ADVICE_ADD_EMBEDDED_REPO]			=3D { "addEmbeddedRepo" },
> ...
> +	[ADVICE_WORKTREE_ADD_ORPHAN]			=3D { "worktreeAddOrphan" },
>  };

It certainly becomes nicer to use the "unspecified is left to 0"
convention like this.

>  static const char turn_off_instructions[] =3D
> @@ -116,13 +122,13 @@ void advise(const char *advice, ...)
> =20
>  int advice_enabled(enum advice_type type)
>  {
> -	switch(type) {
> -	case ADVICE_PUSH_UPDATE_REJECTED:
> -		return advice_setting[ADVICE_PUSH_UPDATE_REJECTED].enabled &&
> -		       advice_setting[ADVICE_PUSH_UPDATE_REJECTED_ALIAS].enabled;
> -	default:
> -		return advice_setting[type].enabled;
> -	}
> +	int enabled =3D advice_setting[type].level !=3D ADVICE_LEVEL_DISABLED=
;

OK.

> +	if (type =3D=3D ADVICE_PUSH_UPDATE_REJECTED)
> +		return enabled &&
> +		       advice_enabled(ADVICE_PUSH_UPDATE_REJECTED_ALIAS);

I like the textbook use of a simple recursion here ;-)

> +	return enabled;
>  }

>  void advise_if_enabled(enum advice_type type, const char *advice, ...)
> @@ -133,7 +139,8 @@ void advise_if_enabled(enum advice_type type, const=
 char *advice, ...)
>  		return;
> =20
>  	va_start(params, advice);
> -	vadvise(advice, 1, advice_setting[type].key, params);
> +	vadvise(advice, advice_setting[type].level =3D=3D ADVICE_LEVEL_DEFAUL=
T,
> +		advice_setting[type].key, params);

OK.  Once you configure this advice to be always shown, you no
longer are using the _DEFAULT, so we pass 0 as the second parameter.
Makes sense.

As I said, if we explicitly document that _DEFAULT's value is zero
with "=3D 0" in the enum definition, which we also rely on the
initialization of the advice_setting[] array, then it may probably
be better to write it more like so:

	vadvice(advice, !advice_setting[type].level,
		advice_setting[type].key, params);

I wonder if it makes this caller simpler to update the return value
of advice_enabled() to a tristate.  Then we can do

	int enabled =3D advice_enabled(type);

	if (!enabled)
		return;
	va_start(...);
	vadvice(advice, enabled !=3D ADVICE_LEVEL_ENABLED, ...);
	va_end(...);

but it does not make that much difference.

>  	va_end(params);
>  }
> =20
> @@ -162,7 +169,9 @@ int git_default_advice_config(const char *var, cons=
t char *value)
>  	for (i =3D 0; i < ARRAY_SIZE(advice_setting); i++) {
>  		if (strcasecmp(k, advice_setting[i].key))
>  			continue;
> -		advice_setting[i].enabled =3D git_config_bool(var, value);
> +		advice_setting[i].level =3D git_config_bool(var, value)
> +					  ? ADVICE_LEVEL_ENABLED
> +					  : ADVICE_LEVEL_DISABLED;

OK.  We saw (var, value) in the configuration files we are parsing,
so we find [i] that corresponds to the advice key and tweak the
level.

This loop obviously is O(N*M) for the number of "advice.*"
configuration variables N and the number of advice keys M, but that
is not new to this patch---our expectation is that N will be small,
even though M will grow over time.

> diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
> index c13057a4ca..0dcfb760a2 100755
> --- a/t/t0018-advice.sh
> +++ b/t/t0018-advice.sh
> @@ -17,7 +17,6 @@ test_expect_success 'advice should be printed when co=
nfig variable is unset' '
>  test_expect_success 'advice should be printed when config variable is =
set to true' '
>  	cat >expect <<-\EOF &&
>  	hint: This is a piece of advice
> -	hint: Disable this message with "git config advice.nestedTag false"
>  	EOF
>  	test_config advice.nestedTag true &&
>  	test-tool advise "This is a piece of advice" 2>actual &&

OK.  The commit changes behaviour for existing users who explicitly
said "I want to see this advice" by configuring advice.* key to 'true',
and it probably is a good thing, even though it may be a bit surprising.

One thing that may be missing is a documentation update.  Something
along this line to highlight that now 'true' has a bit different
meaning from before (and as a consequence, we can no longer say
"defaults to true").

 Documentation/config/advice.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git c/Documentation/config/advice.txt w/Documentation/config/advic=
e.txt
index 2737381a11..364a8268b6 100644
--- c/Documentation/config/advice.txt
+++ w/Documentation/config/advice.txt
@@ -1,7 +1,11 @@
 advice.*::
-	These variables control various optional help messages designed to
-	aid new users. All 'advice.*' variables default to 'true', and you
-	can tell Git that you do not need help by setting these to 'false':
+
+	These variables control various optional help messages
+	designed to aid new users.  When left unconfigured, Git will
+	give you the help message with an instruction on how to
+	squelch it.  When set to 'true', the help message is given,
+	but without hint on how to squelch the message.  You can
+	tell Git that you do not need help by setting these to 'false':
 +
 --
 	ambiguousFetchRefspec::
