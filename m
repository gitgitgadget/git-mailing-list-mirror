From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 3/3] unpack-trees: free created cache entries
Date: Thu, 30 May 2013 16:49:20 +0200
Message-ID: <51A766F0.3030408@lsrfire.ath.cx>
References: <1369920861-30030-1-git-send-email-felipe.contreras@gmail.com> <1369920861-30030-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 16:49:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui4AT-0005DX-MH
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 16:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933139Ab3E3Ot0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 10:49:26 -0400
Received: from india601.server4you.de ([85.25.151.105]:57657 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932733Ab3E3OtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 10:49:25 -0400
Received: from [192.168.2.105] (p579BEB6E.dip0.t-ipconnect.de [87.155.235.110])
	by india601.server4you.de (Postfix) with ESMTPSA id E2FE81FF;
	Thu, 30 May 2013 16:49:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1369920861-30030-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226005>

Am 30.05.2013 15:34, schrieb Felipe Contreras:
> We created them, and nobody else is going to destroy them.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>   unpack-trees.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index eff2944..9f19d01 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -590,8 +590,16 @@ static int unpack_nondirectories(int n, unsigned=
 long mask,
>   		src[i + o->merge] =3D create_ce_entry(info, names + i, stage);
>   	}
>
> -	if (o->merge)
> -		return call_unpack_fn(src, o);
> +	if (o->merge) {
> +		int ret =3D call_unpack_fn(src, o);
> +		for (i =3D 0; i < n; i++) {
> +			struct cache_entry *ce =3D src[i + o->merge];
> +			if (!ce || ce =3D=3D o->df_conflict_entry)
> +				continue;
> +			free(ce);
> +		}
> +		return ret;
> +	}

Ah, now I understand what you meant in that other email.  That works as=
=20
well, of course.  It's slightly nicer on the eye, admittedly.

Ren=C3=A9
