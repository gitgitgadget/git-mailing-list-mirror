From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Thu, 17 Nov 2011 16:05:52 +0530
Message-ID: <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com> <1321522335-24193-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 11:36:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQzKT-0002CN-Gc
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 11:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab1KQKgP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 05:36:15 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41573 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756511Ab1KQKgO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 05:36:14 -0500
Received: by wyh11 with SMTP id 11so1760790wyh.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 02:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VbxheZ2mnD+if5If/pfm4zc8uKwaTeiyMTnPNUxJbnQ=;
        b=Q3jvBMyoqKpMOPbiLIQnX+8dQ/0EJKp+6JfkCQScr+6P5DoO7GV9BwbaahLgY9Wgmv
         28vObeqMZ4St/m0RyX9VXn+2wMzMvlPoGHxAE8E1RwR7QGu+gTvElBmF8j7sEHRIDgAF
         C48GglwXbD+5qmi6MG0TmmwARYrXW5nh6+u3U=
Received: by 10.227.207.205 with SMTP id fz13mr24487785wbb.0.1321526173160;
 Thu, 17 Nov 2011 02:36:13 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Thu, 17 Nov 2011 02:35:52 -0800 (PST)
In-Reply-To: <1321522335-24193-9-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185591>

Hi Nguy=E1=BB=85n,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy writes:
> diff --git a/cache.h b/cache.h
> index feb44a5..66365fb 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -661,10 +661,13 @@ extern char *git_pathdup(const char *fmt, ...)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__attribute__((format (printf, 1, 2)));
>
> =C2=A0/* Return a statically allocated filename matching the sha1 sig=
nature */
> -extern char *mkpath(const char *fmt, ...) __attribute__((format (pri=
ntf, 1, 2)));
> -extern char *git_path(const char *fmt, ...) __attribute__((format (p=
rintf, 1, 2)));
> -extern char *git_path_submodule(const char *path, const char *fmt, .=
=2E.)
> - =C2=A0 =C2=A0 =C2=A0 __attribute__((format (printf, 2, 3)));
> +#define mkpath(...) mkpath_real(__FUNCTION__, __LINE__, __VA_ARGS__)
> +extern char *mkpath_real(const char *file, int line, const char *fmt=
, ...) __attribute__((format (printf, 3, 4)));
> +#define git_path( ...) git_path_real(__FUNCTION__, __LINE__, __VA_AR=
GS__)
> +extern char *git_path_real(const char *file, int line, const char *f=
mt, ...) __attribute__((format (printf, 3, 4)));
> +#define git_path_submodule(path, ...) git_path_submodule_real(__FUNC=
TION__, __LINE__, path, __VA_ARGS__)
> +extern char *git_path_submodule_real(const char *file, int line, con=
st char *path, const char *fmt, ...)
> + =C2=A0 =C2=A0 =C2=A0 __attribute__((format (printf, 4, 5)));

The macros __FILE__, __LINE__ and __VA_ARGS__ are gcc-specific
extensions, no?  I was curious to see if some other parts of Git are
using this: a quick grep returns mailmap.c and notes-merge.c.  They
both use __VA_ARGS__ it for debugging purposes.  So, nothing new.

What happens if GIT_DEBUG_MEMCHECK is set, but I'm not using gcc?
Also, it's probably worth mentioning in the commit message that this
debugging trick is gcc-specific.

Thanks for working on this.

-- Ram
