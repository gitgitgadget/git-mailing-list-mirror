From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log - crash and core dump
Date: Tue, 16 Apr 2013 15:21:29 -0700
Message-ID: <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx> <7v61zml0ow.fsf@alter.siamese.dyndns.org>
 <516DBE2E.4060201@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Lyapunov <dront78@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 17 00:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USEFw-0006QD-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 00:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965440Ab3DPWVg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 18:21:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965353Ab3DPWVf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 18:21:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC2B177C3;
	Tue, 16 Apr 2013 22:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PjEP+lGTohQR
	U1in0ori2nbm2P0=; b=ec4yD5tjWUxi8bMeUmMMl2ivuRIZQxbSy/gXraU75fKS
	2e77ob5BCIKsAf61HgKvruJ0xlB0CGKpNimZqL39oWkvGGRkPb1vLd4WmqSVvP5v
	an/yaoHJQYTRUhPvNvfgNf1muNi+6N9y1YZV1/Nw7NqTRHIvKxR8/DdWvWXTVkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wvkEPd
	pAJzr26ACWZcINlEGvOBQOcZ+aUSsQyG0VDcg6Bbf+SK83KX+h/SNWn2pUvWECkK
	+ImXEJJV2sykjEoWveRAqOz+zNaNMxbVLsEzN2zjpL98kdk3mAnZaI3SEndPsZWw
	mTkFfITIgVvUi3dCBUN5e3L+wcC0AU9YRyRuU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C33BD177C1;
	Tue, 16 Apr 2013 22:21:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 258F0177BC; Tue, 16 Apr
 2013 22:21:34 +0000 (UTC)
In-Reply-To: <516DBE2E.4060201@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue, 16 Apr 2013 23:10:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF10D024-A6E3-11E2-AEC9-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221483>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> How about making split_ident_line() a bit friendlier be letting it
> provide the epoch as default time stamp instead of NULL? =20

Two knee-jerk concerns I have without going back to the callers:

 * Would that "0" ever be given to the approxidate parser, which
   rejects ancient dates in numbers-since-epoch format without @
   prefix?

 * Does any existing caller use the NULL as a sign to see the input
   was without date and act on that information?


> -- >8 --
> Subject: ident: let split_ident_line() provide a default time stamp
>
> If a commit has a broken time stamp, split_ident_line() sets
> date_begin, date_end, tz_begin and tz_end to NULL.  Not all callers
> are prepared to handle that case and segfault.
>
> Instead of fixing them and having to be careful while implementing
> the next caller, provide a string consisting of the number zero as
> default value, representing the UNIX epoch.  That's the value that
> git log showed before it was converted to use split_ident_line().
>
> Reported-by: Ivan Lyapunov <dront78@gmail.com>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  ident.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index 1c123e6..ee840f4 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -191,6 +191,8 @@ static void strbuf_addstr_without_crud(struct str=
buf *sb, const char *src)
>  	sb->buf[sb->len] =3D '\0';
>  }
> =20
> +static const char zero_string[] =3D "0";
> +
>  /*
>   * Reverse of fmt_ident(); given an ident line, split the fields
>   * to allow the caller to parse it.
> @@ -254,10 +256,10 @@ int split_ident_line(struct ident_split *split,=
 const char *line, int len)
>  	return 0;
> =20
>  person_only:
> -	split->date_begin =3D NULL;
> -	split->date_end =3D NULL;
> -	split->tz_begin =3D NULL;
> -	split->tz_end =3D NULL;
> +	split->date_begin =3D zero_string;
> +	split->date_end =3D zero_string + strlen(zero_string);
> +	split->tz_begin =3D zero_string;
> +	split->tz_end =3D zero_string + strlen(zero_string);
>  	return 0;
>  }
