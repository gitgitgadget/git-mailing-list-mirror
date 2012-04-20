From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH nd/threaded-index-pack] index-pack: disable threading
 if NO_PREAD is defined
Date: Fri, 20 Apr 2012 08:25:09 +0200
Message-ID: <4F910145.5030102@viscovery.net>
References: <1334844329-24557-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kusmabite@gmail.com,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 08:25:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL7Hw-0007Tg-Gi
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 08:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243Ab2DTGZR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Apr 2012 02:25:17 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:15877 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab2DTGZQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2012 02:25:16 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SL7Hf-0002hg-VD; Fri, 20 Apr 2012 08:25:32 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 41EAB1660F;
	Fri, 20 Apr 2012 08:25:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <1334844329-24557-1-git-send-email-pclouds@gmail.com>
X-Enigmail-Version: 1.4
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195982>

Am 4/19/2012 16:05, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> NO_PREAD simulates pread() as a sequence of seek, read, seek in
> compat/pread.c. The simulation is not thread-safe because another
> thread could move the file offset away in the middle of pread
> operation. Do not allow threading in that case.

Unsurprisingly, this fixes the breakage for me.

I used the attached patch to keep t9300 running when the breakage
was detected.

--- 8< ---
=46rom: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t9300-fast-import: avoid 'exit' in test_expect_success=
 snippets

Exiting from a for-loop early using '|| break' does not propagate the
failure code, and for this reason, the tests used just 'exit'. But this
ends the test script with 'FATAL: Unexpected exit code 1' in the case o=
f
a failed test.

=46ix this by moving the loop into a shell function, from which we can
simply return early.

While at it, modernize the style of the affected test cases.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9300-fast-import.sh |   88 +++++++++++++++++++++++++++++-----------=
--------
 1 file changed, 54 insertions(+), 34 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 0f5b5e5..8d7be67 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -24,6 +24,13 @@ head_c () {
 	' - "$1"
 }
=20
+verify_packs () {
+	for p in .git/objects/pack/*.pack
+	do
+		git verify-pack "$@" "$p" || return
+	done
+}
+
 file2_data=3D'file2
 second line of EOF'
=20
@@ -105,9 +112,10 @@ test_expect_success \
     'A: create pack from stdin' \
     'git fast-import --export-marks=3Dmarks.out <input &&
 	 git whatchanged master'
-test_expect_success \
-	'A: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+
+test_expect_success 'A: verify pack' '
+	verify_packs
+'
=20
 cat >expect <<EOF
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -252,9 +260,11 @@ test_expect_success \
 	'A: verify marks import does not crash' \
 	'git fast-import --import-marks=3Dmarks.out <input &&
 	 git whatchanged verify--import-marks'
-test_expect_success \
-	'A: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+
+test_expect_success 'A: verify pack' '
+	verify_packs
+'
+
 cat >expect <<EOF
 :000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be=
127c5eb701e5968176ee9d78b1 A	copy-of-file2
 EOF
@@ -514,9 +524,11 @@ test_expect_success \
     'C: incremental import create pack from stdin' \
     'git fast-import <input &&
 	 git whatchanged branch'
-test_expect_success \
-	'C: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+
+test_expect_success 'C: verify pack' '
+	verify_packs
+'
+
 test_expect_success \
 	'C: validate reuse existing blob' \
 	'test $newf =3D `git rev-parse --verify branch:file2/newf` &&
@@ -572,9 +584,10 @@ test_expect_success \
     'D: inline data in commit' \
     'git fast-import <input &&
 	 git whatchanged branch'
-test_expect_success \
-	'D: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+
+test_expect_success 'D: verify pack' '
+	verify_packs
+'
=20
 cat >expect <<EOF
 :000000 100755 0000000000000000000000000000000000000000 35a59026a33bea=
c1569b1c7f66f3090ce9c09afc A	newdir/exec.sh
@@ -618,9 +631,10 @@ test_expect_success 'E: rfc2822 date, --date-forma=
t=3Draw' '
 test_expect_success \
     'E: rfc2822 date, --date-format=3Drfc2822' \
     'git fast-import --date-format=3Drfc2822 <input'
-test_expect_success \
-	'E: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+
+test_expect_success 'E: verify pack' '
+	verify_packs
+'
=20
 cat >expect <<EOF
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170778938 -0500
@@ -669,9 +683,10 @@ test_expect_success \
 		fi
 	 fi
 	'
-test_expect_success \
-	'F: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+
+test_expect_success 'F: verify pack' '
+	verify_packs
+'
=20
 cat >expect <<EOF
 tree `git rev-parse branch~1^{tree}`
@@ -705,9 +720,11 @@ INPUT_END
 test_expect_success \
     'G: non-fast-forward update forced' \
     'git fast-import --force <input'
-test_expect_success \
-	'G: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+
+test_expect_success 'G: verify pack' '
+	verify_packs
+'
+
 test_expect_success \
 	'G: branch changed, but logged' \
 	'test $old_branch !=3D `git rev-parse --verify branch^0` &&
@@ -742,9 +759,10 @@ test_expect_success \
     'H: deletall, add 1' \
     'git fast-import <input &&
 	 git whatchanged H'
-test_expect_success \
-	'H: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+
+test_expect_success 'H: verify pack' '
+	verify_packs
+'
=20
 cat >expect <<EOF
 :100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 00000000000000=
00000000000000000000000000 D	file2/newf
@@ -1857,9 +1875,10 @@ test_expect_success \
 	'Q: commit notes' \
 	'git fast-import <input &&
 	 git whatchanged notes-test'
-test_expect_success \
-	'Q: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+
+test_expect_success 'Q: verify pack' '
+	verify_packs
+'
=20
 commit1=3D$(git rev-parse notes-test~2)
 commit2=3D$(git rev-parse notes-test^)
@@ -2616,13 +2635,14 @@ test_expect_success \
 	'R: blob bigger than threshold' \
 	'test_create_repo R &&
 	 git --git-dir=3DR/.git fast-import --big-file-threshold=3D1 <input'
-test_expect_success \
-	'R: verify created pack' \
-	': >verify &&
-	 for p in R/.git/objects/pack/*.pack;
-	 do
-	   git verify-pack -v $p >>verify || exit;
-	 done'
+
+test_expect_success 'R: verify created pack' '
+	(
+		cd R &&
+		verify_packs -v > ../verify
+	)
+'
+
 test_expect_success \
 	'R: verify written objects' \
 	'git --git-dir=3DR/.git cat-file blob big-file:big1 >actual &&
--=20
1.7.10.1386.g7bd022
