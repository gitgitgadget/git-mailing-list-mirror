From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/1] http: Add Accept-Language header if possible
Date: Mon, 22 Dec 2014 11:34:05 -0800
Message-ID: <xmqqwq5j8onm.fsf@gitster.dls.corp.google.com>
References: <CAO2U3QjG2rUgUrM5odX0UOnHsENnYTfwaRLhHv8gka7qj4XWdw@mail.gmail.com>
	<1419266658-1180-1-git-send-email-eungjun.yi@navercorp.com>
	<1419266658-1180-2-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 20:34:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y38kB-0004WF-Nl
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 20:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbaLVTeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 14:34:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755286AbaLVTeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 14:34:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D49DA27E76;
	Mon, 22 Dec 2014 14:34:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hd7OCNmGjRAVmn1YQWgL4F7ZYZk=; b=sCdQcB
	auPF6E4f4T54z0tYZ9QgZR53EPi9dT9Y0OdKdGA/8CpqG6boCGfNjjxO9KneqDOw
	zAJhtCpEVgVEL0fd3RSLZyHN1hmiO47tHV4IzPvZ6F4q94geRKHt3UN4qq9n3Srt
	21u2w5+N/faaEPBRrCIC/RfbDxOZOavxbAuwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VtGwIDyIWKrKLZ8RpuHg/4JcoT26uumv
	6Qncw58/XFV7nAm5p2E9JpSZ4mTvWjrRrDhVuu+V6cjQs3wfGzGJDFbO/AuEY4BG
	11dFby2zxuBgAAbYA4BGxU1Y90Lp9I9p4VImfY6wQruslwULdPJhotC7adPAZpox
	SBRFdg9XwE8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C90E927E75;
	Mon, 22 Dec 2014 14:34:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 254C427E6E;
	Mon, 22 Dec 2014 14:34:07 -0500 (EST)
