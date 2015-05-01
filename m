From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
Date: Fri, 1 May 2015 19:41:03 -0400
Message-ID: <CAPig+cRCKDD--Px-FvrV1h8Os7WjYKQXN+5kh1WzVDoud9NJmg@mail.gmail.com>
References: <1430508507-14016-1-git-send-email-sbeller@google.com>
	<1430519737-6224-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat May 02 01:41:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoKYP-0001bo-E9
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 01:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbbEAXlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 19:41:05 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34325 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbEAXlE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 19:41:04 -0400
Received: by iedfl3 with SMTP id fl3so111206707ied.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ps5BkG4EhK8q5rI0MQz+pvS0wE/4+bUiyIKoKCFPYsQ=;
        b=l5N6cNYMUFzYM3KwwsBLsloLwXGRMawf1sS8gbWvQrTdJ3lTJ7RuZZVwWrW0aCOHSd
         n4sPOpH/Obg22zEZKhngd89FC2tgaG4hbPlRjsT68PNrqoHJKMqugUXdw+6brJ8kjx8h
         9eHftRwhK5ZfV8TtJbSY7ojDazKEa4E6CSPzMDPY3XNH6UPX2rlDU4QQhM/JJ4D9CSzO
         eGETcGzx0iHZ5PDYCkPF/52g79eauQGjSy8xZOckX80rUPLniqH0kEsV2hkvIl+YKG5u
         DAi2wJ3Gr4YP8l2vryT0btvQUC6ylODaeELY8fkT/dNKdJciCu/J5i8rTRgMJPamG3f4
         nwBA==
X-Received: by 10.42.207.206 with SMTP id fz14mr17595284icb.34.1430523663325;
 Fri, 01 May 2015 16:41:03 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 1 May 2015 16:41:03 -0700 (PDT)
In-Reply-To: <1430519737-6224-1-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: J8tasq_HnA0fHfj2dBIhzuuHswA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268202>

On Fri, May 1, 2015 at 6:35 PM, Stefan Beller <sbeller@google.com> wrote:
> It's safe to free the char pointer `p` unconditionally.
>
> The pointer is assigned just 2 lines earlier as a return from
> prefix_path, which allocates new memory for its return value.
>
> Then it is used in checkout_file, which passes the pointer on to
> cache_name_pos and write_tempfile_record, both of which do not store
> the pointer in any permanent record.
> So the condition on when to free the pointer is just "always".

In addition to Peff's comment about the Subject: being incorrect for
this updated patch, the commit message itself is specific to
checkout-index.c by mentioning only cache_name_pos() and
write_tempfile_record(), neither of which are applicable to
update-index.c.

In fact, the commit message, by talking about 'p' and this or that
called function, is probably too detailed. It should be more than
sufficient merely to observe that the string returned by prefix_path()
is always newly allocated (and, parenthetically, that that result is
never stored away for later use), therefore freeing it unconditionally
is the correct thing to do.

> Looking at the history this behavior must be fixed since at least
> (f5114a40c0d0, 2011-08-04, git-check-attr: Normalize paths), where
> the result of prefix_path is freed unconditionally.

This is a strange justification. How does the reader know that the
author of that change was disposing of the result of prefix_path()
properly? Rather than increasing the reader's confidence that your
change is correct, this sort of hand-wavy argument decreases
confidence.

The change which made prefix_path() always return a newly allocated
string was d089eba (setup: sanitize absolute and funny paths in
get_pathspec(), 2008-01-28), so why not cite that instead?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 9ca2da1..5325f92 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -249,8 +249,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>                         die("git checkout-index: don't mix '--stdin' and explicit filenames");
>                 p = prefix_path(prefix, prefix_length, arg);
>                 checkout_file(p, prefix);
> -               if (p < arg || p > arg + strlen(arg))
> -                       free((char *)p);
> +               free((char *)p);
>         }
>
>         if (read_from_stdin) {
> @@ -269,8 +268,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>                         }
>                         p = prefix_path(prefix, prefix_length, buf.buf);
>                         checkout_file(p, prefix);
> -                       if (p < buf.buf || p > buf.buf + buf.len)
> -                               free((char *)p);
> +                       free((char *)p);
>                 }
>                 strbuf_release(&nbuf);
>                 strbuf_release(&buf);
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 6271b54..584efa5 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -534,8 +534,7 @@ static int do_unresolve(int ac, const char **av,
>                 const char *arg = av[i];
>                 const char *p = prefix_path(prefix, prefix_length, arg);
>                 err |= unresolve_one(p);
> -               if (p < arg || p > arg + strlen(arg))
> -                       free((char *)p);
> +               free((char *)p);
>         }
>         return err;
>  }
> --
> 2.4.0.rc3.16.g0ab00b9
