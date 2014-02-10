From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 1/2] daemon: move daemonize() to libgit.a
Date: Mon, 10 Feb 2014 12:04:58 +0100
Message-ID: <CABPQNSaNuCM5mNFF_74OPo+RYqZHgUPpw0k5HbaL=p54j48i4g@mail.gmail.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com> <1391843332-20583-1-git-send-email-pclouds@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, jugg@hotmail.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 12:05:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCogJ-0006R5-1e
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 12:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbaBJLFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Feb 2014 06:05:39 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:53550 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbaBJLFi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Feb 2014 06:05:38 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so6975542obc.39
        for <git@vger.kernel.org>; Mon, 10 Feb 2014 03:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=3s2ceCE6kFNlw35jROwWMi+h9SB4DX+ZDcKvJDZ13Qw=;
        b=qESYD/CJ32rjH9mmISLugEYwUPnm0f3a7YOtqla2lULCLfLOv/fiYX+Pa2gnZp+pCU
         x5T2i4AIyVj4YX27D4ibFVFkdC9Kms8T4dqLebGBLbVjK4ik0667VVqNAuQD9xjhmq9e
         eVivsEiD8fTmR/a1DyHwuhS83Cdp+tDokKFffcwPOhf3FVCKXaRZGUKixXc3cVnlZIUt
         UyJ5XBEUBvOljelBoaLYUgbia6kvPRVXuFilvtZDm2ccup26uFG6gqSz4iDtk4SUknqS
         UFx/Os8FDzKXksKX1Rgd5y1gB6M+OGKw6NFLBGclpkg3bh6C5Je08LIjHqry6t3Yi3BK
         6uOA==
X-Received: by 10.182.223.37 with SMTP id qr5mr6249702obc.41.1392030338179;
 Mon, 10 Feb 2014 03:05:38 -0800 (PST)
Received: by 10.76.85.103 with HTTP; Mon, 10 Feb 2014 03:04:58 -0800 (PST)
In-Reply-To: <1391843332-20583-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241908>

On Sat, Feb 8, 2014 at 8:08 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> diff --git a/setup.c b/setup.c
> index 6c3f85f..b09a412 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -787,3 +787,27 @@ void sanitize_stdfds(void)
>         if (fd > 2)
>                 close(fd);
>  }
> +
> +int daemonize(void)
> +{
> +#ifdef NO_POSIX_GOODIES
> +       errno =3D -ENOSYS;
> +       return -1;
> +#else
> +       switch (fork()) {
> +               case 0:
> +                       break;
> +               case -1:
> +                       die_errno("fork failed");
> +               default:
> +                       exit(0);
> +       }
> +       if (setsid() =3D=3D -1)
> +               die_errno("setsid failed");
> +       close(0);
> +       close(1);
> +       close(2);
> +       sanitize_stdfds();
> +       return 0;
> +#endif
> +}

Nice change.

Just a nit: When I added the NO_POSIX_GOODIES-flag, Junio wanted the
implementations to be separate.
