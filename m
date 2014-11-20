From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] t0027: check the eol conversion warnings
Date: Thu, 20 Nov 2014 14:37:14 -0800
Message-ID: <xmqqr3wx1oth.fsf@gitster.dls.corp.google.com>
References: <546E5D26.8030109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 20 23:37:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XraLs-0004lN-6f
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 23:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664AbaKTWhS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2014 17:37:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756409AbaKTWhQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2014 17:37:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 177D31ECE4;
	Thu, 20 Nov 2014 17:37:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VACsuHfktL7H
	VgEBH0B1zmX+EU0=; b=sgwvbqXgQVNBDojKLPp6bqEUY9MgT4Bz4YKr167OyI22
	SjzDB3FrXXqSVmwbwUhwanewIB8XulBSwsRODFEEHcG32Cc8eQ75YWcgsiaVLPxR
	LJbB619DIAwfoXkmvGXKRY4Bs9U3HzhcDWLqAvYsXX6toskdn7pxnYT2FscO664=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gw6HYO
	6MAObhsAPsqfu4man/+r1CE7+OCMjlrwy8KNrj1KGmHyWug2PhMjYk7wEyPmzHhF
	OY+RtcTl3koCavbKg3KqPYsYCyU85Rxcx04+OeyOX7TVK5+HSSffPK808tezTH8M
	4cup3WxTyDobfp8+qVk5tFQVA5AAG//OUEZB0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0ECB51ECE3;
	Thu, 20 Nov 2014 17:37:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D4601ECE2;
	Thu, 20 Nov 2014 17:37:15 -0500 (EST)
In-Reply-To: <546E5D26.8030109@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 20 Nov 2014 22:29:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C6F34602-7105-11E4-9143-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Add tests to check the warnings when adding file with eol=3Dlf and eo=
l=3Dcrlf.
>
> Add a function check_warning() to check the warnings on stderr
> "CRLF will be replaced..." or "LF will be replaced..."
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

At a glance it is very hard to see what we might be _losing_ with this
change that claims to "add" new kinds of tests on top of existing ones.

I am guessing that add-check-warn roughly corresponds to the old
create-file-in-repo but they have different calling conventions, or
something?

