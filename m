From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 0/1] http: Add Accept-Language header if possible
Date: Mon, 19 Jan 2015 15:21:16 -0500
Message-ID: <CAPig+cSrX=mpFWznRtYgQOsi7YU7ewEo6VqMmkq9OSiveG961Q@mail.gmail.com>
References: <1421583806-3563-1-git-send-email-eungjun.yi@navercorp.com>
	<1421583995-3663-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 21:21:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDIp8-00026N-LZ
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 21:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbbASUVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 15:21:18 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:52222 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbASUVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2015 15:21:17 -0500
Received: by mail-yh0-f44.google.com with SMTP id c41so16262403yho.3
        for <git@vger.kernel.org>; Mon, 19 Jan 2015 12:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SRLeT+/n8dc+BXAgbEewijG5wclKBBEMh+4ZCxZCUKs=;
        b=zZ2pek2ssHlPRqL/0Wvs5Bz7Y99xZ9hw3slxJc/3pL6vPHKO0tbmclw1z6Xq9PZDe+
         LDykgJ5nOhP70DeRES4HLfRKgF5CmReh8pa41SJYAX4KZVjlTvf7grDD6DXsFozcypPg
         bY4tut1oLB/4swlqn5ayVRbIiKXNIGWp/Nulym3APD05ByjbpbHfFQAyEPL55UrjeQ1F
         Ni54V0vK20+L0Vmh4ZN14dIvAHI2V4ehCM3NM2TcADcLBZwj6pr9n9sR6kXrzYUwpCvW
         2hnaR7SAFXBTKRfPE09VuU8i1SwBweQtm54fIWCXzFvTiuURSYkm7EOmWyeoEFQVUj0O
         uK0w==
X-Received: by 10.236.8.6 with SMTP id 6mr19296227yhq.112.1421698876468; Mon,
 19 Jan 2015 12:21:16 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 19 Jan 2015 12:21:16 -0800 (PST)
In-Reply-To: <1421583995-3663-1-git-send-email-eungjun.yi@navercorp.com>
X-Google-Sender-Auth: E561VdJnx-0iL87LIDuzPEg4-EI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262643>

