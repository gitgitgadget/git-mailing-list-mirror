From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/19] Convert ce_path_match() use to match_pathspec()
Date: Mon, 13 Dec 2010 11:31:51 -0800
Message-ID: <7vsjy1zcyg.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 20:32:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSE8H-0001EU-IJ
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 20:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009Ab0LMTcB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 14:32:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab0LMTb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 14:31:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 049A73AF9;
	Mon, 13 Dec 2010 14:32:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=bNVMPqGSAKgHgo87DNrni9aZo
	64=; b=aNrU4XBECa9uekUZf4b9FYwqoNq+wIDnyBsRNREbEnKFerxzAYQx5iwWM
	dbGWdOG4CotU6fczZeNfR2M5K81y0QtM4XNZb5OGmtnP67Fg07U7Mn+v5mPr9N2Z
	VT/1/gzZk0UYFarSnaPTeEdM32hcLa33RxLx9qrJPS+jEIGciU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=obTIPt7dJtXYmdPa3G4
	CFT7f0KHD9Q7zf0bUPYcdbPW9nGmVxzwfwHpeIzgsduFzzPM4fkXI2xtKqXMPUeB
	dOnIrTk7PvTax/sOxnAdPdxt6iJbkj+f8yVsNtRpmJeQzEdnfvlIPWrRMoaFPanQ
	Vy+09pIOitoDOkZqsb6dheJE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D81673AF8;
	Mon, 13 Dec 2010 14:32:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9F0A13AF7; Mon, 13 Dec 2010
 14:32:18 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B4A0104A-06EF-11E0-AA6B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163585>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Previously ce_path_match() is used together with tree_entry_interesti=
ng().
> Both do not support wildcards. tree_entry_interesting() understands
> wildcards now, so it's time to teach ce_path_match() to do the same.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

This function is called from both Porcelains (e.g. "git diff" via
diff-lib.c and "git status" via wt-status.c) and plumbing commands
(e.g. "git update-index"), and we are changing the semantics in a big w=
ay,
even though it is a huge improvement.

I am fairly excited with the progress of this series.  When it gets mer=
ged
to 'master', we will be declaring 1.8.0 ;-)

I imagine that eventually ce_path_match() will also take "struct pathsp=
ec *"
not "const char **" when the series is completed, yes?  Or there is no
real need for that?

>  read-cache.c |   20 +-------------------
>  1 files changed, 1 insertions(+), 19 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 1f42473..cbabd8b 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -685,28 +685,10 @@ int ce_same_name(struct cache_entry *a, struct =
cache_entry *b)
> =20
>  int ce_path_match(const struct cache_entry *ce, const char **pathspe=
c)
>  {
> -	const char *match, *name;
> -	int len;
> -
>  	if (!pathspec)
>  		return 1;
> =20
> -	len =3D ce_namelen(ce);
> -	name =3D ce->name;
> -	while ((match =3D *pathspec++) !=3D NULL) {
> -		int matchlen =3D strlen(match);
> -		if (matchlen > len)
> -			continue;
> -		if (memcmp(name, match, matchlen))
> -			continue;
> -		if (matchlen && name[matchlen-1] =3D=3D '/')
> -			return 1;
> -		if (name[matchlen] =3D=3D '/' || !name[matchlen])
> -			return 1;
> -		if (!matchlen)
> -			return 1;
> -	}
> -	return 0;
> +	return match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL);
>  }
> =20
>  /*
> --=20
> 1.7.3.3.476.g10a82
