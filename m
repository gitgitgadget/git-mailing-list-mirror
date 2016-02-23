From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] convert.c: correct attr_action
Date: Tue, 23 Feb 2016 12:52:22 -0800
Message-ID: <xmqqpovnyws9.fsf@gitster.mtv.corp.google.com>
References: <56CBED82.5040400@web.de>
	<1456247239-5988-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Feb 23 21:52:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYJwa-0001W5-Rl
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 21:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbcBWUwZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 15:52:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755051AbcBWUwY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 15:52:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0A9147CB9;
	Tue, 23 Feb 2016 15:52:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AJyvw5wOU7VW
	g3hy1Xk95Q347EY=; b=i0Fz/hz6UV1uXhrUKCN8qCZX3+bvaSMLir/yH6UH6ROC
	8ErF9cMBafIWiHX49Wn2M/4Geuaf41uEpST3TZ2UzWsIk64mbQv8KXZMLQJmW988
	O6X1V+7mMpuDRYvB5LSsF+Do4oyHtO5W+KXf4YbJCx8YrE+wyJHEDecSSc8ieN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JnhHnR
	zwAzwu5tz/hJFLZIk8xYECEg9eMwQkReuqVFPrB/TA63aJGoW2fTc5AjOGrs4SGl
	IzzOm5o0MfueZJi6KaaLREyysJulOniySNp11DWqtWmZ2jSwnD3O2kYIlwgKVlZp
	pRhkXMOGUP/ZGXWXqnUMLILKOXHZ/j6uVwyLE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D91D347CB8;
	Tue, 23 Feb 2016 15:52:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 59B4B47CB7;
	Tue, 23 Feb 2016 15:52:23 -0500 (EST)
In-Reply-To: <1456247239-5988-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Tue, 23 Feb 2016 18:07:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5699CC62-DA6F-11E5-86E1-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287116>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Commit "convert.c: refactor crlf_action" unified the crlf_handling
> and introdused a bug for "git ls-files --eol".
> The "text" attribute was shown as "text eol=3Dlf" or "text eol=3Dcrlf=
",
> depending on core.autpcrlf or core.eol.
> Correct this and add test cases in t0027.

Sigh.  I think I typofixed this when I queued the previous version
while commenting on it.

Do people not pay attention to what is queued in 'pu' these days?

>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  convert.c            | 18 +++++++++---------
>  t/t0027-auto-crlf.sh | 33 ++++++++++++++++++++++++++-------
>  2 files changed, 35 insertions(+), 16 deletions(-)

I looked at the interdiff from the previous version; the updated
parts looked sensible.

Thanks, will queue.

