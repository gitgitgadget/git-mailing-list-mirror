From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/25] upload-pack: move "unshallow" sending code out of deepen()
Date: Thu, 04 Feb 2016 15:39:26 -0800
Message-ID: <xmqq4mdof3kh.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 00:39:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTUr-0004KV-AC
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 00:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbcBDXj3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 18:39:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752308AbcBDXj2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 18:39:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24076421D9;
	Thu,  4 Feb 2016 18:39:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CByj8ODwDJSy
	6Z97Z5g0XQGXl80=; b=fN+9/KbKCjNFFr8bbO+Atpz3o/jtBM7Jwd+FMNSHncdG
	TaM7u9u882CIHg7/icLIHq9x8bN1k90d8YSAxvSuteWGctucSxlOvZVii4HcJldk
	iNJcNT/1yXDGnOl2iYrbSU3K6WVo6YFFMfG0i7PGrC8/ZngkP4bGfd0lPuWe0BQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GcBtLT
	6z2OlHEXYLipEE6zXrQercYPk3+etad6fVly8owT+wueq1Y1D1X0jTsKOCqnpF6W
	oyCQJc2RNDCY2JkN9WJ+WeDGeI4g7LZnXsNlGnm2INqjF1CNMKPuGimXrPu0UzqR
	FueNt1lRv74h3lQhlSanqdbkGottpwDGOgggc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BB9D421D8;
	Thu,  4 Feb 2016 18:39:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 95C06421D6;
	Thu,  4 Feb 2016 18:39:27 -0500 (EST)
In-Reply-To: <1454576641-29615-8-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 87AB0C2A-CB98-11E5-A332-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285520>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Also add some more comments in this code because it takes too long to
> understand what it does (to me, who should be familiar enough to
> understand this code well!)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

The diff is harder to read than necessary (not your fault), but
splitting this into a separate helper makes sense to me.

Thanks.

>  upload-pack.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index ee5d20b..bfb7985 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -552,20 +552,10 @@ static void send_shallow(struct commit_list *re=
sult)
>  	}
>  }
> =20
> -static void deepen(int depth, const struct object_array *shallows)
> +static void send_unshallow(const struct object_array *shallows)
>  {
> -	struct commit_list *result =3D NULL;
>  	int i;
> -	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
> -		for (i =3D 0; i < shallows->nr; i++) {
> -			struct object *object =3D shallows->objects[i].item;
> -			object->flags |=3D NOT_SHALLOW;
> -		}
> -	else
> -		result =3D get_shallow_commits(&want_obj, depth,
> -					     SHALLOW, NOT_SHALLOW);
> -	send_shallow(result);
> -	free_commit_list(result);
> +
>  	for (i =3D 0; i < shallows->nr; i++) {
>  		struct object *object =3D shallows->objects[i].item;
>  		if (object->flags & NOT_SHALLOW) {
> @@ -573,7 +563,13 @@ static void deepen(int depth, const struct objec=
t_array *shallows)
>  			packet_write(1, "unshallow %s",
>  				     oid_to_hex(&object->oid));
>  			object->flags &=3D ~CLIENT_SHALLOW;
> -			/* make sure the real parents are parsed */
> +			/*
> +			 * We want to _register_ "object" as shallow, but we
> +			 * also need to traverse object's parents to deepen a
> +			 * shallow clone. Unregister it for now so we can
> +			 * parse and add the parents to the want list, then
> +			 * re-register it.
> +			 */
>  			unregister_shallow(object->oid.hash);
>  			object->parsed =3D 0;
>  			parse_commit_or_die((struct commit *)object);
> @@ -588,6 +584,23 @@ static void deepen(int depth, const struct objec=
t_array *shallows)
>  		/* make sure commit traversal conforms to client */
>  		register_shallow(object->oid.hash);
>  	}
> +}
> +
> +static void deepen(int depth, const struct object_array *shallows)
> +{
> +	struct commit_list *result =3D NULL;
> +	int i;
> +	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
> +		for (i =3D 0; i < shallows->nr; i++) {
> +			struct object *object =3D shallows->objects[i].item;
> +			object->flags |=3D NOT_SHALLOW;
> +		}
> +	else
> +		result =3D get_shallow_commits(&want_obj, depth,
> +					     SHALLOW, NOT_SHALLOW);
> +	send_shallow(result);
> +	free_commit_list(result);
> +	send_unshallow(shallows);
>  	packet_flush(1);
>  }
