From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 7/7] determine_author_info: stop leaking name/email
Date: Mon, 23 Jun 2014 05:28:14 -0400
Message-ID: <CAPig+cT7mAGaGXZHNEWvZ31acth2wooexZ5s7wWFrJ40rBviYw@mail.gmail.com>
References: <20140618201944.GA23238@sigill.intra.peff.net>
	<20140618203609.GG23896@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 11:28:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz0Y1-0004LM-KA
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 11:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbaFWJ2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 05:28:16 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:36007 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbaFWJ2P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 05:28:15 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so4816806yha.10
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 02:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XI06mV4uS3/DMxnEEIwHp0IMuYHlDCuYE6sPMvKXGlA=;
        b=WA1KdgWR7MCqPi6BxqB8L0Q9koUYlxOfUpNOGLIcs3jfHgaNvoFUUUSD/2tHIAcQ3Y
         zK6FRkLoyPc1OSvPKx93/sdpeRgh00qmS/J7PbPJlmQAzlRiihXLbRlMYariUtvCuSdc
         HNG2KUkQD/gzadf8CtiqXHd3+07Q7OI0SX9TxUxfceAxyuIBf9jpwSyFCVOidmr+re/C
         oex+P74ajZJ8gzSEryZD9C/PYkqfr/SZMhm8zY/CIF8o8yS9VigWDTxu9jIqzBdduiOz
         cm8FljbRPpXgMm+HzqbSKqUC+v7c3Ja7i9qIlS6OHSN3zWipSXO1Mlea43krTOeIWISs
         l+bg==
X-Received: by 10.236.30.105 with SMTP id j69mr34088838yha.19.1403515694407;
 Mon, 23 Jun 2014 02:28:14 -0700 (PDT)
Received: by 10.170.36.80 with HTTP; Mon, 23 Jun 2014 02:28:14 -0700 (PDT)
In-Reply-To: <20140618203609.GG23896@sigill.intra.peff.net>
X-Google-Sender-Auth: ialM4SaL2vE-TzSA1Cnbq1r6P9s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252326>

On Wed, Jun 18, 2014 at 4:36 PM, Jeff King <peff@peff.net> wrote:
> When we get the author name and email either from an
> existing commit or from the "--author" option, we create a
> copy of the strings. We cannot just free() these copies,
> since the same pointers may also be pointing to getenv()
> storage which we do not own.
>
> Instead, let's treat these the same way as we do the date
> buffer: keep a strbuf to be released, and point the bare
> pointers at the strbuf.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/commit.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 62abee0..72beb7f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -546,16 +546,20 @@ static void strbuf_add_pair(struct strbuf *buf, const struct pointer_pair *p)
>         strbuf_add(buf, p->begin, p->end - p->begin);
>  }
>
> -static char *xmemdupz_pair(const struct pointer_pair *p)
> +static char *set_pair(struct strbuf *buf, struct pointer_pair *p)
>  {
> -       return xmemdupz(p->begin, p->end - p->begin);
> +       strbuf_reset(buf);
> +       strbuf_add_pair(buf, p);
> +       return buf->buf;
>  }
>
>  static void determine_author_info(struct strbuf *author_ident)
>  {
>         char *name, *email, *date;
>         struct ident_split author;
> -       struct strbuf date_buf = STRBUF_INIT;
> +       struct strbuf name_buf = STRBUF_INIT,
> +                     mail_buf = STRBUF_INIT,

nit: The associated 'char *' variable is named "email", so perhaps
s/mail_buf/email_buf/g

> +                     date_buf = STRBUF_INIT;
>
>         name = getenv("GIT_AUTHOR_NAME");
>         email = getenv("GIT_AUTHOR_EMAIL");
> @@ -572,8 +576,8 @@ static void determine_author_info(struct strbuf *author_ident)
>                 if (split_ident_line(&ident, a, len) < 0)
>                         die(_("commit '%s' has malformed author line"), author_message);
>
> -               name = xmemdupz_pair(&ident.name);
> -               email = xmemdupz_pair(&ident.mail);
> +               name = set_pair(&name_buf, &ident.name);
> +               email = set_pair(&mail_buf, &ident.mail);
>                 if (ident.date.begin) {
>                         strbuf_reset(&date_buf);
>                         strbuf_addch(&date_buf, '@');
> @@ -589,8 +593,8 @@ static void determine_author_info(struct strbuf *author_ident)
>
>                 if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
>                         die(_("malformed --author parameter"));
> -               name = xmemdupz_pair(&ident.name);
> -               email = xmemdupz_pair(&ident.mail);
> +               name = set_pair(&name_buf, &ident.name);
> +               email = set_pair(&mail_buf, &ident.mail);

Does the code become too convoluted with these changes? You're now
maintaining three 'char *' variables in parallel with three strbuf
variables. Is it possible to drop the 'char *' variables and just pass
the .buf member of the strbufs to fmt_ident()?

Alternately, you also could solve the leaks by having an envdup() helper:

    static char *envdup(const char *s)
    {
        const char *v = getenv(s);
        return v ? xstrdup(v) : NULL;
    }

    ...
    name = envdup("GIT_AUTHOR_NAME");
    email = envdup("GIT_AUTHOR_EMAIL");
    ...

And then just free() 'name' and 'email' normally.

>         }
>
>         if (force_date) {
> @@ -608,6 +612,8 @@ static void determine_author_info(struct strbuf *author_ident)
>                 export_one("GIT_AUTHOR_DATE", author.date.begin, author.tz.end, '@');
>         }
>
> +       strbuf_release(&name_buf);
> +       strbuf_release(&mail_buf);
>         strbuf_release(&date_buf);
>  }
>
> --
> 2.0.0.566.gfe3e6b2
