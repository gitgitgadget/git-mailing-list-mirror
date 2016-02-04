From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/25] transport-helper.c: do not send null option to remote helper
Date: Thu, 04 Feb 2016 15:22:58 -0800
Message-ID: <xmqqh9hof4bx.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 00:23:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTEw-0008VZ-V3
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 00:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757300AbcBDXXB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 18:23:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755811AbcBDXXA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 18:23:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4ED141D6C;
	Thu,  4 Feb 2016 18:22:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=D4mifQALksEP
	VvM7H3Gap0cCEjc=; b=I7Ls3otRJhksj50XouBZ6HueNw7FYbcgSbbfmOSzYqgV
	x20VkBhJ2hFEtdTohADqfK7x2cuh9JQ5r+8w4oxqDz4NP5aTGckGwoALlbLzD0MG
	/NLNAcifMH5mvdBDUDjtVrI1CMriDQgNqOHXqFzukRA/1CerDTP3zxGAoYJHMyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Z0PibJ
	Aw30YDgtezMhzGa+oFrcvsXTvPemC7T/p3MOadLkmFWGLep9WlYkI2G9RFHLYP6v
	9VqEcd9kDJl4NJIoG58YyfKmCk9dsfyGnQbGAUNGfDAX2ukOucPu4Sj7dlMDJGcc
	whaz6KDMkgNiGuluqWxQcSXVR6z4dmMjzZWhg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB6A341D6B;
	Thu,  4 Feb 2016 18:22:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 60FF241D6A;
	Thu,  4 Feb 2016 18:22:59 -0500 (EST)
In-Reply-To: <1454576641-29615-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3AA50C16-CB96-11E5-B823-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285517>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

This is even more strange.  Are the current callers broken and some
sends value=3D=3DNULL for an option that is not is_bool, resulting in
a call to quote_c_style() with NULL?  I somehow find it hard to
believe as that would lead to an immediate segfault.

Assuming that no current caller passes NULL to value when is_bool is
not in effect, there needs an explanation why future new callers may
need to do so.  An alternative for a valueless option could be to
send "option name\n" instead of the usual "option name value\n", but
without such an explanation, readers cannot tell why not sending
anything about "name", which is what this patch chooses to implement,
is a better idea.

>  transport-helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 35023da..2e78c4d 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -309,8 +309,12 @@ static int set_helper_option(struct transport *t=
ransport,
>  	strbuf_addf(&buf, "option %s ", name);
>  	if (is_bool)
>  		strbuf_addstr(&buf, value ? "true" : "false");
> -	else
> +	else if (value)
>  		quote_c_style(value, &buf, NULL, 0);
> +	else {
> +		strbuf_release(&buf);
> +		return 0;
> +	}
>  	strbuf_addch(&buf, '\n');
> =20
>  	ret =3D strbuf_set_helper_option(data, &buf);
