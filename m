From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
Date: Fri, 1 May 2015 15:33:58 -0400
Message-ID: <CAPig+cQr5wQ6nfy90+SWyFFv0Neq4oJiEtur4cBJNGHNKXhZrQ@mail.gmail.com>
References: <1430508507-14016-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 01 21:34:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoGhI-0004ju-Sl
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 21:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbbEATd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 15:33:59 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34955 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbEATd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 15:33:59 -0400
Received: by igbyr2 with SMTP id yr2so46563873igb.0
        for <git@vger.kernel.org>; Fri, 01 May 2015 12:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=v/PxFral9ba7RO9pj+ivDliEMPFID7O9LHlR8FqACEg=;
        b=H/iJxQIL9WNblT7VveBOxGoTe4QKoHW0V1tUbnuZwA3K75eCTZPIW7+clIGDIhXnAd
         tgNpcUhcBw6r7i14X4bG6r7B/xcD8WpLNX9JPlO+rolCXmr3zAjUZ2uZJ83LkO6ELF6L
         b2562ZPgmRREQqRi/2wsXR65jsuMEQ1px2LfcsMGD2dMyL6acfuC27PcL+uuiSbxP5r/
         Q7Hc87Eta5O2LJCNOD2TL4JwmjMO9viFYbmod4/gActRl9gfhNydARTTiG4XFGYWpgaL
         2pI98btO7KZ8RICg/I4DZr2txTpfav9yZyNXHfyc6SbRhHB2tCJM+qRHdGsnotjziBhj
         EXfA==
X-Received: by 10.107.31.134 with SMTP id f128mr14299740iof.19.1430508838425;
 Fri, 01 May 2015 12:33:58 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 1 May 2015 12:33:58 -0700 (PDT)
In-Reply-To: <1430508507-14016-1-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 2b4hmx0abYCdolKLkTQn3I6AYsI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268176>

On Fri, May 1, 2015 at 3:28 PM, Stefan Beller <sbeller@google.com> wrote:
> It's safe to free the char pointer `p` unconditionally.
>
> The pointer is assigned just 2 lines earlier as a return from
> prefix_path, which allocates new memory for its return value.
>
> Then it is used in checkout_file, which passes the pointer on to
> cache_name_pos and write_tempfile_record, both of which do not store
> the pointer in any permanent record.
>
> So the condition on when to free the pointer is just "always".

Why doesn't the 'p' in the 'while' loop just below deserve the same treatment?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 9ca2da1..e28dc35 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -249,8 +249,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>                         die("git checkout-index: don't mix '--stdin' and explicit filenames");
>                 p = prefix_path(prefix, prefix_length, arg);
>                 checkout_file(p, prefix);
> -               if (p < arg || p > arg + strlen(arg))
> -                       free((char *)p);
> +
> +               free((char *)p);
>         }
>
>         if (read_from_stdin) {
> --
> 2.4.0.rc3.16.g0ab00b9
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
