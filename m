From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/5] gitweb: Move check-ref-format code into separate function
Date: Wed, 4 Dec 2013 16:56:22 +0100
Message-ID: <CANQwDwfWPuH_OOU46yOrRN23qbppHBQbXEUnDcR37dF=93A-iA@mail.gmail.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com> <1386164583-14109-3-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 16:57:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoEpL-00038W-4W
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 16:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754Ab3LDP5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 10:57:22 -0500
Received: from mail-we0-f175.google.com ([74.125.82.175]:33034 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642Ab3LDP5E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 10:57:04 -0500
Received: by mail-we0-f175.google.com with SMTP id p61so15006128wes.6
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 07:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Ruix/cGZEj0bvn2OHUNDlbmV2FJu87arKl1E7Zd8p7E=;
        b=yUPMde26VQhMXvBDGGq7pqZctr66mwbNzVPWjslfOz0N9ltcP/TMOaMN2q1YnGtX3Q
         l2XvjhB8z1hycCvOTXUVH3SQnXWJKr51j5M8d+n/MYfnGuxYSvUjIHyIHw2EdAEp5ywc
         N/QcZLS00tK/zb2A0f3N4NUkp26MDrEY1H3KKXl28roo9rStMvteMKPVacZsMWLKoHPH
         RNxdvBmLoy3AVKv5NZxI9QO4tp5dnLqhRgJT6HYxZfIwLE28sjYdX8QbhLcWE9BCmqTE
         XJl7b/4EANR/zCZNSgt0B4Ckc8MbH49DErBrjxfnX42pi6/fcME/sPCcCVAmA0ChBhvj
         9PJg==
X-Received: by 10.180.188.229 with SMTP id gd5mr7975342wic.38.1386172622969;
 Wed, 04 Dec 2013 07:57:02 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Wed, 4 Dec 2013 07:56:22 -0800 (PST)
In-Reply-To: <1386164583-14109-3-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238786>

On Wed, Dec 4, 2013 at 2:43 PM, Krzesimir Nowak <krzesimir@endocode.com=
> wrote:

> This check will be used in more than one place later.
>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

All right, that is nice refactoring.

> ---
>  gitweb/gitweb.perl | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ee61f9e..67415b9 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1452,6 +1452,16 @@ sub validate_pathname {
>         return $input;
>  }
>
> +sub check_ref_format {
> +       my $input =3D shift || return undef;
> +
> +       # restrictions on ref name according to git-check-ref-format
> +       if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> +               return undef;
> +       }
> +       return $input;
> +}
> +
>  sub validate_refname {
>         my $input =3D shift || return undef;
>
> @@ -1462,10 +1472,9 @@ sub validate_refname {
>         # it must be correct pathname
>         $input =3D validate_pathname($input)
>                 or return undef;
> -       # restrictions on ref name according to git-check-ref-format
> -       if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> -               return undef;
> -       }
> +       # check git-check-ref-format restrictions
> +       check_ref_format($input)
> +               or return undef;
>         return $input;
>  }

Right, check_ref_format() has name after git-check-ref-format...
though... check_ref_format() or die  doesn't read completely
naturally...

--=20
Jakub Narebski
