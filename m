From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH v4 1/1] http: Add Accept-Language header if possible
Date: Sun, 3 Aug 2014 16:35:52 +0900
Message-ID: <CAFT+Tg-3jCEdpS1K5bGTG-Pv6ne+5q4rD5q2=+KWVjckfy5W8g@mail.gmail.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
	<1405792730-13539-2-git-send-email-eungjun.yi@navercorp.com>
	<xmqqwqb6ilik.fsf@gitster.dls.corp.google.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 09:36:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDqKu-0004VJ-6T
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 09:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbaHCHfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2014 03:35:54 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:42969 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaHCHfx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2014 03:35:53 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn18so3719548igb.15
        for <git@vger.kernel.org>; Sun, 03 Aug 2014 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6wg7F6XbVlmew48HHtCcPtdY+t/xxYe4D6oAC4SLMNw=;
        b=ohT2yqOqGDDKs3w3OFIzQ3FGOZC7uJ6waC2T1/OgWU4eK7APwnDcCKeZZIR1BK9xhA
         n7fqiTsFMph3tKvCGxz+A1w6vrCDm1Ps8KX0Vjx3uZUoxF0eBIg5fBlSuDkl7MD1QdCm
         kPCyCWzn+0S40lYf0QrplKKMuMH5s5MrNPd/qwtYkegUY82hz2UqMljMXG9eowQPil59
         b44q1diFUCgG1o91lKYGXpIdz/pOGFOhjK5SY8jGSlAscNT/E6tw4bJiLyBgwQeH1+Be
         WcpmQTabVoYoTKf+J7t+AuIuPc1PK67WcQwpuOliCCDegntkNrX9eZFgQgB7cMwFaSgl
         Rmfw==
X-Received: by 10.43.64.198 with SMTP id xj6mr15447237icb.70.1407051352354;
 Sun, 03 Aug 2014 00:35:52 -0700 (PDT)
Received: by 10.50.153.135 with HTTP; Sun, 3 Aug 2014 00:35:52 -0700 (PDT)
In-Reply-To: <xmqqwqb6ilik.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254720>

Thanks very much for your detailed review and sorry for late reply.

2014-07-22 4:01 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> Yi EungJun <semtlenori@gmail.com> writes:
>
>> From: Yi EungJun <eungjun.yi@navercorp.com>
>>
>> Add an Accept-Language header which indicates the user's preferred
>> languages defined by $LANGUAGE, $LC_ALL, $LC_MESSAGES and $LANG.
>>
>> Examples:
>>   LANGUAGE= -> ""
>>   LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
>>   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
>>   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
>>
>> This gives git servers a chance to display remote error messages in
>> the user's preferred language.
>>
>> Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
>> ---
>>  http.c                     | 134 +++++++++++++++++++++++++++++++++++++++++++++
>>  remote-curl.c              |   2 +
>>  t/t5550-http-fetch-dumb.sh |  31 +++++++++++
>>  3 files changed, 167 insertions(+)
>>
>> diff --git a/http.c b/http.c
>> index 3a28b21..ed4e8e1 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -67,6 +67,8 @@ static struct curl_slist *no_pragma_header;
>>
>>  static struct active_request_slot *active_queue_head;
>>
>> +static struct strbuf *cached_accept_language = NULL;
>
> Please drop " = NULL" that is unnecessary for BSS.

Thanks, I'll fix it.

