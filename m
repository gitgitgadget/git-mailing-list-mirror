Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1980A1F45F
	for <e@80x24.org>; Tue,  7 May 2019 03:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfEGDnI (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 23:43:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58295 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfEGDnI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 23:43:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 940A913CC49;
        Mon,  6 May 2019 23:43:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S1VXCcdhSsp2
        BSlJIb6ozLaWa6k=; b=SDfh+n7ESMYMyRmOl3vznEptHbdGGTXLI6mJet+TnVVg
        lLN6kVfduMILRVrSLxOZPMCaC374mXyK108G0vB4346L2hEaAT4NCOo4XEbgk3tT
        7/KXhZVrOEAc1r11ivNxwz0y8CNTjqaS2zQSOWifpcmt+12qfLcy0gR48jNxd1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rENr7u
        5JiRjik+pIKneJbLG7hBHnSU9z6gdLpC6nIPfvdsMG7+71gXWzL4eu+VpC3L3ZU0
        lErzmVrXOScw05utDr15tLwG//TQTK5rctzfbos3D94BKotBdw+xprCs8EocV4b7
        e2U9h6wL6p/nG/1ReUvZgnoUZho/dxCGnaeqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B6BB13CC48;
        Mon,  6 May 2019 23:43:03 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFFAA13CC45;
        Mon,  6 May 2019 23:43:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        liu.denton@gmail.com
Subject: Re: [PATCH v2] parse-options: don't emit "ambiguous option" for aliases
References: <20190422122250.15248-1-pclouds@gmail.com>
        <20190429100525.32045-1-pclouds@gmail.com>
Date:   Tue, 07 May 2019 12:43:01 +0900
In-Reply-To: <20190429100525.32045-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 29 Apr 2019 17:05:25 +0700")
Message-ID: <xmqq1s1bnd4q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3770D02A-707A-11E9-8773-E828E74BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> But due to the way the options parsing machinery works this resulted
> in the rather absurd situation of:
>
>     $ git clone --recurs [...]
>     error: ambiguous option: recurs (could be --recursive or --recurse-=
submodules)
>
> Add OPT_ALIAS() to express this link between two or more options and us=
e
> it in git-clone. Multiple aliases of an option could be written as
>
>     OPT_ALIAS(0, "alias1", "original-name"),
>     OPT_ALIAS(0, "alias2", "original-name"),
>     ...
>
> The current implementation is not exactly optimal in this case. But we
> can optimize it when it becomes a problem. So far we don't even have tw=
o
> aliases of any option.

Sounds good enough for any practical need I can forsee ;-)  Thanks.

> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index 800b3ea5f5..cebc77fab0 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -48,6 +48,12 @@ Standard options
>      -q, --quiet           be quiet
>      --expect <string>     expected output in the variable dump
> =20
> +Alias
> +    -A, --alias-source <string>
> +                          get a string
> +    -Z, --alias-target <string>
> +                          get a string
> +
>  EOF

This is not a new problem per-se, as there already is a line before
the precontext of this hunk that shares the same issue, but to
prevent future problems, I am very much tempted to apply the
attached on top.

-- >8 --
Subject: t0040: protect lines that are indented by spaces

This block is byte-for-byte identical expected output, that contains a
few lines that are indented in many spaces, which makes "git diff --check=
"
unhappy and will break the test when "git am --whitespace=3Dfix" is
allowed to "correct" them.

Protect the left edge with a marker character, and strip it with
sed, which is used as a standard way to deal with this issue in our
test suite.

Signed-off-by: Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Of course, if the right-edge need to be protected, we can do so
   as well.

 t/t0040-parse-options.sh | 94 ++++++++++++++++++++++++------------------=
------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index cebc77fab0..26373b5b72 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -7,53 +7,53 @@ test_description=3D'our own option parser'
=20
 . ./test-lib.sh
=20
-cat >expect <<\EOF
-usage: test-tool parse-options <options>
-
-    A helper function for the parse-options API.
-
-    --yes                 get a boolean
-    -D, --no-doubt        begins with 'no-'
-    -B, --no-fear         be brave
-    -b, --boolean         increment by one
-    -4, --or4             bitwise-or boolean with ...0100
-    --neg-or4             same as --no-or4
-
-    -i, --integer <n>     get a integer
-    -j <n>                get a integer, too
-    -m, --magnitude <n>   get a magnitude
-    --set23               set integer to 23
-    -L, --length <str>    get length of <str>
-    -F, --file <file>     set file to <file>
-
-String options
-    -s, --string <string>
-                          get a string
-    --string2 <str>       get another string
-    --st <st>             get another string (pervert ordering)
-    -o <str>              get another string
-    --list <str>          add str to list
-
-Magic arguments
-    --quux                means --quux
-    -NUM                  set integer to NUM
-    +                     same as -b
-    --ambiguous           positive ambiguity
-    --no-ambiguous        negative ambiguity
-
-Standard options
-    --abbrev[=3D<n>]        use <n> digits to display SHA-1s
-    -v, --verbose         be verbose
-    -n, --dry-run         dry run
-    -q, --quiet           be quiet
-    --expect <string>     expected output in the variable dump
-
-Alias
-    -A, --alias-source <string>
-                          get a string
-    -Z, --alias-target <string>
-                          get a string
-
+sed -e 's/^|//' >expect <<\EOF
+|usage: test-tool parse-options <options>
+|
+|    A helper function for the parse-options API.
+|
+|    --yes                 get a boolean
+|    -D, --no-doubt        begins with 'no-'
+|    -B, --no-fear         be brave
+|    -b, --boolean         increment by one
+|    -4, --or4             bitwise-or boolean with ...0100
+|    --neg-or4             same as --no-or4
+|
+|    -i, --integer <n>     get a integer
+|    -j <n>                get a integer, too
+|    -m, --magnitude <n>   get a magnitude
+|    --set23               set integer to 23
+|    -L, --length <str>    get length of <str>
+|    -F, --file <file>     set file to <file>
+|
+|String options
+|    -s, --string <string>
+|                          get a string
+|    --string2 <str>       get another string
+|    --st <st>             get another string (pervert ordering)
+|    -o <str>              get another string
+|    --list <str>          add str to list
+|
+|Magic arguments
+|    --quux                means --quux
+|    -NUM                  set integer to NUM
+|    +                     same as -b
+|    --ambiguous           positive ambiguity
+|    --no-ambiguous        negative ambiguity
+|
+|Standard options
+|    --abbrev[=3D<n>]        use <n> digits to display SHA-1s
+|    -v, --verbose         be verbose
+|    -n, --dry-run         dry run
+|    -q, --quiet           be quiet
+|    --expect <string>     expected output in the variable dump
+|
+|Alias
+|    -A, --alias-source <string>
+|                          get a string
+|    -Z, --alias-target <string>
+|                          get a string
+|
 EOF
=20
 test_expect_success 'test help' '
