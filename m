From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 10/15] for-each-ref: introduce format specifier %>(*) and %<(*)
Date: Tue, 4 Jun 2013 19:54:49 +0700
Message-ID: <CACsJy8A2h0pjZ759NpByrEJYzg3ETyDkUGTptC-FFkeZCpGSbQ@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com> <1370349337-20938-11-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:55:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujqlq-0005vf-8s
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab3FDMzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 08:55:22 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:52490 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab3FDMzV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:55:21 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so280852obb.0
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mQSrj8KxIMt4vdroQVt138J1Hh66naVwB0KOokSXeAw=;
        b=ZaL8HlmjAQKb5aC4K7jWsBx5y8WYWCwwzAW4Qw3/8AfawSH3GqR+RCBeckMXyjr1oK
         aAanPlwlOG4ED2nVLxHaqL6w124h3ZS3StztdTwo7RUkTuAYmBYKmFKSUAUvwIUP3xfZ
         ipbXacA823eRFlmGn8nhg0pUWyjOebXIchTUhaCt6q4ulNWx/orLGa1UIh8Rln3tTWzx
         iGldCUYStf9qnQIvXKkEewY0P3NOhV3DCe8M1HRdsGGWD3aNwAiVMcudMJfDyV+wcYzW
         18bd5UawvwSSNb37vG+ncJZCq4vPKMMThIuKg8L9bQ9OhiTi20PR2b8fjrCAVSVdglF1
         3+Nw==
X-Received: by 10.60.97.232 with SMTP id ed8mr11106191oeb.96.1370350519709;
 Tue, 04 Jun 2013 05:55:19 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Tue, 4 Jun 2013 05:54:49 -0700 (PDT)
In-Reply-To: <1370349337-20938-11-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226363>

On Tue, Jun 4, 2013 at 7:35 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> +static unsigned int get_atom_width(struct format_one_atom_context *ctx,
> +                                  const char *start, const char *end)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +       int i, atom = parse_atom(start, end);
> +       unsigned int len = 0, sb_len;
> +       for (i = 0; i < ctx->maxcount; i++) {
> +               print_value(&sb, ctx->refs[i], atom, ctx->quote_style);
> +               sb_len = utf8_strnwidth(sb.buf, sb.len, 1);
> +               if (sb_len > len)
> +                       len = sb_len;
> +               strbuf_reset(&sb);
> +       }
> +       strbuf_release(&sb);
> +       return len;
> +}
> +

I mentioned it before and I do it again. This is not optimal. We
should cache the result of get_atom_width() after the first
calculation. I haven't done it yet because I'm still not sure if it's
worth supporting %<(*)%non-atom at this stage. Caching for atoms only
is much easier because atom is indexed. But I guess it's ok in this
shape unless you run this over hundreds of refs.
--
Duy
