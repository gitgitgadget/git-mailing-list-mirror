From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive-tar: split long paths more carefully
Date: Sat, 05 Jan 2013 22:54:24 -0800
Message-ID: <7v7gnqpzrz.fsf@alter.siamese.dyndns.org>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
 <50E8AE12.8040102@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 06 07:55:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trk8H-0004Ug-BY
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974Ab3AFGy1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:54:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab3AFGy0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2013 01:54:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58BC47109;
	Sun,  6 Jan 2013 01:54:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aFS4IyX++95B
	lBfxFYBkzOScyOo=; b=klTTRyfpTFFqxj7DUU56uJJMm6NFi3COegipD6P2VV2a
	Y20VfcorPNJ6rU1Op99Q3TATSATO1zjPaUi7ZzvHplrsSvJ/fif68Kiw7xQcwS/p
	CPK49XZ1+tpwVQDIFkEFf5hrChk4wP6pTTXQ7GwDfnJzxI8QSvSk6TaSX1jMMz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iTwh8H
	JDefTj9yiCu46z8OoNX40R/R1bdY4P3oHuEPFs7Fn0YDzIkAQSlAwWYo/R0qkJhu
	gXjcXNtdB9UG9yYjQ20EfiyFlLTClsJWwP7Im/igEcP3SOGoS0h4Rmy6A67lqCh2
	5a59JKC1y49/qMTO+26UgoR1H1mqNko/XNKIY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B3F47108;
	Sun,  6 Jan 2013 01:54:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E2427107; Sun,  6 Jan 2013
 01:54:25 -0500 (EST)
In-Reply-To: <50E8AE12.8040102@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 05 Jan 2013 23:49:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E895521C-57CD-11E2-B7F0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212780>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The name field of a tar header has a size of 100 characters.  This li=
mit
> was extended long ago in a backward compatible way by providing the
> additional prefix field, which can hold 155 additional characters.  T=
he
> actual path is constructed at extraction time by concatenating the pr=
efix
> field, a slash and the name field.
>
> get_path_prefix() is used to determine which slash in the path is use=
d as
> the cutting point and thus which part of it is placed into the field
> prefix and which into the field name.  It tries to cram as much into =
the
> prefix field as possible.  (And only if we can't fit a path into the
> provided 255 characters we use a pax extended header to store it.)
>
> If a path is longer than 100 but shorter than 156 characters and ends
> with a slash (i.e. is for a directory) then get_path_prefix() puts th=
e
> whole path in the prefix field and leaves the name field empty.  GNU =
tar
> reconstructs the path without complaint, but the tar included with
> NetBSD 6 does not: It reports the header to be invalid.
>
> For compatibility with this version of tar, make sure to never leave =
the
> name field empty.  In order to do that, trim the trailing slash from =
the
> part considered as possible prefix, if it exists -- that way the last
> path component (or more, but not less) will end up in the name field.

Nicely explained; thanks.

Makes me wonder what we should do for a file inside a directory
whose name is 10 bytes long, and whose filename is 120 bytes long,
though.

Sounds like people on NetBSD are SOL due to the 155+'/'+100 in such
a case and there is nothing we can do, I guess.

> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  archive-tar.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index 0ba3f25..923daf5 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -153,6 +153,8 @@ static unsigned int ustar_header_chksum(const str=
uct ustar_header *header)
>  static size_t get_path_prefix(const char *path, size_t pathlen, size=
_t maxlen)
>  {
>  	size_t i =3D pathlen;
> +	if (i > 1 && path[i - 1] =3D=3D '/')
> +		i--;
>  	if (i > maxlen)
>  		i =3D maxlen;
>  	do {
