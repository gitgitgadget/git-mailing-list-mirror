From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] list-objects: perform NULL check before the variable is
 dereferenced
Date: Mon, 09 Apr 2012 11:51:46 -0700
Message-ID: <7v7gxowxfh.fsf@alter.siamese.dyndns.org>
References: <1333968311-29889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:52:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJgx-00072P-KL
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757562Ab2DISvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Apr 2012 14:51:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757560Ab2DISvt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2012 14:51:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B782E798D;
	Mon,  9 Apr 2012 14:51:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=I2Dhk1MtrTun
	La1Pchg0ZTlMS5s=; b=oE7IopFQWlddw3BgC914uy56ctLX37EeCJ4Z+IWVEffG
	halSV0r1qr81/UbucVfEQnrTe60v2KLISBLG/PlwI+CICY6N3hGSK5Yvaq33+KK/
	Ef8N6jxRvmHBtxtNGTjxZCY4KzLJ7mRHmy5B66K/IoILYqcU/akJUjHYZ2hr4rA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jKpcZ5
	eTC0KiCeQNyqRbFfHbaPOzK4oMO8UaXxdpqF5pPV1hJp54/Dy31FGcamZtKQtcFV
	PjYhAps5Tv/OoqRnCKu5rq/N0AWnjo2rvW4ZKqxQ6Hfe39OgcwbvXSSVWBpW+iNc
	XWOu77G5W98uRqz9L6+RVQ+UF6MXkPOM/1MHA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFAD2798C;
	Mon,  9 Apr 2012 14:51:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 383D5798A; Mon,  9 Apr 2012
 14:51:48 -0400 (EDT)
In-Reply-To: <1333968311-29889-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Apr
 2012 17:45:11 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F9AC39E-8275-11E1-B50E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195028>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  list-objects.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)

Please explain why this is needed?

I can see that process_blob() is called from process_tree() which passe=
s
the return value from lookup_blob(entry.sha1) directly without looking =
at
it.  lookup_blob() can issue an error message and return NULL if there =
is
a SHA-1 collision with an object that is not a blob.

> diff --git a/list-objects.c b/list-objects.c
> index 3dd4a96..34044d9 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -15,12 +15,13 @@ static void process_blob(struct rev_info *revs,
>  			 const char *name,
>  			 void *cb_data)
>  {
> -	struct object *obj =3D &blob->object;
> +	struct object *obj;
> =20
>  	if (!revs->blob_objects)
>  		return;
> -	if (!obj)
> +	if (!blob)
>  		die("bad blob object");
> +	obj =3D &blob->object;
>  	if (obj->flags & (UNINTERESTING | SEEN))
>  		return;
>  	obj->flags |=3D SEEN;
> @@ -67,7 +68,7 @@ static void process_tree(struct rev_info *revs,
>  			 const char *name,
>  			 void *cb_data)
>  {
> -	struct object *obj =3D &tree->object;
> +	struct object *obj;
>  	struct tree_desc desc;
>  	struct name_entry entry;
>  	struct name_path me;
> @@ -77,8 +78,9 @@ static void process_tree(struct rev_info *revs,
> =20
>  	if (!revs->tree_objects)
>  		return;
> -	if (!obj)
> +	if (!tree)
>  		die("bad tree object");
> +	obj =3D &tree->object;
>  	if (obj->flags & (UNINTERESTING | SEEN))
>  		return;
>  	if (parse_tree(tree) < 0)
