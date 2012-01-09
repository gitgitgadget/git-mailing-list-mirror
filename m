From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH v2] git on Mac OS and precomposed unicode
Date: Mon, 09 Jan 2012 11:52:08 -0800
Message-ID: <7vd3asejrr.fsf@alter.siamese.dyndns.org>
References: <201201091745.30415.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 09 20:52:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkLGT-0003yR-GB
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 20:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933274Ab2AITwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 14:52:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933081Ab2AITwK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 14:52:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2000E5421;
	Mon,  9 Jan 2012 14:52:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9eTe7v/w+RKT
	98WxBdaRGjJtL9o=; b=Qq9NqBLC6dacKnveppIVChxOMoEFQwuiXqF4trNLxtoV
	N6vxg4N34tNwxDQa9x3K/c6Kj359oCp0OicftpUZHtgDzfJbFGPkPy6GY8AFY0w/
	BDaFPL3qha5C5cvbFzQnGaSbCkECavvPpogJObknDoLTsiwxDMEP6aYDpPRl6B0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ld/gOF
	93z54trQtbpn+CKXqS6leyCuWFhVWvnj8+pGsEfw/WWpptXs9Kvk4TyAIMw5w47k
	LAwWvfb0jRNLvyOpSRotjERzNQnD7QCuQIyBfTE0u2FHGmGrf56I0wqW5rA9HX0V
	VP2qXaQr6HVmWIpaMLmTfSvnYwxC7/g3UHILE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17B165420;
	Mon,  9 Jan 2012 14:52:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96769541F; Mon,  9 Jan 2012
 14:52:09 -0500 (EST)
In-Reply-To: <201201091745.30415.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Mon, 9 Jan 2012 17:45:29
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A871C60-3AFB-11E1-BA6C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188186>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 0dacb8b..88c9de1 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -290,6 +290,28 @@ static int create_default_files(const char *temp=
late_path)
>  		strcpy(path + len, "CoNfIg");
>  		if (!access(path, F_OK))
>  			git_config_set("core.ignorecase", "true");
> +#if defined (PRECOMPOSED_UNICODE)
> +		{
> +...
> +#endif

I'd prefer just a single, unconditional call here:

		probe_utf8_pathname_composition(path, len);

with something like this at the top of the file:

	#ifndef PRECOMPOSED_UNICODE
	#define probe_utf8_pathname_composition(a,b) /* nothing */
        #else
        void probe_utf8_pathname_composition(char *, int);
	#endif

and implementation of the function body in compat/darwin.c (Didn't I se=
e a
comment on the name of this file, by the way? What was the conclusion o=
f
the discussion?).

> +void
> +argv_precompose(int argc, const char **argv)

Style.

> +{
> +	int i =3D 0;
> +	int first_arg =3D 0; /* convert everything */
> +	const char *oldarg;
> +	char *newarg;
> +	iconv_t ic_precompose;
> +
> +	git_config(precomposed_unicode_config, NULL);

Hmmmmm.  Is it safe to call git_config() this early in the program?  Ha=
ve
we determined if we are in a git managed repository and where its $GIT_=
DIR
is?
