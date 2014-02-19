From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/25] path.c: make get_pathname() return strbuf instead of static buffer
Date: Wed, 19 Feb 2014 15:26:33 -0800
Message-ID: <xmqqk3cq7kgm.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 00:27:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGGXf-0000bk-UU
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 00:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbaBSX0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 18:26:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbaBSX0s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 18:26:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E65C6EF0D;
	Wed, 19 Feb 2014 18:26:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4Feezs+coVpU
	7LktP4Ee305m1Z0=; b=i1EtXC0ayKXt+oUHz6u319zZrS1RNwSVC3vaCzOmtRnc
	InJ45azCqXtakdp3ZQGlTKOqvtcqLOmVaMHWrLbSUOgb7vxkKa7LsaCnLWtRYEVn
	nyTRncS8r7oYZZ2Jj+lt0yXrHvGOoNBB+uzhVOoWhocLZ4aaF6mrAh0SgTvjjgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xfM7hw
	G0Pyp9spOYaU5VXiCeuNv2zFCmD478NuUPs3Ug6rSYnEllrR4Aew3dv4m7F+FOuS
	sZByUDiOzQvro08zZysXaSZiW0Kr9mEi6Z/A28WY1DwjlM3QLmk5OdPpCaS5Oz7R
	iT8i1FKLbWy80XhA21IlBHtkNtQy0ej7WSOLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CFAD6EF09;
	Wed, 19 Feb 2014 18:26:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A413C6EEFE;
	Wed, 19 Feb 2014 18:26:37 -0500 (EST)
In-Reply-To: <1392730814-19656-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:39:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4763F51E-99BD-11E3-B46B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242417>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> We've been avoiding PATH_MAX whenever possible. This patch makes
> get_pathname() return a strbuf and updates the callers to take
> advantage of this. The code is simplified as we no longer need to
> worry about buffer overflow.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  path.c | 119 +++++++++++++++++++++++++++----------------------------=
----------
>  1 file changed, 50 insertions(+), 69 deletions(-)

Nice.

>  char *git_pathdup(const char *fmt, ...)
>  {
> -	char path[PATH_MAX], *ret;
> +	struct strbuf *path =3D get_pathname();
>  	va_list args;
>  	va_start(args, fmt);
> -	ret =3D vsnpath(path, sizeof(path), fmt, args);
> +	vsnpath(path, fmt, args);
>  	va_end(args);
> -	return xstrdup(ret);
> +	return strbuf_detach(path, NULL);
>  }

This feels somewhat wrong.

This function is for callers who are willing to take ownership of
the path buffer and promise to free the returned buffer when they
are done, because you are returning strbuf_detach()'ed piece of
memory, giving the ownership away.

The whole point of using get_pathname() is to allow callers not to
care about allocation issues on the paths they scribble on during
their short-and-simple codepaths that do not have too many uses of
similar temporary path buffers.  Why borrow from that round-robin
pool (which may now cause some codepaths to overflow the number of
such active temporary path buffers---have they been all audited)?

Is there a reason not to do just an equivalent of

    #define git_pathdup mkpathdup

and be done with it?  Am I missing something?

>  char *mkpathdup(const char *fmt, ...)
>  {
> -	char *path;
>  	struct strbuf sb =3D STRBUF_INIT;
>  	va_list args;
> -
>  	va_start(args, fmt);
>  	strbuf_vaddf(&sb, fmt, args);
>  	va_end(args);
> -	path =3D xstrdup(cleanup_path(sb.buf));
> -
> -	strbuf_release(&sb);
> -	return path;
> +	strbuf_cleanup_path(&sb);
> +	return strbuf_detach(&sb, NULL);
>  }
> =20
>  char *mkpath(const char *fmt, ...)
>  {
>  	va_list args;
> -	unsigned len;
> -	char *pathname =3D get_pathname();
> -
> +	struct strbuf *pathname =3D get_pathname();
>  	va_start(args, fmt);
> -	len =3D vsnprintf(pathname, PATH_MAX, fmt, args);
> +	strbuf_vaddf(pathname, fmt, args);
>  	va_end(args);
> -	if (len >=3D PATH_MAX)
> -		return bad_path;
> -	return cleanup_path(pathname);
> +	return cleanup_path(pathname->buf);
>  }

On the other hand, this one does seem correct.

>  char *git_path(const char *fmt, ...)
>  {
> -	char *pathname =3D get_pathname();
> +	struct strbuf *pathname =3D get_pathname();
>  	va_list args;
> -	char *ret;
> -
>  	va_start(args, fmt);
> -	ret =3D vsnpath(pathname, PATH_MAX, fmt, args);
> +	vsnpath(pathname, fmt, args);
>  	va_end(args);
> -	return ret;
> +	return pathname->buf;
>  }

So does this.

Thanks.
