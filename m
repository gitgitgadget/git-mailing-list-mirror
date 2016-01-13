From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] t0060: basename("//") is implementation defined
Date: Wed, 13 Jan 2016 13:16:52 -0800
Message-ID: <xmqqegdlmb7f.fsf@gitster.mtv.corp.google.com>
References: <1452718561-32226-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Wed Jan 13 22:17:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJSms-000845-4K
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 22:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbcAMVQ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2016 16:16:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752688AbcAMVQz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2016 16:16:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65AAE3A6FC;
	Wed, 13 Jan 2016 16:16:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=u4uDBuLF8GoX
	63aj/Uw0G7AqTeY=; b=ukHN0o1HdCC1FsH3l6YfuEUSwtGksXPQEWbd0RfvoJz1
	2TaHEeMJdZB8J+UFX0jqVIhpOPLAul18k8Y5Fzjd7qti9u22Gk9fDYb+YFts+YSR
	gtmO4hUfsTEOD3Irctl59nS6Cqsxlum13+Z/TWLDaUrirpnNY4FNGFu1Jk54AhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yE41nE
	R8sYChSXTc+g+lTKyNqszK1AJXQmowNhVezdq6mJm3aIv4RUXnWH6e1ChFiVTF4U
	C5jtK2IziZ4k0EappHSqIoqWTFzHrS5H/DPGuE01CMfnTuzQEINVLRLDIeT6nzCY
	ntIgeyzhv2vedjzKw0bG+sw5UX9ImS+oG9Rnc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D0533A6FB;
	Wed, 13 Jan 2016 16:16:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D4B943A6F9;
	Wed, 13 Jan 2016 16:16:53 -0500 (EST)
In-Reply-To: <1452718561-32226-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Wed, 13 Jan 2016 21:56:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F826F6E0-BA3A-11E5-A3A8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283988>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> From
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/basename.ht=
ml
> basename("//") may return either "//" or "/".
>
> Linux returns "/", some systems like Mac OS X return "//".
> Skip the test unless NO_LIBGEN_H is set and gitbasename() from
> compat/basename is used.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> My version of a hot fix
>  test-path-utils.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks.  Ramsay gave a nice analysis at

  http://thread.gmane.org/gmane.comp.version-control.git/283928

and Dscho already is working on it, IIUC, in a slightly different
direction.

> diff --git a/test-path-utils.c b/test-path-utils.c
> index 4ab68ac..db0bb39 100644
> --- a/test-path-utils.c
> +++ b/test-path-utils.c
> @@ -142,7 +142,9 @@ static struct test_data dirname_data[] =3D {
>  	{ ".",               "."      },
>  	{ "..",              "."      },
>  	{ "/",               "/"      },
> +#if defined(NO_LIBGEN_H)
>  	{ "//",              "//"     },
> +#endif
>  #if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
>  	{ "///",             "//"     },
>  	{ "////",            "//"     },
