From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Thu, 17 Jul 2014 11:13:20 -0700
Message-ID: <xmqqk37bq2f3.fsf@gitster.dls.corp.google.com>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
	<53C80265.5030903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:13:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7qBT-0005wW-9z
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 20:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbaGQSNb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2014 14:13:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50602 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbaGQSNa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2014 14:13:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF508293BB;
	Thu, 17 Jul 2014 14:13:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nZavTSKrIAiZ
	TTi1ua13WEY5JwY=; b=Yko16BUFB0FcESVorCQ6dS/hAdQONWflkO2bpmVv54La
	tWqtO0cxt5fAUO3HQpFdh+MgHEThq15lg39oDbvG32BDQF3NPuKj67ibrHdt6v0/
	lzWPN/VBFWSKksLAe9JXae1Nj1s5JyPacYcmxxckatzHiZbGNkImQbfbxkDDcsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xvC4CO
	dpXjoaoCf/U6TuPxJmB6RzFktfdXJIriWUl9MPoSeCItUZ0Q2sM0HBxU93N3qcyw
	ZuUlHcDQP4ZdpDkc3p2C1F2VYSAFNH/f1tUt854vNO0+kGEPZIeoa2V5YPzL3Yq2
	1PrmmoSp+eSvfYo9E8XwyQ3ZwWW9xSrulBVGU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D4A17293BA;
	Thu, 17 Jul 2014 14:13:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 65035293AD;
	Thu, 17 Jul 2014 14:13:22 -0400 (EDT)
In-Reply-To: <53C80265.5030903@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Thu, 17
	Jul 2014 19:05:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 09ADAB62-0DDE-11E4-AA34-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253766>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> "These routines have traditionally been used by programs to save the
> name of a working directory for the purpose of returning to it. A muc=
h
> faster and less error-prone method of accomplishing this is to open t=
he
> current directory (.) and use the fchdir(2) function to return."
>
> So, how about something like this?

Yeah, I've always wanted to see us use fchdir() for coming back
(another thing I wanted to see is to use openat() and friends).

I do not offhand recall if the run of chdir() in gitdir discovery
code has a similar "now we are done, let's go back to the original"
use of chdir() there, but if we do, we should fix it, too.

Looks sensible from a cursory read.

>
> ---
>  abspath.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/abspath.c b/abspath.c
> index ca33558..7fff13a 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -38,10 +38,10 @@ static const char *real_path_internal(const char =
*path, int die_on_error)
> =20
>  	/*
>  	 * If we have to temporarily chdir(), store the original CWD
> -	 * here so that we can chdir() back to it at the end of the
> +	 * here so that we can fchdir() back to it at the end of the
>  	 * function:
>  	 */
> -	char cwd[1024] =3D "";
> +	int cwd_fd =3D -1;
> =20
>  	int buf_index =3D 1;
> =20
> @@ -80,7 +80,9 @@ static const char *real_path_internal(const char *p=
ath, int die_on_error)
>  		}
> =20
>  		if (*buf) {
> -			if (!*cwd && !getcwd(cwd, sizeof(cwd))) {
> +			if (cwd_fd < 0)
> +				cwd_fd =3D open(".", O_RDONLY);
> +			if (cwd_fd < 0) {
>  				if (die_on_error)
>  					die_errno("Could not get current working directory");
>  				else
> @@ -142,8 +144,11 @@ static const char *real_path_internal(const char=
 *path, int die_on_error)
>  	retval =3D buf;
>  error_out:
>  	free(last_elem);
> -	if (*cwd && chdir(cwd))
> -		die_errno("Could not change back to '%s'", cwd);
> +	if (cwd_fd >=3D 0) {
> +		if (fchdir(cwd_fd))
> +			die_errno("Could not change back to the original working director=
y");
> +		close(cwd_fd);
> +	}
> =20
>  	return retval;
>  }
