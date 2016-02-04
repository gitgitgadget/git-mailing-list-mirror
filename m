From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/25] upload-pack: move shallow deepen code out of receive_needs()
Date: Thu, 04 Feb 2016 15:30:25 -0800
Message-ID: <xmqqd1scf3zi.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 00:30:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTME-0001Pw-4k
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 00:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbcBDXac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 18:30:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932810AbcBDXa2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 18:30:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8453E41F8E;
	Thu,  4 Feb 2016 18:30:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=A27RNhsO5KtW
	ze6HvvDyCgx0ezo=; b=hNmE8RfJpvN5D0P8TFzJPWEswWPODdvLvOWsvNsjVeWn
	MruhVQmyPx17A7X1gYFqw205Yijr39wf+kbfEU/35k0XuigTETon9DJ0TlDQgt52
	plK7fxI27cI8+wYvsJ4tTGdzRVzEymLqK7FOpuOcKeHu/P1QGFXLON2ImMGm2bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AsMYGP
	MNz+D6NoXxqNxPXDZe+HtU7CSMmPd8yX7p8Fry/koZbXh+2oyxOHNo39QODy6Je4
	toWINYUVYkXQ2toULBKs73Tu/aakd2bVytH/58gygdQiojcrtecLlEABT3i2hi7/
	9rU9rtd9GU9VTqEaDSi0HRnQ2qYrlrLSKUBPU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C86F41F8C;
	Thu,  4 Feb 2016 18:30:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E5C8841F89;
	Thu,  4 Feb 2016 18:30:26 -0500 (EST)
In-Reply-To: <1454576641-29615-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4567A5AE-CB97-11E5-A4DC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285518>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is a prep step for further refactoring. Besides reindentation an=
d
> s/shallows\./shallows->/g, no other changes are expected.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Good.

>  upload-pack.c | 99 +++++++++++++++++++++++++++++++------------------=
----------
>  1 file changed, 52 insertions(+), 47 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index b3f6653..97ed620 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -538,6 +538,55 @@ error:
>  	}
>  }
> =20
> +static void deepen(int depth, const struct object_array *shallows)
> +{
> +	struct commit_list *result =3D NULL, *backup =3D NULL;
> +	int i;
> +	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
> +		for (i =3D 0; i < shallows->nr; i++) {
> +			struct object *object =3D shallows->objects[i].item;
> +			object->flags |=3D NOT_SHALLOW;
> +		}
> +	else
> +		backup =3D result =3D
> +			get_shallow_commits(&want_obj, depth,
> +					    SHALLOW, NOT_SHALLOW);
> +	while (result) {
> +		struct object *object =3D &result->item->object;
> +		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
> +			packet_write(1, "shallow %s",
> +				     oid_to_hex(&object->oid));
> +			register_shallow(object->oid.hash);
> +			shallow_nr++;
> +		}
> +		result =3D result->next;
> +	}
> +	free_commit_list(backup);
> +	for (i =3D 0; i < shallows->nr; i++) {
> +		struct object *object =3D shallows->objects[i].item;
> +		if (object->flags & NOT_SHALLOW) {
> +			struct commit_list *parents;
> +			packet_write(1, "unshallow %s",
> +				     oid_to_hex(&object->oid));
> +			object->flags &=3D ~CLIENT_SHALLOW;
> +			/* make sure the real parents are parsed */
> +			unregister_shallow(object->oid.hash);
> +			object->parsed =3D 0;
> +			parse_commit_or_die((struct commit *)object);
> +			parents =3D ((struct commit *)object)->parents;
> +			while (parents) {
> +				add_object_array(&parents->item->object,
> +						 NULL, &want_obj);
> +				parents =3D parents->next;
> +			}
> +			add_object_array(object, NULL, &extra_edge_obj);
> +		}
> +		/* make sure commit traversal conforms to client */
> +		register_shallow(object->oid.hash);
> +	}
> +	packet_flush(1);
> +}
> +
>  static void receive_needs(void)
>  {
>  	struct object_array shallows =3D OBJECT_ARRAY_INIT;
> @@ -630,53 +679,9 @@ static void receive_needs(void)
> =20
>  	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
>  		return;
> -	if (depth > 0) {
> -		struct commit_list *result =3D NULL, *backup =3D NULL;
> -		int i;
> -		if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
> -			for (i =3D 0; i < shallows.nr; i++) {
> -				struct object *object =3D shallows.objects[i].item;
> -				object->flags |=3D NOT_SHALLOW;
> -			}
> -		else
> -			backup =3D result =3D
> -				get_shallow_commits(&want_obj, depth,
> -						    SHALLOW, NOT_SHALLOW);
> -		while (result) {
> -			struct object *object =3D &result->item->object;
> -			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
> -				packet_write(1, "shallow %s",
> -						oid_to_hex(&object->oid));
> -				register_shallow(object->oid.hash);
> -				shallow_nr++;
> -			}
> -			result =3D result->next;
> -		}
> -		free_commit_list(backup);
> -		for (i =3D 0; i < shallows.nr; i++) {
> -			struct object *object =3D shallows.objects[i].item;
> -			if (object->flags & NOT_SHALLOW) {
> -				struct commit_list *parents;
> -				packet_write(1, "unshallow %s",
> -					oid_to_hex(&object->oid));
> -				object->flags &=3D ~CLIENT_SHALLOW;
> -				/* make sure the real parents are parsed */
> -				unregister_shallow(object->oid.hash);
> -				object->parsed =3D 0;
> -				parse_commit_or_die((struct commit *)object);
> -				parents =3D ((struct commit *)object)->parents;
> -				while (parents) {
> -					add_object_array(&parents->item->object,
> -							NULL, &want_obj);
> -					parents =3D parents->next;
> -				}
> -				add_object_array(object, NULL, &extra_edge_obj);
> -			}
> -			/* make sure commit traversal conforms to client */
> -			register_shallow(object->oid.hash);
> -		}
> -		packet_flush(1);
> -	} else
> +	if (depth > 0)
> +		deepen(depth, &shallows);
> +	else
>  		if (shallows.nr > 0) {
>  			int i;
>  			for (i =3D 0; i < shallows.nr; i++)
