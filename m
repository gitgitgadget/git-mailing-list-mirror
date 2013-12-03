From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RESEND] transport.c: mark push status strings for
 translation
Date: Tue, 3 Dec 2013 12:08:57 -0800
Message-ID: <20131203200857.GE29959@google.com>
References: <1386066409-15262-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 21:09:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnwHL-0006YO-Oh
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 21:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab3LCUJE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 15:09:04 -0500
Received: from mail-yh0-f47.google.com ([209.85.213.47]:36454 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827Ab3LCUJC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 15:09:02 -0500
Received: by mail-yh0-f47.google.com with SMTP id 29so10453160yhl.6
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 12:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jkDEdqwpurgUEdZp7DpoGXVTKWHZaAZC1K7Rv1Y53KI=;
        b=xvezFhglAc0XFlOVQ5a4WoCjedih/88bFZvEhYNDcY5lWw6Y3123XzLQ9YzNF15BQ4
         8tV7u075zXO/05c4j8x2JDsAdkJ1uAX40YYq4xVBJb0SImwy35tHglcD9Hdp/+XRfERs
         5z/sg3iV8poVCd/QjcInZ9kIGWOgzzSPEtGe6BQT62S0ypFhKHXOiIF2evSkrZesULFp
         DCF8EK62N0kRA1/hIB+KVzWDRhQzr/b+2180HjGzjUy9XocrxPUSR/Y4arl24nSQSX0d
         BjkH+QciOKXWod8dJrOjA4v9omyqMrEOuESulal9OWcBl7MiVb6cHObum2ECKoOXP7QW
         lDbQ==
X-Received: by 10.236.117.144 with SMTP id j16mr37444049yhh.19.1386101340508;
        Tue, 03 Dec 2013 12:09:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e39sm135689221yhq.15.2013.12.03.12.08.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 12:09:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386066409-15262-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238729>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Mark strings like "[up to date]" passed to print_ref_status() for
> translation with N_() instead of _() so they can remain untranslated
> in porcelain mode.

Makes sense.

[...]
> --- a/builtin/push.c
> +++ b/builtin/push.c

Perhaps it would make sense to send these as a separate patch, since
they are simpler than the rest.

[...]
> --- a/transport.c
> +++ b/transport.c
> @@ -14,6 +14,7 @@
>  #include "url.h"
>  #include "submodule.h"
>  #include "string-list.h"
> +#include "utf8.h"
> =20
>  /* rsync support */
> =20
> @@ -627,16 +628,23 @@ static void print_ref_status(char flag, const c=
har *summary, struct ref *to, str
>  		else
>  			fprintf(stdout, "%s\n", summary);
>  	} else {
> -		fprintf(stderr, " %c %-*s ", flag, TRANSPORT_SUMMARY_WIDTH, summar=
y);
> +		int width =3D TRANSPORT_SUMMARY_WIDTH;
> +		const char *localized_summary =3D _(summary);

The summary arg comes from one of a few places:

 (a) [deleted] etc from print_ok_ref_status, which you marked
     with N_ (good)

 (b) deadbe... from status_abbrev via print_ok_ref_status.  Can we
     avoid passing it to gettext()?

 (c) [no match] etc from print_one_push_status, marked with
     N_ (good)

I am tempted to suggest something like

		const char *localized_summary;

		if (*summary !=3D '[')
			/* Leave abbreviated sha1 from status_abbrev() alone */
			localized_summary =3D summary;
		else
			localized_summary =3D _(summary);

but that's kind of ugly.  Is there a simpler way?  Should the summary
arg be passed in already localized (with 'porcelain' handling higher
up)?

Thanks,
Jonathan
