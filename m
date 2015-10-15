From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 16/31] mailinfo: move metainfo_charset to struct mailinfo
Date: Thu, 15 Oct 2015 16:47:19 -0400
Message-ID: <CAPig+cSnPT=oEB7bxFufaZ8JtDTxtrkiaUDcz4K+hu4wM-wOmg@mail.gmail.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
	<1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1444855557-2127-17-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 22:47:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmpQs-0000DY-G8
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 22:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbbJOUrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 16:47:22 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33816 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbbJOUrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 16:47:20 -0400
Received: by vkat63 with SMTP id t63so57062239vka.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=of3mvNA4bU7XfnUOEXMGkkQfW3P1XUx83jkJRb52UaA=;
        b=BxamAgJrLmRD0s+W77EN2hwcXPb7BqxMFbutUUqE3ZJtLWIOYevPgoH4W/WdkhLIxp
         05fngwJe37lxUCx9XXY5iC/rutSnKSAmEeRZo4Xb9QiwyHhqBFsTt2zW5wMWmXKNYyYB
         lVkNCynDdjEGSEDdqNG5fJC2TcHfGLzdIzon60xCvbhptlFeV62v92oHkiM8sMrHSvek
         AVyRIkmiscVIJDm+I3l9ZU/vpGFWaSBhFtLtO4/b36Zp6Ql63gz13gnhGHRKKQbc3Lzy
         7jkiZ7Od1EmrH4f0T5fPrKJdbi/ZWl3FX5QOISdoZxYO6TyHkx/a4dK9LVgrHC6zO3VW
         ol/g==
X-Received: by 10.31.178.3 with SMTP id b3mr6809009vkf.19.1444942039883; Thu,
 15 Oct 2015 13:47:19 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Thu, 15 Oct 2015 13:47:19 -0700 (PDT)
In-Reply-To: <1444855557-2127-17-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: eBUTj3r-ihwM6eHWTZnMLCacYE8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279709>

On Wed, Oct 14, 2015 at 4:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This requires us to pass the struct down to decode_header() and
> convert_to_utf8() callchain.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> @@ -520,23 +519,24 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
> -static void convert_to_utf8(struct strbuf *line, const char *charset)
> +static void convert_to_utf8(struct mailinfo *mi,
> +                           struct strbuf *line, const char *charset)
>  {
>         char *out;
>
> -       if (!charset || !*charset)
> +       if (!mi->metainfo_charset || !charset || !*charset)
>                 return;

Mental note: convert_to_utf8() is updated to return early when
metainfo_charset==NULL.

> -       if (same_encoding(metainfo_charset, charset))
> +       if (same_encoding(mi->metainfo_charset, charset))
>                 return;
> -       out = reencode_string(line->buf, metainfo_charset, charset);
> +       out = reencode_string(line->buf, mi->metainfo_charset, charset);
>         if (!out)
>                 die("cannot convert from %s to %s",
> -                   charset, metainfo_charset);
> +                   charset, mi->metainfo_charset);
>         strbuf_attach(line, out, strlen(out), strlen(out));
>  }
>
> -static void decode_header(struct strbuf *it)
> +static void decode_header(struct mailinfo *mi, struct strbuf *it)
>  {
>         char *in, *ep, *cp;
>         struct strbuf outbuf = STRBUF_INIT, *dec;
> @@ -599,8 +599,7 @@ static void decode_header(struct strbuf *it)
>                         dec = decode_q_segment(&piecebuf, 1);
>                         break;
>                 }
> -               if (metainfo_charset)
> -                       convert_to_utf8(dec, charset_q.buf);
> +               convert_to_utf8(mi, dec, charset_q.buf);

It's safe to drop the conditional here since convert_to_utf8() now
checks metainfo_charset. Okay.

>                 strbuf_addbuf(&outbuf, dec);
>                 strbuf_release(dec);
> @@ -745,8 +744,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
>                 mi->header_stage = 0;
>
>         /* normalize the log message to UTF-8. */
> -       if (metainfo_charset)
> -               convert_to_utf8(line, charset.buf);
> +       convert_to_utf8(mi, line, charset.buf);

Ditto.

>         if (mi->use_scissors && is_scissors_line(line)) {
>                 int i;
