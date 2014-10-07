From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use skip_prefix() to avoid more magic numbers
Date: Tue, 07 Oct 2014 11:23:52 -0700
Message-ID: <xmqqd2a3g2mf.fsf@gitster.dls.corp.google.com>
References: <5430427A.5080800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:24:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbZQa-0000hy-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 20:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbaJGSX5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Oct 2014 14:23:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59629 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753857AbaJGSXy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2014 14:23:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20C9613C29;
	Tue,  7 Oct 2014 14:23:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xUP/7FWNDxOl
	0h1VCznG9/AJQbY=; b=jjyfBz1AoR5DN6ma7ZEth/Tjz/r1clLsyF0ZV5zrngsx
	kAAoMJTkdBNCrihaXtKN1bJc9518Fyisza3Ybeq8tme/XP5aHPsl3lcLPoa13Rdr
	7aCuoxVJYdDYzkEdSrO02J5sclOVWudESULRr3mgJcz2FTOabJ5hCDWE1iSBVBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CwlKGH
	hdbbnyj06KA/Vz2vXV5paPRYPccV6xEkjuDwr3tyvoekAnu607NhNK43I9R9IThj
	gGeQCqd3tCph/X6Fsk5X31mLWz99fnKBtyDa0qkJLlQSIrJuvDGMRg5AJTf5OX8b
	FcPk2hT5vuTgOKLwk0b1pRcXUYVLoclv4gMhs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1815D13C28;
	Tue,  7 Oct 2014 14:23:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75C8613C27;
	Tue,  7 Oct 2014 14:23:53 -0400 (EDT)
In-Reply-To: <5430427A.5080800@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 04
	Oct 2014 20:54:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 17B2CAEC-4E4F-11E4-BA3D-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> @@ -335,20 +337,18 @@ static int append_ref(const char *refname, cons=
t unsigned char *sha1, int flags,
>  	static struct {
>  		int kind;
>  		const char *prefix;
> -		int pfxlen;
>  	} ref_kind[] =3D {
> -		{ REF_LOCAL_BRANCH, "refs/heads/", 11 },
> -		{ REF_REMOTE_BRANCH, "refs/remotes/", 13 },
> +		{ REF_LOCAL_BRANCH, "refs/heads/" },
> +		{ REF_REMOTE_BRANCH, "refs/remotes/" },
>  	};
> =20
>  	/* Detect kind */
>  	for (i =3D 0; i < ARRAY_SIZE(ref_kind); i++) {
>  		prefix =3D ref_kind[i].prefix;
> -		if (strncmp(refname, prefix, ref_kind[i].pfxlen))
> -			continue;
> -		kind =3D ref_kind[i].kind;
> -		refname +=3D ref_kind[i].pfxlen;
> -		break;
> +		if (skip_prefix(refname, prefix, &refname)) {
> +			kind =3D ref_kind[i].kind;
> +			break;
> +		}

This certainly makes it easier to read.

I suspect that the original was done as a (possibly premature)
optimization to avoid having to do strlen(3) on a variable that
points at constant strings for each and every ref we iterate with
for_each_rawref(), and it is somewhat sad to see it lost because
skip_prefix() assumes that the caller never knows the length of the
prefix, though.

Thanks.
