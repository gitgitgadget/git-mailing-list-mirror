From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] Add more large blob test cases
Date: Mon, 05 Mar 2012 16:59:13 -0800
Message-ID: <7vipiiwnmm.fsf@alter.siamese.dyndns.org>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 01:59:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4ikK-000338-Nf
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 01:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659Ab2CFA7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 19:59:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932607Ab2CFA7P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 19:59:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E81B681B;
	Mon,  5 Mar 2012 19:59:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hROXF2qoue6d
	FR7BvcWc9lcfVro=; b=rTHuWFYMqAFHI/kyEb/mVTFW57TqhDbWhXWOJgLD5mnG
	/cXNFwj4BdaWsbH2xUw0P9mirvATINjnnk33q9KQf/T+4x4ZLMCGvGps4MCqTOUo
	oO6vyhSWdI1UhNAh8Jfk8qMevD0v8cIS3eKtxNEDwrdF0Ka5kSiTvhYAUpNYkHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=F+jLvb
	mdS47/wPxMiRZF+uLurCarXWgM7OjyVs7gj/ttGF0lGizb5tuDpHlKjSa3Elbvjn
	/BeOzpRBUE0J9RzSrhamRzjuuJwwrwcpkqhEU9D75/vjSXCEiFHL9nD12D3klcp/
	VpjcIZWLk22FwfUCNcoQhIgIAYFmLkrPwKLls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54694681A;
	Mon,  5 Mar 2012 19:59:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4D316819; Mon,  5 Mar 2012
 19:59:14 -0500 (EST)
In-Reply-To: <1330865996-2069-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 4 Mar
 2012 19:59:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97DA03FA-6727-11E1-BB53-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192294>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/wrapper.c b/wrapper.c
> index 85f09df..d4c0972 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -9,6 +9,18 @@ static void do_nothing(size_t size)
> =20
>  static void (*try_to_free_routine)(size_t size) =3D do_nothing;
> =20
> +static void memory_limit_check(size_t size)
> +{
> +	static int limit =3D -1;
> +	if (limit =3D=3D -1) {
> +		const char *env =3D getenv("GIT_ALLOC_LIMIT");
> +		limit =3D env ? atoi(env) * 1024 : 0;
> +	}
> +	if (limit && size > limit)
> +		die("attempting to allocate %d over limit %d",
> +		    size, limit);

size is size_t and %d calls for an int.

I'll push out a fixed-up version later to 'pu'.
