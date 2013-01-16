From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length
 calculation
Date: Tue, 15 Jan 2013 18:33:21 -0800
Message-ID: <7vbocp26xa.fsf@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <201301152014.28433.avila.jn@gmail.com>
 <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
 <CACsJy8Bn4GKJzi4n5cMPp+26dovT795nUqcXGNLgapf+r_PFCw@mail.gmail.com>
 <20130116020901.GA1041@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:33:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvIp0-00009B-AN
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051Ab3APCdZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 21:33:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756839Ab3APCdZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 21:33:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31DD7A3E5;
	Tue, 15 Jan 2013 21:33:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JcmBGE3Wy3vT
	Z1TjJ4KWHfUfPzE=; b=TY0KwwRog0EKYDtZ5pEtnGNude3GyGR6XLuVYGQFKFxW
	1crTfk5tJCHKiEXOWPMsmzLBLUD5ASmftx0asRDRJQgbnURmfQiymamWJvprXFO5
	cxDkckVFPU5FqkANsJhlbaqL69DXYuTtkVFp7q9ZgmLrXvYyH+eXUAvS7T+OzRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EWGbbC
	hwm9Xkkx5Buv6WxvBVTAJtL1WpIMEFTbStLY/XJWcvLaCkvgZXdRQrPjjxphajTY
	rBNvqLpu0GQVCKN6idZbz5vGTQceyUvLgJ5y3p9vns18vJcZdUi2FjsVcbvqC5xj
	RhhgW8u/iUTiMcSnlvCK8jQ2O2ZAuxX1NcSgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27896A3E4;
	Tue, 15 Jan 2013 21:33:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A3BBA3E3; Tue, 15 Jan 2013
 21:33:23 -0500 (EST)
In-Reply-To: <20130116020901.GA1041@duynguyen-vnpc.dek-tpc.internal> (Duy
 Nguyen's message of "Wed, 16 Jan 2013 09:09:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1944F2FA-5F85-11E2-B0D4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213716>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 16, 2013 at 08:08:03AM +0700, Duy Nguyen wrote:
>> Actually I'd like to remove that function.
>
> This is what I had in mind:

I think the replacement logic to find the basename is moderately
inferiour to the original.  For one thing (this may be somewhat
subjective), it is less readable now.  Also the original only
scanned the string from the beginning once (instead of letting
strlen() to scan once and go back).

The new code structure to inline the basename finding part and to
pass the dirlen down the callchain may make sense, though.

>> -- 8< --
> Subject: [PATCH] attr: avoid calling find_basename() twice per path
>
> find_basename() is only used inside collect_all_attrs(), called once
> in prepare_attr_stack, then again after prepare_attr_stack()
> returns. Both calls return exact same value. Reorder the code to do i=
t
> once.
>
> While at it, make use of "pathlen" to stop searching early if
> possible.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  attr.c | 46 +++++++++++++++++++---------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index cfc6748..04cb9a0 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -564,32 +564,12 @@ static void bootstrap_attr_stack(void)
>  	attr_stack =3D elem;
>  }
> =20
> -static const char *find_basename(const char *path)
> -{
> -	const char *cp, *last_slash =3D NULL;
> -
> -	for (cp =3D path; *cp; cp++) {
> -		if (*cp =3D=3D '/' && cp[1])
> -			last_slash =3D cp;
> -	}
> -	return last_slash ? last_slash + 1 : path;
> -}
> -
> -static void prepare_attr_stack(const char *path)
> +static void prepare_attr_stack(const char *path, int dirlen)
>  {
>  	struct attr_stack *elem, *info;
> -	int dirlen, len;
> +	int len;
>  	const char *cp;
> =20
> -	dirlen =3D find_basename(path) - path;
> -
> -	/*
> -	 * find_basename() includes the trailing slash, but we do
> -	 * _not_ want it.
> -	 */
> -	if (dirlen)
> -		dirlen--;
> -
>  	/*
>  	 * At the bottom of the attribute stack is the built-in
>  	 * set of attribute definitions, followed by the contents
> @@ -769,15 +749,27 @@ static int macroexpand_one(int attr_nr, int rem=
)
>  static void collect_all_attrs(const char *path)
>  {
>  	struct attr_stack *stk;
> -	int i, pathlen, rem;
> -	const char *basename;
> +	int i, pathlen, rem, dirlen =3D 0;
> +	const char *basename =3D path, *cp;
> =20
> -	prepare_attr_stack(path);
> +	pathlen =3D strlen(path);
> +
> +	/*
> +	 * This loop is similar to strrchr(path, '/') except that the
> +	 * trailing slash is skipped.
> +	 */
> +	for (cp =3D path + pathlen - 2; cp >=3D path; cp--) {
> +		if (*cp =3D=3D '/') {
> +			basename =3D cp + 1;
> +			dirlen =3D cp - path;
> +			break;
> +		}
> +	}
> +
> +	prepare_attr_stack(path, dirlen);
>  	for (i =3D 0; i < attr_nr; i++)
>  		check_all_attr[i].value =3D ATTR__UNKNOWN;
> =20
> -	basename =3D find_basename(path);
> -	pathlen =3D strlen(path);
>  	rem =3D attr_nr;
>  	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
>  		rem =3D fill(path, pathlen, basename, stk, rem);
