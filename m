From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/1] http: Add Accept-Language header if possible
Date: Wed, 3 Dec 2014 14:31:40 -0500
Message-ID: <CAPig+cTsULQPxoaSQ-ZvjWJ9Rgpdf3zG7ObPg4TnxFbXT9TwnA@mail.gmail.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
	<1417522356-24212-1-git-send-email-eungjun.yi@navercorp.com>
	<1417522356-24212-2-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 20:31:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwFeM-00025u-0k
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 20:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbaLCTbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 14:31:42 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:63718 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbaLCTbl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 14:31:41 -0500
Received: by mail-yk0-f176.google.com with SMTP id q200so7196849ykb.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 11:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3aklQSG36nbtCGRY7fF6pFuu4shd7HTySbCWfSB6YBk=;
        b=OtbYn3o3KO5Pg034lzlVWJs7vnS+MK40+JDO0hNjVWDoJ6f121h9y1etgjLApKJOAU
         P0x9mQO5aBcr0dEYRwA8awlbDoWwly3TrcgnMoMUR4KCDW//KPIza0uPOyzWWeVEIgtM
         8OLVbeRtlAncVsZRMOyu9FnpIsEEtGE3+RCagOgrL+9TmiVZEGETeuXmz4RHnpQU3K5e
         aHT8bzsRwIYDt61K9vNhFnmIDq4YTRcwd16jhLDdorwFbNJtXAUMY8kQxzT8gWqhzDNo
         UJQWjypaxQ1UXpcHgpPBDchKqvgaVLmCrnPW54zAOYXwS/jsvMywVIFAB5AaynvjjWdR
         ZXzw==
X-Received: by 10.236.206.74 with SMTP id k50mr8312906yho.180.1417635100719;
 Wed, 03 Dec 2014 11:31:40 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Wed, 3 Dec 2014 11:31:40 -0800 (PST)
In-Reply-To: <1417522356-24212-2-git-send-email-eungjun.yi@navercorp.com>
X-Google-Sender-Auth: 8tVhjpebZUhMmuH69SBsDOpH0Qk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260681>

On Tue, Dec 2, 2014 at 7:12 AM, Yi EungJun <semtlenori@gmail.com> wrote:
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
> ---
> diff --git a/http.c b/http.c
> index 040f362..69624af 100644
> --- a/http.c
> +++ b/http.c
> @@ -68,6 +68,8 @@ static struct curl_slist *no_pragma_header;
>
>  static struct active_request_slot *active_queue_head;
>
> +static struct strbuf *cached_accept_language;

Is there a reason this needs to be a pointer to a strbuf rather than
just a strbuf? That is wouldn't this work?

    static struct strbuf cached_accept_language = STRBUF_INIT;

>  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  {
>         size_t size = eltsize * nmemb;
> @@ -515,6 +517,9 @@ void http_cleanup(void)
>                 cert_auth.password = NULL;
>         }
>         ssl_cert_password_required = 0;
> +
> +       if (cached_accept_language)
> +               strbuf_release(cached_accept_language);

Junio already mentioned that this is leaking the memory of the strbuf
struct itself which was xmalloc()'d by get_accept_language().

>  }
>
>  struct active_request_slot *get_active_slot(void)
> @@ -986,6 +991,149 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
>                 strbuf_addstr(charset, "ISO-8859-1");
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
> +       const char *retval;
> +
> +       retval = getenv("LANGUAGE");
> +       if (retval && *retval)
> +               return retval;
> +
> +       retval = setlocale(LC_MESSAGES, NULL);
> +       if (retval && *retval &&
> +               strcmp(retval, "C") &&
> +               strcmp(retval, "POSIX"))
> +               return retval;
> +
> +       return NULL;

Mental note: This function will never return an empty string "", even
if LANGUAGE or LC_MESSAGES is empty.

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

I find this API a bit strange. Use of strbuf to construct the returned
string is an implementation detail of this function. From the caller's
point of view, it should just be receiving a constant string: one
which it needs neither to modify nor free. Also, if the caller were to
modify the returned strbuf for some reason, then that modification
would impact all future calls to get_accept_language() since the
strbuf is 'static' and not recomputed. Instead, I would expect the
declaration to be:

    static const char *get_accept_language(void)

