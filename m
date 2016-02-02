From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/6] t0027: Add tests for get_stream_filter()
Date: Tue, 02 Feb 2016 13:18:56 -0800
Message-ID: <xmqqk2mmretb.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1454431988-1941-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Feb 02 22:19:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQiLp-0006xJ-5x
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 22:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbcBBVTA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2016 16:19:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964891AbcBBVS7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 16:18:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B3C241028;
	Tue,  2 Feb 2016 16:18:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eWywqgrXTIby
	LIIRHf1OR5aLJpQ=; b=I4msD7Tr5XChk7quVkyi10YPjbKuN5vizwPs38h4ivgQ
	agiGA/jTvdUGUiw7IrHbhVzTwxNzsTDcesnvFz04Qh9K67vHDxEAskoy6z8+cCh7
	9W+Mx5ry6dhfN/873XZVBauDWvvz0edqUd8a02eYfx8VRoqBe1IZycfUYART/yI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=byUWPp
	nRUuHyEJXiMwgNv9PFWtZjNpRnqD4WsRsIl9s8CurPUxNrAZ/HPteeZWJOLWTdab
	0Zin97HihBSGPOhWM6+qTIfV3gbKsZKvXtPz9yVjMoVW2cVbTGUsnEvmRKF2fcfm
	XQ9VnaUmHPTf7H2iIIzmU+YahtZsUEiN7p4dw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8278F41026;
	Tue,  2 Feb 2016 16:18:58 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F14BF41025;
	Tue,  2 Feb 2016 16:18:57 -0500 (EST)
In-Reply-To: <1454431988-1941-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Tue, 2 Feb 2016 17:53:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9264AA24-C9F2-11E5-AA9E-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285309>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> When a filter is configured, a different code-path is used in convert=
=2Ec
> and entry.c via get_stream_filter(), but there are no test cases yet.
>
> Add tests for the filter API by configuring the ident filter.
> The result of the SHA1 conversion is not checked, this is already
> done in other TC.
>
> Add a parameter to checkout_files() in t0027.
> While changing the signature, add another parameter for the eol=3D at=
tribute.
> This is currently unused, tests for e.g.
> "* text=3Dauto eol=3Dlf" will be added in a separate commit.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/t0027-auto-crlf.sh | 262 ++++++++++++++++++++++++++++-------------=
----------
>  1 file changed, 146 insertions(+), 116 deletions(-)
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 504e5a0..681f0c5 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -21,32 +21,45 @@ compare_ws_file () {
>  	pfx=3D$1
>  	exp=3D$2.expect
>  	act=3D$pfx.actual.$3
> -	tr '\015\000' QN <"$2" >"$exp" &&
> -	tr '\015\000' QN <"$3" >"$act" &&
> +	tr '\015\000abcdef01234567890' QN00000000000000000 <"$2" >"$exp" &&
> +	tr '\015\000abcdef01234567890' QN00000000000000000 <"$3" >"$act" &&

'0' is listed twice on purpose?

>  	test_cmp $exp $act &&
>  	rm $exp $act

As we are not forcing all the future callers of this helper
functions to feed only non problematic pathnames, we should quote
these variable references, but this is not a new issue this patch
introduces.

>  }
> =20
>  create_gitattributes () {
>  	attr=3D$1
> +	ident=3D$2
> +	case "$2" in
> +		"")
> +			>.gitattributes
> +			;;
> +		i)
> +			echo "* ident" >.gitattributes
> +			;;
> +		*)
> +			echo >&2 invalid ident: $2
> +			exit 1

This is overindented.  Case arms align with case/esac, and their
bodies indent one level down, i.e.

	case "$2" in
        "")
        	>.gitattributes
                ;;
	esac

By the way, I somehow find it hard to follow to assign magic
meanings "clear" and "prepare ident for everybody" to a short
and cryptic "" (empty string) and "i".  If you were taking advantage
of the fact that all existing uses of this helper function pass only
one argument to it and you will get $ident=3D"" automatically from the
ones that you did not touch, that might be a reasonable way to reduce
patch noise, but because you are doing things like this

> -	create_gitattributes "$attr" &&
> +	create_gitattributes "$attr" "" &&

anyway, it may make sense to be slightly more verbose and readable.

> +	esac
> +
>  	case "$attr" in
>  		auto)
> -		echo "*.txt text=3Dauto" >.gitattributes
> +		echo "*.txt text=3Dauto" >>.gitattributes
>  		;;
>  		...
>  		;;
>  		*)
>  		echo >&2 invalid attribute: $attr

As you are touching this helper to emit more than one thing into the
file, I'd consider doing=20

	{
                case "$2" in
                clear)	;;
                ident)	echo '* ident' ;;
                ...
                esac &&
                case "$1" in
                auto)	echo '*.txt auto' ;;
                ...
                esac
	} >.gitattributes

or even

	{
                while test "$#" !=3D 1
                do
                        printf "%s\n" "$1"
                        shift
                done &&
                case "$1" in
                auto)	echo '*.txt auto' ;;
                ...
                esac &&
	} >.gitattributes

anticipating that we may want more things added to the output in the
future.  The latter form allows your callers to say things like

	create_gitattributes "auto" "* ident" "*.bin binary"=20

without having to touch the helper function.
