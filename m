From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Fail softly if file system does not like test data.
Date: Wed, 31 Jan 2007 01:10:03 +0100
Organization: Dewire
Message-ID: <200701310110.04429.robin.rosenberg.lists@dewire.com>
References: <20070130163219.GA14431@164.242.249.10.in-addr.arpa> <20070130224446.28311.31828.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 01:09:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC32a-0006pL-K1
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 01:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXAaAJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 30 Jan 2007 19:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbXAaAJ3
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 19:09:29 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11712 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbXAaAJ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jan 2007 19:09:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4664580338F;
	Wed, 31 Jan 2007 01:04:48 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06173-04; Wed, 31 Jan 2007 01:04:47 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id C0B4F800199;
	Wed, 31 Jan 2007 01:04:45 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <20070130224446.28311.31828.stgit@lathund.dewire.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38215>

    Most unix file system allow almost any byte sequence, but other may=
 reject
    sequences that are not valid according to the locale. This change m=
akes
    failure somewhat less likely by using UTF-8-encoded characters and =
skips
    the test if the local file system does not support the test data.
   =20
    Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

The first version of the patch had two errors. First it had a slash too=
 much, then
it did not clean up after test for applicability and then it was sent U=
TF-8 encoded
which is wrong for non-utf8 systems. The patch is ment to actually have=
 the
UTF-8 byte sequences and not be translated (it should work regardless o=
n most
systems).

 t/t9200-git-cvsexportcommit.sh |   37 +++++++++++++++++++++++---------=
-----
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index fd0a554..d0d5365 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -169,20 +169,29 @@ test_expect_success \
       test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" =3D "wi=
th spaces.png/1.2/-kb with spaces.txt/1.2/"
       )'
=20
-# This test contains ISO-8859-1 characters
-test_expect_success \
-     'File with non-ascii file name' \
-     'mkdir -p =EF=BF=BDgoo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/=
v/w/x/y/z/=EF=BF=BD=EF=BF=BD=EF=BF=BD&&
-      echo Foo >=EF=BF=BDgoo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u=
/v/w/x/y/z/=EF=BF=BD=EF=BF=BD=EF=BF=BDg=EF=BF=BDdets=EF=BF=BD=EF=BF=BDd=
et.txt &&
-      git add =EF=BF=BDgoo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v=
/w/x/y/z/=EF=BF=BD=EF=BF=BD=EF=BF=BDg=EF=BF=BDdets=EF=BF=BD=EF=BF=BDdet=
=2Etxt &&
-      cp ../test9200a.png =EF=BF=BDgoo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p=
/q/r/s/t/u/v/w/x/y/z/=EF=BF=BD=EF=BF=BD=EF=BF=BDg=EF=BF=BDdets=EF=BF=BD=
=EF=BF=BDdet.png &&
-      git add =EF=BF=BDgoo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v=
/w/x/y/z/=EF=BF=BD=EF=BF=BD=EF=BF=BDg=EF=BF=BDdets=EF=BF=BD=EF=BF=BDdet=
=2Epng &&
-      git commit -a -m "G=EF=BF=BD det s=EF=BF=BDg=EF=BF=BD det" && \
-      id=3D$(git rev-list --max-count=3D1 HEAD) &&
-      (cd "$CVSWORK" &&
-      git-cvsexportcommit -v -c $id &&
-      test "$(echo $(sort =EF=BF=BDgoo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p=
/q/r/s/t/u/v/w/x/y/z/=EF=BF=BD=EF=BF=BD=EF=BF=BDCVS/Entries|cut -d/ -f2=
,3,5))" =3D "g=EF=BF=BDdets=EF=BF=BD=EF=BF=BDdet.png/1.1/-kb g=EF=BF=BD=
dets=EF=BF=BD=EF=BF=BDdet.txt/1.1/"
-      )'
+# This test contains UTF-8 characters and may fail on some filesystems
+mkdir -p "=C3=A5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y=
/z/=C3=A5/=C3=A4/=C3=B6" >/dev/null 2>&1
+if test $? -ne 0
+then
+    test_expect_success 'File with non-ascii file name skipped, file s=
ystem is incompatible with test data' :
+    rm -rf "=C3=A5"
+else
+    rm -rf "=C3=A5"
+    test_expect_success \
+	'File with non-ascii file name' \
+	'(mkdir -p "=C3=A5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/=
x/y/z/=C3=A5/=C3=A4/=C3=B6" ||
+         echo "Local filesystem does not permit this test" ) &&
+         echo Foo >"=C3=A5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t=
/u/v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt" &&
+         git add "=C3=A5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u=
/v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt" &&
+         cp ../test9200a.png "=C3=A5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o=
/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rd=
et.png" &&
+         git add "=C3=A5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u=
/v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.png" &&
+         git commit -a -m "G=C3=A5r det s=C3=A5 g=C3=A5r det" && \
+         id=3D$(git rev-list --max-count=3D1 HEAD) &&
+         (cd "$CVSWORK" &&
+         git-cvsexportcommit -v -c $id &&
+         test "$(echo $(sort "=C3=A5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o=
/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/CVS/Entries"|cut -d/ -f2,3,=
5))" =3D "g=C3=A5rdets=C3=A5g=C3=A5rdet.png/1.1/-kb g=C3=A5rdets=C3=A5g=
=C3=A5rdet.txt/1.1/"
+         )'
+fi
=20
 test_expect_success \
      'Mismatching patch should fail' \
