From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] submodule: port resolve_relative_url from shell to C
Date: Wed, 2 Mar 2016 18:21:17 +0100
Message-ID: <56D7210D.8050708@kdbg.org>
References: <1455320356-15778-1-git-send-email-sbeller@google.com>
 <1455320356-15778-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 18:21:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abASn-0001Bx-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 18:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbcCBRVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 12:21:22 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:52651 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755072AbcCBRVV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 12:21:21 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qFhv250mPz5tlS;
	Wed,  2 Mar 2016 18:21:18 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id D598553BF;
	Wed,  2 Mar 2016 18:21:17 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1455320356-15778-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288132>

Am 13.02.2016 um 00:39 schrieb Stefan Beller:
> @@ -289,4 +296,39 @@ test_git_path GIT_COMMON_DIR=3Dbar config       =
            bar/config
>   test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/pac=
ked-refs
>   test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/sha=
llow
>  =20
> +test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "..=
/foo/sub/a/b/c"
> +test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c" =
"../../../../foo/sub/a/b/c"
> +test_submodule_relative_url "(null)" "../foo/bar" "../submodule" "..=
/foo/submodule"
> +test_submodule_relative_url "../" "../foo/bar" "../submodule" "../..=
/foo/submodule"
> +test_submodule_relative_url "(null)" "../foo/submodule" "../submodul=
e" "../foo/submodule"
> +test_submodule_relative_url "../" "../foo/submodule" "../submodule" =
"../../foo/submodule"
> +test_submodule_relative_url "(null)" "../foo" "../submodule" "../sub=
module"
> +test_submodule_relative_url "../" "../foo" "../submodule" "../../sub=
module"
> +test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "foo=
/submodule"
> +test_submodule_relative_url "../" "./foo/bar" "../submodule" "../foo=
/submodule"
> +test_submodule_relative_url "(null)" "./foo" "../submodule" "submodu=
le"
> +test_submodule_relative_url "../" "./foo" "../submodule" "../submodu=
le"
> +test_submodule_relative_url "(null)" "//somewhere else/repo" "../sub=
repo" "//somewhere else/subrepo"
> +test_submodule_relative_url "(null)" "/u//trash directory.t7406-subm=
odule-update/subsuper_update_r" "../subsubsuper_update_r" "/u//trash di=
rectory.t7406-submodule-update/subsubsuper_update_r"
> +test_submodule_relative_url "(null)" "/u//trash directory.t7406-subm=
odule-update/super_update_r2" "../subsuper_update_r" "/u//trash directo=
ry.t7406-submodule-update/subsuper_update_r"
> +test_submodule_relative_url "(null)" "/u/trash directory.t3600-rm/."=
 "../." "/u/trash directory.t3600-rm/."
> +test_submodule_relative_url "(null)" "/u/trash directory.t3600-rm" "=
=2E/." "/u/trash directory.t3600-rm/."
> +test_submodule_relative_url "(null)" "/u/trash directory.t7400-submo=
dule-basic/addtest" "../repo" "/u/trash directory.t7400-submodule-basic=
/repo"
> +test_submodule_relative_url "../" "/u/trash directory.t7400-submodul=
e-basic/addtest" "../repo" "/u/trash directory.t7400-submodule-basic/re=
po"
> +test_submodule_relative_url "(null)" "/u/trash directory.t7400-submo=
dule-basic" "./=C3=A5 =C3=A4=C3=B6" "/u/trash directory.t7400-submodule=
-basic/=C3=A5 =C3=A4=C3=B6"
> +test_submodule_relative_url "(null)" "/u/trash directory.t7403-submo=
dule-sync/." "../submodule" "/u/trash directory.t7403-submodule-sync/su=
bmodule"
> +test_submodule_relative_url "(null)" "/u/trash directory.t7407-submo=
dule-foreach/submodule" "../submodule" "/u/trash directory.t7407-submod=
ule-foreach/submodule"
> +test_submodule_relative_url "(null)" "/u/trash directory.t7409-submo=
dule-detached-worktree/home2/../remote" "../bundle1" "/u/trash director=
y.t7409-submodule-detached-worktree/home2/../bundle1"
> +test_submodule_relative_url "(null)" "/u/trash directory.t7613-merge=
-submodule/submodule_update_repo" "./." "/u/trash directory.t7613-merge=
-submodule/submodule_update_repo/."

The tests with absolute paths all fail on Windows. The reason is that
git.exe sees mangled paths and 'git submodule--helper
resolve-relative-url-test' produces mangled paths (that begins with a
drive letter), whereas the test script expects POSIX paths. The pattern
I currently use to fix this is

test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd)/r=
epo"

(In our test scripts, $PWD is a POSIX style path and $(pwd) is a
Windows style path).

With this change, the penultimate case above still fails because the
'home2/..' gets lost somewhere in the actual output, which I still have
to debug.

The two cases beginning with '/u//' cannot be tested on Windows.
Are they important? Are the doubled slashes intentional?

> +test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo"=
 "file:///tmp/subrepo"
> +test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/s=
ubmodule"
> +test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/s=
ubmodule"
> +test_submodule_relative_url "(null)" "foo" "../submodule" "submodule=
"
> +test_submodule_relative_url "../" "foo" "../submodule" "../submodule=
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
