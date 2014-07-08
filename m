From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Tue, 8 Jul 2014 17:52:22 -0400
Message-ID: <CAPig+cTbhUKF7OwYJY2_1m9j=khPRaLM2kd5KqDGD=vjRz0qHg@mail.gmail.com>
References: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 23:52:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4dJN-0001V3-VQ
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 23:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbaGHVwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 17:52:25 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:58919 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaGHVwY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 17:52:24 -0400
Received: by mail-la0-f54.google.com with SMTP id mc6so4471854lab.13
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=z0nGbbcifArsJDDDME4o/EzJ8/cHey/N/qZ1nt8GBJE=;
        b=diRaBL7HQMVsii3DtKb7P0WDTiw0f7PHOZSueOEYmMQ5k2hwM16xhBquc18OoOG862
         jpm/rqmFSKrxH4kU50dNFqtz9zwdlZFnlY5M26QZJhDVt0ir89urPi1z4tSzk5XOMN37
         yxFPAMUijLtoRWZhHM6JlxLgB/FCxE114EPgFrc4e9ajnH0ATKiSbyy+3fi0Ut9U6Cxb
         /t7YiW/NdPzlDIwtKVMbjOKkNixhFkhxmXu5SfetGRLwrxqA8KAmkOybFrVsJFBFvL0D
         W9JJHakRhMX/r7Noa3Pwd68XbAyO2P1gkTrSGDgRN6sW9Pjjlf5i+hvSZd0fuVje8m6O
         SQwA==
X-Received: by 10.112.161.71 with SMTP id xq7mr8866324lbb.57.1404856342076;
 Tue, 08 Jul 2014 14:52:22 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Tue, 8 Jul 2014 14:52:22 -0700 (PDT)
In-Reply-To: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
X-Google-Sender-Auth: rAm36B6QiqM1MWylrZtHQ8NxwOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253053>

On Tue, Jul 8, 2014 at 11:54 AM, Yi EungJun <semtlenori@gmail.com> wrote:
> From: Yi EungJun <eungjun.yi@navercorp.com>
>
> Add an Accept-Language header which indicates the user's preferred
> languages defined by 'LANGUAGE' environment variable if the variable is
> not empty.
>
> Example:
>   LANGUAGE= -> ""
>   LANGUAGE=ko -> "Accept-Language: ko; q=1.000, *; q=0.001"
>   LANGUAGE=ko:en -> "Accept-Language: ko; q=1.000, en; q=0.999, *; q=0.001"
>
> This gives git servers a chance to display remote error messages in
> the user's preferred language.
> ---
>  http.c                     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  t/t5550-http-fetch-dumb.sh | 10 ++++++++++
>  2 files changed, 53 insertions(+)
>
> diff --git a/http.c b/http.c
> index 3a28b21..c345616 100644
> --- a/http.c
> +++ b/http.c
> @@ -983,6 +983,47 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
>                 strbuf_addstr(charset, "ISO-8859-1");
>  }
>
> +/*
> + * Add an Accept-Language header which indicates user's preferred languages
> + * defined by 'LANGUAGE' environment variable if the variable is not empty.
> + *
> + * Example:
> + *   LANGUAGE= -> ""
> + *   LANGUAGE=ko -> "Accept-Language: ko; q=1.000, *; q=0.001"
> + *   LANGUAGE=ko:en -> "Accept-Language: ko; q=1.000, en; q=0.999, *; q=0.001"
> + */
> +static void add_accept_language(struct strbuf *buf)
> +{
> +       const char *p1, *p2;
> +       float q = 1.000;
> +
> +       p1 = getenv("LANGUAGE");
> +
> +       if (p1 != NULL && p1[0] != '\0') {
> +               strbuf_reset(buf);

It seems wrong to clear 'buf' in a function named add_accept_language().

> +               strbuf_addstr(buf, "Accept-Language: ");
> +               for (p2 = p1; q > 0.001; p2++) {
> +                       if ((*p2 == ':' || *p2 == '\0') && p1 != p2) {
> +                               if (q < 1.0) {
> +                                       strbuf_addstr(buf, ", ");
> +                               }
> +                               strbuf_add(buf, p1, p2 - p1);
> +                               strbuf_addf(buf, "; q=%.3f", q);
> +                               q -= 0.001;
> +                               p1 = p2 + 1;
> +
> +                               if (*p2 == '\0') {
> +                                       break;
> +                               }
> +                       }
> +               }
> +               if (q < 1.0) {
> +                       strbuf_addstr(buf, ", ");
> +               }
> +               strbuf_addstr(buf, "*; q=0.001\r\n");

Manually adding "\r\n" is contraindicated. Headers passed to
curl_easy_setopt(c, CURLOPT_HTTPHEADER, headers) must not have "\r\n",
since curl will add terminators itself [1].

[1]: http://curl.haxx.se/libcurl/c/CURLOPT_HTTPHEADER.html

> +       }
> +}
> +
>  /* http_request() targets */
>  #define HTTP_REQUEST_STRBUF    0
>  #define HTTP_REQUEST_FILE      1
> @@ -1020,6 +1061,8 @@ static int http_request(const char *url,
>                                          fwrite_buffer);
>         }
>
> +       add_accept_language(&buf);

This is inconsistent with how other headers are handled by this
function. The existing idiom is:

    strbuf_add(&buf, ...); /* construct header */
    headers = curl_slist_apend(headers, buf.buf);
    strbuf_reset(&buf);

> +
>         strbuf_addstr(&buf, "Pragma:");
>         if (options && options->no_cache)
>                 strbuf_addstr(&buf, " no-cache");
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index ac71418..ea15158 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -196,5 +196,15 @@ test_expect_success 'reencoding is robust to whitespace oddities' '
>         grep "this is the error message" stderr
>  '
>
> +test_expect_success 'git client sends Accept-Language' '
> +       GIT_CURL_VERBOSE=1 LANGUAGE=ko:en git clone "$HTTPD_URL/accept/language" 2>actual

Broken &&-chain.

> +       grep "^Accept-Language: ko; q=1.000, en; q=0.999, \*; q=0.001" actual

Do you want to \-escape the periods? (Or maybe use 'grep -F'?)

> +'
> +
> +test_expect_success 'git client does not send Accept-Language' '
> +       GIT_CURL_VERBOSE=1 LANGUAGE= git clone "$HTTPD_URL/accept/language" 2>actual

Broken &&-chain.

> +       test_must_fail grep "^Accept-Language:" actual
> +'
> +
>  stop_httpd
>  test_done
> --
> 2.0.1.473.gafdefd9.dirty