>
> diff --git a/convert.c b/convert.c
> index 18af685..d8b1f17 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -708,7 +708,7 @@ static enum crlf_action git_path_check_crlf(struc=
t git_attr_check *check)
>  	const char *value =3D check->value;
> =20
>  	if (ATTR_TRUE(value))
> -		return text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_INPUT;
> +		return CRLF_TEXT;
>  	else if (ATTR_FALSE(value))
>  		return CRLF_BINARY;
>  	else if (ATTR_UNSET(value))
> @@ -778,20 +778,20 @@ static void convert_attrs(struct conv_attrs *ca=
, const char *path)
>  	}
> =20
>  	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
> -		enum eol eol_attr;
>  		ca->crlf_action =3D git_path_check_crlf(ccheck + 4);
>  		if (ca->crlf_action =3D=3D CRLF_UNDEFINED)
>  			ca->crlf_action =3D git_path_check_crlf(ccheck + 0);
>  		ca->attr_action =3D ca->crlf_action;
>  		ca->ident =3D git_path_check_ident(ccheck + 1);
>  		ca->drv =3D git_path_check_convert(ccheck + 2);
> -		if (ca->crlf_action =3D=3D CRLF_BINARY)
> -			return;
> -		eol_attr =3D git_path_check_eol(ccheck + 3);
> -		if (eol_attr =3D=3D EOL_LF)
> -			ca->crlf_action =3D CRLF_TEXT_INPUT;
> -		else if (eol_attr =3D=3D EOL_CRLF)
> -			ca->crlf_action =3D CRLF_TEXT_CRLF;
> +		if (ca->crlf_action !=3D CRLF_BINARY) {
> +			enum eol eol_attr =3D git_path_check_eol(ccheck + 3);
> +			if (eol_attr =3D=3D EOL_LF)
> +				ca->crlf_action =3D CRLF_TEXT_INPUT;
> +			else if (eol_attr =3D=3D EOL_CRLF)
> +				ca->crlf_action =3D CRLF_TEXT_CRLF;
> +		}
> +		ca->attr_action =3D ca->crlf_action;
>  	} else {
>  		ca->drv =3D NULL;
>  		ca->crlf_action =3D CRLF_UNDEFINED;
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index fc4c628..f33962b 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -159,6 +159,25 @@ stats_ascii () {
> =20
>  }
> =20
> +
> +# contruct the attr/ returned by git ls-files --eol
> +# Take none (=3Dempty), one or two args
> +attr_ascii () {
> +	case $1,$2 in
> +	-text,*)   echo "-text" ;;
> +	text,)     echo "text" ;;
> +	text,lf)   echo "text eol=3Dlf" ;;
> +	text,crlf) echo "text eol=3Dcrlf" ;;
> +	auto,)     echo "text=3Dauto" ;;
> +	auto,lf)   echo "text=3Dauto eol=3Dlf" ;;
> +	auto,crlf) echo "text=3Dauto eol=3Dcrlf" ;;
> +	lf,)       echo "text eol=3Dlf" ;;
> +	crlf,)     echo "text eol=3Dcrlf" ;;
> +	,) echo "" ;;
> +	*) echo invalid_attr "$1,$2" ;;
> +	esac
> +}
> +
>  check_files_in_repo () {
>  	crlf=3D$1
>  	attr=3D$2
> @@ -228,15 +247,15 @@ checkout_files () {
>  	test_expect_success "ls-files --eol attr=3D$attr $ident $aeol core.=
autocrlf=3D$crlf core.eol=3D$ceol" '
>  		test_when_finished "rm expect actual" &&
>  		sort <<-EOF >expect &&
> -		i/crlf w/$(stats_ascii $crlfname) crlf_false_attr__CRLF.txt
> -		i/mixed w/$(stats_ascii $lfmixcrlf) crlf_false_attr__CRLF_mix_LF.t=
xt
> -		i/lf w/$(stats_ascii $lfname) crlf_false_attr__LF.txt
> -		i/-text w/$(stats_ascii $lfmixcr) crlf_false_attr__LF_mix_CR.txt
> -		i/-text w/$(stats_ascii $crlfnul) crlf_false_attr__CRLF_nul.txt
> -		i/-text w/$(stats_ascii $crlfnul) crlf_false_attr__LF_nul.txt
> +		i/crlf w/$(stats_ascii $crlfname) attr/$(attr_ascii $attr $aeol) c=
rlf_false_attr__CRLF.txt
> +		i/mixed w/$(stats_ascii $lfmixcrlf) attr/$(attr_ascii $attr $aeol)=
 crlf_false_attr__CRLF_mix_LF.txt
> +		i/lf w/$(stats_ascii $lfname) attr/$(attr_ascii $attr $aeol) crlf_=
false_attr__LF.txt
> +		i/-text w/$(stats_ascii $lfmixcr) attr/$(attr_ascii $attr $aeol) c=
rlf_false_attr__LF_mix_CR.txt
> +		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) c=
rlf_false_attr__CRLF_nul.txt
> +		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) c=
rlf_false_attr__LF_nul.txt
>  		EOF
>  		git ls-files --eol crlf_false_attr__* |
> -		sed -e "s!attr/[^	]*!!g" -e "s/	/ /g" -e "s/  */ /g" |
> +		sed -e "s/	/ /g" -e "s/  */ /g" |
>  		sort >actual &&
>  		test_cmp expect actual
>  	'
