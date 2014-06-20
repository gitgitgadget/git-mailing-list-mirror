From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/16] refactor skip_prefix to return a boolean
Date: Thu, 19 Jun 2014 21:59:39 -0400
Message-ID: <CAPig+cTKgrYx1hcO-hV3ZT2sm1rR17bWJC0ktZzFQB=TMr6Xuw@mail.gmail.com>
References: <20140618194117.GA22269@sigill.intra.peff.net>
	<20140618194417.GD22622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 03:59:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxo7E-0000tz-GM
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 03:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455AbaFTB7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 21:59:41 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:40165 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbaFTB7k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 21:59:40 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so2390193yho.30
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 18:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZZ7FR5kNPFvtSvlFsafB4xRWYp2dUyZZKXSdTShlGLU=;
        b=p5rIFacWaD3+rNnpHYe7v58AsQsoHjWcKC10fHTBuDNgGHc7BXeC2i6xYyFOUegR/b
         va5lhJ4RoNuEPC+KEF46nwoH34fdhPfVbrxFbfeCQ+PLSvNjIJuHjYRbNYwMc+KxXxtc
         YCUHBxhZ4aVFeXbfY9sCROLbOQZRFvqQB4G/AUx77KV1f0SNu6XbSNKOAKkzQTEePS+I
         VCzp2HDUj30nyavqckr4Enay27okcor+rq6hiojIa8oTOYWsCHC3gZ4FqPvFLZjg6kuy
         5YmJUs8KXC9PjkttOQ4IDF+L0nB/b8WgrNoqXx5j7+uxA5TrQ+by92OqClPSKXE0bcCF
         J74g==
X-Received: by 10.236.89.69 with SMTP id b45mr510492yhf.16.1403229579689; Thu,
 19 Jun 2014 18:59:39 -0700 (PDT)
Received: by 10.170.36.80 with HTTP; Thu, 19 Jun 2014 18:59:39 -0700 (PDT)
In-Reply-To: <20140618194417.GD22622@sigill.intra.peff.net>
X-Google-Sender-Auth: pQxe7yDJi4OMrvrUjdKG10TE-Gg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252204>

On Wed, Jun 18, 2014 at 3:44 PM, Jeff King <peff@peff.net> wrote:
> The skip_prefix function returns a pointer to the content
> past the prefix, or NULL if the prefix was not found. While
> this is nice and simple, in practice it makes it hard to use
> for two reasons:
>
>   1. When you want to conditionally skip or keep the string
>      as-is, you have to introduce a second temporary
>      variable. For example:
>
>        tmp = skip_prefix(buf, "foo");
>        if (tmp)
>                buf = tmp;
>
>   2. It is verbose to check the outcome in a conditional, as
>      you need extra parentheses to silence compiler
>      warnings. For example:
>
>        if ((cp = skip_prefix(buf, "foo"))
>                /* do something with cp */
>
> Both of these make it harder to use for long if-chains, and
> we tend to use starts_with instead. However, the first line
> of "do something" is often to then skip forward in buf past
> the prefix, either using a magic constant or with an extra
> strlen (which is generally computed at compile time, but
> means we are repeating ourselves).
>
> This patch refactors skip_prefix to return a simple boolean,
> and to provide the pointer value as an out-parameter. If the
> prefix is not found, the out-parameter is untouched. This
> lets you write:
>
>   if (skip_prefix(arg, "foo ", &arg))
>           do_foo(arg);
>   else if (skip_prefix(arg, "bar ", &arg))
>           do_bar(arg);
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b6f03b3..556c839 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -349,13 +349,31 @@ extern void set_die_is_recursing_routine(int (*routine)(void));
>  extern int starts_with(const char *str, const char *prefix);
>  extern int ends_with(const char *str, const char *suffix);
>
> -static inline const char *skip_prefix(const char *str, const char *prefix)
> +/*
> + * If "str" begins with "prefix", return 1. If out is non-NULL,
> + * it it set to str + strlen(prefix) (i.e., the prefix is skipped).

The documentation claims that 'out' can be NULL, however, the code
does not respect this. NULL 'out' seems rather pointless (unless you
want an alias for starts_with()), so presumably the documentation is
incorrect.

> + *
> + * Otherwise, returns 0 and out is left untouched.
> + *
> + * Examples:
> + *
> + *   [extract branch name, fail if not a branch]
> + *   if (!skip_prefix(ref, "refs/heads/", &branch)
> + *     return -1;
> + *
> + *   [skip prefix if present, otherwise use whole string]
> + *   skip_prefix(name, "refs/heads/", &name);
> + */
> +static inline int skip_prefix(const char *str, const char *prefix,
> +                             const char **out)
>  {
>         do {
> -               if (!*prefix)
> -                       return str;
> +               if (!*prefix) {
> +                       *out = str;
> +                       return 1;
> +               }
>         } while (*str++ == *prefix++);
> -       return NULL;
> +       return 0;
>  }
>
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
