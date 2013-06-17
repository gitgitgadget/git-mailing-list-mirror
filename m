From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: don't shift conflicts left and right
Date: Mon, 17 Jun 2013 16:29:05 -0700
Message-ID: <7vy5a89v0e.fsf@alter.siamese.dyndns.org>
References: <1371339883-22775-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<7va9mqlvpu.fsf@alter.siamese.dyndns.org>
	<51BF71D4.402@lsrfire.ath.cx>
	<7vehc0bh79.fsf@alter.siamese.dyndns.org>
	<51BF8DC7.4020008@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 18 01:29:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoirK-0003KY-I1
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 01:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab3FQX3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 19:29:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106Ab3FQX3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jun 2013 19:29:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3047328B21;
	Mon, 17 Jun 2013 23:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tYGRJ5FRgm7l
	4OyDYDpjP1xCRkk=; b=YmoWLqTbXsCeEHm8dREECHcxVfYzQbK4JT4rnqpbQHdZ
	4OZBuP1ncCAnOt6oTRHXd5deYRsWEQ9iBhpDzoF8cCii+UGMzVv2DnYIqbCuZHGt
	3AD8bYZM16836JWGOCmzUibtcMKYqCHOAU6ZOSi+pnr/H6WEh80ptmHFhtUSKXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kIJEJV
	z2kYzCdP7B6d1sna6JzLJ8sZkmhoz+LCFBN/lURWJ7lh2upFxsDgM90tL1QeoqGJ
	sSf391wUw7un8tPgqAzQroa+4XsfvSjVOAM2s6+YJkw0y9KiF/QkC++NrScMBX5F
	R+I75jr+4Lh3zOFSdQjo6MB8UVbkWca3By+nE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2562828B20;
	Mon, 17 Jun 2013 23:29:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C6AF28B1C;
	Mon, 17 Jun 2013 23:29:07 +0000 (UTC)
In-Reply-To: <51BF8DC7.4020008@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Tue, 18 Jun 2013 00:29:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4A029F2-D7A5-11E2-A4DF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228125>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 17.06.2013 22:44, schrieb Junio C Hamano:
>>=20
>> ...  Or, perhaps we can
>>=20
>>   - add df_conflict to struct unpack_trees_options;
>>=20
>>   - have traverse_info->data point at struct unpack_trees_options as
>>     before; and
>>=20
>>   - save the old value of o->df_conflict on the stack of
>>     traverse_trees_recursive(), update the field in place, and
>>     restore it when the recursion returns???
>
> I'm not sure unpack_trees_options is the right place for that, but it
> already has several members that aren't really "options".

Yup, most notably the "df_conflict_entry" singleton sentinel.

> It would look something like this:

Hmm, that does not look too bad, actually.

>
>
>  tree-walk.h    | 1 -
>  unpack-trees.c | 9 +++++++--
>  unpack-trees.h | 1 +
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tree-walk.h b/tree-walk.h
> index ae04b64..4876695 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -46,7 +46,6 @@ struct traverse_info {
>  	int pathlen;
>  	struct pathspec *pathspec;
> =20
> -	unsigned long df_conflicts;
>  	traverse_callback_t fn;
>  	void *data;
>  	int show_all_errors;
> diff --git a/unpack-trees.c b/unpack-trees.c
> index b27f2a6..1c0ead0 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -454,6 +454,10 @@ static int traverse_trees_recursive(int n, unsig=
ned long dirmask,
>  	void *buf[MAX_UNPACK_TREES];
>  	struct traverse_info newinfo;
>  	struct name_entry *p;
> +	struct unpack_trees_options *o =3D info->data;
> +	unsigned long saved_df_conflicts =3D o->df_conflicts;
> +
> +	o->df_conflicts |=3D df_conflicts;
> =20
>  	p =3D names;
>  	while (!p->mode)
> @@ -464,7 +468,6 @@ static int traverse_trees_recursive(int n, unsign=
ed long dirmask,
>  	newinfo.pathspec =3D info->pathspec;
>  	newinfo.name =3D *p;
>  	newinfo.pathlen +=3D tree_entry_len(p) + 1;
> -	newinfo.df_conflicts |=3D df_conflicts;
> =20
>  	for (i =3D 0; i < n; i++, dirmask >>=3D 1) {
>  		const unsigned char *sha1 =3D NULL;
> @@ -480,6 +483,8 @@ static int traverse_trees_recursive(int n, unsign=
ed long dirmask,
>  	for (i =3D 0; i < n; i++)
>  		free(buf[i]);
> =20
> +	o->df_conflicts =3D saved_df_conflicts;
> +
>  	return ret;
>  }
> =20
> @@ -565,7 +570,7 @@ static int unpack_nondirectories(int n, unsigned =
long mask,
>  {
>  	int i;
>  	struct unpack_trees_options *o =3D info->data;
> -	unsigned long conflicts =3D info->df_conflicts | dirmask;
> +	unsigned long conflicts =3D o->df_conflicts | dirmask;
> =20
>  	/* Do we have *only* directories? Nothing to do */
>  	if (mask =3D=3D dirmask && !src[0])
> diff --git a/unpack-trees.h b/unpack-trees.h
> index 36a73a6..05ee968 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -66,6 +66,7 @@ struct unpack_trees_options {
> =20
>  	struct cache_entry *df_conflict_entry;
>  	void *unpack_data;
> +	unsigned long df_conflicts;
> =20
>  	struct index_state *dst_index;
>  	struct index_state *src_index;
