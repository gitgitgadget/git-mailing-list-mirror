From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_name: use strlcpy() to copy strings
Date: Sun, 22 Feb 2015 12:00:15 -0800
Message-ID: <xmqqsidxvhrk.fsf@gitster.dls.corp.google.com>
References: <54E8E2AA.1020300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 22 21:00:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPchn-0006Go-2D
	for gcvg-git-2@plane.gmane.org; Sun, 22 Feb 2015 21:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbbBVUAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2015 15:00:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752069AbbBVUAb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2015 15:00:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CFD439D14;
	Sun, 22 Feb 2015 15:00:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XBqS7jeFWUkV
	TNImT3BmrpRZmpE=; b=MCXimURXKZXw6ur2PGqnUFCERW1dLYGFLqpmxWfZ0PHU
	Vn7mstXKv9cnPgswMSjOxvFANR64g4Zaj2rucio04dUY6TXO9QtPbF0TNrzw5nnh
	P47Q3WNQgNVfs0tf/b9bFLDiTgS8kzLyEwyMTacCNfSPRT9x4c7Lt7C0S04UQ+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=i+mmoU
	vTFvK78+btImsbdK4L+/2kX7zFr+rpzCdq0SImCOmQsaWe91hATGV6SWNhMFfxiH
	2rOXnOjV84jYdgR0BNWBn6fQ1N3e55kA7PIoKmTPZtaUFGd5gT69aOWBa5b/Css8
	kf8H55GTRB1PLTtDhnmMvo/sCnQkwhgGUff2k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33FD339D13;
	Sun, 22 Feb 2015 15:00:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D04E39D07;
	Sun, 22 Feb 2015 15:00:16 -0500 (EST)
In-Reply-To: <54E8E2AA.1020300@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 21
	Feb 2015 20:55:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6BB26446-BACD-11E4-B9B9-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264238>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Use strlcpy() instead of calling strncpy() and then setting the last
> byte of the target buffer to NUL explicitly.  This shortens and
> simplifies the code a bit.

Thanks.  It makes me wonder if the longer term direction should be
not to use a bound buffer for oc->path, though.

>
> Signed-of-by: Rene Scharfe <l.s.r@web.de>
> ---
>  sha1_name.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index cf2a83b..95f9f8f 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1391,9 +1391,7 @@ static int get_sha1_with_context_1(const char *=
name,
>  			namelen =3D strlen(cp);
>  		}
> =20
> -		strncpy(oc->path, cp,
> -			sizeof(oc->path));
> -		oc->path[sizeof(oc->path)-1] =3D '\0';
> +		strlcpy(oc->path, cp, sizeof(oc->path));
> =20
>  		if (!active_cache)
>  			read_cache();
> @@ -1443,9 +1441,7 @@ static int get_sha1_with_context_1(const char *=
name,
>  							   name, len);
>  			}
>  			hashcpy(oc->tree, tree_sha1);
> -			strncpy(oc->path, filename,
> -				sizeof(oc->path));
> -			oc->path[sizeof(oc->path)-1] =3D '\0';
> +			strlcpy(oc->path, filename, sizeof(oc->path));
> =20
>  			free(new_filename);
>  			return ret;
