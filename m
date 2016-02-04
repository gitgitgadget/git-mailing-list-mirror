From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/25] fetch-pack: use skip_prefix() instead of starts_with() when possible
Date: Thu, 04 Feb 2016 15:56:58 -0800
Message-ID: <xmqqpowcdo6t.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 00:57:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTlq-0001c4-Tq
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 00:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115AbcBDX5C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 18:57:02 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757221AbcBDX5A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 18:57:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5BF14272E;
	Thu,  4 Feb 2016 18:56:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FQW90DN6pTyX
	5LkN9ZaOjZgn0IQ=; b=Tu+ykTIUvZar0f40eZXa+lNnHOpQ5QxSnpMvQnnT8LTX
	CTvkAetIz6OPoHnidtCra0cbu+bUi+dx+YDq0uoP227ptRGzrS5UmCDfnsgMzkV1
	spF0OHPZU/yg2D9Xnb7foiSGnfGFE7drzbKXzfy4eWyeSp56qySqIM8e9tUUsRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Bm+DtK
	dSutkRgzl4AmoLuibyb5JKy08uhP5GAakaMvSbCvzUwJS9k/JRKhYK518GejAeTN
	1kn9KtWp/oT9+dPM2L6KAiuPqh9qmIddb2qNmDYUTfKHDWsd+jQIHcAC/QaPSXV9
	r1MSl7w+9POCahMvBjCTOOBot01vU+aCTVgDA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDC894272D;
	Thu,  4 Feb 2016 18:56:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A47F42729;
	Thu,  4 Feb 2016 18:56:59 -0500 (EST)
In-Reply-To: <1454576641-29615-12-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA860A90-CB9A-11E5-9EFB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285525>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

OK, with the same comment on "when possible".  I would have reused
the same "arg" without inventing a separate variable "value" if I
were doing this conversion, but either way would be OK.

>  builtin/fetch-pack.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 9b2a514..0482077 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -58,13 +58,14 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
> =20
>  	for (i =3D 1; i < argc && *argv[i] =3D=3D '-'; i++) {
>  		const char *arg =3D argv[i];
> +		const char *value;
> =20
> -		if (starts_with(arg, "--upload-pack=3D")) {
> -			args.uploadpack =3D arg + 14;
> +		if (skip_prefix(arg, "--upload-pack=3D", &value)) {
> +			args.uploadpack =3D value;
>  			continue;
>  		}
> -		if (starts_with(arg, "--exec=3D")) {
> -			args.uploadpack =3D arg + 7;
> +		if (skip_prefix(arg, "--exec=3D", &value)) {
> +			args.uploadpack =3D value;
>  			continue;
>  		}
>  		if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
> @@ -100,8 +101,8 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
>  			args.verbose =3D 1;
>  			continue;
>  		}
> -		if (starts_with(arg, "--depth=3D")) {
> -			args.depth =3D strtol(arg + 8, NULL, 0);
> +		if (skip_prefix(arg, "--depth=3D", &value)) {
> +			args.depth =3D strtol(value, NULL, 0);
>  			continue;
>  		}
>  		if (!strcmp("--no-progress", arg)) {