>
>> @@ -512,6 +514,9 @@ void http_cleanup(void)
>>               cert_auth.password = NULL;
>>       }
>>       ssl_cert_password_required = 0;
>> +
>> +     if (cached_accept_language)
>> +             strbuf_release(cached_accept_language);
>>  }
>
>
>
>> @@ -983,6 +988,129 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
>>               strbuf_addstr(charset, "ISO-8859-1");
>>  }
>>
>> +/*
>> + * Guess the user's preferred languages from the value in LANGUAGE environment
>> + * variable and LC_MESSAGES locale category.
>> + *
>> + * The result can be a colon-separated list like "ko:ja:en".
>> + */
>> +static const char *get_preferred_languages(void)
>> +{
>> +     const char *retval;
>> +
>> +     retval = getenv("LANGUAGE");
>> +     if (retval && *retval)
>> +             return retval;
>> +
>> +     retval = setlocale(LC_MESSAGES, NULL);
>> +     if (retval && *retval &&
>> +             strcmp(retval, "C") &&
>> +             strcmp(retval, "POSIX"))
>> +             return retval;
>> +
>> +     return NULL;
>> +}
>> +
>> +/*
>> + * Get an Accept-Language header which indicates user's preferred languages.
>> + *
>> + * Examples:
>> + *   LANGUAGE= -> ""
>> + *   LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
>> + *   LANGUAGE=ko_KR.UTF-8:sr@latin -> "Accept-Language: ko-KR, sr; q=0.9, *; q=0.1"
>> + *   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
>> + *   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
>> + *   LANGUAGE= LANG=C -> ""
>> + */
>> +static struct strbuf *get_accept_language(void)
>> +{
>> +     const char *lang_begin, *pos;
>> +     int q, max_q;
>> +     int num_langs;
>> +     int decimal_places;
>> +     int is_codeset_or_modifier = 0;
>> +     static struct strbuf buf = STRBUF_INIT;
>> +     struct strbuf q_format_buf = STRBUF_INIT;
>> +     char *q_format;
>> +
>> +     if (cached_accept_language)
>> +             return cached_accept_language;
>> +
>> +     lang_begin = get_preferred_languages();
>> +
>> +     /* Don't add Accept-Language header if no language is preferred. */
>> +     if (!(lang_begin && *lang_begin)) {
>
> It is not wrong per-se, but given how hard get_preferred_languages()
> tries not to return a pointer to an empty string, this seems a bit
> overly defensive to me.

Thanks, I'll fix it.

>
>> +             cached_accept_language = &buf;
>> +             return cached_accept_language;
>
> It is somewhat unconventional to have a static pointer outside to
> point at a singleton and then have a singleton actually as a static
> structure.  I would have done without "buf" in this function and
> instead started this function like so:
>
>         if (cached_accept_language)
>                 return cached_accept_language;
>
>         cached_accept_language = xmalloc(sizeof(struct strbuf));
>         strbuf_init(cached_accept_language, 0);
>         lang_begin =  get_preferred_languages();
>         if (!lang_begin)
>                 return cached_accept_language;
>

Thanks, I'll fix it as you suggest.

>> +     }
>> +
>> +     /* Count number of preferred lang_begin to decide precision of q-factor */
>> +     for (num_langs = 1, pos = lang_begin; *pos; pos++)
>> +             if (*pos == ':')
>> +                     num_langs++;
>> +
>> +     /* Decide the precision for q-factor on number of preferred lang_begin. */
>> +     num_langs += 1; /* for '*' */
>
>
>> +     decimal_places = 1 + (num_langs > 10) + (num_langs > 100);
>
> What if you got 60000 languages ;-)?  I do not think we want to bend
> backwards and make the code list all 60000 of them, assigning a
> unique and decreasing q value to each of them, forming an overlong
> Accept-Language header, but at the same time, I do not think we want
> to show nonsense output because we compute the precision incorrectly
> here.

In that case, less-preferred 59,001 languages will have same q-value
of 0.001. Unfortunately, there is no way to represent user's
preferences of over 1,000 languages since the HTTP specification
restricts the range of q-value from 0.001 to 1.000 [1]. I think this
code reflects user's preferences better than Google chrome whose
minimum q-value is 0.2 and Mozilla firefox whose minimum q-value is
0.01 [2].

>
>> +     strbuf_addf(&q_format_buf, "; q=0.%%0%dd", decimal_places);
>> +     q_format = strbuf_detach(&q_format_buf, NULL);
>
> q_format_buf is an overkill use of strbuf, isn't it?  Just
>
>         char q_format_buf[32];
>         sprintf(q_format_buf, ";q=0.%%0%d", decimal_places);
>
> or something should be more than sufficient, no?

Thanks, I'll fix it as you suggest.

>
>> +     for (max_q = 1; decimal_places-- > 0;) max_q *= 10;
>
> As you have to do one loop like this that amounts to computing log10
> of num_langs, why not compute decimal_places the same way while at
> it?  It may also make sense to cap the number of languages to avoid
> spitting out overly long Accept-Language header with practicaly
> useless list of many languages.  That is, something along the lines
> of ... (note that I may very well have off-by-one or off-by-ten
> errors here you may need to tweak to get right):
>
>         if (MAX_LANGS < num_langs)
>                 num_langs = MAX_LANGS;
>         for (max_q = 1, decimal_places = 1;
>              max_q < num_langs;
>              decimal_places++, max_q *= 10)
>              ;
>
> If you are to use the MAX_LANGS cap, the main loop would also need
> to pay attention to it by breaking out of the loop early before you
> reach the end of the string, of course.

Thanks for good point. As you said, we should limit the length of the
value of Accept-Language header because some HTTP servers respond 4xx
Client Error if any header's value is very long (4KB or more) [3].

But MAX_LANGS may not be enough because the header can be too long
even if the number of languages does not exceed MAX_LANGS if language
tag is too long. Many of language tags are 2-3 characters but some are
11 characters; Even it is possible that a user has a very long custom
language tag.

I think this problem can be solved by one of these solutions:

