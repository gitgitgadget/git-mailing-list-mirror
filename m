From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 19/34] mailinfo: move check for metainfo_charset to convert_to_utf8()
Date: Mon, 19 Oct 2015 18:57:53 -0400
Message-ID: <CAPig+cS32_rf3cCLUKne-aMc+YJRqThOiZ+sjZ6DrV4BW8PL-Q@mail.gmail.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-20-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 00:58:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoJNT-0007WX-RF
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 00:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbJSW54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 18:57:56 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33669 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbbJSW5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 18:57:54 -0400
Received: by vkgy127 with SMTP id y127so99514vkg.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 15:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kFOk7Nb7YwQi3ffl7OuNhfYKa8IvEWdWFGP2Jxv6geY=;
        b=LAso2NxVHzD5zYKaXJL/OrO+hQbaDPoWV6IWOnxfSgP0qyaBfld4ggT9mS2VlqNH/j
         UbvRgZUTyf4MjkjB9Yekzk9QeSOrkSnLjpXsL3xUKIcJ1W+DyZhDtmtA87gTG8Z/UW7r
         wxjt6ygt3FvTf6VzQDhBhXBQUwCk5QGLG8XDKzNUouf9F3Tk91T8L1ANTT3uSK31HlBP
         kI5Xj8U5GBHn+89F/qwmp5iEUzAGv1ENNzM53ByR7G3hRWf41GLw2SVTiihJNeKTYRvN
         j0+7bcoSzir2XIyCTyRCSMKkMJ+2KUME9N9JxAjFNAbGPrnoQE95PwbyaendnJc8Fe5j
         Lsfw==
X-Received: by 10.31.56.193 with SMTP id f184mr21917346vka.115.1445295473978;
 Mon, 19 Oct 2015 15:57:53 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Mon, 19 Oct 2015 15:57:53 -0700 (PDT)
In-Reply-To: <1445239731-10677-20-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: 0eaOY5xnJMX7-UjEH4rvzc4LBZY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279895>

On Mon, Oct 19, 2015 at 3:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> All callers of this function refrains from calling it when

s/refrains/refrain/

> mi->metainfo_charset is NULL; move the check to the callee,
> as it already has a few conditions at its beginning to turn
> it into a no-op.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 26fd9b1..737d0fc 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -524,7 +524,7 @@ static void convert_to_utf8(struct mailinfo *mi,
>  {
>         char *out;
>
> -       if (!charset || !*charset)
> +       if (!mi->metainfo_charset || !charset || !*charset)
>                 return;
>
>         if (same_encoding(mi->metainfo_charset, charset))
> @@ -599,8 +599,7 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
>                         dec = decode_q_segment(&piecebuf, 1);
>                         break;
>                 }
> -               if (mi->metainfo_charset)
> -                       convert_to_utf8(mi, dec, charset_q.buf);
> +               convert_to_utf8(mi, dec, charset_q.buf);
>
>                 strbuf_addbuf(&outbuf, dec);
>                 strbuf_release(dec);
> @@ -745,8 +744,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
>                 mi->header_stage = 0;
>
>         /* normalize the log message to UTF-8. */
> -       if (mi->metainfo_charset)
> -               convert_to_utf8(mi, line, charset.buf);
> +       convert_to_utf8(mi, line, charset.buf);
>
>         if (mi->use_scissors && is_scissors_line(line)) {
>                 int i;
> --
> 2.6.2-383-g144b2e6
