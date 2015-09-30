From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Provide a dirname() function when NO_LIBGEN_H=YesPlease
Date: Wed, 30 Sep 2015 11:24:45 -0700
Message-ID: <xmqq8u7n934i.fsf@gitster.mtv.corp.google.com>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 30 20:24:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhM3g-0002AR-O6
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 20:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbbI3SYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 14:24:49 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33294 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932434AbbI3SYr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 14:24:47 -0400
Received: by pacex6 with SMTP id ex6so47903740pac.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8Z8v2SB1G2btbetvlXS7mdxyFfVcfFDk1W/TqBLeJeY=;
        b=IS2SWtrozX4ccWrvdoGegZe5HyXEzqe3dG8BkFCaelU8XS4aFHVV2dYLZsYqB8w/Gh
         CbCweawLRL3QjZQyu4L2edh/30e8Nkm8Ha1CwGSGn2Rn58a1VoGXrcZqsu79i4faBw/o
         YaZM0taO7knyfYWHWte0TBWUMlofuZNUIw9rg4pkve29l1rB8wr3s2nykeiGLrlOKAbN
         urfRd15Di0i3Rzcos2/j2DTRacqA0rlzTDZcuAnaOx1f3effai9fBbptlcJD0TbM7uo1
         3c77uOniCSHH1UjLyQT9MMsAp4nqKvlPhBEfHUTEhfKGZV4kpEHvL4mZEKDi2cMYGEy5
         zpJQ==
X-Received: by 10.66.102.97 with SMTP id fn1mr306468pab.97.1443637486836;
        Wed, 30 Sep 2015 11:24:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id qp5sm1991395pbc.43.2015.09.30.11.24.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 11:24:46 -0700 (PDT)
In-Reply-To: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 30 Sep 2015 16:50:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278850>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> 	I stumbled over the compile warning when upgrading Git for Windows
> 	to 2.6.0. There was a left-over NO_LIBGEN_H=YesPlease (which we
> 	no longer need in Git for Windows 2.x), but it did point to the
> 	fact that we use `dirname()` in builtin/am.c now, so we better
> 	have a fall-back implementation for platforms without libgen.h.

Thanks for being careful.

>
> 	I tested this implementation a bit, but I still would appreciate
> 	a few eye-balls to go over it.
>
>  compat/basename.c | 26 ++++++++++++++++++++++++++
>  git-compat-util.h |  2 ++
>  2 files changed, 28 insertions(+)
>
> diff --git a/compat/basename.c b/compat/basename.c
> index d8f8a3c..10dba38 100644
> --- a/compat/basename.c
> +++ b/compat/basename.c
> @@ -13,3 +13,29 @@ char *gitbasename (char *path)
>  	}
>  	return (char *)base;
>  }
> +
> +char *gitdirname(char *path)
> +{
> +	char *p = path, *slash, c;
> +
> +	/* Skip over the disk name in MSDOS pathnames. */
> +	if (has_dos_drive_prefix(p))
> +		p += 2;

Not a new problem, but many callers of has_dos_drive_prefix()
hardcodes that "2" in various forms.  I wonder if this is something
we should relieve callers of by tweaking the semantics of it, e.g.
by returning 2 (or howmanyever bytes should be skipped) from the
function, changing it to skip_dos_drive_prefix(&p), etc.

> +	/* POSIX.1-2001 says dirname("/") should return "/" */
> +	slash = is_dir_sep(*p) ? ++p : NULL;
> +	while ((c = *(p++)))

I am confused by this.  What is the invariant on 'p' at the
beginning of the body of this while loop in each iteration?

Inside the body, p skips over dir-sep characters, so p must point at
the byte past the last run of slashes?

If that is the invariant, upon entry, shouldn't the initialization
of "slash" be skipping over all slashes, not just the first one,
when the input is "///foo", for example?  Instead the above skips '/'
and sets slash to the byte past the first '/' (which is OK because
you want to NUL-terminate to remove "//foo" from the input) but does
not move p to 'f', so the invariant is not "p must point at the byte
past the last run of slashes".

> +		if (is_dir_sep(c)) {
> +			char *tentative = p - 1;
> +
> +			/* POSIX.1-2001 says to ignore trailing slashes */
> +			while (is_dir_sep(*p))
> +				p++;
> +			if (*p)
> +				slash = tentative;
> +		}

I would have expected the function to scan from the end/right/tail.

> +	if (!slash)
> +		return ".";
> +	*slash = '\0';
> +	return path;
> +}
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f649e81..8b01aa5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -253,6 +253,8 @@ struct itimerval {
>  #else
>  #define basename gitbasename
>  extern char *gitbasename(char *);
> +#define dirname gitdirname
> +extern char *gitdirname(char *);
>  #endif
>  
>  #ifndef NO_ICONV
