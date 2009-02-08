From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/5] Test and fix normalize_path_copy()
Date: Sun, 8 Feb 2009 16:50:21 +0100
Message-ID: <200902081650.22068.j6t@kdbg.org>
References: <498CAF73.6050409@lsrfire.ath.cx> <1234019311-6449-5-git-send-email-j6t@kdbg.org> <498EF028.3040702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Feb 08 16:52:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWBwp-0002Sp-Gh
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 16:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbZBHPu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 10:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbZBHPu2
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 10:50:28 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:42165 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbZBHPu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 10:50:28 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3B5F110019;
	Sun,  8 Feb 2009 16:50:22 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BDC83117E9;
	Sun,  8 Feb 2009 16:50:22 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <498EF028.3040702@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108988>

On Sonntag, 8. Februar 2009, Ren=E9 Scharfe wrote:
> Johannes Sixt schrieb:
> > Moreover, the test case descriptions of t0060 now include the test =
data
> > and expected outcome.
>
> The test still fails in a lot of cases for me, because "/" is transla=
ted to
> the installation path of msys.

To fix t0060 on Windows was not even on the radar of this series.

That said, I'm slowly working on a series that fixes or skips many test=
s on=20
Windows. I currently have the patch below in my tree.

-- Hannes

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 4ed1f0b..dd2d241 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -7,41 +7,89 @@ test_description=3D'Test various path utilities'
=20
 . ./test-lib.sh
=20
-norm_abs() {
-	test_expect_success "normalize absolute: $1 =3D> $2" \
+norm_path() {
+	test_expect_success "normalize path: $1 =3D> $2" \
 	"test \"\$(test-path-utils normalize_path_copy '$1')\" =3D '$2'"
 }
+xnorm_path() { say fix this: "$*"; }
+
+# On Windows, we are using MSYS's bash, which mangles the paths.
+# Absolute paths are anchored at the MSYS installation directory,
+# which means that the path / accounts for this many characters:
+rootoff=3D$(test-path-utils normalize_path_copy / | wc -c)
+# Account for the trailing LF:
+if test "$rootoff" =3D 2; then
+	rootoff=3D	# we are on Unix
+else
+	rootoff=3D$(($rootoff-1))
+fi
=20
 ancestor() {
-	test_expect_success "longest ancestor: $1 $2 =3D> $3" \
-	"test \"\$(test-path-utils longest_ancestor_length '$1' '$2')\" =3D '=
$3'"
+	# We do some math with the expected ancestor length.
+	expected=3D$3
+	if test -n "$rootoff" && ! test "$expected" =3D -1; then
+		expected=3D$(($expected+$rootoff))
+	fi
+	test_expect_success "longest ancestor: $1 $2 =3D> $expected" \
+	"actual=3D\$(test-path-utils longest_ancestor_length '$1' '$2') &&
+	 test \"\$actual\" =3D '$expected'"
 }
=20
-norm_abs "" ""
-norm_abs / /
-norm_abs // /
-norm_abs /// /
-norm_abs /. /
-norm_abs /./ /
-norm_abs /./.. ++failed++
-norm_abs /../. ++failed++
-norm_abs /./../.// ++failed++
-norm_abs /dir/.. /
-norm_abs /dir/sub/../.. /
-norm_abs /dir/sub/../../.. ++failed++
-norm_abs /dir /dir
-norm_abs /dir// /dir/
-norm_abs /./dir /dir
-norm_abs /dir/. /dir/
-norm_abs /dir///./ /dir/
-norm_abs /dir//sub/.. /dir/
-norm_abs /dir/sub/../ /dir/
-norm_abs //dir/sub/../. /dir/
-norm_abs /dir/s1/../s2/ /dir/s2/
-norm_abs /d1/s1///s2/..//../s3/ /d1/s3/
-norm_abs /d1/s1//../s2/../../d2 /d2
-norm_abs /d1/.../d2 /d1/.../d2
-norm_abs /d1/..././../d2 /d1/d2
+do_abs=3Dt
+case $(uname -s) in
+*MINGW*) do_abs=3D
+esac
+
+norm_path "" ""
+norm_path . ""
+norm_path ./ ""
+norm_path ./. ""
+norm_path .. ++failed++
+norm_path ../sub ++failed++
+norm_path dir/.. ""
+norm_path dir/sub/../.. ""
+norm_path dir/sub/../../.. ++failed++
+norm_path dir dir
+norm_path dir// dir/
+norm_path ./dir dir
+norm_path dir/. dir/
+norm_path dir///./ dir/
+norm_path dir//sub/.. dir/
+norm_path dir/sub/../ dir/
+norm_path dir/sub/../. dir/
+norm_path dir/s1/../s2/ dir/s2/
+norm_path d1/s1///s2/..//../s3/ d1/s3/
+norm_path d1/s1//../s2/../../d2 d2
+norm_path d1/.../d2 d1/.../d2
+norm_path d1/..././../d2 d1/d2
+
+if test -n "$do_abs"; then
+norm_path "" ""
+norm_path / /
+norm_path // /
+norm_path /// /
+norm_path /. /
+norm_path /./ /
+norm_path /./.. ++failed++
+norm_path /../. ++failed++
+norm_path /./../.// ++failed++
+norm_path /dir/.. /
+norm_path /dir/sub/../.. /
+norm_path /dir/sub/../../.. ++failed++
+norm_path /dir /dir
+norm_path /dir// /dir/
+norm_path /./dir /dir
+norm_path /dir/. /dir/
+norm_path /dir///./ /dir/
+norm_path /dir//sub/.. /dir/
+norm_path /dir/sub/../ /dir/
+norm_path //dir/sub/../. /dir/
+norm_path /dir/s1/../s2/ /dir/s2/
+norm_path /d1/s1///s2/..//../s3/ /d1/s3/
+norm_path /d1/s1//../s2/../../d2 /d2
+norm_path /d1/.../d2 /d1/.../d2
+norm_path /d1/..././../d2 /d1/d2
+fi
=20
 ancestor / "" -1
 ancestor / / -1
@@ -80,9 +128,9 @@ ancestor /foo/bar /:/foo:/bar/ 4
 ancestor /foo/bar /foo:/:/bar/ 4
 ancestor /foo/bar /:/bar/:/fo 0
 ancestor /foo/bar /:/bar/ 0
-ancestor /foo/bar :://foo/. 4
-ancestor /foo/bar :://foo/.:: 4
-ancestor /foo/bar //foo/./::/bar 4
-ancestor /foo/bar ::/bar -1
+ancestor /foo/bar .:/foo/. 4
+ancestor /foo/bar .:/foo/.:.: 4
+ancestor /foo/bar /foo/./:.:/bar 4
+ancestor /foo/bar .:/bar -1
=20
 test_done
