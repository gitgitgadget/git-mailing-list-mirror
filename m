From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] http: Add Accept-Language header if possible
Date: Sun, 13 Jul 2014 00:26:58 -0400
Message-ID: <CAPig+cRwJhyZ=R_HGs9JKUFLuJxoS=abrD9+HuoWDiA5oJrtjw@mail.gmail.com>
References: <1405097573-19239-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 06:27:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BNU-0004hV-Ix
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbaGME1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 00:27:02 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:33424 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbaGME1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:27:00 -0400
Received: by mail-la0-f48.google.com with SMTP id el20so1959335lab.21
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=s15J8zh1vsCI7UYXbE2xUMTZ8e/seI8ii770lzJ+7gI=;
        b=eSAn2+ckcbNDbYn+JUZhC1zrau5tD3VksaI4MKP4NAtCxHyBD1tjr3c9esB5QqzH0m
         PcCjMa5sfleFfo858HM7UGUOiukI/AWp/deK5yECkJZ/NnzwXKwISFBvJXb2e+nFgQ7R
         WWQOoAJzYs8ULK+ZB5uxsDFWqZe0WREqq17DioDMEDnWbEAaPUXHDTWa5XPIzvRmwoll
         TV2X5fBRAyGIsZ565t2ZTLZVXXXuAPeUR/KuMbFc/MVAkDKzY4iNajasNCQ2gnRJuFEC
         NoAth1dc86bDhYQtYdph1ARJKsHmiiE5zqDuLMNxRJzHtYQdbH7mCUi/hmYgSVGMt6a1
         nSkQ==
X-Received: by 10.112.24.167 with SMTP id v7mr7032791lbf.19.1405225618620;
 Sat, 12 Jul 2014 21:26:58 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Sat, 12 Jul 2014 21:26:58 -0700 (PDT)
In-Reply-To: <1405097573-19239-1-git-send-email-eungjun.yi@navercorp.com>
X-Google-Sender-Auth: 3zyTCtQlRrIENdCCpHwCJ6thhuw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253401>

On Fri, Jul 11, 2014 at 12:52 PM, Yi EungJun <semtlenori@gmail.com> wrote:
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
> diff --git a/http.c b/http.c
> index 3a28b21..a20f3e2 100644
> --- a/http.c
> +++ b/http.c
> @@ -983,6 +983,129 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
>                 strbuf_addstr(charset, "ISO-8859-1");
>  }
>
> +/*
> + * Guess the user's preferred languages from the value in LANGUAGE environment
> + * variable and LC_MESSAGES locale category.
> + *
> + * The result can be a colon-separated list like "ko:ja:en".
> + */
> +static const char* get_preferred_languages() {
> +    const char* retval;
> +
> +       retval = getenv("LANGUAGE");
> +       if (retval != NULL && retval[0] != '\0')
> +               return retval;
> +
> +       retval = setlocale(LC_MESSAGES, NULL);
> +       if (retval != NULL && retval[0] != '\0'
> +               && strcmp(retval, "C") != 0
> +               && strcmp(retval, "POSIX") != 0)
> +               return retval;
> +
> +       return NULL;
> +}
> +
> +/*
> + * Add an Accept-Language header which indicates user's preferred languages.
> + *
> + * Examples:
> + *   LANGUAGE= -> ""
> + *   LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
> + *   LANGUAGE=ko_KR.UTF-8:sr@latin -> "Accept-Language: ko-KR, sr; q=0.9, *; q=0.1"
> + *   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
> + *   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
> + *   LANGUAGE= LANG=C -> ""
> + */
> +static struct curl_slist* add_accept_language(struct curl_slist *headers)
> +{
> +       const char *p1, *p2, *p3;
> +       struct strbuf buf = STRBUF_INIT;
> +       float q = 1.0;
> +       float q_precision = 0.1;
> +       int num_langs = 1;
> +       char* q_format = "; q=%.1f";

This can be 'const char *'.

> +
> +       p1 = get_preferred_languages();
> +
> +       /* Don't add Accept-Language header if no language is preferred. */
> +       if (p1 == NULL || p1[0] == '\0') {
> +               strbuf_release(&buf);
> +               return headers;
> +       }
> +
> +       /* Count number of preferred languages to decide precision of q-factor */
> +       for (p3 = p1; *p3 != '\0'; p3++) {
> +               if (*p3 == ':') {
> +                       num_langs++;
> +               }
> +       }
> +
> +       /* Decide the precision for q-factor on number of preferred languages. */
> +       if (num_langs + 1 > 100) { /* +1 is for '*' */
> +               q_precision = 0.001;
> +               q_format = "; q=%.3f";
> +       } else if (num_langs + 1 > 10) { /* +1 is for '*' */
> +               q_precision = 0.01;
> +               q_format = "; q=%.2f";
> +       }

It might make sense to have a final 'else' here which sets these
variables for the 0.1 case so that the reader of the code doesn't have
to refer back to the top of the function to figure out what is going
on.

    } else {
        q_precision = 0.1;
        q_format = "; q=%.1f";
    }

Better yet, would it be possible to compute these values rather than
having to set them manually via a cascading if-chain?

> +
> +       strbuf_addstr(&buf, "Accept-Language: ");
> +
> +       for (p2 = p1; q > q_precision; p2++) {
> +               if ((*p2 == ':' || *p2 == '\0') && p1 != p2) {
> +                       if (q < 1.0) {
> +                               strbuf_addstr(&buf, ", ");
> +                       }
> +
> +                       for (p3 = p1; p3 < p2; p3++) {
> +                               /* Replace '_' with '-'. */
> +                               if (*p3 == '_') {
> +                                       strbuf_add(&buf, p1, p3 - p1);
> +                                       strbuf_addstr(&buf, "-");
> +                                       p1 = p3 + 1;
> +                               }
> +
> +                               /* Chop off anything after '.' or '@'. */
> +                               if ((*p3 == '.' || *p3 == '@')) {
> +                                       break;
> +                               }
> +                       }
> +
> +                       if (p3 > p1) {
> +                               strbuf_add(&buf, p1, p3 - p1);
> +                       }
> +
> +                       /* Put the q factor if only it is less than 1.0. */
> +                       if (q < 1.0) {
> +                               strbuf_addf(&buf, q_format, q);
> +                       }
> +
> +                       q -= q_precision;
> +                       p1 = p2 + 1;
> +
> +                       if (*p2 == '\0') {
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       /* Don't add Accept-Language header if no language is preferred. */
> +       if (q >= 1.0) {
> +               strbuf_release(&buf);
> +               return headers;
> +       }
> +
> +       /* Add '*' with minimum q-factor greater than 0.0. */
> +       strbuf_addstr(&buf, ", *");
> +       strbuf_addf(&buf, q_format, q_precision);
> +
> +       headers = curl_slist_append(headers, buf.buf);
> +
> +       strbuf_release(&buf);
> +
> +       return headers;
> +}
> +
