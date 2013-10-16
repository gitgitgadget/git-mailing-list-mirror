From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] t3600: fix broken "choking git rm" test
Date: Wed, 16 Oct 2013 02:48:57 +0200
Message-ID: <1381884537-16256-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 02:49:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWFIm-0005cH-JP
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 02:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933831Ab3JPAtX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 20:49:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:64056 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933687Ab3JPAtU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 20:49:20 -0400
Received: from localhost6.localdomain6 (g226140223.adsl.alicedsl.de [92.226.140.223])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0Lx0lJ-1VpYVs18zR-016iJ3; Wed, 16 Oct 2013 02:49:05 +0200
X-Mailer: git-send-email 1.8.4.1.495.gd8d272e
X-Provags-ID: V02:K0:iR7uFoi9nSN2+/zMGY7VYRaudL9pznCVRMPbgnrtI/0
 w7oxsQeOMfeOJg35AT7qUtcGSUU7lNxM/h6ouztPrtSWBFVvL/
 rO/+EB5mh3RnvvoaUaAJ3HnXmiU+ZokIsT8opfXZwwxbq/JgFC
 wADNLs7sJfKpeF+lpWaazrGf50SPRe+I1CHi0TTGW9O81jFZOd
 u/GJzDZ9NuIWKUwlkf5nd1eCFhbcNLhdPkLuOmP8hVxHOqFRIf
 u8C8cz8ijaORy5ORFTYQRaQ/gTJq2sBLCEA1vTMPnvs5VCNX8/
 GlW8pEdEPM24ThDOUcFr5SZQJ2P3hQXYZJ3HxM4UKM6Y7ggwIM
 4wXmQ/GbDaBtQs8wrk2D2Cn5sDvO5drPAh92szYcgxuoe+SA85
 HSK+H8fpN9HrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236227>

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
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3600-rm.sh | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 824342f413..ad30a61f9e 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -230,18 +230,15 @@ test_expect_success 'refresh index before checkin=
g if it is up-to-date' '
=20
 test_expect_success 'choking "git rm" should not let it die with cruft=
' '
 	git reset -q --hard &&
+	test_when_finished "rm -f .git/index.lock && git reset -q --hard" &&
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
+	test_path_is_missing .git/index.lock
 '
=20
 test_expect_success 'rm removes subdirectories recursively' '
--=20
1.8.4.1.495.gd8d272e
