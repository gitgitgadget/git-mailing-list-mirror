From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/1] http: Add Accept-Language header if possible
Date: Mon, 21 Jul 2014 12:01:39 -0700
Message-ID: <xmqqwqb6ilik.fsf@gitster.dls.corp.google.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
	<1405792730-13539-2-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:02:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Iqh-0005Xl-Mo
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 21:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933478AbaGUTCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 15:02:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59749 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933453AbaGUTCF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 15:02:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A05E29B36;
	Mon, 21 Jul 2014 15:02:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2w8WZYAHCsQOfwKvNnFf0IhpVzI=; b=RkBN1p
	7JYFFnthhD2qPReSlOwbshXZYhZhLgiJyUFGt9f/vA1Ywh29fqVaPuzUjWhHG/0+
	kNzgRwr56SOdhu2Xt+v1Tic3h9tOIq654GfwU0+OhNy2uTssIVeRrV1wM9u2SC9W
	aSj6wa89Q1+tsvgUJTKca8AIv4h3r8iG0xJYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hD/g5DZK9kuSzrQYh9Q48xfP19ZuH76x
	KI8caYAvuy3kz/Aw0HZe7eoTK3SYvXCsjLWESk6e9gPl+FPukgMv3Y/neeICkV2O
	z7NZ1G/AjYoPSh5aTHUDOnUuNVjhXvpHVQG96Uuv/uU2/OtmorF1k2lnFZrTK2t5
	mjlS5hhYo5s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D56229B35;
	Mon, 21 Jul 2014 15:02:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 29F5229B17;
	Mon, 21 Jul 2014 15:01:41 -0400 (EDT)
In-Reply-To: <1405792730-13539-2-git-send-email-eungjun.yi@navercorp.com> (Yi
	EungJun's message of "Sun, 20 Jul 2014 02:58:50 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7320F9CC-1109-11E4-8C53-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253988>

Yi EungJun <semtlenori@gmail.com> writes:

> From: Yi EungJun <eungjun.yi@navercorp.com>
>
> Add an Accept-Language header which indicates the user's preferred
> languages defined by $LANGUAGE, $LC_ALL, $LC_MESSAGES and $LANG.
>
> Examples:
>   LANGUAGE= -> ""
>   LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
>   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
>   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
>
> This gives git servers a chance to display remote error messages in
> the user's preferred language.
>
> Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
> ---
>  http.c                     | 134 +++++++++++++++++++++++++++++++++++++++++++++
>  remote-curl.c              |   2 +
>  t/t5550-http-fetch-dumb.sh |  31 +++++++++++
>  3 files changed, 167 insertions(+)
>
> diff --git a/http.c b/http.c
> index 3a28b21..ed4e8e1 100644
> --- a/http.c
> +++ b/http.c
> @@ -67,6 +67,8 @@ static struct curl_slist *no_pragma_header;
>  
>  static struct active_request_slot *active_queue_head;
>  
> +static struct strbuf *cached_accept_language = NULL;

Please drop " = NULL" that is unnecessary for BSS.

> @@ -512,6 +514,9 @@ void http_cleanup(void)
>  		cert_auth.password = NULL;
>  	}
>  	ssl_cert_password_required = 0;
> +
> +	if (cached_accept_language)
> +		strbuf_release(cached_accept_language);
>  }



> @@ -983,6 +988,129 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
>  		strbuf_addstr(charset, "ISO-8859-1");
>  }
>  
> +/*
> + * Guess the user's preferred languages from the value in LANGUAGE environment
> + * variable and LC_MESSAGES locale category.
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
> +	retval = setlocale(LC_MESSAGES, NULL);
> +	if (retval && *retval &&
> +		strcmp(retval, "C") &&
> +		strcmp(retval, "POSIX"))
> +		return retval;
> +
> +	return NULL;
> +}
> +
> +/*
> + * Get an Accept-Language header which indicates user's preferred languages.
> + *
> + * Examples:
> + *   LANGUAGE= -> ""
> + *   LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
> + *   LANGUAGE=ko_KR.UTF-8:sr@latin -> "Accept-Language: ko-KR, sr; q=0.9, *; q=0.1"
> + *   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
> + *   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
> + *   LANGUAGE= LANG=C -> ""
> + */
> +static struct strbuf *get_accept_language(void)
> +{
> +	const char *lang_begin, *pos;
> +	int q, max_q;
> +	int num_langs;
> +	int decimal_places;
> +	int is_codeset_or_modifier = 0;
> +	static struct strbuf buf = STRBUF_INIT;
> +	struct strbuf q_format_buf = STRBUF_INIT;
> +	char *q_format;
> +
> +	if (cached_accept_language)
> +		return cached_accept_language;
> +
> +	lang_begin = get_preferred_languages();
> +
> +	/* Don't add Accept-Language header if no language is preferred. */
> +	if (!(lang_begin && *lang_begin)) {

It is not wrong per-se, but given how hard get_preferred_languages()
tries not to return a pointer to an empty string, this seems a bit
overly defensive to me.

> +		cached_accept_language = &buf;
> +		return cached_accept_language;

It is somewhat unconventional to have a static pointer outside to
point at a singleton and then have a singleton actually as a static
structure.  I would have done without "buf" in this function and
instead started this function like so:

	if (cached_accept_language)
        	return cached_accept_language;

	cached_accept_language = xmalloc(sizeof(struct strbuf));
        strbuf_init(cached_accept_language, 0);
        lang_begin =  get_preferred_languages();
	if (!lang_begin)
		return cached_accept_language;

> +	}
> +
> +	/* Count number of preferred lang_begin to decide precision of q-factor */
> +	for (num_langs = 1, pos = lang_begin; *pos; pos++)
> +		if (*pos == ':')
> +			num_langs++;
> +
> +	/* Decide the precision for q-factor on number of preferred lang_begin. */
> +	num_langs += 1; /* for '*' */


> +	decimal_places = 1 + (num_langs > 10) + (num_langs > 100);

What if you got 60000 languages ;-)?  I do not think we want to bend
backwards and make the code list all 60000 of them, assigning a
unique and decreasing q value to each of them, forming an overlong
Accept-Language header, but at the same time, I do not think we want
to show nonsense output because we compute the precision incorrectly
here.

