From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 3/3] get_sha1: support relative path ":path" syntax
Date: Sun, 14 Nov 2010 18:22:14 -0200
Message-ID: <AANLkTimJKQ=xc7az+FEM+18aTxQ5zQ24q7pfChnSwt6f@mail.gmail.com>
References: <1289484484-8632-1-git-send-email-pclouds@gmail.com>
	<1289484484-8632-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Matthieu.Moy@grenoble-inp.fr
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 21:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHj5i-0004sY-A3
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 21:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab0KNUWQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 15:22:16 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65095 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942Ab0KNUWP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 15:22:15 -0500
Received: by bwz15 with SMTP id 15so4637772bwz.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sEAgZhUfy88kIuduhzYvsltGedEWT0E/443cRhFLNXA=;
        b=v+iES/JgDgnWrYUBvYcOAR9wjOPMRuWWFge83arGsVJb/gmOzuDz6vqRNs1YauquNC
         9zMjpbjTSQNPa5kmFNIntwUyou9zav9FpcwZ6yEZX6GeZPRNP5nirDRZzeeP2ckHQhhB
         3mUWyATZ13UO4W73IabW6wvs0uOGWa9hZa21o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kDAPzakCpHikz82rvObkeD/BA3kJQGif00cl6owH93YYMTzbZKN/MeVViwl6juX8Vh
         TbWQnqWy+1k1JJjhykYcR9rDpp32KRhrLpd2TY+D+ZPRMb/kF3LDSJUs4BlaEEPdO6K0
         jcTPaK0uoKOYTjjAwDfIzuz4C2uumTBjYnPCc=
Received: by 10.204.61.81 with SMTP id s17mr5257880bkh.121.1289766134348; Sun,
 14 Nov 2010 12:22:14 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Sun, 14 Nov 2010 12:22:14 -0800 (PST)
In-Reply-To: <1289484484-8632-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161437>

2010/11/11 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
> Currently :path and ref:path can be used to refer to a specific objec=
t
> in index or ref respectively. "path" component is absolute path. This
> patch allows "path" to be written as "./path" or "../path", which is
> relative to user's original cwd.
>
> This does not work in commands for which startup_info is NULL
> (i.e. non-builtin ones, it seems none of them needs this anyway).
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0sha1_name.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 37 ++++++++++++++++++++++--
> =C2=A0t/t1506-rev-parse-diagnosis.sh | =C2=A0 62 ++++++++++++++++++++=
++++++++++++++++++++
> =C2=A02 files changed, 96 insertions(+), 3 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 484081d..22c1df9 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1046,6 +1046,23 @@ int get_sha1_with_mode_1(const char *name, uns=
igned char *sha1, unsigned *mode,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> +static char *resolve_relative_path(const char *rel)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (prefixcmp(rel, "./") && prefixcmp(rel, "..=
/"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!startup_info)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Relative path=
 syntax is not supported in this command. Please report.");
Is the "Please report." necessary? Report to who? Where? (I know we
know these answers, but maybe a new user won't know them).

> +
> + =C2=A0 =C2=A0 =C2=A0 if (!is_inside_work_tree())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("relative path=
 syntax can't be used outside working tree.");
nit: s/relative/Relative ?
