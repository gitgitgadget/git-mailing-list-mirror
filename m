From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_sha1: improve ambiguity warning regarding SHA-1 and ref names
Date: Tue, 07 May 2013 09:09:26 -0700
Message-ID: <7v38tylqkp.fsf@alter.siamese.dyndns.org>
References: <20130501184327.GM24467@google.com>
	<1367639113-17342-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 18:09:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZkSM-0004dz-9x
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 18:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758599Ab3EGQJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 May 2013 12:09:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758460Ab3EGQJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 May 2013 12:09:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 602031C6B3;
	Tue,  7 May 2013 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eCORUyE1clF/
	0l0yIo1ywty4amw=; b=tKwI6iR+wRJP/LKmdtHOPPSpGjYaiyf2BiJ5jvZyv0Z9
	SJ8z4+FS0Gg+paFKeYCu17NyOsCKqQHbcGB02NRnpO41aC34eFwu9jzpxg8ivy1c
	ubj3YVTp2CrgOWR5oWV+hobywUQnIHd0CYjINUTaIDgYeJV3ZoB2cyI5TP7ZzLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RaknQO
	udixkD1lZ9Isk1+NWlomWYwx9RWMWt9TQFMvxNWnsO0R2aChBAmml0unf8EnxYqp
	cvrn9u2+z38l1VoN35dc4h7Wo4DroNitDU5zagGipy8zj2iT7lqhhJ8kOxnXnlqy
	eszNE6Dzaycnp5Y/QUE5e5wXfilmi68lhadc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 586341C6AA;
	Tue,  7 May 2013 16:09:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DE331C6A0;
	Tue,  7 May 2013 16:09:27 +0000 (UTC)
In-Reply-To: <1367639113-17342-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 4 May
 2013 10:45:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E1AF4EC-B730-11E2-B968-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223585>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  > That's an important feature for safety. When a script has created =
an
>  > object or learned about it some other way, as long as it doesn't
>  > abbreviate its name it can be sure that git commands will not
>  > misunderstand it.
>  >
>  > So I think this is a bad change.
> ...
>  static int get_sha1_basic(const char *str, int len, unsigned char *s=
ha1)
>  {
>  	static const char *warn_msg =3D "refname '%.*s' is ambiguous.";
> +	unsigned char tmp_sha1[20];
>  	char *real_ref =3D NULL;
>  	int refs_found =3D 0;
>  	int at, reflog_len;
> =20
> -	if (len =3D=3D 40 && !get_sha1_hex(str, sha1))
> +	if (len =3D=3D 40 && !get_sha1_hex(str, sha1)) {
> +		refs_found =3D dwim_ref(str, len, tmp_sha1, &real_ref);
> +		if (refs_found > 0 && warn_ambiguous_refs)
> +			warning(warn_msg, len, str);

The warning is issued at the right spot from the codeflow's point of
view, but it is very likely that the user did not even mean to use
the str in question as a 'refname'. The warning message we see above
is not appropriate for this case, is it?

> +		free(real_ref);
>  		return 0;
> +	}
> =20
>  	/* basic@{time or number or -number} format to query ref-log */
>  	reflog_len =3D at =3D 0;
> @@ -481,7 +487,9 @@ static int get_sha1_basic(const char *str, int le=
n, unsigned char *sha1)
>  	if (!refs_found)
>  		return -1;
> =20
> -	if (warn_ambiguous_refs && refs_found > 1)
> +	if (warn_ambiguous_refs &&
> +	    (refs_found > 1 ||
> +	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY)))
>  		warning(warn_msg, len, str);

Ditto for the case in which (refs_found <=3D 1) and get_short_sha1()
finds str as a short object name.


> diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-=
disambiguation.sh
> index 6b3d797..db22808 100755
> --- a/t/t1512-rev-parse-disambiguation.sh
> +++ b/t/t1512-rev-parse-disambiguation.sh
> @@ -261,4 +261,22 @@ test_expect_success 'rev-parse --disambiguate' '
>  	test "$(sed -e "s/^\(.........\).*/\1/" actual | sort -u)" =3D 0000=
00000
>  '
> =20
> +test_expect_success 'ambiguous 40-hex ref' '
> +	TREE=3D$(git mktree </dev/null) &&
> +	REF=3D`git rev-parse HEAD` &&
> +	VAL=3D$(git commit-tree $TREE </dev/null) &&
> +	git update-ref refs/heads/$REF $VAL &&
> +	test `git rev-parse $REF 2>err` =3D $REF &&
> +	grep "refname.*${REF}.*ambiguous" err
> +'
> +
> +test_expect_success 'ambiguous short sha1 ref' '
> +	TREE=3D$(git mktree </dev/null) &&
> +	REF=3D`git rev-parse --short HEAD` &&
> +	VAL=3D$(git commit-tree $TREE </dev/null) &&
> +	git update-ref refs/heads/$REF $VAL &&
> +	test `git rev-parse $REF 2>err` =3D $VAL &&
> +	grep "refname.*${REF}.*ambiguous" err
> +'
> +
>  test_done
