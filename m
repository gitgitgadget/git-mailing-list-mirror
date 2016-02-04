From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/25] upload-pack: tighten number parsing at "deepen" lines
Date: Thu, 04 Feb 2016 15:48:04 -0800
Message-ID: <xmqqvb64doln.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 00:48:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTdF-0007EZ-Nz
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 00:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933261AbcBDXsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 18:48:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932668AbcBDXsH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 18:48:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B0A94243A;
	Thu,  4 Feb 2016 18:48:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RyG3+535KMpi
	tnD/yuJfokU/JYU=; b=YnX1daRvGSb8/7gKbXiqU4yPCUveR6EI6+yTdoU2Gcwp
	YU+vN9NsiXOf2W5liqxZAQZowuACv1twZeYNLj3ebnmD25wICZCk9nxOUQlRsrxe
	PKqwVmJv9Klu7T5yA93Jfzq/rWsh/3OcF/SiPObnCe8hN7cb3lZbdTxMmwV2UUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UWforJ
	X/s1YyXnxrJqtuk0NRDuOZrEoZCEDIiBh7VlY9lwL5vu2iC9/maNdqrGqctc0p2Z
	eJDbtS4FvxaoJhhB+4ZOZo/EPH4ZM1oUb63QvMOOQcyrPAbtOfkWiu2g8pUmMn80
	lWW42tzH3sDI2x+lV/j0cND8l8CL5pmawexvM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 533FA42439;
	Thu,  4 Feb 2016 18:48:06 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CE0CC42436;
	Thu,  4 Feb 2016 18:48:05 -0500 (EST)
In-Reply-To: <1454576641-29615-10-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC8F0724-CB99-11E5-A47E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285522>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Hmm, so "deepen 10-by-the-way-let-me-tell-you-something-else" was an
acceptable input that some (third-party) version of "git fetch"
could have used, but now we are rejecting it.

That "let me tell you something else" part wouldn't have reached
outside this code, so it is inconceivable that anybody would relied
on that looseness as a "feature", so the only practical risk would
be if somebody wrote a protocol driver, mumbling "on the Internet,
the end of line is CRLF, just like SMTP does", that sends a "deepen
10<CR><LF>".  We used not to notice, but now we reject such a
reimplementation of Git.

>  upload-pack.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 257ad48..9f14933 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -641,9 +641,9 @@ static void receive_needs(void)
>  			continue;
>  		}
>  		if (skip_prefix(line, "deepen ", &arg)) {
> -			char *end;
> +			char *end =3D NULL;
>  			depth =3D strtol(arg, &end, 0);
> -			if (end =3D=3D arg || depth <=3D 0)
> +			if (!end || *end || depth <=3D 0)
>  				die("Invalid deepen: %s", line);
>  			continue;
>  		}
