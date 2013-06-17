From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: don't shift conflicts left and right
Date: Mon, 17 Jun 2013 16:42:50 -0700
Message-ID: <7vsj0g9udh.fsf@alter.siamese.dyndns.org>
References: <1371339883-22775-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<7va9mqlvpu.fsf@alter.siamese.dyndns.org>
	<51BF71D4.402@lsrfire.ath.cx>
	<7vehc0bh79.fsf@alter.siamese.dyndns.org>
	<51BF9B35.3010801@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 18 01:42:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoj4c-00053P-KB
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 01:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab3FQXmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 19:42:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab3FQXmx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jun 2013 19:42:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23DA82840E;
	Mon, 17 Jun 2013 23:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Sc/aGaY4HYYi
	SXwEUPqNC+lm2qk=; b=ZX3aUHkEm9JGpKQu8KVYYSj2C5lCblyE0KxZ8vrMqXbp
	7DGfLkiyLxAGJu6coG8M9efgba+fVHqY5XeibBFvuWgjaYOqTwRYyYV8rbqZ22ZW
	3FpoKtYCalEjS+ayJVuGfN4lHe1BBY5EYrdPiGu6MOQOP8GOuGNK/jITlMaYHgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nWI/fC
	eT6qfCztYQzWmSylFEFt7Vx09xeAzG1BKVyVrwbKvMog/qh7piQhSF5751QlPyov
	SqHW4Cqz1jFD79kn3UGlJIphEPMvXNz2rjYewEI/UoOIbHfNKIUCgoWY/7gvCaKz
	1Ai5J0pUzSqnX2P5mW0EYjtYtoVq1Lma/LbW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 123512840D;
	Mon, 17 Jun 2013 23:42:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C6352840C;
	Mon, 17 Jun 2013 23:42:52 +0000 (UTC)
In-Reply-To: <51BF9B35.3010801@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Tue, 18 Jun 2013 01:26:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A05D5D14-D7A7-11E2-94DA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228126>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> How about going into the opposite direction and moving df_conflicts
> handling more into traverse_tree?  If the function saved the mask
> and dirmask in traverse_info then callbacks could calculate the
> cumulated d/f conflicts by walking the info chain, similar to how
> make_traverse_path works.  That would match the spirit of that
> struct.  Below is a patch for that, for illustration.
>
> We could then remove the mask and dirmask parameters from
> traverse_callback_t functions, as the callbacks can then get them
> through traverse_info.

Hmph.

> @@ -565,12 +563,16 @@ static int unpack_nondirectories(int n, unsigne=
d long mask,
>  {
>  	int i;
>  	struct unpack_trees_options *o =3D info->data;
> -	unsigned long conflicts =3D info->df_conflicts | dirmask;
> +	unsigned long conflicts =3D dirmask;

We grab the dirmask for the current level.

> +	const struct traverse_info *previnfo;
> =20
>  	/* Do we have *only* directories? Nothing to do */
>  	if (mask =3D=3D dirmask && !src[0])
>  		return 0;
> =20
> +	for (previnfo =3D info->prev; previnfo; previnfo =3D previnfo->prev=
)
> +		conflicts |=3D previnfo->mask & ~previnfo->dirmask;

And OR-in the bits for non-directories in levels that are closer to
the root (i.e. if a path that corresponds to our parent directory is
a non-directory in one of the trees, our path cannot be a file in
that tree).

So the bit-math looks correct here.  conflicts ends up having bits
set for trees that cannot have a non-directory at the path we are
looking at.

But the need to go all the way up in the recursive callframes to get
the union of bitmask to get conflicts looks somewhat ugly.

I dunno.