In-Reply-To: <1419266658-1180-2-git-send-email-eungjun.yi@navercorp.com> (Yi
	EungJun's message of "Tue, 23 Dec 2014 01:44:18 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7EAD6F4C-8A11-11E4-9183-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261668>

Yi EungJun <semtlenori@gmail.com> writes:

> From: Yi EungJun <eungjun.yi@navercorp.com>
>
> Add an Accept-Language header which indicates the user's preferred
> languages defined by $LANGUAGE, $LC_ALL, $LC_MESSAGES and $LANG.
>
> Examples:
>   LANGUAGE= -> ""
>   LANGUAGE=ko:en -> "Accept-Language: ko, en;q=0.9, *;q=0.1"
>   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *;q=0.1"
>   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *;q=0.1"
>
> This gives git servers a chance to display remote error messages in
> the user's preferred language.
>
> Limit the number of languages to 1,000 because q-value must not be
> smaller than 0.001, and limit the length of Accept-Language header to
> 4,000 bytes for some HTTP servers which cannot accept such long header.
>
> Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>

Overall, this one is a much more pleasant read than the previous
rounds.

> @@ -986,6 +993,166 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
>  		strbuf_addstr(charset, "ISO-8859-1");
>  }
>  
> +/*
> + * Guess the user's preferred languages from the value in LANGUAGE environment
> + * variable and LC_MESSAGES locale category if NO_GETTEXT is not defined.
> + *
> + * The result can be a colon-separated list like "ko:ja:en".
> + */
> +static const char *get_preferred_languages(void)
> +{
> +	const char *retval;
> +
> +	retval = getenv("LANGUAGE");
> +	if (retval && *retval)
> +		return retval;
> +
> +#ifndef NO_GETTEXT
> +	retval = setlocale(LC_MESSAGES, NULL);
> +	if (retval && *retval &&
> +		strcmp(retval, "C") &&
> +		strcmp(retval, "POSIX"))
> +		return retval;
> +#endif

A tangent.

I wonder if we want to have something silly like this:

	#ifndef NO_GETTEXT
        #define setlocale(x, y) NULL /* or "C"??? */
        #endif

in a common header (e.g. gettext.h) to avoid sprinkling #ifdefs in
our code.  While I do not think we call setlocale() that often to
warrant such a trick, we already do something very similar to make
git_setup_gettext() a no-op in NO_GETTEXT builds in that header
file, and the change in this patch to remote-curl.c does take
advantage of it already, so...

> +static void write_accept_language(struct strbuf *buf)
> +{
> +	const char *lang_begin, *pos;
> +	int q, max_q;
> +	int num_langs;
> +	int decimal_places;
> +	const int CODESET_OR_MODIFIER = 1;
> +	const int LANGUAGE_TAG = 2;
> +	const int SEPARATOR = 3;

Another tangent, but I think we tend to use either #define or enum
for constants, not "const int", in our codebase, for symbolic
constants.  In order to define a set of symbolic constants limited
to a function scope, the "const int" way may be nicer than the other
two methods we have traditionally used.  Perhaps we should promote
such use more widely, write our new code following this example, and
migrate existing ones over time?  I dunno.

> ...
> +	/* Decide the precision for q-factor on number of preferred lang_begin. */
> +	num_langs += 1; /* for '*' */
> +
> +	if (MAX_LANGS < num_langs)
> +		num_langs = MAX_LANGS;
> +
> +	for (max_q = 1, decimal_places = 0;
> +		max_q < num_langs;
> +		decimal_places++, max_q *= 10)
> +		;

So, if we have 10 languages (num_langs == 10), decimal_places
becomes 1, max_q becomes 10 ...

> +	sprintf(q_format, ";q=0.%%0%dd", decimal_places);

... and we will use "q=0.%01d" as the format.  This is OK because
the first one is given without q= so we use the format only nine
times, counting down from 0.9 to 0.1 in 0.1 increments.

Sounds OK to me (I always miscount this kind of loop and need to
think aloud while doing a sanity check).

> +	for (pos = lang_begin; ; pos++) {
> +		if (!*pos || *pos == ':') {
> +			if (is_q_factor_required) {
> +				/* Put a q-factor only if it is less than 1.0. */
> +				if (q < max_q)
> +					strbuf_addf(buf, q_format, q);
> +
> +				if (q > 1)
> +					q--;

When does this "if" statement not trigger?  It seems to me that it
will stop decrementing only if you have very many languages (e.g.
num_langs was clipped to MAX_LANGS), and at that point you would not
want to scan and add more languages---is there a reason why you keep
going in such a case and not break out of the loop, i.e.

	if (q-- < 1)
		break;

or something like that?

> + ...
> +		if (buf->len > MAX_SIZE_OF_HEADER - MAX_SIZE_OF_ASTERISK_ELEMENT) {
> +			strbuf_remove(buf, last_size, buf->len - last_size);
> +			break;
> +		}
> +
> +		if (!*pos)
> +			break;

Alternatively use one of these breaks when q goes below 1, perhaps?

> +/*
> + * Get an Accept-Language header which indicates user's preferred languages.
> + *
> + * This function always return non-NULL string as strbuf_detach() does.
> + *
> + * Examples:
> + *   LANGUAGE= -> ""
> + *   LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
> + *   LANGUAGE=ko_KR.UTF-8:sr@latin -> "Accept-Language: ko-KR, sr; q=0.9, *; q=0.1"
> + *   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
> + *   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
> + *   LANGUAGE= LANG=C -> ""
> + */
> +static const char *get_accept_language(void)
> +{
> +	if (!cached_accept_language) {
> +		struct strbuf buf = STRBUF_INIT;
> +		write_accept_language(&buf);
> +		cached_accept_language = strbuf_detach(&buf, NULL);
> +		strbuf_release(&buf);

If you detached the associated string from the strbuf, you have
already released the resource from it; no need to release it, I
would think.

> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index ac71418..1a58b97 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -196,5 +196,37 @@ test_expect_success 'reencoding is robust to whitespace oddities' '
>  	grep "this is the error message" stderr
>  '
>  
> +check_language () {
> +	echo "Accept-Language: $1" >expect &&
> +	GIT_CURL_VERBOSE=1 \
> +	LANGUAGE=$2 \
> +	git ls-remote "$HTTPD_URL/dumb/repo.git" 2>&1 |
> +	tr -d '\015' |
> +	sort -u >stderr &&
> +	grep -i ^Accept-Language: stderr >actual &&
> +	test_cmp expect actual
> +}

This makes it hard to test a case where no Accept-Language: header
should be issued in the request, because at that point we would be
expecting no matching string in the output.

	case "$2" in
        '')
        	>expect
                ;;
	?*)
        	echo "Accept-Language: $1" >expect
                ;;
	esac &&
	git ls-remote "$HTTPD_URL/dumb/repo.git" >output 2>&1 &&
	tr -d '\015' <output |
        sort -u |
        sed -ne '/^Accept-Language:/' >actual &&
        test_cmp expect actual

or something like that, perhaps?

And I can see below that we are not testing that "negative" case.

After writing a new shiny feature, it always is tempting to show off
that it triggers when it is expected to and gives an expected
result, but it is equally important to have tests that make sure
that the feature does not trigger when it should not.


> +test_expect_success 'git client sends Accept-Language based on LANGUAGE' '
> +	check_language "ko-KR, *;q=0.1" ko_KR.UTF-8'
> +
> +test_expect_success 'git client sends Accept-Language correctly with unordinary LANGUAGE' '
> +	check_language "ko-KR, *;q=0.1" "ko_KR:" &&
> +	check_language "ko-KR, *;q=0.1" " ko_KR" &&
> +	check_language "ko-KR, en-US;q=0.9, *;q=0.1" "ko_KR: en_US" &&
> +	check_language "ko-KR, en-US;q=0.9, *;q=0.1" "ko_KR::en_US" &&
> +	check_language "ko-KR, *;q=0.1" ":::ko_KR"'
> +
> +test_expect_success 'git client sends Accept-Language with many preferred languages' '
> +	check_language "ko-KR, en-US;q=0.99, fr-CA;q=0.98, de;q=0.97, sr;q=0.96, \
> +ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.01" \
> +		ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt:nb
> +'
