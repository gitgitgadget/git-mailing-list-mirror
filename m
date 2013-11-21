From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v6 01/10] t5601: remove clear_ssh, refactor setup_ssh_wrapper
Date: Thu, 21 Nov 2013 21:41:31 +0100
Message-ID: <201311212141.32210.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 21:41:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjb4H-0000vP-I5
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab3KUUli convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 15:41:38 -0500
Received: from mout.web.de ([212.227.15.14]:58807 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020Ab3KUUlh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Nov 2013 15:41:37 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MLPaA-1Vj36Q0Yxm-000fRo for <git@vger.kernel.org>; Thu,
 21 Nov 2013 21:41:36 +0100
X-Provags-ID: V03:K0:DRY59Vwx9dHk4McfM7Zea8ozKcKmsqyCKBNEd8SsLcyUoiIW53o
 CDW5aChKkf9xHsb+5QAY7D3VdALucpUhR7GOcTVMKFik87Nij029GQVGfBn5NmNCtmP22U5
 q2eBSz1dZWInTnTtFWkMH93u0c1ekeXFnHiZLB9ZZ/hbfHtptriYHSRnNJL1dGoopiDgWDU
 9H7i3HImyWikQ00UzGiUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238149>

Commit 8d3d28f5 added test cases for URLs which should be ssh.
Remove the function clear_ssh, use test_when_finished to clean up.

Introduce the function setup_ssh_wrapper, which could be factored
out together with expect_ssh.

Tighten one test and use "foo:bar" instead of "./foo:bar",

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since last version:
- updated t5601, thanks Peff
- Split up the patch into 10 commits
- Hannes suggested 2 patches
- Add tests for git fetch-pack, which verifies the parsing
- Added lots of test cases in t5500 via git fetch-pack --diag-url

 t/t5601-clone.sh | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 1d1c875..83b21f5 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -280,25 +280,26 @@ test_expect_success 'clone checking out a tag' '
 	test_cmp fetch.expected fetch.actual
 '
=20
-test_expect_success 'setup ssh wrapper' '
-	write_script "$TRASH_DIRECTORY/ssh-wrapper" <<-\EOF &&
-	echo >>"$TRASH_DIRECTORY/ssh-output" "ssh: $*" &&
-	# throw away all but the last argument, which should be the
-	# command
-	while test $# -gt 1; do shift; done
-	eval "$1"
-	EOF
-
-	GIT_SSH=3D"$TRASH_DIRECTORY/ssh-wrapper" &&
-	export GIT_SSH &&
-	export TRASH_DIRECTORY
-'
-
-clear_ssh () {
-	>"$TRASH_DIRECTORY/ssh-output"
+setup_ssh_wrapper () {
+	test_expect_success 'setup ssh wrapper' '
+		write_script "$TRASH_DIRECTORY/ssh-wrapper" <<-\EOF &&
+		echo >>"$TRASH_DIRECTORY/ssh-output" "ssh: $*" &&
+		# throw away all but the last argument, which should be the
+		# command
+		while test $# -gt 1; do shift; done
+		eval "$1"
+		EOF
+		GIT_SSH=3D"$TRASH_DIRECTORY/ssh-wrapper" &&
+		export GIT_SSH &&
+		export TRASH_DIRECTORY &&
+		>"$TRASH_DIRECTORY"/ssh-output
+	'
 }
=20
 expect_ssh () {
+	test_when_finished '
+	  (cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)
+	' &&
 	{
 		case "$1" in
 		none)
@@ -310,21 +311,20 @@ expect_ssh () {
 	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
 }
=20
+setup_ssh_wrapper
+
 test_expect_success 'cloning myhost:src uses ssh' '
-	clear_ssh &&
 	git clone myhost:src ssh-clone &&
 	expect_ssh myhost src
 '
=20
 test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
-	clear_ssh &&
 	cp -R src "foo:bar" &&
-	git clone "./foo:bar" foobar &&
+	git clone "foo:bar" foobar &&
 	expect_ssh none
 '
=20
 test_expect_success 'bracketed hostnames are still ssh' '
-	clear_ssh &&
 	git clone "[myhost:123]:src" ssh-bracket-clone &&
 	expect_ssh myhost:123 src
 '
--=20
1.8.4.457.g424cb08
