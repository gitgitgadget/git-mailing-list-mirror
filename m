From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rm: only refresh entries that we may touch
Date: Fri, 15 Jan 2010 20:39:31 -0800
Message-ID: <7v8wbyiry4.fsf@alter.siamese.dyndns.org>
References: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
 <1263481341-28401-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 05:40:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW0SW-0003jQ-Qf
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 05:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932Ab0APEjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 23:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756735Ab0APEjk
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 23:39:40 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036Ab0APEjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 23:39:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F793917F3;
	Fri, 15 Jan 2010 23:39:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xxmdaVxiCZKn
	Guz1mW7QhowA01Q=; b=lWu3EdQE8BBNuterO8M49S3cgeEjaAmlQpihTU9Dg0bj
	k5x8ybvM60CTi1/UgckYJWcgKDHbFoXDMAEco1Q/PQOqmVN2uzaKoR0jodMBintH
	ktsYDgVtLy+e7ijZFW4VfnQaElFStaF/wcl3g+El9HdwHw31/ioKoLeXnmbBfb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NeDiYr
	GQyxHlf1Knr+Rh8x5WeDGXLsK+4PmK1NkMR4kHRZLjE5TX7oCrLXYJWGoGzGjcb4
	2oKAmoetzfzZthLokBRLf/BivjaxDslzxyYGqXgccdHgz2dx3BreZXLLYuLJE9kg
	et9wqtnYMfvRHEXIiS//RYrVaYqS4GeJM0k5E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9319917F2;
	Fri, 15 Jan 2010 23:39:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 144FE917F1; Fri, 15 Jan
 2010 23:39:32 -0500 (EST)
In-Reply-To: <1263481341-28401-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\, 14 Jan
 2010 22\:02\:20 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2613D190-0259-11DF-8943-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137199>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin-rm.c b/builtin-rm.c
> index 57975db..4cac3d1 100644
> --- a/builtin-rm.c
> +++ b/builtin-rm.c
> @@ -169,7 +169,6 @@ int cmd_rm(int argc, const char **argv, const cha=
r *prefix)
> =20
>  	if (read_cache() < 0)
>  		die("index file corrupt");
> -	refresh_cache(REFRESH_QUIET);
> =20
>  	pathspec =3D get_pathspec(prefix, argv);
>  	seen =3D NULL;
> @@ -181,6 +180,7 @@ int cmd_rm(int argc, const char **argv, const cha=
r *prefix)
>  		struct cache_entry *ce =3D active_cache[i];
>  		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
>  			continue;
> +		refresh_cache_entry(ce, 1);

Why does this pass "1" instead of "0"?  The existing code does not give
refresh_cache() REFRESH_REALLY bit, and a patch that is marked as a pur=
e
optimization should pass 0.  If you really mean it, please spell it as
CE_MATCH_IGNORE_VALID and justify why it is a good change in a separate
patch.

Thanks.
