From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 03/14] strutil: add skip_prefix_icase
Date: Thu, 31 Dec 2015 01:40:46 -0500
Message-ID: <CAPig+cTF_HF-xoiV2osEi6RnGBKQTmkvmUcUn1GbYHVP15_hDA@mail.gmail.com>
References: <20151229071847.GA8726@sigill.intra.peff.net>
	<20151229072204.GC8842@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 31 07:40:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEWup-0002sz-VE
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 07:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbbLaGkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2015 01:40:49 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36109 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbbLaGkr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 01:40:47 -0500
Received: by mail-vk0-f46.google.com with SMTP id f2so174276282vkb.3
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 22:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/kMNnWUhHQYdwlXdPKF3+7keKI/yDPasiz78yR23+jY=;
        b=EHumPR3VZweNAEEeeT1KAP8732sgejIJvcKNSuysdyEc3wtt2y5o9tG0IXhLaCiZAr
         q7R+CP11/Yf0XE7AmBPPdrFyZJohpYrR+dSf8LUeJDu+BZAnzYpyuUr1FOf+EUVJdapZ
         NmbS0rhqZiWVdtDws4NhIv+wMQtUsuQauPCRGl9gGl2JeaASalJX3gI/7MGv7h0nX3g7
         Vu1Xun07rV2ZyxnBhbHLb/2rdxihKS/6P2Mqw62EttmG/Uy9YSKEDg/h2J5Mcd2hahYH
         RrWPKhOnxSK9MtftkAGdV/dS5xXsF0HPLNQlQR2NadSbZPdiaK0HdGI/sn5jrrOHbu/j
         DSoQ==
X-Received: by 10.31.150.76 with SMTP id y73mr21578439vkd.84.1451544046839;
 Wed, 30 Dec 2015 22:40:46 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 30 Dec 2015 22:40:46 -0800 (PST)
In-Reply-To: <20151229072204.GC8842@sigill.intra.peff.net>
X-Google-Sender-Auth: ZJEXdQ5aeABW5Vzd6BfkJLnUgfc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283230>

On Tue, Dec 29, 2015 at 2:22 AM, Jeff King <peff@peff.net> wrote:
> Some sites that otherwise would use skip_prefix cannot do
> so, because it has no way to do case-insensitive
> comparisons. Such sites usually get around this by using
> strncasecmp, at the cost of having to use magic numbers.
> We can help them by providing a case-insensitive version of
> skip_prefix.
>
> Unfortunately, we don't share any code with the original
> skip_prefix. Since this is performance-sensitive code, we
> would not want to introduce an extra "do we are about case?"
> conditional into the middle of the loop. We could instead
> use macros or another technique to generate the
> almost-identical implementations, but the function simply
> isn't long enough to merit that confusing boilerplate.
>
> To show off the new function, we convert a simple case in
> log's add_header function.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/log.c b/builtin/log.c
> @@ -677,10 +677,10 @@ static void add_header(const char *value)
> -       if (!strncasecmp(value, "to: ", 4))
> -               item = string_list_append(&extra_to, value + 4);
> -       else if (!strncasecmp(value, "cc: ", 4))
> -               item = string_list_append(&extra_cc, value + 4);
> +       if (skip_prefix_icase(value, "to: ", &value))
> +               item = string_list_append(&extra_to, value);
> +       else if (skip_prefix_icase(value, "cc: ", &value))
> +               item = string_list_append(&extra_cc, value);

Is it worth holding this patch, with its introduction of
skip_prefix_icase(), hostage to the unrelated change in the previous
patch (2/14) which touches the same bit of code? Would it make sense
to split this change out?

>         else
>                 item = string_list_append(&extra_hdr, value);
>
> diff --git a/strutil.h b/strutil.h
> @@ -32,6 +32,21 @@ static inline int skip_prefix(const char *str, const char *prefix,
>  /*
> + * Identical to skip_prefix, but compare characters case-insensitively.
> + */
> +static inline int skip_prefix_icase(const char *str, const char *prefix,
> +                                   const char **out)
> +{
> +       do {
> +               if (!*prefix) {
> +                       *out = str;
> +                       return 1;
> +               }
> +       } while (tolower(*str++) == tolower(*prefix++));

I wondered initially if we should be concerned about invoking
tolower() with an expression with side-effects since some older and/or
non-compliant libraries implement it as a macro which doesn't ensure
that the argument is evaluated only once. However, it seems that Git
already uses tolower(*p++) in a few other places, so I guess we're not
worrying about those broken implementations.

> +       return 0;
> +}
> +
> +/*