Perhaps split it into two patches (or more), each of which does one
thing and one thing well?  I suspect that even with a two-patch
split (e.g. the first of which only renames the function without
adding the new "grep in error messages that could be localized and
give false failures" code, and the second adds the lf/crlf stuff)
might make this at least readable.

I dunno.

>  t/t0027-auto-crlf.sh | 103 +++++++++++++++++++++++++++++++++++++++--=
----------
>  1 file changed, 80 insertions(+), 23 deletions(-)
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 2a4a6c1..9570947 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -55,16 +55,36 @@ create_gitattributes () {
>  	esac
>  }
> =20
> -create_file_in_repo () {
> +check_warning () {
> +	case "$1" in
> +	LF_CRLF) grep "LF will be replaced by CRLF" $2;;
> +	CRLF_LF) grep "CRLF will be replaced by LF" $2;;
> +	*) test_cmp /dev/null $2;;
> +	esac
> +}
> +
> +add_check_warn () {
>  	crlf=3D$1
>  	attr=3D$2
> +	lfname=3D$3
> +	crlfname=3D$4
> +	lfmixcrlf=3D$5
> +	lfmixcr=3D$6
> +	crlfnul=3D$7
>  	create_gitattributes "$attr" &&
> +	pfx=3Dcrlf_${crlf}_attr_${attr}
>  	for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
>  	do
> -		pfx=3Dcrlf_${crlf}_attr_${attr}_$f.txt &&
> -		cp $f $pfx && git -c core.autocrlf=3D$crlf add $pfx
> +		fname=3D${pfx}_$f.txt &&
> +		cp $f $fname &&
> +		git -c core.autocrlf=3D$crlf add $fname 2>"${pfx}_$f.err"
>  	done &&
> -	git commit -m "core.autocrlf $crlf"
> +	git commit -m "core.autocrlf $crlf" &&
> +	check_warning "$lfname" ${pfx}_LF.err &&
> +	check_warning "$crlfname" ${pfx}_CRLF.err &&
> +	check_warning "$lfmixcrlf" ${pfx}_LF_mix_CR.err &&
> +	check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err &&
> +	check_warning "$crlfnul" ${pfx}_CRLF_nul.err
>  }
> =20
>  check_files_in_repo () {
> @@ -140,50 +160,87 @@ test_expect_success 'setup master' '
>  '
> =20
> =20
> -test_expect_success 'create files' '
> -	create_file_in_repo false "" &&
> -	create_file_in_repo true  "" &&
> -	create_file_in_repo input "" &&
> =20
> -	create_file_in_repo false "auto" &&
> -	create_file_in_repo true  "auto" &&
> -	create_file_in_repo input "auto" &&
> +warn_LF_CRLF=3D"LF will be replaced by CRLF"
> +warn_CRLF_LF=3D"CRLF will be replaced by LF"
> +
> +test_expect_success 'add files empty attr' '
> +	add_check_warn false ""     ""        ""        ""        ""       =
 "" &&
> +	add_check_warn true  ""     "LF_CRLF" ""        ""        ""       =
 "" &&
> +	add_check_warn input ""     ""        "CRLF_LF" ""        ""       =
 ""
> +'
> =20
> -	create_file_in_repo false "text" &&
> -	create_file_in_repo true  "text" &&
> -	create_file_in_repo input "text" &&
> +test_expect_success 'add files attr=3Dauto' '
> +	add_check_warn false "auto" ""        "CRLF_LF" ""        ""       =
 "" &&
> +	add_check_warn true  "auto" "LF_CRLF" ""        ""        ""       =
 "" &&
> +	add_check_warn input "auto" ""        "CRLF_LF" ""        ""       =
 ""
> +'
> =20
> -	create_file_in_repo false "-text" &&
> -	create_file_in_repo true  "-text" &&
> -	create_file_in_repo input "-text" &&
> +test_expect_success 'add files attr=3Dtext' '
> +	add_check_warn false "text" ""        "CRLF_LF" ""        ""       =
 "CRLF_LF" &&
> +	add_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF"=
 ""        &&
> +	add_check_warn input "text" ""        "CRLF_LF" ""        ""       =
 "CRLF_LF"
> +'
> +
> +test_expect_success 'add files attr=3D-text' '
> +	add_check_warn false "-text" ""       ""        ""        ""       =
 "" &&
> +	add_check_warn true  "-text" ""       ""        ""        ""       =
 "" &&
> +	add_check_warn input "-text" ""       ""        ""        ""       =
 ""
> +'
> +
> +test_expect_success 'add files attr=3Dlf' '
> +	add_check_warn false "lf"    ""       "CRLF_LF" ""         ""      =
 "CRLF_LF" &&
> +	add_check_warn true  "lf"    ""       "CRLF_LF" ""         ""      =
 "CRLF_LF" &&
> +	add_check_warn input "lf"    ""       "CRLF_LF" ""         ""      =
 "CRLF_LF"
> +'
> +
> +test_expect_success 'add files attr=3Dcrlf' '
> +	add_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF"=
 "" &&
> +	add_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF"=
 "" &&
> +	add_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF"=
 ""
> +'
> +
> +test_expect_success 'create files cleanup' '
>  	rm -f *.txt &&
>  	git reset --hard
>  '
> =20
> -test_expect_success 'commit empty gitattribues' '
> +test_expect_success 'check file in repo empty gitattribues' '
>  	check_files_in_repo false ""      LF CRLF CRLF_mix_LF LF_mix_CR CRL=
=46_nul &&
>  	check_files_in_repo true  ""      LF LF   LF          LF_mix_CR CRL=
=46_nul &&
>  	check_files_in_repo input ""      LF LF   LF          LF_mix_CR CRL=
=46_nul
>  '
> =20
> -test_expect_success 'commit text=3Dauto' '
> +test_expect_success 'check file in repo text=3Dauto' '
>  	check_files_in_repo false "auto"  LF LF   LF          LF_mix_CR CRL=
=46_nul &&
>  	check_files_in_repo true  "auto"  LF LF   LF          LF_mix_CR CRL=
=46_nul &&
>  	check_files_in_repo input "auto"  LF LF   LF          LF_mix_CR CRL=
=46_nul
>  '
> =20
> -test_expect_success 'commit text' '
> +test_expect_success 'check file in repo text' '
>  	check_files_in_repo false "text"  LF LF   LF          LF_mix_CR LF_=
nul &&
>  	check_files_in_repo true  "text"  LF LF   LF          LF_mix_CR LF_=
nul &&
>  	check_files_in_repo input "text"  LF LF   LF          LF_mix_CR LF_=
nul
>  '
> =20
> -test_expect_success 'commit -text' '
> +test_expect_success 'check file in repo -text' '
>  	check_files_in_repo false "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRL=
=46_nul &&
>  	check_files_in_repo true  "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRL=
=46_nul &&
>  	check_files_in_repo input "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRL=
=46_nul
>  '
> =20
> +test_expect_success 'check file in repo lf' '
> +	check_files_in_repo false "lf"    LF LF   LF          LF_mix_CR LF_=
nul &&
> +	check_files_in_repo true  "lf"    LF LF   LF          LF_mix_CR LF_=
nul &&
> +	check_files_in_repo input "lf"    LF LF   LF          LF_mix_CR LF_=
nul
> +'
> +
> +test_expect_success 'check file in repo crlf' '
> +	check_files_in_repo false "crlf"  LF LF   LF          LF_mix_CR LF_=
nul &&
> +	check_files_in_repo true  "crlf"  LF LF   LF          LF_mix_CR LF_=
nul &&
> +	check_files_in_repo input "crlf"  LF LF   LF          LF_mix_CR LF_=
nul
> +'
> +
>  ####################################################################=
############
>  # Check how files in the repo are changed when they are checked out
>  # How to read the table below:
> @@ -199,8 +256,8 @@ test_expect_success 'commit -text' '
>  # - parameter $8 : reference for a file with CRLF and a NUL (should =
be handled as binary when auto)
> =20
>  #                                            What we have in the rep=
o:
> -#                														 ----------------- EOL in repo ------=
----------
> -#                														 LF    CRLF  CRLF_mix_LF  LF_mix_CR  =
  CRLF_nul
> +#                                            ----------------- EOL i=
n repo ----------------
> +#                                            LF    CRLF  CRLF_mix_LF=
  LF_mix_CR    CRLF_nul
>  #                   settings with checkout:
>  #                   core.   core.   .gitattr
>  #                    eol     acrlf
