From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/19] read-cache: allow to keep mmap'd memory after reading
Date: Wed, 09 Mar 2016 15:02:01 -0800
Message-ID: <xmqqziu7fe6u.fsf@gitster.mtv.corp.google.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	<1457548582-28302-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 00:02:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adn7O-0004Mb-5U
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 00:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbcCIXCK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 18:02:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752167AbcCIXCG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2016 18:02:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9507E4A0E8;
	Wed,  9 Mar 2016 18:02:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+cBY/sJB/N7E
	I5Cd9RrekAy38Ks=; b=p6b5eBmmvDGvIVOSGWIuaKjms08SfJVRWW7+N7BnHHul
	vDMQF7b3ZsB3Nt3SY1loGrVGrg7M5H4GWUjg30s+5Mv05FQ2qn45N66y5xgyCpzO
	8uda5ctP0CliMBo8RlrKaFVNuHHcc7yPxV8ZPRyKizdSqFrlgc01gngXWK6jsmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RlVwKf
	ggOoCR4RwmpA80S7qu5lKlPrFT9oMgQlhPlNOoXvy/soB8nUOU4DcS8LcdiSVrc/
	rR9w7r5CRWuvz/qjS748kAmTuYfG+hW7EzwAysInPVGeBLoVRlRFR8b6SPbD5CRH
	qVcvtPxZCns9khYFmMyzx1k6OKHzY6VtklIAQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C9144A0E7;
	Wed,  9 Mar 2016 18:02:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3328F4A0E1;
	Wed,  9 Mar 2016 18:02:03 -0500 (EST)
In-Reply-To: <1457548582-28302-4-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 9 Mar 2016 13:36:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EFF1B0AA-E64A-11E5-9FA2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288580>

David Turner <dturner@twopensource.com> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

As usual in Duy's patches, this one seriously lacks "why".  And also
makes the reader wonder if the memory region is ever unmapped() and
if so under what condition.

> diff --git a/cache.h b/cache.h
> index 7e01403..c43ef3d 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -333,11 +333,14 @@ struct index_state {
>  	struct split_index *split_index;
>  	struct cache_time timestamp;
>  	unsigned name_hash_initialized : 1,
> +		 keep_mmap : 1,
>  		 initialized : 1;
>  	struct hashmap name_hash;
>  	struct hashmap dir_hash;
>  	unsigned char sha1[20];
>  	struct untracked_cache *untracked;
> +	void *mmap;
> +	size_t mmap_size;
>  };
> =20
>  extern struct index_state the_index;
> diff --git a/read-cache.c b/read-cache.c
> index 16cc487..7e387e9 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1574,6 +1574,10 @@ int do_read_index(struct index_state *istate, =
const char *path, int must_exist)
>  	mmap =3D xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
>  	if (mmap =3D=3D MAP_FAILED)
>  		die_errno("unable to map index file");
> +	if (istate->keep_mmap) {
> +		istate->mmap =3D mmap;
> +		istate->mmap_size =3D mmap_size;
> +	}
>  	close(fd);
> =20
>  	hdr =3D mmap;
> @@ -1626,10 +1630,12 @@ int do_read_index(struct index_state *istate,=
 const char *path, int must_exist)
>  		src_offset +=3D 8;
>  		src_offset +=3D extsize;
>  	}
> -	munmap(mmap, mmap_size);
> +	if (!istate->keep_mmap)
> +		munmap(mmap, mmap_size);
>  	return istate->cache_nr;
> =20
>  unmap:
> +	istate->mmap =3D NULL;
>  	munmap(mmap, mmap_size);
>  	die("index file corrupt");
>  }
> @@ -1655,6 +1661,7 @@ int read_index_from(struct index_state *istate,=
 const char *path)
>  		discard_index(split_index->base);
>  	else
>  		split_index->base =3D xcalloc(1, sizeof(*split_index->base));
> +	split_index->base->keep_mmap =3D istate->keep_mmap;
>  	ret =3D do_read_index(split_index->base,
>  			    git_path("sharedindex.%s",
>  				     sha1_to_hex(split_index->base_sha1)), 1);
> @@ -1698,6 +1705,10 @@ int discard_index(struct index_state *istate)
>  	free(istate->cache);
>  	istate->cache =3D NULL;
>  	istate->cache_alloc =3D 0;
> +	if (istate->keep_mmap && istate->mmap) {
> +		munmap(istate->mmap, istate->mmap_size);
> +		istate->mmap =3D NULL;
> +	}
>  	discard_split_index(istate);
>  	free_untracked_cache(istate->untracked);
>  	istate->untracked =3D NULL;
