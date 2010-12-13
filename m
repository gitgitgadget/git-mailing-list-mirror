From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/19] pathspec: add match_pathspec_depth()
Date: Mon, 13 Dec 2010 11:28:52 -0800
Message-ID: <7vzks9zd3f.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 20:29:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSE58-0008G9-0J
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 20:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab0LMT3E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 14:29:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab0LMT3D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 14:29:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 005373A70;
	Mon, 13 Dec 2010 14:29:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cyzZdAGwCMhx
	foiO84lN1uTYZFQ=; b=lxtLHaFYWKbh7b/BC9axnuHwtq8I2ahg34mXf6PQohIK
	yzCstyCPd4HwKFBdoEDHWT0f2BkaIf9k0cVeDFM1Ok9/bQUOSM4/QKtciyYL/zGm
	9PPbQB3weczr1aCcEXHeUA+Y2lSMMkPNEEXa7DVufeeSwoXnstLmhKDt9Enc+sE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S7qLqF
	MbwQ+dhAe16V+Jpac6BDtU4I94jIuW6ZJ/YxyfklE1MDyc+fcr3oRFubNsvYcmBs
	8q/UkQy2DiOS3f2cwDCGdRWm1RygjEzTvgUoD2CquBPgmyINXrGZZ8+Q2E2ke5VA
	yTRHf/gY4IIDcRxFAG73bFlBR7grFDisvrc98=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D250C3A6C;
	Mon, 13 Dec 2010 14:29:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D79DE3A6A; Mon, 13 Dec 2010
 14:29:19 -0500 (EST)
In-Reply-To: <1292233616-27692-16-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\, 13 Dec
 2010 16\:46\:52 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 49EB037C-06EF-11E0-AA6B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163584>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> match_pathspec_depth() is similar to match_pathspec() except that it
> can take depth limit.
>
> In long term, match_pathspec() should be removed in favor of this
> function.

Hmm, this strongly suggests that match_pathspec() should take "const
struct pathspec *" which already contains the necessary information and
more, including the depth limit, no?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  dir.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
>  dir.h |    3 +++
>  2 files changed, 48 insertions(+), 0 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index bb5076c..e12dbdd 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -169,6 +169,51 @@ int match_pathspec(const char **pathspec, const =
char *name, int namelen,
>  	return retval;
>  }
> =20
> +int match_pathspec_depth(const char **pathspec, int max_depth,
> +			 const char *name, int namelen,
> +			 int prefix, char *seen)
> +{
> +	int i, retval =3D 0;
> +
> +	if (!pathspec) {
> +		if (max_depth =3D=3D -1)
> +			return MATCHED_RECURSIVELY;
> +
> +		if (within_depth(name, namelen, 0, max_depth))
> +			return MATCHED_EXACTLY;

Why the difference between _RECURSIVELY and _EXACTLY here?  If you have=
 a
five-level deep project and give max-depth of 1000, shouldn't you get t=
he
same result as you run the same command with unlimited depth?
