From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: fix help.autocorrect after 57ea712 breaks it
Date: Tue, 26 Jan 2016 11:02:38 -0800
Message-ID: <xmqqbn88cgfl.fsf@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 20:02:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO8t2-00011Q-Sr
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 20:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbcAZTCm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 14:02:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752011AbcAZTCk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2016 14:02:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B538A3FDF3;
	Tue, 26 Jan 2016 14:02:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DXgo1bWe+t/C
	HF2ps5kZZ2jfQlY=; b=G3SLq4e4fWFAZY+JoYTpriJLfDoHhaj0srNCyZGGL4df
	OLVQWdTfvu6aiycNIXKFHQKp6Zdvk37NUCgGKGBcli8UJLq/dTni8L+9Suh3D1Pl
	IHwgvrpSnrgUNDYohu7FNrp/H+sinBbwQEi0/FlLA/DbE1SaD9hxdCWKahaG+dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IK8S40
	GnChqON2eeTStizMMLquwy851CDKffUrf2ETsynHH2l/16/Ke6PGZP9t4edr4fwQ
	TCVLLrNU9Ld8+A/kORcQLtQ7mhN0HTpM+HO0TEd3t8qtQ4JeoNpvZA9bsC/XGa1x
	JzNsSWRFS6FT0zB6PmFjkQT8AoXfJyd47d0Hw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ABB513FDF1;
	Tue, 26 Jan 2016 14:02:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2A2A53FDEB;
	Tue, 26 Jan 2016 14:02:39 -0500 (EST)
In-Reply-To: <1453814801-1925-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 26
 Jan 2016 20:26:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E8C99FC-C45F-11E5-A1B8-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284849>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/git.c b/git.c
> index da278c3..cd733f7 100644
> --- a/git.c
> +++ b/git.c
> @@ -25,14 +25,15 @@ static const char *env_names[] =3D {
>  	GIT_PREFIX_ENVIRONMENT
>  };
>  static char *orig_env[4];
> -static int saved_env_before_alias;
> +static int saved_env_before_alias, saved;

Even for a file-local static, this name is a bit too generic, isn't
it?  saved_env_count or something perhaps?


>  static void save_env_before_alias(void)
>  {
>  	int i;
> -	if (saved_env_before_alias)
> -		return;
> +	if (saved)
> +		die("BUG: uneven pair of save_env/restore_env calls");
>  	saved_env_before_alias =3D 1;
> +	saved =3D 1;
>  	orig_cwd =3D xgetcwd();
>  	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
>  		orig_env[i] =3D getenv(env_names[i]);
> @@ -44,9 +45,13 @@ static void save_env_before_alias(void)
>  static void restore_env(int external_alias)
>  {
>  	int i;
> +	if (saved !=3D 1)
> +		die("BUG: uneven pair of save_env/restore_env calls");
>  	if (!external_alias && orig_cwd && chdir(orig_cwd))
>  		die_errno("could not move to %s", orig_cwd);
>  	free(orig_cwd);
> +	orig_cwd =3D NULL;
> +	saved =3D 0;
>  	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
>  		if (external_alias &&
>  		    !strcmp(env_names[i], GIT_PREFIX_ENVIRONMENT))
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 52678e7..3f95285 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -1201,4 +1201,12 @@ test_expect_success POSIXPERM,PERL 'preserves =
existing permissions' '
>  	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) !=3D 060=
0"
>  '
> =20
> +test_expect_success 'autocorrect and save_env/restore_env' '
> +	git config alias.ss status &&
> +	git config help.autocorrect 1 &&
> +	git sss --porcelain | grep actual >actual &&
> +	echo "?? actual" >expected &&
> +	test_cmp expected actual
> +'
> +
>  test_done
