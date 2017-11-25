Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAE92036D
	for <e@80x24.org>; Sat, 25 Nov 2017 03:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdKYDQI (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 22:16:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61717 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751882AbdKYDQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 22:16:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4424BAC40;
        Fri, 24 Nov 2017 22:16:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=o7E6Ej8mB/GK
        5ZHff/WWe4J+6qY=; b=pTeksY4052DRDAo1ejY7c7nQdp9lTpjawT5QFc+Yz4XJ
        6uzQNU6uTt4s4hT0QzlEz41Z5fYX+VzcQLGY9+6D6MYTD9StdKHtZ60NDHkGXfzx
        jj3A7i+qteKxVj3JP6IWIzKnSy0bcwuwW+M8CbhTiJ46m8Jzj2hK9lEsLV8y/Jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fjdJNZ
        6+aRKT2EF0HncdgP4wmmRY9rmFQo3+sX1li2tOsZQzePFCuUrRKRewhsTq6ExSXn
        LwExJWHpdnveDcHC7b/SrPNHH7CECge1n8Ha9RLFo3/vMZI7sJTB0+n0ZiB4gYTd
        eGAiU5gmrgyJSI51KuS6+cukikXF419Dm8ndU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCDE4BAC3F;
        Fri, 24 Nov 2017 22:16:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3718EBAC3E;
        Fri, 24 Nov 2017 22:16:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, ashishnegi33@gmail.com
Subject: Re: [PATCH 1/1] convert: tighten the safe autocrlf handling
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
        <20171124161407.30698-1-tboegi@web.de>
Date:   Sat, 25 Nov 2017 12:16:03 +0900
In-Reply-To: <20171124161407.30698-1-tboegi@web.de> (tboegi@web.de's message
        of "Fri, 24 Nov 2017 17:14:07 +0100")
Message-ID: <xmqqlgivkpzg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F9124E5C-D18E-11E7-935F-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> When a text file had been commited with CRLF and the file is commited
> again, the CRLF are kept if .gitattributs has "text=3Dauto".
> This is done by analyzing the content of the blob stored in the index:
> If a '\r' is found, Git assumes that the blob was commited with CRLF.
>
> The simple search for a '\r' does not always work as expected:
> A file is encoded in UTF-16 with CRLF and commited. Git treats it as bi=
nary.
> Now the content is converted into UTF-8. At the next commit Git treats =
the
> file as text, the CRLF should be converted into LF, but isn't.
>
> Solution:

Remove this line.

> Replace has_cr_in_index() with has_crlf_in_index(). When no '\r' is fou=
nd,
> 0 is returned directly, this is the most common case.
> If a '\r' is found, the content is analyzed more deeply.

I may be recalling things incorrectly, but didn't an old version of
the code check CRLF explicitly, unlike the current implementation
that only check CRs?

In any case, I think we have accumulated enough cruft only to work
around the issues caused by "safe" crlf.  I moderately strongly
wonder if we should go back and think if that "feature" is adding
much value, and remove it if it is not.

In the meantime, let's queue this fix on top of the "safe crlf
workaround" pile.

Thanks.

>
> Reported-By: Ashish Negi <ashishnegi33@gmail.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  convert.c            | 19 +++++++++----
>  t/t0027-auto-crlf.sh | 76 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
>  2 files changed, 85 insertions(+), 10 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index 20d7ab67bd..63ef799239 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -220,18 +220,27 @@ static void check_safe_crlf(const char *path, enu=
m crlf_action crlf_action,
>  	}
>  }
> =20
> -static int has_cr_in_index(const struct index_state *istate, const cha=
r *path)
> +static int has_crlf_in_index(const struct index_state *istate, const c=
har *path)
>  {
>  	unsigned long sz;
>  	void *data;
> -	int has_cr;
> +	const char *crp;
> +	int has_crlf =3D 0;
> =20
>  	data =3D read_blob_data_from_index(istate, path, &sz);
>  	if (!data)
>  		return 0;
> -	has_cr =3D memchr(data, '\r', sz) !=3D NULL;
> +
> +	crp =3D memchr(data, '\r', sz);
> +	if (crp && (crp[1] =3D=3D '\n')) {
> +		unsigned int ret_stats;
> +		ret_stats =3D gather_convert_stats(data, sz);
> +		if (!(ret_stats & CONVERT_STAT_BITS_BIN) &&
> +		    (ret_stats & CONVERT_STAT_BITS_TXT_CRLF))
> +			has_crlf =3D 1;
> +	}
>  	free(data);
> -	return has_cr;
> +	return has_crlf;
>  }
> =20
>  static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats=
,
> @@ -290,7 +299,7 @@ static int crlf_to_git(const struct index_state *is=
tate,
>  		 * cherry-pick.
>  		 */
>  		if ((checksafe !=3D SAFE_CRLF_RENORMALIZE) &&
> -		    has_cr_in_index(istate, path))
> +		    has_crlf_in_index(istate, path))
>  			convert_crlf_into_lf =3D 0;
>  	}
>  	if ((checksafe =3D=3D SAFE_CRLF_WARN ||
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 68108d956a..0af35cfb1f 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -43,19 +43,31 @@ create_gitattributes () {
>  	} >.gitattributes
>  }
> =20
> -create_NNO_files () {
> +# Create 2 sets of files:
> +# The NNO files are "Not NOrmalized in the repo. We use CRLF_mix_LF an=
d store
> +#   it under different names for the different test cases, see ${pfx}
> +#   Depending on .gitattributes they are normalized at the next commit=
 (or not)
> +# The MIX files have different contents in the repo.
> +#   Depending on its contents, the "new safer autocrlf" may kick in.
> +create_NNO_MIX_files () {
>  	for crlf in false true input
>  	do
>  		for attr in "" auto text -text
>  		do
>  			for aeol in "" lf crlf
>  			do
> -				pfx=3DNNO_attr_${attr}_aeol_${aeol}_${crlf}
> +				pfx=3DNNO_attr_${attr}_aeol_${aeol}_${crlf} &&
>  				cp CRLF_mix_LF ${pfx}_LF.txt &&
>  				cp CRLF_mix_LF ${pfx}_CRLF.txt &&
>  				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
>  				cp CRLF_mix_LF ${pfx}_LF_mix_CR.txt &&
> -				cp CRLF_mix_LF ${pfx}_CRLF_nul.txt
> +				cp CRLF_mix_LF ${pfx}_CRLF_nul.txt &&
> +				pfx=3DMIX_attr_${attr}_aeol_${aeol}_${crlf} &&
> +				cp LF          ${pfx}_LF.txt &&
> +				cp CRLF        ${pfx}_CRLF.txt &&
> +				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
> +				cp LF_mix_CR   ${pfx}_LF_mix_CR.txt &&
> +				cp CRLF_nul    ${pfx}_CRLF_nul.txt
>  			done
>  		done
>  	done
> @@ -136,6 +148,49 @@ commit_chk_wrnNNO () {
>  	'
>  }
> =20
> +# Commit a file with mixed line endings on top of different files
> +# in the index. Check for warnings
> +commit_MIX_chkwrn () {
> +	attr=3D$1 ; shift
> +	aeol=3D$1 ; shift
> +	crlf=3D$1 ; shift
> +	lfwarn=3D$1 ; shift
> +	crlfwarn=3D$1 ; shift
> +	lfmixcrlf=3D$1 ; shift
> +	lfmixcr=3D$1 ; shift
> +	crlfnul=3D$1 ; shift
> +	pfx=3DMIX_attr_${attr}_aeol_${aeol}_${crlf}
> +	#Commit file with CLRF_mix_LF on top of existing file
> +	create_gitattributes "$attr" $aeol &&
> +	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
> +	do
> +		fname=3D${pfx}_$f.txt &&
> +		cp CRLF_mix_LF $fname &&
> +		printf Z >>"$fname" &&
> +		git -c core.autocrlf=3D$crlf add $fname 2>"${pfx}_$f.err"
> +	done
> +
> +	test_expect_success "commit file with mixed EOL crlf=3D$crlf attr=3D$=
attr LF" '
> +		check_warning "$lfwarn" ${pfx}_LF.err
> +	'
> +	test_expect_success "commit file with mixed EOL attr=3D$attr aeol=3D$=
aeol crlf=3D$crlf CRLF" '
> +		check_warning "$crlfwarn" ${pfx}_CRLF.err
> +	'
> +
> +	test_expect_success "commit file with mixed EOL attr=3D$attr aeol=3D$=
aeol crlf=3D$crlf CRLF_mix_LF" '
> +		check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err
> +	'
> +
> +	test_expect_success "commit file with mixed EOL attr=3D$attr aeol=3D$=
aeol crlf=3D$crlf LF_mix_cr" '
> +		check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err
> +	'
> +
> +	test_expect_success "commit file with mixed EOL attr=3D$attr aeol=3D$=
aeol crlf=3D$crlf CRLF_nul" '
> +		check_warning "$crlfnul" ${pfx}_CRLF_nul.err
> +	'
> +}
> +
> +
>  stats_ascii () {
>  	case "$1" in
>  	LF)
> @@ -323,8 +378,8 @@ test_expect_success 'setup master' '
>  	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\=
r\nLINETWO\rLINETHREE"   >CRLF_mix_CR &&
>  	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONEQ=
\r\nLINETWO\r\nLINETHREE" | q_to_nul >CRLF_nul &&
>  	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONEQ\n=
LINETWO\nLINETHREE" | q_to_nul >LF_nul &&
> -	create_NNO_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF=
_mix_LF &&
> -	git -c core.autocrlf=3Dfalse add NNO_*.txt &&
> +	create_NNO_MIX_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF =
CRLF_mix_LF &&
> +	git -c core.autocrlf=3Dfalse add NNO_*.txt MIX_*.txt &&
>  	git commit -m "mixed line endings" &&
>  	test_tick
>  '
> @@ -385,6 +440,17 @@ test_expect_success 'commit files attr=3Dcrlf' '
>  	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""
>  '
> =20
> +# Commit "CRLFmixLF" on top of these files already in the repo:
> +# LF, CRLF, CRLFmixLF LF_mix_CR CRLFNULL
> +#                 attr                    LF        CRLF      CRLFmixL=
F   LF_mix_CR   CRLFNUL
> +commit_MIX_chkwrn ""      ""      false   ""        ""        ""      =
    ""          ""
> +commit_MIX_chkwrn ""      ""      true    "LF_CRLF" ""        ""      =
    "LF_CRLF"   "LF_CRLF"
> +commit_MIX_chkwrn ""      ""      input   "CRLF_LF" ""        ""      =
    "CRLF_LF"   "CRLF_LF"
> +
> +commit_MIX_chkwrn "auto"  ""      false   "CRLF_LF" ""        ""      =
    "CRLF_LF"   "CRLF_LF"
> +commit_MIX_chkwrn "auto"  ""      true    "LF_CRLF" ""        ""      =
    "LF_CRLF"   "LF_CRLF"
> +commit_MIX_chkwrn "auto"  ""      input   "CRLF_LF" ""        ""      =
    "CRLF_LF"   "CRLF_LF"
> +
>  #                 attr                    LF        CRLF      CRLFmixL=
F   LF_mix_CR   CRLFNUL
>  commit_chk_wrnNNO ""      ""      false   ""        ""        ""      =
    ""          ""
>  commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""      =
    ""          ""
