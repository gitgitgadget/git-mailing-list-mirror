From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Tue, 27 Jan 2015 22:15:48 -0800
Message-ID: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
References: <xmqq7fwfuu62.fsf@gitster.dls.corp.google.com> <1422373918-14132-1-git-send-email-eungjun.yi@navercorp.com>
 <1422373918-14132-2-git-send-email-eungjun.yi@navercorp.com> <xmqqwq47iyrn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 07:16:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGLvE-0001dP-3c
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 07:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053AbbA1GQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 01:16:10 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:57192 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbbA1GQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 01:16:09 -0500
Received: by mail-ob0-f179.google.com with SMTP id va8so6781811obc.10
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 22:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8oCpMEyx6ftLiHRnj/7pK3HSiyxrF1+SM0j+VK+fKhE=;
        b=oVIAjceQiGB9JNdh7iCjcoyEx+STSkxZ6hljOTv4FtYiq336XH0nCvzcarRIfqkn4D
         EOCIMshg8yVDl/rX/u/UdyPlwVAnPrVt0lvpS4RMU41UuRVnbXwS1EEme4nOoXyYI3Gi
         Wu/GdmctqktamiIxa7xN8iAvGkr0rlYo6R81pL5eMyW0Gk/jKnxkrOvq5CiYyOS5UtrS
         76XID8BwEZA3IyDNUwDnSW/tLu8SFJO7M942AfzH0jvBlqC6+QekqSuBJG8icdrobDRv
         pXDAvcykNVySbPCZhRgUBH5u+YF037hvgo74UvDg2JD5ptEUmoV1+qRk6YYVqunujD8T
         NFwg==
X-Received: by 10.202.217.9 with SMTP id q9mr950876oig.35.1422425768530; Tue,
 27 Jan 2015 22:16:08 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Tue, 27 Jan 2015 22:15:48 -0800 (PST)
In-Reply-To: <xmqqwq47iyrn.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: AMkgPWW5pvAd8P1ng_U3zh8Jis4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263101>

On Tue, Jan 27, 2015 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Yi EungJun <semtlenori@gmail.com> writes:
>
>> +
>> +             sprintf(q_format, ";q=0.%%0%dd", decimal_places);
>> +
>> +             strbuf_addstr(buf, "Accept-Language: ");
>> +
>> +             for(i = 0; i < num_langs; i++) {
>> +                     if (i > 0)
>> +                             strbuf_addstr(buf, ", ");
>> +
>> +                     strbuf_addstr(buf, strbuf_detach(&language_tags[i], NULL));
>
> This is not wrong per-se, but it looks somewhat convoluted to me.
> ...

Actually, this is wrong, isn't it?

strbuf_detach() removes the language_tags[i].buf from the strbuf,
and the caller now owns that piece of memory. Then strbuf_addstr()
appends a copy of that string to buf, and the piece of memory
that was originally held by language_tags[i].buf is now lost forever.

This is leaking.

>> +     /* free language tags */
>> +     for(i = 0; i < num_langs; i++) {
>> +             strbuf_release(&language_tags[i]);
>> +     }

... because this loop does not free memory for earlier parts of language_tags[].

> I am wondering if using strbuf for each of the language_tags[] is
> even necessary.  How about doing it this way instead?

And I think my counter-proposal does not leak (as it does not us strbuf for
language_tags[] anymore).

>
>  http.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/http.c b/http.c
> index 6111c6a..db591b3 100644
> --- a/http.c
> +++ b/http.c
> @@ -1027,7 +1027,7 @@ static void write_accept_language(struct strbuf *buf)
>         const int MAX_DECIMAL_PLACES = 3;
>         const int MAX_LANGUAGE_TAGS = 1000;
>         const int MAX_ACCEPT_LANGUAGE_HEADER_SIZE = 4000;
> -       struct strbuf *language_tags = NULL;
> +       char **language_tags = NULL;
>         int num_langs = 0;
>         const char *s = get_preferred_languages();
>         int i;
> @@ -1053,9 +1053,7 @@ static void write_accept_language(struct strbuf *buf)
>                 if (tag.len) {
>                         num_langs++;
>                         REALLOC_ARRAY(language_tags, num_langs);
> -                       strbuf_init(&language_tags[num_langs - 1], 0);
> -                       strbuf_swap(&tag, &language_tags[num_langs - 1]);
> -
> +                       language_tags[num_langs - 1] = strbuf_detach(&tag, NULL);
>                         if (num_langs >= MAX_LANGUAGE_TAGS - 1) /* -1 for '*' */
>                                 break;
>                 }
> @@ -1070,13 +1068,12 @@ static void write_accept_language(struct strbuf *buf)
>
>                 /* add '*' */
>                 REALLOC_ARRAY(language_tags, num_langs + 1);
> -               strbuf_init(&language_tags[num_langs], 0);
> -               strbuf_addstr(&language_tags[num_langs++], "*");
> +               language_tags[num_langs++] = "*"; /* it's OK; this won't be freed */
>
>                 /* compute decimal_places */
>                 for (max_q = 1, decimal_places = 0;
> -                               max_q < num_langs && decimal_places <= MAX_DECIMAL_PLACES;
> -                               decimal_places++, max_q *= 10)
> +                    max_q < num_langs && decimal_places <= MAX_DECIMAL_PLACES;
> +                    decimal_places++, max_q *= 10)
>                         ;
>
>                 sprintf(q_format, ";q=0.%%0%dd", decimal_places);
> @@ -1087,7 +1084,7 @@ static void write_accept_language(struct strbuf *buf)
>                         if (i > 0)
>                                 strbuf_addstr(buf, ", ");
>
> -                       strbuf_addstr(buf, strbuf_detach(&language_tags[i], NULL));
> +                       strbuf_addstr(buf, language_tags[i]);
>
>                         if (i > 0)
>                                 strbuf_addf(buf, q_format, max_q - i);
> @@ -1101,10 +1098,9 @@ static void write_accept_language(struct strbuf *buf)
>                 }
>         }
>
> -       /* free language tags */
> -       for(i = 0; i < num_langs; i++) {
> -               strbuf_release(&language_tags[i]);
> -       }
> +       /* free language tags -- last one is a static '*' */
> +       for(i = 0; i < num_langs - 1; i++)
> +               free(language_tags[i]);
>         free(language_tags);
>  }
>
