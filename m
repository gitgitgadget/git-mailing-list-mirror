From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Guard memory overwriting in resolve_ref's static
 buffer
Date: Mon, 12 Dec 2011 16:37:22 -0800
Message-ID: <7v8vmhz4ql.fsf@alter.siamese.dyndns.org>
References: <1323688832-32016-1-git-send-email-pclouds@gmail.com>
 <1323688832-32016-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 01:37:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGNB-0000n1-O4
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab1LMAh0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 19:37:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753642Ab1LMAhZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2011 19:37:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B7E87978;
	Mon, 12 Dec 2011 19:37:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=kZHHk+yD/I3DwN8UgWAqmFRN0
	to=; b=JfyPyUplWM+oCtJNeaRD8M5jWOg6ZnfpZ/cRM01k8VORVlTVicK99Xtw/
	1XOPBQLqc5vwAi9mALhiUf8RZV0l635p9NyDT+3YhXyIzbkc55LXP3G3bdJ983Ej
	nxp5vSUn2SGHBYV8ZKYhlC6ke9SLDk3rFf07tBnCnL+tdfYsg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=rNhYAXFjJ53uRT9e+10
	Xb0QJlCm9GyeGxbjcqQbOuoue1q1TnMcspUO19fyIcS7+s5Z9dFyoIrnEeutxKg6
	JFx+9HDm/WXSakBwPZYRBndLhNNNBF3RV0/B+6fpOsQ8NXkif0kLs4JjdMvAOf8n
	qMF1LwNakuMxYqTN+Hi7cbkc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 329BB7977;
	Mon, 12 Dec 2011 19:37:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A17107976; Mon, 12 Dec 2011
 19:37:23 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FBA2894-2522-11E1-9D1C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186981>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/cache.h b/cache.h
> index 4887a3e..ba5e911 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -865,7 +865,8 @@ extern int read_ref(const char *filename, unsigne=
d char *sha1);
>   *
>   * errno is sometimes set on errors, but not always.
>   */
> -extern const char *resolve_ref(const char *ref, unsigned char *sha1,=
 int reading, int *flag);
> +#define resolve_ref(ref, sha1, reading, flag) resolve_ref_real(ref, =
sha1, reading, flag, __FILE__, __LINE__)
> +extern const char *resolve_ref_real(const char *ref, unsigned char *=
sha1, int reading, int *flag, const char *file, int line);
>  extern char *resolve_refdup(const char *ref, unsigned char *sha1, in=
t reading, int *flag);
> =20
>  extern int dwim_ref(const char *str, int len, unsigned char *sha1, c=
har **ref);

Eek.

> diff --git a/wrapper.c b/wrapper.c
> index 85f09df..02b6c81 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -60,6 +60,33 @@ void *xmallocz(size_t size)
>  	return ret;
>  }
> =20
> +void *xmalloc_mmap(size_t size, const char *file, int line)
> +{
> +	struct alloc_header *block;
> +	size +=3D offsetof(struct alloc_header,buf);
> +	block =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
> +		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	if (block =3D=3D (struct alloc_header*)-1)
> +		die_errno("unable to mmap %lu bytes anonymously",
> +			  (unsigned long)size);
> +
> +	block->file =3D file;
> +	block->line =3D line;
> +	block->size =3D size;
> +	return block->buf;
> +}
> +

Double eek. A refname is ordinarily way too small than a page and we sp=
end
a full page every time resolve_ref_unsafe() is called. That is acceptab=
le
only for debugging build, but then having to patch the main codepath li=
ke
the following, renaming the "real" implementation of a rather important
function is not acceptable in a non-debugging build.

> diff --git a/refs.c b/refs.c
> index 8ffb32f..cf8dfcc 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -497,12 +497,21 @@ static int get_packed_ref(const char *ref, unsi=
gned char *sha1)
>  	return -1;
>  }
> =20
> -const char *resolve_ref(const char *ref, unsigned char *sha1, int re=
ading, int *flag)
> +const char *resolve_ref_real(const char *ref, unsigned char *sha1,
> +			     int reading, int *flag, const char *file, int line)
>  {
>  	int depth =3D MAXDEPTH;
>  	ssize_t len;
>  	char buffer[256];
> -	static char ref_buffer[256];
> +	static char real_ref_buffer[256];
> +	static char *ref_buffer;
> +
> +	if (!ref_buffer && !getenv("GIT_DEBUG_MEMCHECK"))
> +		ref_buffer =3D real_ref_buffer;
> +	if (ref_buffer !=3D real_ref_buffer) {
> +		xfree_mmap(ref_buffer);
> +		ref_buffer =3D xmalloc_mmap(256, file, line);
> +	}

I'll drop 3/4 from the series, adjust 4/4, and queue the result as a
three-patch series for now.

Thanks.
