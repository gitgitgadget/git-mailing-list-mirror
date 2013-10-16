From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] t3600: fix broken "choking git rm" test
Date: Wed, 16 Oct 2013 02:01:27 +0200
Message-ID: <1381881687-11179-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 16 02:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWEZ3-0005ki-5W
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 02:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759878Ab3JPACI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 20:02:08 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:63407 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759708Ab3JPACG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 20:02:06 -0400
Received: from localhost6.localdomain6 (g226140223.adsl.alicedsl.de [92.226.140.223])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MCIHB-1Ven8P39TF-0098Tj; Wed, 16 Oct 2013 02:02:04 +0200
X-Mailer: git-send-email 1.8.4.1.495.gd8d272e
X-Provags-ID: V02:K0:cHsSrMqXDOgL3Yv6gBkDPqGlcwPUQwiQuia2gFIj0F8
 xwnFZjgQkdSV4eF941o0NTC1WYDr4NKvdU7TutzPhoWrUk6D+4
 toTuh5plCuBS/rWiZKdl5cHK9nI+44YAwwJeHsiEJ2ydHzFVQs
 +0FprVxzRbdqHbCvZT3dhlSo/xzTvbF4wZTpZrFW0kVId5g1CY
 d5DZ5eVJd/WP/d7oErG67t+yJs5SOEYjddkePXpYaKU28HhTsQ
 AFLrmZHiC7rrOK++byldjEclOa+fXZZ1dqb7xWLej9tw176IXp
 yA/2UoTEjnM2Gpjlkzqc1T97xIvL0xIbAFRIcw0w+pYmWt3MIU
 Ubf8Tq8yS1uXf5nZRvqn05eWB2/Ms+iKejd75zG1rz/WhQ5ONa
 Pj0BmUwBkiHzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236224>

The test 'choking "git rm" should not let it die with cruft' is
supposed to check 'git rm's behavior when interrupted by provoking a
SIGPIPE while 'git rm' is busily deleting files from a specially
crafted index.

This test is silently broken for the following reasons:

- The test crafts a special index by feeding a large number of index
  entries with null shas to 'git update-index --index-info'.  It was
  OK back then when this test was introduced in commit 0693f9ddad
  (Make sure lockfiles are unlocked when dying on SIGPIPE,
  2008-12-18), but since commit 4337b5856f (do not write null sha1s to
  on-disk index, 2012-07-28) null shas are not allowed in the on-disk
  index causing 'git update-index' to error out.

- The barfing 'git update-index --index-info' should fail the test,
  but it remains unnoticed because of the severely broken && chain:
  the test's result depends solely on whether there is a stale lock
  file left behind, but after 'git update-index' errors out 'git rm'
  won't be executed at all.

To fix this test feed only non-null shas to 'git update-index' and
restore the && chain (partly by adding a missing && and by using the
test_when_finished helper instead of manual cleanup).

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
A particularly funny one from the fallout of gmane/236183

 t/t3600-rm.sh | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 85854f338f..4dd0130dd9 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -240,18 +240,15 @@ test_expect_success 'refresh index before checkin=
g if it is up-to-date' '
=20
 test_expect_success 'choking "git rm" should not let it die with cruft=
' '
 	git reset -q --hard &&
+	test_when_finished "rm -f .git/index.lock ; git reset -q --hard" &&
 	i=3D0 &&
 	while test $i -lt 12000
 	do
-	    echo "100644 $_z40 0	some-file-$i"
+	    echo "100644 1234567890123456789012345678901234567890 0	some-file=
-$i"
 	    i=3D$(( $i + 1 ))
 	done | git update-index --index-info &&
-	git rm -n "some-file-*" | :;
-	test -f .git/index.lock
-	status=3D$?
-	rm -f .git/index.lock
-	git reset -q --hard
-	test "$status" !=3D 0
+	git rm -n "some-file-*" | : &&
+	test ! -f .git/index.lock
 '
=20
 test_expect_success 'rm removes subdirectories recursively' '
--=20
1.8.4.1.495.gd8d272e
