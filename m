From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] find_pack_entry(): do not keep packed_git pointer
 locally
Date: Mon, 30 Jan 2012 15:26:33 -0800
Message-ID: <7v62fsai1i.fsf@alter.siamese.dyndns.org>
References: <1327922750-12106-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 00:26:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rs0cT-0000qF-QL
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 00:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab2A3X0h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 18:26:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371Ab2A3X0g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 18:26:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20F1177F6;
	Mon, 30 Jan 2012 18:26:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8Np/5noFirKc
	hPUkkq00QFHpk/M=; b=busxZE36xpyWzZcvGcszaO8oRrN7gmqpMo1zSJc6Va9y
	onngv9iM2cHAqHnqxAOdFVSMdMFYYTlKpAXQgQjmtZOK+AmZNF+HOAxIiNBLeH4I
	kM918/4nFLBNTVVZaLzZ+tQ9rQg6nTba5EJvPfsAz1XMpIA0J+pAZ7lnZIfCBrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Av9nO6
	oLmkhxOidd+4RVtMyYfGjdN8Tq2YNux77jHY+K5qlCHzv63UGxqI6EJGdayuJeF/
	RiaTlBYuzx8+6tbUSv3nUAylyp86f9o6Bg9YWm21UIIya/s9JZaUuQcaBUSugxNG
	o/t8uy3pRsbotguvubDl7w9+IMK0Wnkib2qsY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19DDF77F5;
	Mon, 30 Jan 2012 18:26:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 829D777F4; Mon, 30 Jan 2012
 18:26:34 -0500 (EST)
In-Reply-To: <1327922750-12106-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 30 Jan
 2012 18:25:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D94AAF0A-4B99-11E1-96FE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189434>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Commit f7c22cc (always start looking up objects in the last used pack
> first - 2007-05-30) introduces a static packed_git* pointer as an
> optimization.  The kept pointer however may become invalid if
> free_pack_by_name() happens to free that particular pack.
>
> Current code base does not access packs after calling
> free_pack_by_name() so it should not be a problem. Anyway, move the
> pointer out so that free_pack_by_name() can reset it to avoid running
> into troubles in future.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks. Two curiosities:

 - Why is there no hunk to actually clear the pointer in
   free_pack_by_name() in this patch?

 - Could we make the magic (void *)1 value a #define'd constant? Perhap=
s
   we could even use NULL for that purpose?

> diff --git a/sha1_file.c b/sha1_file.c
> index 88f2151..4ecc953 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -54,6 +54,8 @@ static struct cached_object empty_tree =3D {
>  	0
>  };
> =20
> +static struct packed_git *find_pack_entry_last_found =3D (void *)1;
> +
>  static struct cached_object *find_cached_object(const unsigned char =
*sha1)
>  {
>  	int i;
> @@ -720,6 +722,8 @@ void free_pack_by_name(const char *pack_name)
>  			close_pack_index(p);
>  			free(p->bad_object_sha1);
>  			*pp =3D p->next;
> +			if (find_pack_entry_last_found =3D=3D p)
> +				find_pack_entry_last_found =3D (void*)1;
>  			free(p);
>  			return;
>  		}
> @@ -2012,14 +2016,13 @@ int is_pack_valid(struct packed_git *p)
> =20
>  static int find_pack_entry(const unsigned char *sha1, struct pack_en=
try *e)
>  {
> -	static struct packed_git *last_found =3D (void *)1;
>  	struct packed_git *p;
>  	off_t offset;
> =20
>  	prepare_packed_git();
>  	if (!packed_git)
>  		return 0;
> -	p =3D (last_found =3D=3D (void *)1) ? packed_git : last_found;
> +	p =3D (find_pack_entry_last_found =3D=3D (void *)1) ? packed_git : =
find_pack_entry_last_found;
> =20
>  	do {
>  		if (p->num_bad_objects) {
> @@ -2046,16 +2049,16 @@ static int find_pack_entry(const unsigned cha=
r *sha1, struct pack_entry *e)
>  			e->offset =3D offset;
>  			e->p =3D p;
>  			hashcpy(e->sha1, sha1);
> -			last_found =3D p;
> +			find_pack_entry_last_found =3D p;
>  			return 1;
>  		}
> =20
>  		next:
> -		if (p =3D=3D last_found)
> +		if (p =3D=3D find_pack_entry_last_found)
>  			p =3D packed_git;
>  		else
>  			p =3D p->next;
> -		if (p =3D=3D last_found)
> +		if (p =3D=3D find_pack_entry_last_found)
>  			p =3D p->next;
>  	} while (p);
>  	return 0;
