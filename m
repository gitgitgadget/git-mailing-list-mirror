From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 1/1] http: Add Accept-Language header if possible
Date: Wed, 24 Dec 2014 15:35:09 -0500
Message-ID: <CAPig+cQZG3gWEw8_HHHvP6EDLKkf-nMZLwkE4OF9hwNX72wgXw@mail.gmail.com>
References: <CAO2U3QjG2rUgUrM5odX0UOnHsENnYTfwaRLhHv8gka7qj4XWdw@mail.gmail.com>
	<1419266658-1180-1-git-send-email-eungjun.yi@navercorp.com>
	<1419266658-1180-2-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Blume <blume.mike@gmail.com>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 24 21:35:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3seO-000697-J6
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 21:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbaLXUfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 15:35:11 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:49420 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbaLXUfK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 15:35:10 -0500
Received: by mail-yk0-f169.google.com with SMTP id 79so4144782ykr.14
        for <git@vger.kernel.org>; Wed, 24 Dec 2014 12:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RXkqBxzswbBtYQj+jwYdD8UvxgsTKRq8R/RtKsD77Mk=;
        b=XReHtO1q3NQeYqbd0f9sn5AZ1++rLP55IYturaMZasGHU6gsN6oSST5+1gowf/movQ
         e4pi6BtT1kkGE0mgeAUD2jK528QEc/nvL8UgT9FHL/vYypALjfQyBgqZE6dONz9TfyZq
         uQlnL8v4k++0sVqNGciHB/8L0MPbY7dUcPPFHu+V2lV5NlSmj5qP9pIF0oGasPzjzj30
         NWmtuj0XtCfkrS6JvOJQ6VpwQj6HGQ7OEnkGuPcN1TfpH1sOoQy8+UPHvcPjlcb+Ijqm
         pAEkPXZGBRD4DKIUCMkaVFVTqv+vSoLP2dgoGUPJB6qdmEdmHT7v4GcqBRoTRwwxY98k
         6gcQ==
X-Received: by 10.170.78.130 with SMTP id u124mr31076434yku.91.1419453309431;
 Wed, 24 Dec 2014 12:35:09 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 24 Dec 2014 12:35:09 -0800 (PST)
In-Reply-To: <1419266658-1180-2-git-send-email-eungjun.yi@navercorp.com>
X-Google-Sender-Auth: 7kkWCYwCFgHXKck3hJtolAFXT3U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261810>

On Mon, Dec 22, 2014 at 11:44 AM, Yi EungJun <semtlenori@gmail.com> wrote:
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

Just a few comments and observations below. Alone, they are not
necessarily worth a re-roll, but if you happen to re-roll for some
other reason, perhaps take them into consideration.

> Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
> ---
> diff --git a/http.c b/http.c
> index 040f362..7a77708 100644
> --- a/http.c
> +++ b/http.c
> @@ -986,6 +993,166 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
>                 strbuf_addstr(charset, "ISO-8859-1");
>  }
>
> +static void write_accept_language(struct strbuf *buf)
> +{
> + [...]
> +       /*
> +        * MAX_LANGS must not be larger than 1,000. If it is larger than that,
> +        * q-value will be smaller than 0.001, the minimum q-value the HTTP
> +        * specification allows [1].
> +        *
> +        * [1]: http://tools.ietf.org/html/rfc7231#section-5.3.1
> +        */
> +       const int MAX_LANGS = 1000;
> +       const int MAX_SIZE_OF_HEADER = 4000;
> +       const int MAX_SIZE_OF_ASTERISK_ELEMENT = 11; /* for ", *;q=0.001" */

These two MAX_SIZE_* constants are never used individually, but rather
only as (MAX_SIZE_OF_HEADER - MAX_SIZE_OF_ASTERISK_ELEMENT). It might
be a bit more readable to compute the final value here, with a
suitable comment, rather than at point-of-use. Perhaps something like:

    /* limit of some HTTP servers is 4000 - strlen(", *;q=0.001") */
    const int MAX_HEADER_SIZE = 4000 - 11;

More below.

> + [...]
> +       /*
> +        * Convert a list of colon-separated locale values [1][2] to a list of
> +        * comma-separated language tags [3] which can be used as a value of
> +        * Accept-Language header.
> + [...]
> +        */
> +       for (pos = lang_begin; ; pos++) {
> +               if (!*pos || *pos == ':') {
> +                       if (is_q_factor_required) {
> +                               /* Put a q-factor only if it is less than 1.0. */
> +                               if (q < max_q)
> +                                       strbuf_addf(buf, q_format, q);
> +
> +                               if (q > 1)
> +                                       q--;
> +
> +                               last_size = buf->len;
> +
> +                               is_q_factor_required = 0;
> +                       }
> +                       parse_state = SEPARATOR;
> +               } else if (parse_state == CODESET_OR_MODIFIER)
> +                       continue;
> +               else if (*pos == ' ') /* Ignore whitespace character */
> +                       continue;
> +               else if (*pos == '.' || *pos == '@') /* Remove .codeset and @modifier. */
> +                       parse_state = CODESET_OR_MODIFIER;
> +               else {
> +                       if (parse_state != LANGUAGE_TAG && q < max_q)
> +                               strbuf_addstr(buf, ", ");
> +                       strbuf_addch(buf, *pos == '_' ? '-' : *pos);
> +                       is_q_factor_required = 1;
> +                       parse_state = LANGUAGE_TAG;
> +               }
> +
> +               if (buf->len > MAX_SIZE_OF_HEADER - MAX_SIZE_OF_ASTERISK_ELEMENT) {
> +                       strbuf_remove(buf, last_size, buf->len - last_size);
> +                       break;
> +               }
> +
> +               if (!*pos)
> +                       break;
> +       }

Although often suitable when parsing complex inputs, state machines
demand high cognitive load. The input you're parsing, on the other
hand, is straightforward and can easily be processed with a simple
sequential parser, which is easier to reason about and review for
correctness. For instance, something like this:

    while (*s) {
        /* collect language tag */
        for (; *s && *s != '.' && *s != '@' && *s != ':'; s++)
            strbuf_addch(buf, *s == '_' ? '-' : *s);

        /* skip .codeset and @modifier */
        while (*s && *s != ':')
            s++;

        strbuf_addf(buf, q_format, q);
        ... other bookkeeping ...

        if (*s == ':')
            s++;
    }

This example is intentionally simplified but illustrates the general
idea. It lacks comma insertion (left as an exercise for the reader)
and empty language tag handling (":en", "en::ko"); and doesn't take
whitespace into consideration since it wasn't clear why your v6 parser
pays attention to embedded spaces, whereas your earlier versions did
not.

> +       /* Don't add Accept-Language header if no language is preferred. */
> +       if (q >= max_q) {
> +               strbuf_reset(buf);
> +               return;
> +       }
> +
> +       /* Add '*' with minimum q-factor greater than 0.0. */
> +       strbuf_addstr(buf, ", *");
> +       strbuf_addf(buf, q_format, 1);
> +}
> +
> +/*
> + * Get an Accept-Language header which indicates user's preferred languages.
> + *
> + * This function always return non-NULL string as strbuf_detach() does.

A couple comments:

It's not necessary to explain the public API in terms of an
implementation detail. Callers of this function don't care and don't
need to know that the value was constructed via strbuf, nor that it is
somehow dependent upon the behavior of the underlying implementation
of strbuf_detach().

This is a somewhat unusual contract. It's much more common and
idiomatic in C to return NULL as an indication of "no preference" (or
"failure") than to return an empty string.

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
> +       if (!cached_accept_language) {
> +               struct strbuf buf = STRBUF_INIT;
> +               write_accept_language(&buf);
> +               cached_accept_language = strbuf_detach(&buf, NULL);
> +               strbuf_release(&buf);

Junio already mentioned that strbuf_release() is unnecessary following
strbuf_detach().

> +       }
> +
> +       return cached_accept_language;
> +}
> +
>  /* http_request() targets */
>  #define HTTP_REQUEST_STRBUF    0
>  #define HTTP_REQUEST_FILE      1
