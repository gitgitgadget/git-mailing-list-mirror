From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] ls-files: Add eol diagnostics
Date: Sun, 29 Nov 2015 03:17:38 -0500
Message-ID: <CAPig+cT-z8SyeY-pentrCHr=g3zt4cW9YOFxFs0nT9_C-QvFwg@mail.gmail.com>
References: <5659C32C.50007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 29 12:02:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2zkZ-000819-6o
	for gcvg-git-2@plane.gmane.org; Sun, 29 Nov 2015 12:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbbK2IRl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2015 03:17:41 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36536 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbbK2IRj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2015 03:17:39 -0500
Received: by vkay187 with SMTP id y187so86824400vka.3
        for <git@vger.kernel.org>; Sun, 29 Nov 2015 00:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ZDdCADWZV0GMOBlyxrko9aUaUfDyMl4lZbvTUk383vY=;
        b=o86+yLn4Iqcom74PbwtthAB8zkfMU30J0F4PWYmxo8ctRSSNYciokJ/zE9bxSN4WP2
         NeHvlemacdcsPE4if69ts4IecoW5kZ7W7O99alWmf/EZmAe8dJ+VAwXnISHPE4F34x9d
         Jmjw74Lo8Xj3Hc6yb+NhAmwmqcQjMj/BeRac8s5w2H+v8iMTVN1+LPSShoKlRdtqE8fH
         rZUSf9m1BTwnE0s2fAeG0Ew33AhIgwM7tV4gm5A1KlcW5Kv3GBSei0JevuyQtumymaLD
         vpU3P4K7jPmJ2AjC0R4P3R2vVwx76lKHCSYrA0jrhLwvd5Of9TTslV9+QEp/TOcLItJ4
         ubbQ==
X-Received: by 10.31.52.82 with SMTP id b79mr49720009vka.84.1448785058826;
 Sun, 29 Nov 2015 00:17:38 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 29 Nov 2015 00:17:38 -0800 (PST)
In-Reply-To: <5659C32C.50007@web.de>
X-Google-Sender-Auth: c0dc-4yXr6GWsIFzdXQ1CM0VFag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281797>

On Sat, Nov 28, 2015 at 10:07 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> @@ -213,7 +238,20 @@ checkout_files () {
>                         git -c core.eol=3D$eol checkout $src$f.txt
>                 fi
>         done
> -
> +       test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" "
> +               cat >e <<-EOF &&

This here-doc requires interpolation, hence -EOF is fine, however...

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
> +       "
>         test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D=
$crlf gitattributes=3D$attr file=3DLF" "
>                 compare_ws_file $pfx $lfname    ${src}LF.txt
>         "
> @@ -231,6 +269,37 @@ checkout_files () {
>         "
>  }
>
> +# Test control characters
> +# NUL SOH CR EOF=3D=3D^Z
> +test_expect_success 'ls-files --eol -o Text/Binary' '
> +       test_when_finished "rm e expect actual TeBi_*" &&
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
> +       cat >e <<-EOF &&

Nit: [1] suggested using -\EOF since this here-doc needs no interpolati=
on.

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
> +       test_cmp expect actual
> +'
> @@ -480,4 +549,20 @@ checkout_files    native  true  "lf"      LF    =
CRLF  CRLF_mix_LF  LF_mix_CR
> +# Should be the last test case
> +test_expect_success 'ls-files --eol -d' "
> +       rm  crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.tx=
t crlf_false_attr__LF.txt .gitattributes &&
> +       cat >expect <<-EOF &&

Likewise.

[1]: http://marc.info/?l=3Dgit&m=3D144829967800565&w=3D2

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
>  test_done
> --
> 2.6.2.403.gd7a84e3