On Sunday, January 18, 2015, Yi EungJun <semtlenori@gmail.com> wrote:
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
> index 040f362..349b033 100644
> --- a/http.c
> +++ b/http.c
> @@ -986,6 +993,145 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
>                 strbuf_addstr(charset, "ISO-8859-1");
>  }
>
> +static void write_accept_language(struct strbuf *buf)
> +{
> +       [...]
> +       const int MAX_DECIMAL_PLACES = 3;
> +       const int MAX_LANGUAGE_TAGS = 1000;
> +       const int MAX_ACCEPT_LANGUAGE_HEADER_SIZE = 4000;
> +       struct strbuf *language_tags = NULL;
> +       int num_langs;

Mental note: 'num_langs' is not initialized.

> +       const char *s = get_preferred_languages();
> +
> +       /* Don't add Accept-Language header if no language is preferred. */
> +       if (!s)
> +               return;
> +
> +       /*
> +        * Split the colon-separated string of preferred languages into
> +        * language_tags array.
> +        */
> +       do {
> +               /* increase language_tags array to add new language tag */
> +               REALLOC_ARRAY(language_tags, num_langs + 1);

'num_langs' is used here uninitialized.

> +               strbuf_init(&language_tags[num_langs], 0);
> +
> +               /* collect language tag */
> +               for (; *s && (isalnum(*s) || *s == '_'); s++)
> +                       strbuf_addch(&language_tags[num_langs], *s == '_' ? '-' : *s);
> +
> +               /* skip .codeset, @modifier and any other unnecessary parts */
> +               while (*s && *s != ':')
> +                       s++;
> +
> +               if (language_tags[num_langs].len > 0) {

Mental note: An empty ("") language tag is never allowed in language_tags[].

 > +                       num_langs++;

This is a little bit ugly. At the top of the loop, you allocate space
in the array for a strbuf and initialize it. However, if the language
tag is empty (""), then 'num_langs' is never incremented, so the next
time through the loop, strbuf_init() is invoked on the same block of
memory (assuming the realloc was a no-op since the allocation size did
not change), overwriting whatever was there and possibly leaking
memory. In this particular case, by examining the parser code closely,
we can see that nothing was added to the strbuf, so nothing is being
leaked the next time around, given the current implementation of
strbuf.

However, this is potentially fragile. A change to the implementation
of strbuf in the future (for instance, if strbuf_init() allocates
memory immediately) could result in a leak here. Moreover, this
no-leak situation only holds true if no text at all has been added to
the strbuf after strbuf_init(). If someone changes the parser in the
future to operate a bit differently so that some text is added and
then removed from the strbuf, even though the end result still has
length is 0, then it will start leaking.

One way to make this more robust would be to have a separate strbuf
for collecting the language tag. When you encounter a non-empty tag,
only then grow the array and initialize the new strbuf in the array.
Finally, use strbuf_swap() to swap the collected language tag into the
new array position. Something like this:

    struct strbuf tag = STRBUF_INIT;
    do {
         for (; *s && (isalnum(*s) || *s == '_'); s++)
             strbuf_addch(&tag, *s == '_' ? '-' : *s);

        [...]

        if (tag.len) {
            num_langs++;
            REALLOC_ARRAY(language_tags, num_langs);
            strbuf_init(&language_tags[num_langs], 0);
            strbuf_swap(&tag, &language_tags[num_langs]);

            if (num_langs >= ...)
                break;
        }
    while (...);
    strbuf_release(&tag);

> +                       if (num_langs >= MAX_LANGUAGE_TAGS - 1) /* -1 for '*' */
> +                               break;
> +               }
> +       } while (*s++);
> +
> +       /* write Accept-Language header into buf */
> +       if (num_langs >= 1) {
> +               int i;
> +               int last_buf_len;

Mental note: 'last_buf_len' is not initialized.

> +               int max_q;
> +               int decimal_places;
> +               char q_format[32];
> +
> +               /* add '*' */
> +               REALLOC_ARRAY(language_tags, num_langs + 1);
> +               strbuf_init(&language_tags[num_langs], 0);
> +               strbuf_addstr(&language_tags[num_langs++], "*");
> +
> +               /* compute decimal_places */
> +               for (max_q = 1, decimal_places = 0;
> +                               max_q < num_langs && decimal_places <= MAX_DECIMAL_PLACES;
> +                               decimal_places++, max_q *= 10)
> +                       ;
> +
> +               sprintf(q_format, ";q=0.%%0%dd", decimal_places);
> +
> +               strbuf_addstr(buf, "Accept-Language: ");
> +
> +               for(i = 0; i < num_langs; i++) {
> +                       if (language_tags[i].len == 0)
> +                               continue;

The parsing code does not allow empty tags ("") in language_tags[], so
this conditional is useless, isn't it?

> +
> +                       if (i > 0)
> +                               strbuf_addstr(buf, ", ");
> +
> +                       strbuf_addstr(buf, strbuf_detach(&language_tags[i], NULL));

This leaks the string detached from 'language_tag[i]' since
strbuf_addstr() does not take ownership of it.

> +                       if (i > 0)
> +                               strbuf_addf(buf, q_format, max_q - i);
> +
> +                       if (buf->len > MAX_ACCEPT_LANGUAGE_HEADER_SIZE) {
> +                               strbuf_remove(buf, last_buf_len, buf->len - last_buf_len);

'last_buf_len' is (potentially) used here uninitialized the first time
through loop.

> +                               break;
> +                       }
> +
> +                       last_buf_len = buf->len;
> +               }
> +       }
> +
> +       free(language_tags);

This _seems_ to be okay since strbuf_detach() was invoked for each
strbuf in language_tags[], however, those strings were in fact leaked
(as noted above), so it's not actually correct.

> +}
> +
> +/*
> + * Get an Accept-Language header which indicates user's preferred languages.
> + *
> + * This function always return non-NULL string as strbuf_detach() does.

Repeating from [1]: It's not good form to describe the published API
in terms of an implementation detail (strbuf_detach). Also, it would
be more idiomatic in C to return NULL rather than empty string.

[1]: http://article.gmane.org/gmane.comp.version-control.git/261810/

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
> +       }
> +
> +       return cached_accept_language;
> +}
> +
