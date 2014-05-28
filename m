From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH 1/5] progress.c: replace signal() with sigaction()
Date: Wed, 28 May 2014 20:07:38 +1200
Message-ID: <5385994A.5040507@gmail.com>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com> <1401257655-6043-2-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 10:07:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpYts-0002MK-2f
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 10:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbaE1IHq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 04:07:46 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:64971 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbaE1IHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 04:07:42 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so10749535pbb.20
        for <git@vger.kernel.org>; Wed, 28 May 2014 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=93qclitH+mVuw5+y0pcReWQLK+Z97k/IeMKrvG+YjQ8=;
        b=jOuh0Cs9FrPljcErcZXvGuFW8hnIgQep92Oqih7GigEp3GlJcH+Fh3l7iCPiIU26tp
         W1k1sMIjFlAaDhc7XBQnCX77STEJcXQ62TeNuZ0rYOh0h8gm6QOIZIxSkFz+Snu5G2ir
         LokIitCWZxwOMYiAHOuqAGEEvg2ytcmMWbI2Ooyjce4/t+fPk3M50ltSI4wVJKbjEmN7
         LWg3/6C2Gb/nw6XwYQfZG4U0OZlDJ6lVFcwYFUrlUpV1MSG/GbUwCPE4ftlMe8XRvakr
         +q01sdwRHiLsHV7wctSIjoCG4iCaHxHGBxDcJItZuaTGWIpshvKOqgCggqE3PRyKLoX+
         pXEw==
X-Received: by 10.66.66.72 with SMTP id d8mr44498399pat.8.1401264462242;
        Wed, 28 May 2014 01:07:42 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id zv3sm85220426pab.20.2014.05.28.01.07.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 28 May 2014 01:07:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401257655-6043-2-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250270>

On 28/05/14 18:14, Jeremiah Mahler wrote:
> From signal(2)
>=20
>   The behavior of signal() varies across UNIX versions, and has also =
var=E2=80=90
>   ied historically across different versions of Linux.   Avoid  its  =
use:
>   use sigaction(2) instead.  See Portability below.

Minor nit. The last sentence applies to the man page you're quoting and
doesn't really make sense when viewed in the context of this commit
message. Same applies to other patches in this series.

>=20
> Replaced signal() with sigaction() in progress.c
>=20
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  progress.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/progress.c b/progress.c
> index 261314e..24df263 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -66,8 +66,12 @@ static void set_progress_signal(void)
>  static void clear_progress_signal(void)
>  {
>  	struct itimerval v =3D {{0,},};
> +	struct sigaction sa;
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_handler =3D SIG_IGN;

A C99 initialiser here would save the call to memset. Unfortunately
Documentation/CodingGuidelines is fairly clear on not using C99
initialisers, given the fact we're now at git 2.0 maybe it's time to
revisit this policy?

>  	setitimer(ITIMER_REAL, &v, NULL);
> -	signal(SIGALRM, SIG_IGN);
> +	sigaction(SIGALRM, &sa, 0);
>  	progress_update =3D 0;
>  }
> =20
>=20
