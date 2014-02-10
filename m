From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] daemon: move daemonize() to libgit.a
Date: Mon, 10 Feb 2014 10:46:04 -0800
Message-ID: <xmqqha86st5f.fsf@gitster.dls.corp.google.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com>
	<1391843332-20583-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jugg@hotmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 19:46:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCvs1-0001ku-LI
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 19:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbaBJSqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Feb 2014 13:46:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55356 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbaBJSqN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Feb 2014 13:46:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36D5A6A916;
	Mon, 10 Feb 2014 13:46:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Z9XX9/JbQ2Zp
	SjA69T9zITk5BUk=; b=IJZuxclo5xztCFWWdC1nr7KP968iuUXMgR/0gj7qI6rz
	27CyCq8EJX73+KpFa0mMnTGFXPOZGrUtWSAIUmUiy9rvMj5E99nXc2jQK/Q6+DSn
	Tf4NYvCuwtzw9MuuAtgX4soPM3XdyTES0rzEGqIwZgLnIvCtRkGl1vcNjcQJOSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jMOZ1t
	TNGQNlAR9jUUDnUIlFEy/mJ5FZEOACqjH4arZbFo1NTOGS3BPi0hlOypQc4QEkzm
	4C+t10SkTEXmEeulk4bkK3451wVeC6MNpiJ8hyjcCTdWQ1O61AseWXbsQQkpfPXY
	8qmDd5s+rJ86WaNOfFFccOjeMY0jhYl8gPbM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C64D76A911;
	Mon, 10 Feb 2014 13:46:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E97C56A909;
	Mon, 10 Feb 2014 13:46:08 -0500 (EST)
In-Reply-To: <1391843332-20583-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 8 Feb
 2014 14:08:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9AF966A0-9283-11E3-85FE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241922>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/setup.c b/setup.c
> index 6c3f85f..b09a412 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -787,3 +787,27 @@ void sanitize_stdfds(void)
>  	if (fd > 2)
>  		close(fd);
>  }
> +
> +int daemonize(void)
> +{
> +#ifdef NO_POSIX_GOODIES
> +	errno =3D -ENOSYS;

Negated?

> +	return -1;
> +#else
> +	switch (fork()) {
> +		case 0:
> +			break;
> +		case -1:
> +			die_errno("fork failed");
> +		default:
> +			exit(0);
> +	}
> +	if (setsid() =3D=3D -1)
> +		die_errno("setsid failed");
> +	close(0);
> +	close(1);
> +	close(2);
> +	sanitize_stdfds();
> +	return 0;
> +#endif
> +}