> +{
> +       const char *lang_begin, *pos;
> +       int q, max_q;
> +       int num_langs;
> +       int decimal_places;
> +       int is_codeset_or_modifier = 0;
> +       char q_format[32];
> +       const int MAX_LANGS = 1000;
> +       const int MAX_SIZE_OF_HEADER = 4000;
> +       int last_size = 0;
> +
> +       if (cached_accept_language)
> +               return cached_accept_language;
> +
> +       cached_accept_language = xmalloc(sizeof(struct strbuf));
> +       strbuf_init(cached_accept_language, 0);
> +       lang_begin = get_preferred_languages();

Mental note: lang_begin will never be the empty string "".

> +       /* Don't add Accept-Language header if no language is preferred. */
> +       if (!lang_begin)
> +               return cached_accept_language;
> +
> +       /* Count number of preferred lang_begin to decide precision of q-factor. */
> +       for (num_langs = 1, pos = lang_begin; *pos; pos++)
> +               if (*pos == ':')
> +                       num_langs++;
> +
> +       /* Decide the precision for q-factor on number of preferred lang_begin. */
> +       num_langs += 1; /* for '*' */
> +
> +       if (MAX_LANGS < num_langs)
> +               num_langs = MAX_LANGS;
> +
> +       for (max_q = 1, decimal_places = 0;
> +               max_q < num_langs;
> +               decimal_places++, max_q *= 10);
> +
> +       sprintf(q_format, ";q=0.%%0%dd", decimal_places);
> +
> +       q = max_q;
> +
> +       strbuf_addstr(cached_accept_language, "Accept-Language: ");
> +
> +       for (pos = lang_begin; ; pos++) {
> +               if (*pos == ':' || !*pos) {
> +                       /* Ignore if this character is the first one. */
> +                       if (pos == lang_begin)
> +                               continue;

If lang_begin were ever to point at an empty string "", then this
logic would access memory beyond the end-of-string. Since
get_preferred_languages() won't return an empty string, this case is
safe, but it's not obvious to the casual reader and some person
modifying the code in the future might not notice this restriction. I
personally would feel more comfortable if the no-empty-string
assumption was documented formally with an assert(*lang_begin) or
die() before entering the loop; or if the code was rewritten to be
less fragile.

> +                       is_codeset_or_modifier = 0;
> +
> +                       /* Put a q-factor only if it is less than 1.0. */
> +                       if (q < max_q)
> +                               strbuf_addf(cached_accept_language, q_format, q);
> +
> +                       if (q > 1)
> +                               q--;
> +
> +                       last_size = cached_accept_language->len;
> +
> +                       /* NULL pos means this is the last language. */

Nit: This feels somewhat backward. It sounds like the comment is
explaining the 'then' part of the 'if' rather than the 'else' part.
Perhaps rephrase like this:

    /* non-NULL pos means more languages */

or, better yet, just drop the comment since the code is self-explanatory.

> +                       if (*pos)
> +                               strbuf_addstr(cached_accept_language, ", ");
> +                       else
> +                               break;
> +
> +               } else if (is_codeset_or_modifier)
> +                       continue;
> +               else if (*pos == '.' || *pos == '@') /* Remove .codeset and @modifier. */
> +                       is_codeset_or_modifier = 1;
> +               else
> +                       strbuf_addch(cached_accept_language, *pos == '_' ? '-' : *pos);
> +
> +               if (cached_accept_language->len > MAX_SIZE_OF_HEADER) {

Mental note: Here you respect MAX_SIZE_OF_HEADER.

> +                       strbuf_remove(cached_accept_language, last_size,
> +                                       cached_accept_language->len - last_size);
> +                       break;
> +               }
> +       }
> +
> +       /* Don't add Accept-Language header if no language is preferred. */

Is this comment correct? The "Accept-Language:" header was already
added to cached_accept_language much earlier in the function.

> +       if (q >= max_q) {
> +               return cached_accept_language;
> +       }

Style: Unnecessary braces.

> +       /* Add '*' with minimum q-factor greater than 0.0. */
> +       strbuf_addstr(cached_accept_language, ", *");
> +       strbuf_addf(cached_accept_language, q_format, 1);

Here you don't respect MAX_SIZE_OF_HEADER.

> +
> +       return cached_accept_language;
> +}
> +
>  /* http_request() targets */
>  #define HTTP_REQUEST_STRBUF    0
>  #define HTTP_REQUEST_FILE      1
> @@ -998,6 +1146,7 @@ static int http_request(const char *url,
>         struct slot_results results;
>         struct curl_slist *headers = NULL;
>         struct strbuf buf = STRBUF_INIT;
> +       struct strbuf *accept_language;
>         int ret;
>
>         slot = get_active_slot();
> @@ -1023,6 +1172,11 @@ static int http_request(const char *url,
>                                          fwrite_buffer);
>         }
>
> +       accept_language = get_accept_language();
> +
> +       if (accept_language && accept_language->len > 0)
> +               headers = curl_slist_append(headers, accept_language->buf);
> +
>         strbuf_addstr(&buf, "Pragma:");
>         if (options && options->no_cache)
>                 strbuf_addstr(&buf, " no-cache");
