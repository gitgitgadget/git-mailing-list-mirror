From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v7 01/10] t5601: remove clear_ssh, refactor setup_ssh_wrapper
Date: Thu, 28 Nov 2013 20:53:47 +0100
Message-ID: <201311282053.47761.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 20:54:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm7fB-00061Z-L7
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759104Ab3K1Tx4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:53:56 -0500
Received: from mout-xforward.web.de ([82.165.159.2]:51860 "EHLO
	mout-xforward.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab3K1Txy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:53:54 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Nov 2013 14:53:54 EST
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MQ6LH-1VgsSZ38Gh-005LRf for <git@vger.kernel.org>; Thu,
 28 Nov 2013 20:53:52 +0100
X-Provags-ID: V03:K0:gbJ4vDAAifMY2fNuLqMObYm9apy/GaInHELJlmW4xF8BYoWwwow
 DST85f7Ejf2sYgkmsVnJuso9jTkJUK84tQmaWLIqTO4wxhC1JFdy/03Vqy6X2BYqt7XDRrM
 cfvWwPtxPCRvvJp7SLhk7U5ueCaHQUQE+k9oNHYHe8Ht39AODAMvGqRSx6alJOW5W/UYDAq
 k1WlvoVigfgc823svaCYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238513>

Commit 8d3d28f5 added test cases for URLs which should be ssh.
Remove the function clear_ssh, use test_when_finished to clean up.

Introduce the function setup_ssh_wrapper, which could be factored
out together with expect_ssh.

Tighten one test and use "foo:bar" instead of "./foo:bar",

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

Comments to V6:
Code from Johannes Sixt is part of the series, original found here:
 http://permalink.gmane.org/gmane.comp.version-control.git/237339
 http://permalink.gmane.org/gmane.comp.version-control.git/237338

Changes since V6:
- git fetch-pack --diag-url uses stdout instead of stderr
- cleanup in the test scripts
- Removed [PATCH v6 07/10] connect.c: Corner case for IPv6
- Added missing sign-off
- Try to explain better why windows supports file://C:/repo
  (Actually we should support file:///C:/repo, but we don't
- Other remarks from code review, did I miss any ?

I'm not sure about 10/10, 2 cleanups which I didn't manage
to find a  better place to be.
However, I want to concentrate on 1..9, so that 10/10 can be dropped.

And a question:
Can we replace tb/clone-ssh-with-colon-for-port with this stuff ?
If we are OK with part 1..4, I don't need to send them again.


 t/t5601-clone.sh | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 1d1c875..c634f77 100755
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
+		(cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)
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
1.8.5.rc0.23.gaa27064
