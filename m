From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Extend index to save more flags
Date: Mon, 01 Sep 2008 15:05:05 +0200
Message-ID: <48BBE881.1050206@viscovery.net>
References: <1220268758-29550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 15:06:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka96m-0007nv-RA
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 15:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbYIANFK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 09:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbYIANFK
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 09:05:10 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:2238 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbYIANFJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2008 09:05:09 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ka95e-0002F4-3V; Mon, 01 Sep 2008 15:05:06 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D3D0654D; Mon,  1 Sep 2008 15:05:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1220268758-29550-1-git-send-email-pclouds@gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94581>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> +/* Extended flags in ondisk_cache_entry_extended */
> +#define CE_EXTENDED2 (0x80000000)
> +#define CE_EXTENDED_MASK (CE_EXTENDED2)

Wouldn't it be better, from a maintainance point of view, to have

#define CE_EXTENDED_MASK 0xffff0000

right from the beginning?

> @@ -1143,19 +1144,29 @@ static void convert_from_disk(struct ondisk_c=
ache_entry *ondisk, struct cache_en
>  	/* On-disk flags are just 16 bits */
>  	ce->ce_flags =3D ntohs(ondisk->flags);
> =20
> -	/* For future extension: we do not understand this entry yet */
> -	if (ce->ce_flags & CE_EXTENDED)
> -		die("Unknown index entry format");
>  	hashcpy(ce->sha1, ondisk->sha1);
> =20
>  	len =3D ce->ce_flags & CE_NAMEMASK;
> +
> +	if (ce->ce_flags & CE_EXTENDED) {
> +		struct ondisk_cache_entry_extended *ondisk2;
> +		ondisk2 =3D (struct ondisk_cache_entry_extended *)ondisk;
> +		ce->ce_flags |=3D (ntohs(ondisk2->flags2) << 16) & CE_EXTENDED_MAS=
K;
> +		/* For future extension: we do not understand the last bit yet */
> +		if (ce->ce_flags & CE_EXTENDED2)
> +			die("Unknown index entry format");

At this point, we do not understand the CE_EXTENDED2 flag; but we do no=
t
understand any of the other 15 extended flags, either. So, you should
error out if *any* of them is non-zero.

> +		name =3D ondisk2->name;
> +	}
> +	else
> +		name =3D ondisk->name;

-- Hannes
