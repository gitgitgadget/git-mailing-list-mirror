From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Suppress some bash redirection error messages
Date: Tue, 26 Aug 2008 18:52:57 +0100
Message-ID: <48B442F9.1090801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:04:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2tt-0006Zb-LT
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 20:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757585AbYHZSC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2008 14:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757719AbYHZSC4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:02:56 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:2503 "EHLO
	anchor-post-35.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752309AbYHZSCz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Aug 2008 14:02:55 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Aug 2008 14:02:55 EDT
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.67)
	id 1KY2kl-0001Z7-IZ; Tue, 26 Aug 2008 17:54:52 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93788>


In particular, when testing if the filesystem allows tabs in
filenames, bash issues an error something like:

=2E/t4016-diff-quote.sh: pathname	with HT: No such file or directory

which is caused by the failure of the (stdout) redirection,
since the file cannot be created. In order to suppress the
error message, you must redirect stderr to /dev/null, *before*
the stdout redirection on the command-line.

Also, remove a redundant filesystem check from the begining of
the t3902-quoted.sh test and standardise the "test skipped"
message to 'say' on exit.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t3300-funny-names.sh |    2 +-
 t/t3902-quoted.sh      |    8 +-------
 t/t4016-diff-quote.sh  |    4 ++--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 0574ef1..db46d53 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -21,7 +21,7 @@ cat >"$p0" <<\EOF
 3. A quick brown fox jumps over the lazy cat, oops dog.
 EOF
=20
-cat >"$p1" "$p0"
+cat 2>/dev/null >"$p1" "$p0"
 echo 'Foo Bar Baz' >"$p2"
=20
 test -f "$p1" && cmp "$p0" "$p1" || {
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index fe4fb51..5868052 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -7,12 +7,6 @@ test_description=3D'quoted output'
=20
 . ./test-lib.sh
=20
-P1=3D'pathname	with HT'
-: >"$P1" 2>&1 && test -f "$P1" && rm -f "$P1" || {
-	echo >&2 'Filesystem does not support HT in names'
-	test_done
-}
-
 FN=3D'=E6=BF=B1=E9=87=8E'
 GN=3D'=E7=B4=94'
 HT=3D'	'
@@ -20,7 +14,7 @@ LF=3D'
 '
 DQ=3D'"'
=20
-echo foo > "Name and an${HT}HT"
+echo foo 2>/dev/null > "Name and an${HT}HT"
 test -f "Name and an${HT}HT" || {
 	# since FAT/NTFS does not allow tabs in filenames, skip this test
 	say 'Your filesystem does not allow tabs in filenames, test skipped.'
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index f07035a..55eb5f8 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -13,8 +13,8 @@ P1=3D'pathname	with HT'
 P2=3D'pathname with SP'
 P3=3D'pathname
 with LF'
-: >"$P1" 2>&1 && test -f "$P1" && rm -f "$P1" || {
-	echo >&2 'Filesystem does not support tabs in names'
+: 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1" || {
+	say 'Your filesystem does not allow tabs in filenames, test skipped.'
 	test_done
 }
=20
--=20
1.6.0
