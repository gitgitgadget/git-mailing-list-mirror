From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/POC 1/7] Make git_path() beware of file relocation in $GIT_DIR
Date: Fri, 13 Dec 2013 08:30:27 -0800
Message-ID: <xmqqsitwr9wc.fsf@gitster.dls.corp.google.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
	<1386771333-32574-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 17:30:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrVdN-0004tB-GP
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 17:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab3LMQad convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Dec 2013 11:30:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48820 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab3LMQac convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Dec 2013 11:30:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E32B56899;
	Fri, 13 Dec 2013 11:30:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uWFbcJN+rl8T
	85XNfZBtVFA0s0g=; b=rezyx3yuB3hZgAjCr3c67czvQDyE3E5uVj75opep3fKv
	GgybdfJcUjgcIACEZV9emiI+iIGnMl0WI/3eA6hIMBnCPXbqCskKDRCqqzgig1A5
	Uqe9bQIjAa0kXvkD69/DU94LJYvTlCOqiTHDBqKaWpg3wsse7JxYZIUs/EIRf4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=geQiXA
	Ev1ZofxuKsMIZna3ucWxHN9j5ykFiqXjht/hR2a5AIgk67HGU24dGDFhCvsSwW7k
	hs7CeNRZVOtI6iigtjLbZo9uIJjsqpKwzTccaBkSA7zdWFzwBhzNv4Lg7CGTNXnz
	0PJTTphcHqj4yLUNrCcjGOt3RTvamCVGAC+pQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC8CF56898;
	Fri, 13 Dec 2013 11:30:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A7A656897;
	Fri, 13 Dec 2013 11:30:30 -0500 (EST)
In-Reply-To: <1386771333-32574-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 11
 Dec 2013 21:15:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E206F39E-6413-11E3-831D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239259>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static void adjust_git_path(char *buf, int git_dir_len)
> +{
> +	/* XXX buffer overflow */
> +	char *base =3D buf + git_dir_len;
> +	if (git_graft_env && !strcmp(base, "info/grafts"))
> +		strcpy(buf, get_graft_file());
> +	else if (git_index_env && !strcmp(base, "index"))
> +		strcpy(buf, get_index_file());
> +	else if (git_db_env && dir_prefix(base, "objects"))
> +		replace_dir(buf, git_dir_len + 7, get_object_directory());
> +}
> +
>  static char *vsnpath(char *buf, size_t n, const char *fmt, va_list a=
rgs)
>  {
>  	const char *git_dir =3D get_git_dir();
> -	size_t len;
> +	size_t len, total_len;
> =20
>  	len =3D strlen(git_dir);
>  	if (n < len + 1)
> @@ -60,9 +88,10 @@ static char *vsnpath(char *buf, size_t n, const ch=
ar *fmt, va_list args)
>  	memcpy(buf, git_dir, len);
>  	if (len && !is_dir_sep(git_dir[len-1]))
>  		buf[len++] =3D '/';
> -	len +=3D vsnprintf(buf + len, n - len, fmt, args);
> -	if (len >=3D n)
> +	total_len =3D len + vsnprintf(buf + len, n - len, fmt, args);
> +	if (total_len >=3D n)
>  		goto bad;
> +	adjust_git_path(buf, len);

This is a minor tangent, but this part of the patch made me raise my
eyebrow, wondering what Git-specific path mangler is doing in a
function vsnpath that is named as if it is a lot more generic, until
I read the change in context.

The vnspath() is already Git-specific---it is a helper that is used
to create a path inside the $GIT_DIR directory.

We probably should do two things to clear things up:

 - Right now, path.c has definitions of functions in this order:

    char *mksnpath(char *buf, size_t n, const char *fmt, ...)
    static char *vsnpath(char *buf, size_t n, const char *fmt, va_list =
args)
    char *git_snpath(char *buf, size_t n, const char *fmt, ...)
    char *git_pathdup(const char *fmt, ...)
    char *mkpathdup(const char *fmt, ...)
    char *mkpath(const char *fmt, ...)
    char *git_path(const char *fmt, ...)

   The two functions mkpathdup() and mkpath() are not Git specific
   at all.  They should be moved up to be grouped together with
   mksnpath() that is also not Git-specific.

 - Rename the static vsnpath() to further clarify that it is Git
   specific.
