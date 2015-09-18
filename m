From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 54/67] color: add overflow checks for parsing colors
Date: Fri, 18 Sep 2015 14:54:11 -0400
Message-ID: <CAPig+cQUwsDfL-epJYy+4xoG2-GfDfhb3mH=7WAzYbsea-sXDA@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915160703.GB29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 18 20:54:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd0nf-0004wA-BY
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 20:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbbIRSyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 14:54:15 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32830 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbbIRSyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 14:54:12 -0400
Received: by vkgd64 with SMTP id d64so35465891vkg.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JlulN6G0//bDVHf5i1aaR+TvWFiEq8pp6MKHbd6ji7E=;
        b=Y0KyBT4pTUF78wyd8pGYhhbN6jKdRPc3yp3JVniwVHTH5v4lobQ7uGsfRHQp8hXzhu
         rvc1KTDAV7OTm96wyg76FUcyfA7P8QOX/m2yXtBBdXgZvKcwAmxKhkAQSD2OWEBin7OE
         xEguCW7EZFRDMBi9xj1llbI3y2L0PofZZwRNRe3I/LovttRyGIQpdmoPANsKbKUwWxmn
         1UU2oao18J/loE/AdVnH70eb/W6sHUlkfbZr6OxBipLuALbY0CqCgaL5+6Q/pC2hPGRh
         UYdztaAm9dSOyi3OqDb2kWl3HSbZL/RHmUwsN0g0IBlBbJbZb6l+cOQC0JuswNAhNKie
         ePIg==
X-Received: by 10.31.56.193 with SMTP id f184mr4447489vka.115.1442602451309;
 Fri, 18 Sep 2015 11:54:11 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Fri, 18 Sep 2015 11:54:11 -0700 (PDT)
In-Reply-To: <20150915160703.GB29753@sigill.intra.peff.net>
X-Google-Sender-Auth: n9ZIKYGkbsiKCxDNuE-hzxSubBA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278214>

On Tue, Sep 15, 2015 at 12:07 PM, Jeff King <peff@peff.net> wrote:
> Our color parsing is designed to never exceed COLOR_MAXLEN
> bytes. But the relationship between that hand-computed
> number and the parsing code is not at all obvious, and we
> merely hope that it has been computed correctly for all
> cases.
>
> Let's mark the expected "end" pointer for the destination
> buffer and make sure that we do not exceed it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> @@ -224,12 +227,18 @@ int color_parse_mem(const char *value, int value_len, char *dst)
>                         goto bad;
>         }
>
> +#define OUT(x) do { \
> +       if (dst == end) \
> +               die("BUG: color parsing ran out of space"); \
> +       *dst++ = (x); \
> +} while(0)

Hmm, can we have an #undef OUT before the #define OUT(...), or choose
a less conflict-likely name? In particular, I'm thinking about
preprocessor namespace pollution arising from sources out of our
control, such as was the case with 414382f (ewah/bitmap: silence
warning about MASK macro redefinition, 2015-06-03).

> +
>         if (attr || !color_empty(&fg) || !color_empty(&bg)) {
>                 int sep = 0;
>                 int i;
>
> -               *dst++ = '\033';
> -               *dst++ = '[';
> +               OUT('\033');
> +               OUT('[');
>
>                 for (i = 0; attr; i++) {
>                         unsigned bit = (1 << i);
> @@ -237,24 +246,24 @@ int color_parse_mem(const char *value, int value_len, char *dst)
>                                 continue;
>                         attr &= ~bit;
>                         if (sep++)
> -                               *dst++ = ';';
> -                       dst += sprintf(dst, "%d", i);
> +                               OUT(';');
> +                       dst += xsnprintf(dst, end - dst, "%d", i);
>                 }
>                 if (!color_empty(&fg)) {
>                         if (sep++)
> -                               *dst++ = ';';
> +                               OUT(';');
>                         /* foreground colors are all in the 3x range */
> -                       dst = color_output(dst, &fg, '3');
> +                       dst = color_output(dst, end - dst, &fg, '3');
>                 }
>                 if (!color_empty(&bg)) {
>                         if (sep++)
> -                               *dst++ = ';';
> +                               OUT(';');
>                         /* background colors are all in the 4x range */
> -                       dst = color_output(dst, &bg, '4');
> +                       dst = color_output(dst, end - dst, &bg, '4');
>                 }
> -               *dst++ = 'm';
> +               OUT('m');
>         }
> -       *dst = 0;
> +       OUT(0);
>         return 0;
>  bad:
>         return error(_("invalid color value: %.*s"), value_len, value);
> --
> 2.6.0.rc2.408.ga2926b9
