From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/25] remote-curl.c: convert fetch_git() to use argv_array
Date: Thu, 04 Feb 2016 14:59:38 -0800
Message-ID: <xmqqpowcf5et.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 23:59:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRSsN-0004UR-Jk
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbcBDW7n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 17:59:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161037AbcBDW7l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 17:59:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76C9741659;
	Thu,  4 Feb 2016 17:59:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d7pUY2IVsOgL
	d16RSSJSl3HdlkM=; b=KeMVAKjkt7FycAD2qLtWYSoX23zBUOUl97JDiucRSF3d
	XR0AVDzqCRNQc2vT58tD9IcIXSRxP0najA+ZnCTfqxJwU3lIoml+1b3dbLvEm+Ny
	raliWP4ZevLLjGrnkxGAKP07WvPQ9JP4aV4yXW3BI/gra7wtEcrqECdna7ykoBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f8sLlc
	Y3/oFhbnBrHGHhexmOHAFNVKRLaJpHZGqQEZn6ztV37o370nZ50vAhLvr4FQ8EMk
	lVSfDhP366y6t8uZjxWOZasXXQTdPcKM3wtmJG2sgaJJ/3gKByqZi68X3uHcf106
	yFN1zN0yEjJAbzf5tNr0BHCEAgFqtk5Wy6Ibo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D6F241658;
	Thu,  4 Feb 2016 17:59:40 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA82241657;
	Thu,  4 Feb 2016 17:59:39 -0500 (EST)
In-Reply-To: <1454576641-29615-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F87A6708-CB92-11E5-B37E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285514>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Yay, it's about time ;-)

> diff --git a/remote-curl.c b/remote-curl.c
> index c704857..3ac5b6c 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -726,37 +726,31 @@ static int fetch_git(struct discovery *heads,
>  	struct rpc_state rpc;
>  	struct strbuf preamble =3D STRBUF_INIT;
>  	char *depth_arg =3D NULL;
> -	int argc =3D 0, i, err;
> -	const char *argv[17];
> +	int i, err;
> +	struct argv_array args =3D ARGV_ARRAY_INIT;
> =20
> -	argv[argc++] =3D "fetch-pack";
> -	argv[argc++] =3D "--stateless-rpc";
> -	argv[argc++] =3D "--stdin";
> -	argv[argc++] =3D "--lock-pack";
> +	argv_array_pushl(&args, "fetch-pack", "--stateless-rpc",
> +			 "--stdin", "--lock-pack",
> +			 NULL);

A lone NULL after a reasonably short line looks somewhat irritating,
but if you are planning to add more on that short line in the later
patch, it is OK.  Let's keep reading.

The remainder of this patch looked obviously correct.

Thanks.