A. Set MAX_LANGS conservatively (100 or less).
B. Limit the length of Accept-Language header directly (4KB or less).
C. Negotiate with server; Resend a request with shorter
Accept-Language header if the server responds 4xx error.

>
>> +     q = max_q;
>> +
>> +     strbuf_addstr(&buf, "Accept-Language: ");
>> +
>> +     /*
>> +      * Convert a list of colon-separated locale values [1][2] to a list of
>> +      * comma-separated language tags [3] which can be used as a value of
>> +      * Accept-Language header.
>> +      *
>> +      * [1]: http://pubs.opengroup.org/onlinepubs/007908799/xbd/envvar.html
>> +      * [2]: http://www.gnu.org/software/libc/manual/html_node/Using-gettextized-software.html
>> +      * [3]: http://tools.ietf.org/html/rfc7231#section-5.3.5
>> +      */
>> +     for (pos = lang_begin; ; pos++) {
>> +             if (*pos == ':' || !*pos) {
>> +                     /* Ignore if this character is the first one. */
>> +                     if (pos == lang_begin)
>> +                             continue;
>
> By doing this "ignore empty" here, but not doing the same when you
> count num_langs, are you potentially miscounting num_langs?

Yes, num_langs can be larger than actual number of languages. For
example, if LANGUAGE="en:" num_langs is 2. I wanted to make the logic
to compute num_langs as simple as possible and thought num_langs does
not need to be very accurate because it is used only to compute the
precision of q-factor (max_q and decimal_places).

Do we need to compute num_langs accurately?

>
>> +                     is_codeset_or_modifier = 0;
>> +
>> +                     /* Put a q-factor only if it is less than 1.0. */
>> +                     if (q < max_q)
>
> ... is it the same thing as "do not do this for the first round, but
> do so for all the other round"?

Yes, q-factor is q/max_q and q-factor of 1.0 is not necessary because:
> if no "q" parameter is present, the default weight is 1.
> -- http://tools.ietf.org/html/rfc7231#section-5.3.1

>
>> +                             strbuf_addf(&buf, q_format, q);
>> +
>> +                     if (q > 1)
>
> Hmm, I am puzzled.  C this ever be an issue (unless you have
> off-by-one error or you add "cap num_langs to MAX_LANGS", that is)?

Yes, it may be an issue if the number of languages is larger than the
max_q. max_q must not be larger than 1000 but the number of languages
may be.

But this if-statement will be not necessary if we limit the number of
languages to 1,000 or less (by MAX_LANGS you suggest).

>
>> +                             q--;
>
>> +                     /* NULL pos means this is the last language. */
>> +                     if (*pos)
>> +                             strbuf_addstr(&buf, ", ");
>> +                     else
>> +                             break;
>> +
>> +             } else if (is_codeset_or_modifier)
>> +                     continue;
>> +             else if (*pos == '.' || *pos == '@') /* Remove .codeset and @modifier. */
>> +                     is_codeset_or_modifier = 1;
>> +             else
>> +                     strbuf_addch(&buf, *pos == '_' ? '-' : *pos);
>> +     }
>> +
>> +     /* Don't add Accept-Language header if no language is preferred. */
>> +     if (q >= max_q) {
>
> Can q go over max_q, or is it "q may be max_q"?  In other words, is
> this essentially saying "if we did not find any language in the
> preferred languages list"?

Yes. q may be max_q if we did not find any language in the preferred
languages list. But there is no chance that q goes over max_q.

But it will be not necessary if num_langs is computed accurately.

>
>> +             cached_accept_language = &buf;
>> +             return cached_accept_language;
>> +     }
>> +
>> +     /* Add '*' with minimum q-factor greater than 0.0. */
>> +     strbuf_addstr(&buf, ", *");
>> +     strbuf_addf(&buf, q_format, 1);
>> +
>> +     cached_accept_language = &buf;
>> +     return cached_accept_language;
>> +}
>> +
>>  /* http_request() targets */
>>  #define HTTP_REQUEST_STRBUF  0
>>  #define HTTP_REQUEST_FILE    1
>> @@ -995,6 +1123,7 @@ static int http_request(const char *url,
>>       struct slot_results results;
>>       struct curl_slist *headers = NULL;
>>       struct strbuf buf = STRBUF_INIT;
>> +     struct strbuf* accept_language;
>
> As we write in C, not C++, our asterisks stick to the variable, not
> the type.

Thanks, I'll fix it.

[1]: http://tools.ietf.org/html/rfc7231#section-5.3.1
[2]: https://hg.mozilla.org/integration/mozilla-inbound/rev/1418f9ce6f8b
[3]: http://stackoverflow.com/questions/686217/maximum-on-http-header-values/8623061#8623061
