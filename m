From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/6] wrapper.c: introduce gentle xmalloc(z) that does not die()
Date: Thu, 14 Aug 2014 09:38:40 -0700
Message-ID: <xmqqegwj2fhr.fsf@gitster.dls.corp.google.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
	<1407927454-9268-1-git-send-email-pclouds@gmail.com>
	<1407927454-9268-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worley@alum.mit.edu
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 18:38:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHy3C-0001e4-Lh
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 18:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbaHNQiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2014 12:38:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50779 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbaHNQit convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2014 12:38:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42066309BA;
	Thu, 14 Aug 2014 12:38:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wNX3BrD0rXyb
	tsNEVhHvJjz+AMQ=; b=WEXesL55505c8tIYRtczi8zQi3+UUXv/dVv7CJeoREtA
	n8+xQk5+wM1+6Ve2Vz1kJQypH+gIjbBKAcDe4pRDWXMBTaHuyLo51s69ERIM4ipb
	Lv01nbZQex9d1SeMjEfWFa4QrhzPk7kj7JRYdyImoZ73tHZoxcCBeDQV2QdRvCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=l51lPX
	G9ut/uEZZ9YWWbNMhAK6ahNZj54KcTThF7O3gVFrFi2Rck0WFZDCC9fPriqucbgR
	1bxoIJVomBxUKCGHrtytAGdkXC5NU2MpKwqEFGARtxu84gDqCi/u/uc3E6nloliu
	06PjIKDGngqm8gsMASldUqwf7M+BhsI+wcCwg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 36E5D309B9;
	Thu, 14 Aug 2014 12:38:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ED85F309B3;
	Thu, 14 Aug 2014 12:38:41 -0400 (EDT)
In-Reply-To: <1407927454-9268-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13
 Aug 2014 17:57:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 73707FD0-23D1-11E4-AAB4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255265>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

I think the basic idea is sound.

"git grep -e _gentle -e _gently -e _gentler" hints me that the new
functions are somewhat misnamed, though.

>  git-compat-util.h |  2 ++
>  wrapper.c         | 73 +++++++++++++++++++++++++++++++++++++++++++--=
----------
>  2 files changed, 59 insertions(+), 16 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f587749..0e541e7 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -592,7 +592,9 @@ extern try_to_free_t set_try_to_free_routine(try_=
to_free_t);
>  #endif
>  extern char *xstrdup(const char *str);
>  extern void *xmalloc(size_t size);
> +extern void *xmalloc_gentle(size_t size);
>  extern void *xmallocz(size_t size);
> +extern void *xmallocz_gentle(size_t size);
>  extern void *xmemdupz(const void *data, size_t len);
>  extern char *xstrndup(const char *str, size_t len);
>  extern void *xrealloc(void *ptr, size_t size);
> diff --git a/wrapper.c b/wrapper.c
> index bc1bfb8..ad0992a 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -9,16 +9,23 @@ static void do_nothing(size_t size)
> =20
>  static void (*try_to_free_routine)(size_t size) =3D do_nothing;
> =20
> -static void memory_limit_check(size_t size)
> +static int memory_limit_check(size_t size, int gentle)
>  {
>  	static int limit =3D -1;
>  	if (limit =3D=3D -1) {
>  		const char *env =3D getenv("GIT_ALLOC_LIMIT");
>  		limit =3D env ? atoi(env) * 1024 : 0;
>  	}
> -	if (limit && size > limit)
> -		die("attempting to allocate %"PRIuMAX" over limit %d",
> -		    (intmax_t)size, limit);
> +	if (limit && size > limit) {
> +		if (gentle) {
> +			error("attempting to allocate %"PRIuMAX" over limit %d",
> +			      (intmax_t)size, limit);
> +			return -1;
> +		} else
> +			die("attempting to allocate %"PRIuMAX" over limit %d",
> +			    (intmax_t)size, limit);
> +	}
> +	return 0;
>  }
> =20
>  try_to_free_t set_try_to_free_routine(try_to_free_t routine)
> @@ -42,11 +49,12 @@ char *xstrdup(const char *str)
>  	return ret;
>  }
> =20
> -void *xmalloc(size_t size)
> +static void *do_xmalloc(size_t size, int gentle)
>  {
>  	void *ret;
> =20
> -	memory_limit_check(size);
> +	if (memory_limit_check(size, gentle))
> +		return NULL;
>  	ret =3D malloc(size);
>  	if (!ret && !size)
>  		ret =3D malloc(1);
> @@ -55,9 +63,16 @@ void *xmalloc(size_t size)
>  		ret =3D malloc(size);
>  		if (!ret && !size)
>  			ret =3D malloc(1);
> -		if (!ret)
> -			die("Out of memory, malloc failed (tried to allocate %lu bytes)",
> -			    (unsigned long)size);
> +		if (!ret) {
> +			if (!gentle)
> +				die("Out of memory, malloc failed (tried to allocate %lu bytes)"=
,
> +				    (unsigned long)size);
> +			else {
> +				error("Out of memory, malloc failed (tried to allocate %lu bytes=
)",
> +				      (unsigned long)size);
> +				return NULL;
> +			}
> +		}
>  	}
>  #ifdef XMALLOC_POISON
>  	memset(ret, 0xA5, size);
> @@ -65,16 +80,42 @@ void *xmalloc(size_t size)
>  	return ret;
>  }
> =20
> -void *xmallocz(size_t size)
> +void *xmalloc(size_t size)
> +{
> +	return do_xmalloc(size, 0);
> +}
> +
> +void *xmalloc_gentle(size_t size)
> +{
> +	return do_xmalloc(size, 1);
> +}
> +
> +static void *do_xmallocz(size_t size, int gentle)
>  {
>  	void *ret;
> -	if (unsigned_add_overflows(size, 1))
> -		die("Data too large to fit into virtual memory space.");
> -	ret =3D xmalloc(size + 1);
> -	((char*)ret)[size] =3D 0;
> +	if (unsigned_add_overflows(size, 1)) {
> +		if (gentle) {
> +			error("Data too large to fit into virtual memory space.");
> +			return NULL;
> +		} else
> +			die("Data too large to fit into virtual memory space.");
> +	}
> +	ret =3D do_xmalloc(size + 1, gentle);
> +	if (ret)
> +		((char*)ret)[size] =3D 0;
>  	return ret;
>  }
> =20
> +void *xmallocz(size_t size)
> +{
> +	return do_xmallocz(size, 0);
> +}
> +
> +void *xmallocz_gentle(size_t size)
> +{
> +	return do_xmallocz(size, 1);
> +}
> +
>  /*
>   * xmemdupz() allocates (len + 1) bytes of memory, duplicates "len" =
bytes of
>   * "data" to the allocated memory, zero terminates the allocated mem=
ory,
> @@ -96,7 +137,7 @@ void *xrealloc(void *ptr, size_t size)
>  {
>  	void *ret;
> =20
> -	memory_limit_check(size);
> +	memory_limit_check(size, 0);
>  	ret =3D realloc(ptr, size);
>  	if (!ret && !size)
>  		ret =3D realloc(ptr, 1);
> @@ -115,7 +156,7 @@ void *xcalloc(size_t nmemb, size_t size)
>  {
>  	void *ret;
> =20
> -	memory_limit_check(size * nmemb);
> +	memory_limit_check(size * nmemb, 0);
>  	ret =3D calloc(nmemb, size);
>  	if (!ret && (!nmemb || !size))
>  		ret =3D calloc(1, 1);
