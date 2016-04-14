From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] submodule: port resolve_relative_url from shell to C
Date: Thu, 14 Apr 2016 12:37:04 -0700
Message-ID: <CAGZ79kYZaurmnPPTUqSOYgr3V0Pnj1S+AycF9-fi_4n9+egR-Q@mail.gmail.com>
References: <1460657909-1329-1-git-send-email-sbeller@google.com>
	<1460657909-1329-2-git-send-email-sbeller@google.com>
	<570FF105.3040204@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:37:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqn4k-0003EH-BI
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 21:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbcDNThH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2016 15:37:07 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36177 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbcDNThG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2016 15:37:06 -0400
Received: by mail-io0-f170.google.com with SMTP id u185so114207254iod.3
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=8PyLVBldmcVSeru8I6pgnkyfR24oJhIW28ky7FdLRG0=;
        b=kDMzlmgU3p2+skL8yADrZlF1TgGcu0DbtbboRf6u7vjm047ZIs4zXypzO+om5pWP9w
         GecavaKDk2e9FX5gR87RggyS/si2HadtCcU+/je9zL/F5RJ58uH0514HC8GDqCPLoJZe
         hVFampsJSKYMxpDdntxNnX2uQDKzjvG94XPDBw03oE99lcCanbsQoNm+Ip97SrJ5Z7/z
         4ydHzryoo59qQ7LFiPicgqDo+NuVWIIOZ3Esnp8lkAq+dtNgeYx/Qlzyk7S+7UTbIfq8
         AkFha+g7RGhrkqEAm2IHlzYrmJQ/09OhNZ4+4Njdke7j+b21fAIE8gp1t7WDr3zpwo59
         NXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=8PyLVBldmcVSeru8I6pgnkyfR24oJhIW28ky7FdLRG0=;
        b=He0kDRyBkCdXMXDJlyTMToRQdgfnpIv6300O9tWGQ6puYQqmKueTDAwIdqZBDwkW5W
         bVfYt3oj3bPsufpoRuVFmGglHGWWrSqJf1hFZRJvXzwTSLV4zzv15SQ7gMR6sipBfBTY
         MrlAcPvXwLDZbY/F2VU5PnJppkSaGGYB4X3XAXBCxZtv9/CP2fSJN3XV5N1Gomk5Z+r3
         f6ounxFLmV/DW9LgjowJe03RTAn5wjKUQrBiZyS0wlmpR9Z2HSGbXuXjfuCzKiGAgd/f
         eqr4DhZNh1zyXBac2efNFY+uRIyz9ur8T5LyCnyrK1KjBAiQq+JItfDQbR0DMNfhQeaI
         pAxw==
X-Gm-Message-State: AOPr4FUC+AAKagLHCa+EP4XpqkxW9J8BmLzrkvZf9+AyDeYADo6/LjhH0WtEInT3iOuGU41beWRqd3WIYEjXQTD3
X-Received: by 10.107.161.68 with SMTP id k65mr20698988ioe.110.1460662624918;
 Thu, 14 Apr 2016 12:37:04 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 14 Apr 2016 12:37:04 -0700 (PDT)
In-Reply-To: <570FF105.3040204@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291560>

On Thu, Apr 14, 2016 at 12:35 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 14.04.2016 um 20:18 schrieb Stefan Beller:
>> @@ -298,4 +305,40 @@ test_git_path GIT_COMMON_DIR=3Dbar config      =
             bar/config
>>   test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/pa=
cked-refs
>>   test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/sh=
allow
>>
>> +test_submodule_relative_url "../" "../foo" "../submodule" "../../su=
bmodule"
>> +test_submodule_relative_url "../" "../foo/bar" "../submodule" "../.=
=2E/foo/submodule"
>> +test_submodule_relative_url "../" "../foo/submodule" "../submodule"=
 "../../foo/submodule"
>> +test_submodule_relative_url "../" "./foo" "../submodule" "../submod=
ule"
>> +test_submodule_relative_url "../" "./foo/bar" "../submodule" "../fo=
o/submodule"
>> +test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c"=
 "../../../../foo/sub/a/b/c"
>> +test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$PWD/re=
po"
>> +test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/=
submodule"
>> +test_submodule_relative_url "../" "foo" "../submodule" "../submodul=
e"
>> +
>> +test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" ".=
=2E/foo/sub/a/b/c"
>> +test_submodule_relative_url "(null)" "../foo/bar" "../submodule" ".=
=2E/foo/submodule"
>> +test_submodule_relative_url "(null)" "../foo/submodule" "../submodu=
le" "../foo/submodule"
>> +test_submodule_relative_url "(null)" "../foo" "../submodule" "../su=
bmodule"
>> +test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "fo=
o/submodule"
>> +test_submodule_relative_url "(null)" "./foo" "../submodule" "submod=
ule"
>> +test_submodule_relative_url "(null)" "//somewhere else/repo" "../su=
brepo" "//somewhere else/subrepo"
>> +test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../s=
ubsubsuper_update_r" "$PWD/subsubsuper_update_r"
>> +test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../sub=
super_update_r" "$PWD/subsuper_update_r"
>> +test_submodule_relative_url "(null)" "$PWD/." "../." "$PWD/."
>> +test_submodule_relative_url "(null)" "$PWD" "./." "$PWD/."
>> +test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$PWD=
/repo"
>> +test_submodule_relative_url "(null)" "$PWD" "./=C3=A5 =C3=A4=C3=B6"=
 "$PWD/=C3=A5 =C3=A4=C3=B6"
