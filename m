From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 7/9] strbuf_getwholeline: use getdelim if it is available
Date: Fri, 17 Apr 2015 06:16:48 -0400
Message-ID: <CAPig+cSKtMPQGxp1Y2GinVRh2y--QyJh_nxhDez2CGFPP6B=xg@mail.gmail.com>
References: <20150416084733.GA17811@peff.net>
	<20150416090138.GG17938@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 12:16:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj3KR-0000iP-If
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 12:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbbDQKQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 06:16:50 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:32798 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbbDQKQt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 06:16:49 -0400
Received: by igbpi8 with SMTP id pi8so23036230igb.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LKYh4U4ehtM97RTejFV3jbwqkzKQNXSuik+9Q7MORH8=;
        b=XP1VL/7WOS1KS6k8AKYF5OparzDKG+qmCyymZWKmcV3+wCifaOD1WGUn8CGgQsgIdg
         SKXIdOxS+wKiGeoCRND8z3cRD6jjuPa0GdRkyNAbgAXlaUDaXMQyh7MkZXQqJ29UTu98
         B9Q05WQ+t/F2ov/qRETCkDs2EaLzRaOOMnvZGrMSR5JCv1pYqV1MHPOK0L2u1+bWLPIZ
         zSJatXkj+VsqWKQnHvkvryHIlRKT8NOyBlpe2KGDh+/SJfYGSrNB++kmddIfwig0g6Yj
         Uptl40Dlv3NlZFu7W8i7d3a8e9KYUogDeUbtUSI9Joph+UQoVFiL7DS4cgaOcIPMxbqN
         RTGg==
X-Received: by 10.42.171.8 with SMTP id h8mr2575605icz.25.1429265808364; Fri,
 17 Apr 2015 03:16:48 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 17 Apr 2015 03:16:48 -0700 (PDT)
In-Reply-To: <20150416090138.GG17938@peff.net>
X-Google-Sender-Auth: Zgt4x6k_Sb4GlDib5dcrnAas0sg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267351>

On Thu, Apr 16, 2015 at 5:01 AM, Jeff King <peff@peff.net> wrote:
> We spend a lot of time in strbuf_getwholeline in a tight
> loop reading characters from a stdio handle into a buffer.
> The libc getdelim() function can do this for us with less
> overhead. It's in POSIX.1-2008, and was a GNU extension
> before that. Therefore we can't rely on it, but can fall
> back to the existing getc loop when it is not available.
>
> The HAVE_GETDELIM knob is turned on automatically for Linux,
> where we have glibc. We don't need to set any new
> feature-test macros, because we already define _GNU_SOURCE.
> Other systems that implement getdelim may need to other
> macros (probably _POSIX_C_SOURCE >= 200809L), but we can
> address that along with setting the Makefile knob after
> testing the feature on those systems.
> [...]
>
> Based on a patch from Rasmus Villemoes <rv@rasmusvillemoes.dk>.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> If somebody has a FreeBSD or OS X system to test on, I'd
> love to see what is needed to compile with HAVE_GETDELIM
> there.

Modern Mac OS X, 10.10.x Yosemite, has getdelim() and git builds fine
with HAVE_GETDELIM. I also tested on old Snow Leopard 10.5.8 from
2009. It does not have getdelim(). Unfortunately, I haven't been able
to determine when getdelim() was introduced on the Mac OS X, thus have
been unable to craft a simple rule for config.mak.uname.

> And to confirm that the performance is much better.
> Sharing my 1.6GB packed-refs file would be hard, but you
> should be able to generate something large and ridiculous.
> I'll leave that as an exercise to the reader.
>
> diff --git a/Makefile b/Makefile
> index 5f3987f..36655d5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -359,6 +359,8 @@ all::
>  # compiler is detected to support it.
>  #
>  # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
> +#
> +# Define HAVE_GETDELIM if your system has the getdelim() function.
>
>  GIT-VERSION-FILE: FORCE
>         @$(SHELL_PATH) ./GIT-VERSION-GEN
> @@ -1437,6 +1439,10 @@ ifdef HAVE_BSD_SYSCTL
>         BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
>  endif
>
> +ifdef HAVE_GETDELIM
> +       BASIC_CFLAGS += -DHAVE_GETDELIM
> +endif
> +
>  ifeq ($(TCLTK_PATH),)
>  NO_TCLTK = NoThanks
>  endif
> diff --git a/config.mak.uname b/config.mak.uname
> index f4e77cb..d26665f 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -36,6 +36,7 @@ ifeq ($(uname_S),Linux)
>         HAVE_DEV_TTY = YesPlease
>         HAVE_CLOCK_GETTIME = YesPlease
>         HAVE_CLOCK_MONOTONIC = YesPlease
> +       HAVE_GETDELIM = YesPlease
>  endif
>  ifeq ($(uname_S),GNU/kFreeBSD)
>         HAVE_ALLOCA_H = YesPlease
