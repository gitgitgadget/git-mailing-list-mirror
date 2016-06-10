From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/27] upload-pack: move rev-list code out of check_non_tip()
Date: Fri, 10 Jun 2016 13:36:16 -0700
Message-ID: <xmqqshwkeq7z.fsf@gitster.mtv.corp.google.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
	<20160610122714.3341-11-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:36:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBTAH-0003fl-II
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbcFJUgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 16:36:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751440AbcFJUgU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 16:36:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E68B32442F;
	Fri, 10 Jun 2016 16:36:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gSekmCvy1hwo
	zZKsPy4dSTzHiqM=; b=DxeOluKvfGsihs2lz55rbtioU+nQZWWxcl6CcbCzXld4
	racaoi92NKDl896JwlYM1F8np3JTD4QDCjYR9lpm10VibxQLO6nN4r/ZtQa+Giix
	f80bKdWqmMyz4dx1b2tyMzp9SuaG7xSsT8d2/hXR3yq8cVIIeIl2FvqS2Ws+rxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Qkw0sD
	ggbPN8L2V+HoVTNYqW8KAM1WgNvn+w4wFBqI8w2wOg9GJJAk0Pg4kRHmpjwSMeMx
	d7ghYE20wTq174vrDPv7Dp0XhPoRXHiotr8hNgPKW89GOuWEspu3r/+MbLcwqGfm
	AgLi+gCm7jwnlhsPxVQTT49aVDJll3P1E3s2Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE8FF2442E;
	Fri, 10 Jun 2016 16:36:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6801E2442D;
	Fri, 10 Jun 2016 16:36:18 -0400 (EDT)
In-Reply-To: <20160610122714.3341-11-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Fri, 10 Jun 2016 19:26:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FC103B56-2F4A-11E6-ADA5-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297070>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> -static void check_non_tip(void)
> +static int check_unreachable(struct object_array *src)
>  {
>...
>  	/* All the non-tip ones are ancestors of what we advertised */
> -	return;
> +	return 1;
> =20
>  error:
>  	if (cmd.in >=3D 0)
>  		close(cmd.in);
>  	if (cmd.out >=3D 0)
>  		close(cmd.out);
> +	return 0;
> +}

"zero is bad, one is good" is OK as a helper function that is local.
The convention needs to be documented as a comment before the
function.

Perhaps if you avoid using "check_", which does not hint the return
value, both the function and the caller would become easier to read.

How about calling it has_unreachable() and make the caller say

	if (!has_unreachable(&want_obj))
        	/* all requested tips are reachable from what we advertised */
		return;

instead?

> +static void check_non_tip(void)
> +{
> +	int i;
> +
> +	/*
> +	 * In the normal in-process case without
> +	 * uploadpack.allowReachableSHA1InWant,
> +	 * non-tip requests can never happen.
> +	 */
> +	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_R=
EACHABLE_SHA1))
> +		goto error;
> +	if (check_unreachable(&want_obj))
> +		/* All the non-tip ones are ancestors of what we advertised */
> +		return;
> +
> +error:
>  	/* Pick one of them (we know there at least is one) */
>  	for (i =3D 0; i < want_obj.nr; i++) {
> -		o =3D want_obj.objects[i].item;
> +		struct object *o =3D want_obj.objects[i].item;
>  		if (!is_our_ref(o))
>  			die("git upload-pack: not our ref %s",
>  			    oid_to_hex(&o->oid));
