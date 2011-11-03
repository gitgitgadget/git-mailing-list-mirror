From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git rev-parse --since=1970-01-01 does not work reliably
Date: Fri, 4 Nov 2011 06:37:12 +0700
Message-ID: <CACsJy8AewxbocqQ3gvgcrbSuNyKa0BCqDn6OV31m_6-P1AxJCA@mail.gmail.com>
References: <20111031161708.GA29924@altlinux.org> <20111031231320.GA3857@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 00:37:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM6r0-0003jO-Dn
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 00:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033Ab1KCXho convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 19:37:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41491 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab1KCXhn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2011 19:37:43 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so1538802bke.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 16:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=569FZOfOdioz0bLN90d/qj4t0i+2/HPK68ttLz/VIog=;
        b=ojGRRoNcEMMfTz0QAjsiw8Aac5GxsJwPpxiYok7CN13HOULcpa5kA3RUoPj1B089jn
         Sncmb4k3SEnvaB5WJiAWGICQol3S5yv6mS15NqySUaUn2KL4LQFVtHjf6g6RWZNqmKVD
         Rty3tkq8ICi/np20WMaxrJhwzgJCpxg77IKMI=
Received: by 10.204.139.8 with SMTP id c8mr9955831bku.97.1320363463141; Thu,
 03 Nov 2011 16:37:43 -0700 (PDT)
Received: by 10.204.177.79 with HTTP; Thu, 3 Nov 2011 16:37:12 -0700 (PDT)
In-Reply-To: <20111031231320.GA3857@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184752>

2011/11/1 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> Subject: [PATCH] Do not accept negative time_t
>
> We use unsigned long internally to present time, negative value just
> breaks thing.

Junio, what do you think about this patch?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0date.c | =C2=A0 =C2=A08 +++++++-
> =C2=A01 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/date.c b/date.c
> index 353e0a5..9cbd521 100644
> --- a/date.c
> +++ b/date.c
> @@ -653,8 +653,12 @@ int parse_date_basic(const char *date, unsigned =
long *timestamp, int *offset)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*timestamp =3D=3D -1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!tm_gmt)
> + =C2=A0 =C2=A0 =C2=A0 if (!tm_gmt) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((time_t)*times=
tamp < (time_t)*offset * 60)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("unsupported time before Epoch");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*timestamp -=3D=
 *offset * 60;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0; /* success */
> =C2=A0}
>
> @@ -722,6 +726,8 @@ static unsigned long update_tm(struct tm *tm, str=
uct tm *now, unsigned long sec)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D mktime(tm) - sec;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0localtime_r(&n, tm);
> + =C2=A0 =C2=A0 =C2=A0 if (n < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("unsupported t=
ime before Epoch");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return n;
> =C2=A0}
>
> --
> 1.7.4.74.g639db
> -- 8< --
>



--=20
Duy
