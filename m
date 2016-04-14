From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] submodule: port resolve_relative_url from shell to C
Date: Thu, 14 Apr 2016 21:35:33 +0200
Message-ID: <570FF105.3040204@kdbg.org>
References: <1460657909-1329-1-git-send-email-sbeller@google.com>
 <1460657909-1329-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:35:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqn3G-0002Qt-BV
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 21:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbcDNTfi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2016 15:35:38 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:25227 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbcDNTfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 15:35:37 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3qm9r64mgJz5tlC;
	Thu, 14 Apr 2016 21:35:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B1414522E;
	Thu, 14 Apr 2016 21:35:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <1460657909-1329-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291559>

Am 14.04.2016 um 20:18 schrieb Stefan Beller:
> @@ -298,4 +305,40 @@ test_git_path GIT_COMMON_DIR=3Dbar config       =
            bar/config
>   test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/pac=
ked-refs
>   test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/sha=
llow
>  =20
> +test_submodule_relative_url "../" "../foo" "../submodule" "../../sub=
module"
> +test_submodule_relative_url "../" "../foo/bar" "../submodule" "../..=
/foo/submodule"
> +test_submodule_relative_url "../" "../foo/submodule" "../submodule" =
"../../foo/submodule"
> +test_submodule_relative_url "../" "./foo" "../submodule" "../submodu=
le"
> +test_submodule_relative_url "../" "./foo/bar" "../submodule" "../foo=
/submodule"
> +test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c" =
"../../../../foo/sub/a/b/c"
> +test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$PWD/rep=
o"
> +test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/s=
ubmodule"
> +test_submodule_relative_url "../" "foo" "../submodule" "../submodule=
"
> +
> +test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "..=
/foo/sub/a/b/c"
> +test_submodule_relative_url "(null)" "../foo/bar" "../submodule" "..=
/foo/submodule"
> +test_submodule_relative_url "(null)" "../foo/submodule" "../submodul=
e" "../foo/submodule"
> +test_submodule_relative_url "(null)" "../foo" "../submodule" "../sub=
module"
> +test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "foo=
/submodule"
> +test_submodule_relative_url "(null)" "./foo" "../submodule" "submodu=
le"
> +test_submodule_relative_url "(null)" "//somewhere else/repo" "../sub=
repo" "//somewhere else/subrepo"
> +test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../su=
bsubsuper_update_r" "$PWD/subsubsuper_update_r"
> +test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subs=
uper_update_r" "$PWD/subsuper_update_r"
> +test_submodule_relative_url "(null)" "$PWD/." "../." "$PWD/."
> +test_submodule_relative_url "(null)" "$PWD" "./." "$PWD/."
> +test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$PWD/=
repo"
> +test_submodule_relative_url "(null)" "$PWD" "./=C3=A5 =C3=A4=C3=B6" =
"$PWD/=C3=A5 =C3=A4=C3=B6"
> +test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$PWD/s=
ubmodule"
> +test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule"=
 "$PWD/submodule"
> +test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bund=
le1" "$PWD/home2/../bundle1"
> +test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" ".=
/." "$PWD/submodule_update_repo/."
> +test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo"=
 "file:///tmp/subrepo"
> +test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/s=
ubmodule"
> +test_submodule_relative_url "(null)" "foo" "../submodule" "submodule=
"
> +test_submodule_relative_url "(null)" "helper:://hostname/repo" "../s=
ubrepo" "helper:://hostname/subrepo"
> +test_submodule_relative_url "(null)" "ssh://hostname/repo" "../subre=
po" "ssh://hostname/subrepo"
> +test_submodule_relative_url "(null)" "ssh://hostname:22/repo" "../su=
brepo" "ssh://hostname:22/subrepo"
> +test_submodule_relative_url "(null)" "user@host:path/to/repo" "../su=
brepo" "user@host:path/to/subrepo"
> +test_submodule_relative_url "(null)" "user@host:repo" "../subrepo" "=
user@host:subrepo"
> +
>   test_done
>=20

I am very sorry that I am chiming in again so late. I forgot to mention
that this requires a fixup on Windows as below. I won't mind to submit
the fixup as a follow-on patch, but you could also squash it in if yet
another round is required.

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 579c1fa..1d19fbb 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -293,13 +293,16 @@ test_git_path GIT_COMMON_DIR=3Dbar config        =
           bar/config
 test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/packed=
-refs
 test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/shallo=
w
=20
+# In the tests below, the distinction between $PWD and $(pwd) is impor=
tant:
+# on Windows, $PWD is POSIX style (/c/foo), $(pwd) has drive letter (c=
:/foo).
+
 test_submodule_relative_url "../" "../foo" "../submodule" "../../submo=
dule"
 test_submodule_relative_url "../" "../foo/bar" "../submodule" "../../f=
oo/submodule"
 test_submodule_relative_url "../" "../foo/submodule" "../submodule" ".=
=2E/../foo/submodule"
 test_submodule_relative_url "../" "./foo" "../submodule" "../submodule=
"
 test_submodule_relative_url "../" "./foo/bar" "../submodule" "../foo/s=
ubmodule"
 test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c" ".=
=2E/../../../foo/sub/a/b/c"
-test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$PWD/repo"
+test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$(pwd)/rep=
o"
 test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/sub=
module"
 test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
=20
@@ -310,16 +313,16 @@ test_submodule_relative_url "(null)" "../foo" "..=
/submodule" "../submodule"
 test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "foo/s=
ubmodule"
 test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule=
"
 test_submodule_relative_url "(null)" "//somewhere else/repo" "../subre=
po" "//somewhere else/subrepo"
-test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subs=
ubsuper_update_r" "$PWD/subsubsuper_update_r"
-test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsup=
er_update_r" "$PWD/subsuper_update_r"
-test_submodule_relative_url "(null)" "$PWD/." "../." "$PWD/."
-test_submodule_relative_url "(null)" "$PWD" "./." "$PWD/."
-test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$PWD/re=
po"
-test_submodule_relative_url "(null)" "$PWD" "./=C3=83=C2=A5 =C3=83=C2=A4=
=C3=83=C2=B6" "$PWD/=C3=83=C2=A5 =C3=83=C2=A4=C3=83=C2=B6"
-test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$PWD/sub=
module"
-test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "=
$PWD/submodule"
-test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle=
1" "$PWD/home2/../bundle1"
-test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./.=
" "$PWD/submodule_update_repo/."
+test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subs=
ubsuper_update_r" "$(pwd)/subsubsuper_update_r"
+test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsup=
er_update_r" "$(pwd)/subsuper_update_r"
+test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
+test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)/."
+test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd)/=
repo"
+test_submodule_relative_url "(null)" "$PWD" "./=C3=83=C2=A5 =C3=83=C2=A4=
=C3=83=C2=B6" "$(pwd)/=C3=83=C2=A5 =C3=83=C2=A4=C3=83=C2=B6"
+test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$(pwd)/s=
ubmodule"
+test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "=
$(pwd)/submodule"
+test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle=
1" "$(pwd)/home2/../bundle1"
+test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./.=
" "$(pwd)/submodule_update_repo/."
 test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo" "=
file:///tmp/subrepo"
 test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/sub=
module"
 test_submodule_relative_url "(null)" "foo" "../submodule" "submodule"
--=20
2.7.0.118.g90056ae