> +	strbuf_addf(&q_format_buf, "; q=0.%%0%dd", decimal_places);
> +	q_format = strbuf_detach(&q_format_buf, NULL);

q_format_buf is an overkill use of strbuf, isn't it?  Just

	char q_format_buf[32];
	sprintf(q_format_buf, ";q=0.%%0%d", decimal_places);

or something should be more than sufficient, no?

> +	for (max_q = 1; decimal_places-- > 0;) max_q *= 10;

As you have to do one loop like this that amounts to computing log10
of num_langs, why not compute decimal_places the same way while at
it?  It may also make sense to cap the number of languages to avoid
spitting out overly long Accept-Language header with practicaly
useless list of many languages.  That is, something along the lines
of ... (note that I may very well have off-by-one or off-by-ten
errors here you may need to tweak to get right):

        if (MAX_LANGS < num_langs)
        	num_langs = MAX_LANGS;
        for (max_q = 1, decimal_places = 1;
             max_q < num_langs;
             decimal_places++, max_q *= 10)
             ;

If you are to use the MAX_LANGS cap, the main loop would also need
to pay attention to it by breaking out of the loop early before you
reach the end of the string, of course.

> +	q = max_q;
> +
> +	strbuf_addstr(&buf, "Accept-Language: ");
> +
> +	/*
> +	 * Convert a list of colon-separated locale values [1][2] to a list of
> +	 * comma-separated language tags [3] which can be used as a value of
> +	 * Accept-Language header.
> +	 *
> +	 * [1]: http://pubs.opengroup.org/onlinepubs/007908799/xbd/envvar.html
> +	 * [2]: http://www.gnu.org/software/libc/manual/html_node/Using-gettextized-software.html
> +	 * [3]: http://tools.ietf.org/html/rfc7231#section-5.3.5
> +	 */
> +	for (pos = lang_begin; ; pos++) {
> +		if (*pos == ':' || !*pos) {
> +			/* Ignore if this character is the first one. */
> +			if (pos == lang_begin)
> +				continue;

By doing this "ignore empty" here, but not doing the same when you
count num_langs, are you potentially miscounting num_langs?

> +			is_codeset_or_modifier = 0;
> +
> +			/* Put a q-factor only if it is less than 1.0. */
> +			if (q < max_q)

... is it the same thing as "do not do this for the first round, but
do so for all the other round"?

> +				strbuf_addf(&buf, q_format, q);
> +
> +			if (q > 1)

Hmm, I am puzzled.  C this ever be an issue (unless you have
off-by-one error or you add "cap num_langs to MAX_LANGS", that is)?

> +				q--;

> +			/* NULL pos means this is the last language. */
> +			if (*pos)
> +				strbuf_addstr(&buf, ", ");
> +			else
> +				break;
> +
> +		} else if (is_codeset_or_modifier)
> +			continue;
> +		else if (*pos == '.' || *pos == '@') /* Remove .codeset and @modifier. */
> +			is_codeset_or_modifier = 1;
> +		else
> +			strbuf_addch(&buf, *pos == '_' ? '-' : *pos);
> +	}
> +
> +	/* Don't add Accept-Language header if no language is preferred. */
> +	if (q >= max_q) {

Can q go over max_q, or is it "q may be max_q"?  In other words, is
this essentially saying "if we did not find any language in the
preferred languages list"?

> +		cached_accept_language = &buf;
> +		return cached_accept_language;
> +	}
> +
> +	/* Add '*' with minimum q-factor greater than 0.0. */
> +	strbuf_addstr(&buf, ", *");
> +	strbuf_addf(&buf, q_format, 1);
> +
> +	cached_accept_language = &buf;
> +	return cached_accept_language;
> +}
> +
>  /* http_request() targets */
>  #define HTTP_REQUEST_STRBUF	0
>  #define HTTP_REQUEST_FILE	1
> @@ -995,6 +1123,7 @@ static int http_request(const char *url,
>  	struct slot_results results;
>  	struct curl_slist *headers = NULL;
>  	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf* accept_language;

As we write in C, not C++, our asterisks stick to the variable, not
the type.
