From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] ls-files: Add eol diagnostics
Date: Mon, 7 Dec 2015 00:28:20 -0500
Message-ID: <CAPig+cR3PLvMbKTUUdrD3hVrr5RWEmd0CxE6iyYhddqBYUQ57Q@mail.gmail.com>
References: <56649CD7.9000902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 07 06:28:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5oLZ-0004QI-RV
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 06:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbbLGF2W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2015 00:28:22 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36667 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbbLGF2V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2015 00:28:21 -0500
Received: by vkay187 with SMTP id y187so96033539vka.3
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 21:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=UQT2DwMD+MppQGXanybimkwnlJC3meCzqnhimpEsJUE=;
        b=LcgszgGaY5HjfOfE3qRcs3Jqzha7J12g62aGP4qys2bGX/Se/BrKG5+WeP1RXaQSja
         8eC6w7XVZFXInrgQN+wD34v9qs2BiDE8Hs327zOC3nC3+czOtovEu2Q50dkeMdRw0L7f
         GOIToTUwN8jhNgBAOJ/lIFgqVGCX9odOV00YRu8XJnHPBhMeeV+qgM1rVRgIibbDR4VW
         8bTWSeFCyBiWDIH52sY3Kk2Fzbjy0tNzinCi7VriLQUxg/h6ab7ONRg1s2Kas7yzmG2z
         C91iYdtGI3JYMjOPsw8Bz8aCRmRRe80YDwYxZLnP9eFt5JF3GGXBVhD7ZBpvrzTUgVyJ
         msZQ==
X-Received: by 10.31.182.129 with SMTP id g123mr20181730vkf.45.1449466100589;
 Sun, 06 Dec 2015 21:28:20 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 6 Dec 2015 21:28:20 -0800 (PST)
In-Reply-To: <56649CD7.9000902@web.de>
X-Google-Sender-Auth: nKU6CpHB5BEh-pQqUNRUdPD9zuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282079>

On Sun, Dec 6, 2015 at 3:38 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> When working in a cross-platform environment, a user wants to
> check if text files are stored normalized in the repository and if
> .gitattributes are set appropriately.
> [...]
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/convert.c b/convert.c
> @@ -95,6 +100,63 @@ static int is_binary(unsigned long size, struct t=
ext_stat *stats)
> +const char *get_wt_convert_stats_ascii(const char *path)
> +{
> +       const char *ret;
> +       struct strbuf sb =3D STRBUF_INIT;
> +       if (strbuf_read_file(&sb, path, 0) < 0)
> +               return "";

Given the implementation of strbuf_read_file(), some memory may have
been allocated to the strbuf even if it returns a failure, therefore
this may be leaking.

> +       ret =3D gather_convert_stats_ascii(sb.buf, sb.len);
> +       strbuf_release(&sb);
> +       return ret;
> +}

You may, therefore, want to restructure the code like this to avoid the=
 leak:

    const char *ret =3D "";
    struct strbuf sb =3D STRBUF_INIT;
    if (strbuf_read_file(...) >=3D 0)
        ret =3D gather_convert_stats_ascii(...);
    strbuf_release(&sb);
    return ret;

> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> @@ -213,7 +238,20 @@ checkout_files () {
>                         git -c core.eol=3D$eol checkout $src$f.txt
>                 fi
>         done
> -

Was dropping this blank line intentional?

> +       test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" "
> +               cat >e <<-EOF &&
> +               i/text-crlf w/$(stats_ascii $crlfname) ${src}CRLF.txt
> +               i/text-crlf-lf w/$(stats_ascii $lfmixcrlf) ${src}CRLF=
_mix_LF.txt
> +               i/text-lf w/$(stats_ascii $lfname) ${src}LF.txt
> +               i/binary w/$(stats_ascii $lfmixcr) ${src}LF_mix_CR.tx=
t
> +               i/binary w/$(stats_ascii $crlfnul) ${src}CRLF_nul.txt
> +               i/binary w/$(stats_ascii $crlfnul) ${src}LF_nul.txt
> +               EOF
> +               sort <e >expect &&
> +               git ls-files --eol $src* | sed -e 's!attr/[=3Da-z-]*!=
!g' -e 's/  */ /g' | sort >actual &&
> +               test_cmp expect actual &&
> +               rm e expect actual

If it is indeed important to cleanup these files so that they don't
muck up following tests, then you'd be better off using:

    test_when_finished "rm -f e expect actual"

at the top of the test to ensure that the cleanup happens regardless
of the whether the test succeeds or fails. On the other hand, if these
files won't muck up subsequent tests, then it may be fine to skip
cleanup altogether.

> +       "
>         test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D=
$crlf gitattributes=3D$attr file=3DLF" "
>                 compare_ws_file $pfx $lfname    ${src}LF.txt
>         "
> @@ -231,6 +269,37 @@ checkout_files () {
> +# Test control characters
> +# NUL SOH CR EOF=3D=3D^Z
> +test_expect_success 'ls-files --eol -o Text/Binary' '
> +       test_when_finished "rm e expect actual TeBi_*" &&

It's probably not a big deal, but "rm -f" perhaps?

> +       STRT=3DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA &&
> +       STR=3D$STRT$STRT$STRT$STRT &&
> +       printf "${STR}BBB\001" >TeBi_127_S &&
> +       printf "${STR}BBBB\001">TeBi_128_S &&
> +       printf "${STR}BBB\032" >TeBi_127_E &&
> +       printf "\032${STR}BBB" >TeBi_E_127 &&
> +       printf "${STR}BBBB\000">TeBi_128_N &&
> +       printf "${STR}BBB\012">TeBi_128_L &&
> +       printf "${STR}BBB\015">TeBi_127_C &&
> +       printf "${STR}BB\015\012" >TeBi_126_CL &&
> +       printf "${STR}BB\015\012\015" >TeBi_126_CLC &&
> +       cat >e <<-\EOF &&
> +       i/ w/binary TeBi_127_S
> +       i/ w/text-no-eol TeBi_128_S
> +       i/ w/text-no-eol TeBi_127_E
> +       i/ w/binary TeBi_E_127
> +       i/ w/binary TeBi_128_N
> +       i/ w/text-lf TeBi_128_L
> +       i/ w/binary TeBi_127_C
> +       i/ w/text-crlf TeBi_126_CL
> +       i/ w/binary TeBi_126_CLC
> +       EOF
> +       sort <e >expect &&
> +       git ls-files --eol -o | egrep "TeBi_" | sed -e 's!attr/[=3Da-=
z-]*!!g' -e "s/  */ /g" | sort >actual &&

Okay. "egrep" is used about as frequently in test scripts as "grep -E".

> +       test_cmp expect actual
> +'
> @@ -480,4 +549,20 @@ checkout_files    native  true  "lf"      LF    =
CRLF  CRLF_mix_LF  LF_mix_CR
> +# Should be the last test case
> +test_expect_success 'ls-files --eol -d' "
> +       rm  crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.tx=
t crlf_false_attr__LF.txt .gitattributes &&

Did you mean to wrap this in test_when_finished()?

If not, is it cleaning up gunk left by some earlier test(s)? If so,
what happens if one of those tests failed and didn't create one of
these files? In that case, this 'rm' would fail, causing this entire
test to fail. Better would be to use "rm -f".

> +       cat >expect <<-\EOF &&
> +       i/text-crlf w/ crlf_false_attr__CRLF.txt
> +       i/text-crlf-lf w/ crlf_false_attr__CRLF_mix_LF.txt
> +       i/text-lf w/ .gitattributes
> +       i/text-lf w/ crlf_false_attr__LF.txt
> +       EOF
> +       git ls-files --eol -d | sed -e 's!attr/[=3Da-z-]*!!g' -e 's/ =
 */ /g' | sort >actual &&
> +       test_cmp expect actual &&
> +       rm expect actual
> +"
> +
> +

Style: Drop the extra blank line.

>  test_done
> --
> 2.6.2.403.gd7a84e3
