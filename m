From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/19] pathspec: mark wildcard pathspecs from the
 beginning
Date: Mon, 13 Dec 2010 10:09:55 -0800
Message-ID: <7vr5dl35os.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 19:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSCqo-0000Mn-So
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 19:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758455Ab0LMSKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 13:10:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab0LMSKJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 13:10:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 645822F20;
	Mon, 13 Dec 2010 13:10:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=bXjHteziNV5H5OvAmSV/dAk9Y
	7I=; b=v+vYPnp7Nz+YKArkdFyAMR4H2C3AIqFoLw2d3tGMtvgGdGGtQ1WbOO3jX
	Th/N7KtF/CxqJQCLlcWxgcv+iRb9mdbhRa+R2j1HNn5yGeKKcLm8mdYb7sWytzm6
	YuzsHDUAVuRslCnzuE79CCzKr32EJkLxjD4s+ds1PLhe04uV8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Lcoelg0dejQ6zO2s7Wi
	rU0eKXEeJ24x2P2BZDIwRdb+c7RvLma62U9wP1db9tQLDuEjSPLclT5HLkHQCpJ+
	C7vSix2LQ3HCtcV/Adwp8GqfX+ZcwsRZWl/x1tuCpr49yLurJaU/T2iNRgRk86wq
	3ec4Vrb7zEVtGfc8jcyasGdY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 344DB2F1B;
	Mon, 13 Dec 2010 13:10:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A50092F1A; Mon, 13 Dec 2010
 13:10:23 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 43D97D02-06E4-11E0-BCAE-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163571>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> diff --git a/dir.c b/dir.c
> index 646c79f..0987d0c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1089,8 +1089,17 @@ int init_pathspec(struct pathspec *pathspec, c=
onst char **paths)
>  	pathspec->items =3D xmalloc(sizeof(struct pathspec_item)*pathspec->=
nr);
>  	for (i =3D 0; i < pathspec->nr; i++) {
>  		struct pathspec_item *item =3D pathspec->items+i;
> -
> -		item->len =3D strlen(paths[i]);
> +		const char *path =3D paths[i];
> +
> +		item->len =3D strlen(path);
> +		item->has_wildcard =3D !no_wildcard(path);
> +		if (item->has_wildcard) {
> +			pathspec->has_wildcard =3D 1;
> +			item->prefix_len =3D 0;
> +			while (item->prefix_len < item->len &&
> +			       strchr("*?[{\\", path[item->prefix_len]) =3D=3D NULL)
> +				item->prefix_len++;
> +		}

Would it make sense to use strcspn(3) here?

>  	}
>  	return 0;
>  }
> --=20
> 1.7.3.3.476.g10a82
