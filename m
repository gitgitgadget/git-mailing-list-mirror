From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: no crc check when the cached version is used
Date: Fri, 13 Sep 2013 11:28:05 -0700
Message-ID: <xmqq7gekk24q.fsf@gitster.dls.corp.google.com>
References: <1379070180-15947-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 20:28:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKY6i-0001mK-7Y
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 20:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab3IMS2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Sep 2013 14:28:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897Ab3IMS2J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Sep 2013 14:28:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06C05418D3;
	Fri, 13 Sep 2013 18:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ugwBD85KHXUV
	T7qYKPukzCqA1Qg=; b=JBlV7AKwa81dEEf5RlUTxw4eRz27L3QRHofPMBhEzbrv
	woyx7MG9S3s/omT2vz5fFoOdiIB4tPMRPITnhCfU0ApTQV8WJ9Vm9lz/b2ZbaV/t
	achq2TUyNDCpUeHNLM3siu05J2xHWKFmDta7t7b40CkYNZFMKmcArMlngFZgVL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=h334Jl
	sW8SBoCjNG96sxupX1eaG1zgyeUz8/zvi3MKP+l7iuCWlhTgoihzO3dSKGKkw7dV
	DuiKKzhTftdbdajKyPacGX+B3DoYWo4N/DDlZOhWz8cGQ4u+/tNYtFnbxh5g58Xr
	8CiHA5lwukZhXhPWIu6FLWUkr5tUF75B2NUFY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE7EC418D2;
	Fri, 13 Sep 2013 18:28:08 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 586EB418CE;
	Fri, 13 Sep 2013 18:28:08 +0000 (UTC)
In-Reply-To: <1379070180-15947-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 13
 Sep 2013 18:03:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3CED654A-1CA2-11E3-95CE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234760>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Current code makes pack-objects always do check_pack_crc() in
> unpack_entry() even if right after that we find out there's a cached
> version and pack access is not needed. Swap two code blocks, search
> for cached version first, then check crc.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Interesting.

This is only triggered inside pack-objects, which would read a lot
of data from existing packs, and the overhead for looking up the
entry from the revindex, faulting in the actual packdata, and
computing and comparing the crc would not be trivial, especially as
the cost is incurred over many objects we need to untangle in the
delta chain.  If you have interesting numbers to show how much this
improves the performance, I am curious to see it.

Good spotting ;-)

>  sha1_file.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 8c2d1ed..4955724 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2126,6 +2126,16 @@ void *unpack_entry(struct packed_git *p, off_t=
 obj_offset,
>  		int i;
>  		struct delta_base_cache_entry *ent;
> =20
> +		ent =3D get_delta_base_cache_entry(p, curpos);
> +		if (eq_delta_base_cache_entry(ent, p, curpos)) {
> +			type =3D ent->type;
> +			data =3D ent->data;
> +			size =3D ent->size;
> +			clear_delta_base_cache_entry(ent);
> +			base_from_cache =3D 1;
> +			break;
> +		}
> +
>  		if (do_check_packed_object_crc && p->index_version > 1) {
>  			struct revindex_entry *revidx =3D find_pack_revindex(p, obj_offse=
t);
>  			unsigned long len =3D revidx[1].offset - obj_offset;
> @@ -2140,16 +2150,6 @@ void *unpack_entry(struct packed_git *p, off_t=
 obj_offset,
>  			}
>  		}
> =20
> -		ent =3D get_delta_base_cache_entry(p, curpos);
> -		if (eq_delta_base_cache_entry(ent, p, curpos)) {
> -			type =3D ent->type;
> -			data =3D ent->data;
> -			size =3D ent->size;
> -			clear_delta_base_cache_entry(ent);
> -			base_from_cache =3D 1;
> -			break;
> -		}
> -
>  		type =3D unpack_object_header(p, &w_curs, &curpos, &size);
>  		if (type !=3D OBJ_OFS_DELTA && type !=3D OBJ_REF_DELTA)
>  			break;
