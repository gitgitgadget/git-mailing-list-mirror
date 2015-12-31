From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/14] log: refactor add_header to drop some magic numbers
Date: Thu, 31 Dec 2015 01:21:42 -0500
Message-ID: <CAPig+cRgK5Ey8WNDLLOnAhR+xh6NEHk-hGhGccj4SkZO-RV_-Q@mail.gmail.com>
References: <20151229071847.GA8726@sigill.intra.peff.net>
	<20151229072048.GB8842@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 31 07:21:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEWcO-0004Z4-BA
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 07:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbbLaGVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2015 01:21:45 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35375 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbbLaGVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 01:21:43 -0500
Received: by mail-vk0-f45.google.com with SMTP id k1so86141721vkb.2
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 22:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=c3wsq11Zkn5HRTqxpQGLD8XHMTBIUG0IfD29j7mogso=;
        b=k1HtW0D42T73IsSpZ9yZeLSOJ7HDqhvoCMCkVRBm4uXgaO/7dSFAASR/Shv50h93Nd
         Qy3scIB//r3HQY3pVIY/yGSPyaDTpL7JEyl2gdDy9t4CUJXqxjJql+07t+NIG0Kvev12
         0k22Pj6gNvg+Vn9zZV8nSzF+gFkwNT3KjNdRVf6IA/iAGEasL8I8QFmpv5yCn+GpJ+wA
         YWnMAtt/5n1NXu9im0sGl2vlIdCrQPvqvugiyVZ5euLO1O+iy0WWAahyiPOR0Ab02TnV
         s5KhL6YtajtNTeUOZPHwjzellb0xgkNtPf+DiD2HTrkOHDl4dUATHVYJtVWYpdanvEZO
         NuEw==
X-Received: by 10.31.141.2 with SMTP id p2mr20337626vkd.37.1451542902897; Wed,
 30 Dec 2015 22:21:42 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 30 Dec 2015 22:21:42 -0800 (PST)
In-Reply-To: <20151229072048.GB8842@sigill.intra.peff.net>
X-Google-Sender-Auth: L4_Ksn0PGPiz-vcUASMZZ9Hn8uA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283229>

On Tue, Dec 29, 2015 at 2:20 AM, Jeff King <peff@peff.net> wrote:
> We want to chomp newlines off the end of the "value" string.
> But because it's const, we must track its length rather than
> writing a NUL. This leads to us having to tweak that length
> later, to account for moving the pointer forward.
>
> Since we are about to create a copy of it anyway, let's just
> wait and chomp at the end.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/log.c b/builtin/log.c
> @@ -675,21 +675,18 @@ static struct string_list extra_cc;
>  static void add_header(const char *value)
>  {
>         struct string_list_item *item;
> -       int len = strlen(value);
> -       while (len && value[len - 1] == '\n')
> -               len--;
> +       size_t len;
>
> -       if (!strncasecmp(value, "to: ", 4)) {
> +       if (!strncasecmp(value, "to: ", 4))
>                 item = string_list_append(&extra_to, value + 4);
> -               len -= 4;
> -       } else if (!strncasecmp(value, "cc: ", 4)) {
> +       else if (!strncasecmp(value, "cc: ", 4))
>                 item = string_list_append(&extra_cc, value + 4);
> -               len -= 4;
> -       } else {
> +       else
>                 item = string_list_append(&extra_hdr, value);
> -       }
>
> -       item->string[len] = '\0';
> +       len = strlen(item->string);
> +       while (len && item->string[len - 1] == '\n')
> +               item->string[--len] = '\0';

Not a strong objection, but this implementation may make the reader
wonder why NUL needs to be assigned to all "stripped" characters. I'd
have expected to see:

    len = strlen(item->string);
    while (len && item->string[len - 1] == '\n')
        len--;
    item->string[len] = '\0';

which indicates clearly that this is a simple truncation rather than
some odd NUL-fill operation, and is slightly more easy to reason about
since it doesn't involve a pre-decrement as an array subscript.

>  }
>
>  #define THREAD_SHALLOW 1
> --
> 2.7.0.rc3.367.g09631da