>> +test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$PWD/=
submodule"
>> +test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule=
" "$PWD/submodule"
>> +test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bun=
dle1" "$PWD/home2/../bundle1"
>> +test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "=
=2E/." "$PWD/submodule_update_repo/."
>> +test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo=
" "file:///tmp/subrepo"
>> +test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/=
submodule"
>> +test_submodule_relative_url "(null)" "foo" "../submodule" "submodul=
e"
>> +test_submodule_relative_url "(null)" "helper:://hostname/repo" "../=
subrepo" "helper:://hostname/subrepo"
>> +test_submodule_relative_url "(null)" "ssh://hostname/repo" "../subr=
epo" "ssh://hostname/subrepo"
>> +test_submodule_relative_url "(null)" "ssh://hostname:22/repo" "../s=
ubrepo" "ssh://hostname:22/subrepo"
>> +test_submodule_relative_url "(null)" "user@host:path/to/repo" "../s=
ubrepo" "user@host:path/to/subrepo"
>> +test_submodule_relative_url "(null)" "user@host:repo" "../subrepo" =
"user@host:subrepo"
>> +
>>   test_done
>>
>
> I am very sorry that I am chiming in again so late. I forgot to menti=
on
> that this requires a fixup on Windows as below. I won't mind to submi=
t
> the fixup as a follow-on patch, but you could also squash it in if ye=
t
> another round is required.

Thanks a lot for testing a patch on Windows!
I'll pick this up in a resend.


>
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 579c1fa..1d19fbb 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -293,13 +293,16 @@ test_git_path GIT_COMMON_DIR=3Dbar config      =
             bar/config
>  test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/pack=
ed-refs
>  test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/shal=
low
>
> +# In the tests below, the distinction between $PWD and $(pwd) is imp=
ortant:
> +# on Windows, $PWD is POSIX style (/c/foo), $(pwd) has drive letter =
(c:/foo).
> +
>  test_submodule_relative_url "../" "../foo" "../submodule" "../../sub=
module"
>  test_submodule_relative_url "../" "../foo/bar" "../submodule" "../..=
/foo/submodule"
>  test_submodule_relative_url "../" "../foo/submodule" "../submodule" =
"../../foo/submodule"
>  test_submodule_relative_url "../" "./foo" "../submodule" "../submodu=
le"
>  test_submodule_relative_url "../" "./foo/bar" "../submodule" "../foo=
/submodule"
>  test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c" =
"../../../../foo/sub/a/b/c"
> -test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$PWD/rep=
o"
> +test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$(pwd)/r=
epo"
>  test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/s=
ubmodule"
>  test_submodule_relative_url "../" "foo" "../submodule" "../submodule=
"
>
> @@ -310,16 +313,16 @@ test_submodule_relative_url "(null)" "../foo" "=
=2E./submodule" "../submodule"
>  test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "foo=
/submodule"
>  test_submodule_relative_url "(null)" "./foo" "../submodule" "submodu=
le"
>  test_submodule_relative_url "(null)" "//somewhere else/repo" "../sub=
repo" "//somewhere else/subrepo"
> -test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../su=
bsubsuper_update_r" "$PWD/subsubsuper_update_r"
> -test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subs=
uper_update_r" "$PWD/subsuper_update_r"
> -test_submodule_relative_url "(null)" "$PWD/." "../." "$PWD/."
> -test_submodule_relative_url "(null)" "$PWD" "./." "$PWD/."
> -test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$PWD/=
repo"
> -test_submodule_relative_url "(null)" "$PWD" "./=C3=83=C2=A5 =C3=83=C2=
=A4=C3=83=C2=B6" "$PWD/=C3=83=C2=A5 =C3=83=C2=A4=C3=83=C2=B6"
> -test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$PWD/s=
ubmodule"
> -test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule"=
 "$PWD/submodule"
> -test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bund=
le1" "$PWD/home2/../bundle1"
> -test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" ".=
/." "$PWD/submodule_update_repo/."
> +test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../su=
bsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
> +test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subs=
uper_update_r" "$(pwd)/subsuper_update_r"
> +test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
> +test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)/."
> +test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd=
)/repo"
> +test_submodule_relative_url "(null)" "$PWD" "./=C3=83=C2=A5 =C3=83=C2=
=A4=C3=83=C2=B6" "$(pwd)/=C3=83=C2=A5 =C3=83=C2=A4=C3=83=C2=B6"
> +test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$(pwd)=
/submodule"
> +test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule"=
 "$(pwd)/submodule"
> +test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bund=
le1" "$(pwd)/home2/../bundle1"
> +test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" ".=
/." "$(pwd)/submodule_update_repo/."
>  test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo"=
 "file:///tmp/subrepo"
>  test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/s=
ubmodule"
>  test_submodule_relative_url "(null)" "foo" "../submodule" "submodule=
"
> --
> 2.7.0.118.g90056ae
>
