From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] argv_array: add argv_array_copy
Date: Thu, 6 Aug 2015 14:18:26 -0400
Message-ID: <CAPig+cQ3bAML7WMyS3Q1YQCjR2SfgB47AEkTmqbycAJcig0=tg@mail.gmail.com>
References: <1438882524-21215-1-git-send-email-sbeller@google.com>
	<1438882524-21215-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 20:18:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNPkO-0002rq-Qp
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 20:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359AbbHFSS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 14:18:28 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35180 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbbHFSS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 14:18:27 -0400
Received: by ykcq64 with SMTP id q64so64661849ykc.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 11:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OtKjjXnIeW8rGtikDGU+r0YyO+/JOZgK1NxVnGygnJ8=;
        b=KaJ5faZUIVPzsuJLnayG5tWt0nA+JDvHrfGZXR7H44pYW/whXhCwISZGNvVepQjkow
         qKNDqEuAMiY/nwNogdoDBd/15apeHZ206zJKWcG2wdaZ2mhBI8Osy32NNKPNip1nJ4cD
         n/cDXSbpaFaLjrn/I3ktXHutlSFZyOOODx+I3KtXWGQqCAuLRaY8qtdgyKMn5YmwUBkv
         ToOIIrpPfyj1HRQMU75dTFOt6KFBsgeHt877p1S0b0F8DzrY6zJqSgT13DTD6l+OFAXC
         jkZKyIkGFocUOy+AJJfuK3kJ4l45hNaqzYFXZAqVvKICKoDZB4vO1mAxPiz6SlZqs1iP
         RBCA==
X-Received: by 10.13.221.213 with SMTP id g204mr3540649ywe.48.1438885106844;
 Thu, 06 Aug 2015 11:18:26 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 11:18:26 -0700 (PDT)
In-Reply-To: <1438882524-21215-4-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: rblYEQHDcsJpADruhoy3Cer37Qo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275431>

On Thu, Aug 6, 2015 at 1:35 PM, Stefan Beller <sbeller@google.com> wrote:
> The copied argv array shall be an identical deep copy except for
> the internal allocation value.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/argv-array.c b/argv-array.c
> index 256741d..6d9c1dd 100644
> --- a/argv-array.c
> +++ b/argv-array.c
> @@ -68,3 +68,16 @@ void argv_array_clear(struct argv_array *array)
> +void argv_array_copy(struct argv_array *src, struct argv_array *dst)

'src' should be 'const'.

Typical Unix argument order has 'dst' first and 'src' second, i.e
strcpy(dst, src). Is it worth deviating from that precedent?

> +{
> +       int i;
> +
> +       dst->argv = xmalloc((src->argc + 1) * sizeof(*dst->argv));

What happens if 'dst' already has content? Isn't that being leaked
here? At the very least, don't you want to argv_array_clear(dst)?

> +       dst->argc = src->argc;
> +       dst->alloc = src->argc;

This is wrong, of course. The number allocated is actually argc+1, not argc.

> +       for (i = 0; i < dst->argc ; i++)

While it's not wrong per se to use dst->argc as the terminating
condition, it is potentially misleading and confusing. Instead using
src->argc as the terminating condition will better telegraph that the
copy process is indeed predicated upon 'src'.

> +               dst->argv[i] = xstrdup(src->argv[i]);
> +       dst->argv[dst->argc] = NULL;

It's not clear why you want to hand-code the low-level functionality
again (such as array allocation and string duplication), risking (and
indeed making) errors in the process, when you could instead re-use
existing argv_array code. I would have expected to see
argv_array_copy() implemented as:

    argv_array_clear(dst);
    for (i = 0; i < src->argc; i++)
        argv_array_push(dst, src->argv[i]);

which provides far fewer opportunities for errors to creep in.

Moreover, this function might be too special-purpose. That is, why
does it need to overwrite 'dst'? Can't you achieve the same
functionality by merely appending to 'dst', and leave it up to the
caller to decide whether 'dst' should be cleared beforehand or not? If
so, then you can drop the argv_array_clear(dst) from the above.

However, that begs the question: Why do you need argv_array_copy() at
all? Isn't the same functionality already provided by
argv_array_pushv()? To wit, a caller which wants to copy from 'src' to
'dst' can already do:

    struct argv_array src = ...;
    struct argv_array dst = ARGV_ARRAY_INIT;
    argv_array_pushv(&dst, src->argv);

> +}
> +
> diff --git a/argv-array.h b/argv-array.h
> index c65e6e8..247627da 100644
> --- a/argv-array.h
> +++ b/argv-array.h
> @@ -19,5 +19,6 @@ LAST_ARG_MUST_BE_NULL
>  void argv_array_pushl(struct argv_array *, ...);
>  void argv_array_pop(struct argv_array *);
>  void argv_array_clear(struct argv_array *);
> +void argv_array_copy(struct argv_array *src, struct argv_array *dst);
>
>  #endif /* ARGV_ARRAY_H */
> --
> 2.5.0.239.g9728e1d.dirty
