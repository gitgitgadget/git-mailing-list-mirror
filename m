From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] prefix_path(): Unconditionally free result of prefix_path
Date: Mon, 4 May 2015 16:19:26 -0400
Message-ID: <CAPig+cSuCouNCuKa99mct4UMPykuMVy3+7sqB6y+v+UtP2oeTw@mail.gmail.com>
References: <1430766714-22368-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 04 22:19:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpMpx-0004qZ-LA
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 22:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbbEDUT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 16:19:29 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37646 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbEDUT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 16:19:27 -0400
Received: by igblo3 with SMTP id lo3so92116722igb.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Cq81GeCTAJjRcgIgpMlFyyuqJKMEHwWfvZGkjMuj8aU=;
        b=sE8/SP2EXvAzzaZLXhLd5JNQgpwaYD+F3hm7JrfE9B5JA/Qq6ipslEoKusP4n+vsMi
         ipsFBrUjHoXg79qkRQ6qaFLSW/V17/G16J4i3P1w3j2u/OhdS5RdQZf7SSOUo7G8W7Eo
         dFy0VsmU3ZrcU74hbMa/msfzoO62ElBNIY6RCHq7qSTPwOm18tfOsF9I+1xIDcwcMs1h
         Od5zzxI6klauPFQf4l+86pI65yPHy18//N9kuFtVflkZV4h5byqPTuZ9lHNxJahZbz0j
         su/DDqyv1JKLgFr++Op8fawMo/wMka18ydhZ4BcT3O9TJNZgns5ETZxpsgKjhUTJ3y06
         057A==
X-Received: by 10.50.85.43 with SMTP id e11mr416172igz.15.1430770766968; Mon,
 04 May 2015 13:19:26 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 4 May 2015 13:19:26 -0700 (PDT)
In-Reply-To: <1430766714-22368-1-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 2XeT2O4NUFByb1hgJ2LKn_iETr8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268345>

On Mon, May 4, 2015 at 3:11 PM, Stefan Beller <sbeller@google.com> wrote:
> prefix_path(): Unconditionally free result of prefix_path

Slightly redundant mention of "prefix_path". Also, prevailing custom
is to drop capitalization.

> prefix_path() always returns a newly allocated string since
> d089eba (setup: sanitize absolute and funny paths in get_pathspec(),
> 2008-01-28)

I'd probably turn this sentence fragment into a proper sentence:

    As of d089eba (...), prefix_path() always returns a newly
    allocated string, so free its result unconditionally.

> Additionally the const is dropped from the pointers, so the call to
> free doesn't need a cast.

Imperative mood:

    Additionally, drop the const from variables to which the
    prefix_path() result is assigned so they can be free()'d
    without having to cast-away constness.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     Thanks for all the suggestions!
>     They are incorporated into this version of the patch.

Thanks, this version looks much better.

FWIW, with or without addressing the very minor nits above:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 9ca2da1..8028c37 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -241,7 +241,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>         /* Check out named files first */
>         for (i = 0; i < argc; i++) {
>                 const char *arg = argv[i];
> -               const char *p;
> +               char *p;
>
>                 if (all)
>                         die("git checkout-index: don't mix '--all' and explicit filenames");
> @@ -249,8 +249,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>                         die("git checkout-index: don't mix '--stdin' and explicit filenames");
>                 p = prefix_path(prefix, prefix_length, arg);
>                 checkout_file(p, prefix);
> -               if (p < arg || p > arg + strlen(arg))
> -                       free((char *)p);
> +               free(p);
>         }
>
>         if (read_from_stdin) {
> @@ -260,7 +259,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>                         die("git checkout-index: don't mix '--all' and '--stdin'");
>
>                 while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
> -                       const char *p;
> +                       char *p;
>                         if (line_termination && buf.buf[0] == '"') {
>                                 strbuf_reset(&nbuf);
>                                 if (unquote_c_style(&nbuf, buf.buf, NULL))
> @@ -269,8 +268,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>                         }
>                         p = prefix_path(prefix, prefix_length, buf.buf);
>                         checkout_file(p, prefix);
> -                       if (p < buf.buf || p > buf.buf + buf.len)
> -                               free((char *)p);
> +                       free(p);
>                 }
>                 strbuf_release(&nbuf);
>                 strbuf_release(&buf);
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 6271b54..a92eed2 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -532,10 +532,9 @@ static int do_unresolve(int ac, const char **av,
>
>         for (i = 1; i < ac; i++) {
>                 const char *arg = av[i];
> -               const char *p = prefix_path(prefix, prefix_length, arg);
> +               char *p = prefix_path(prefix, prefix_length, arg);
>                 err |= unresolve_one(p);
> -               if (p < arg || p > arg + strlen(arg))
> -                       free((char *)p);
> +               free(p);
>         }
>         return err;
>  }
> --
> 2.4.0.rc3.16.g0ab00b9
