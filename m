From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Fail softly if file system does not like test data.
Date: Tue, 30 Jan 2007 23:49:08 +0100
Message-ID: <20070130224446.28311.31828.stgit@lathund.dewire.com>
References: <20070130163219.GA14431@164.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 23:48:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC1mU-000491-Ce
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 23:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbXA3Wsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 30 Jan 2007 17:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbXA3Wsf
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 17:48:35 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11251 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbXA3Wse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 17:48:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 43F0F803392;
	Tue, 30 Jan 2007 23:43:54 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05808-02; Tue, 30 Jan 2007 23:43:53 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id C7B00800199;
	Tue, 30 Jan 2007 23:43:51 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 39FB329324;
	Tue, 30 Jan 2007 23:49:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id S7PHAz72MJzN; Tue, 30 Jan 2007 23:49:09 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 1A67E2911E;
	Tue, 30 Jan 2007 23:49:09 +0100 (CET)
In-Reply-To: <20070130163219.GA14431@164.242.249.10.in-addr.arpa>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38212>

Most unix file system allow almost any byte sequence, but other may rej=
ect
sequences that are not valid according to the locale. This change makes
failure somewhat less likely by using UTF-8-encoded characters (which
happen to be valid interpreted as ISO-8859-1 and skips the test if the=20
local file system does not support the test data.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

Please try this on cygwin (western iso-8859-X, korean on FAT & NTFS) an=
d=20
MacOSX (HFS) where we know there was a problem. The non-ascii filename
test should be skipped, with a notice) in most asian locales on Windows
and MacOSX.

 t/t9200-git-cvsexportcommit.sh |   35 +++++++++++++++++++++-----------=
---
 1 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index fd0a554..fdf7b3f 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -169,20 +169,27 @@ test_expect_success \
       test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" =3D "wi=
th spaces.png/1.2/-kb with spaces.txt/1.2/"
       )'
=20
-# This test contains ISO-8859-1 characters
-test_expect_success \
-     'File with non-ascii file name' \
-     'mkdir -p =C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x=
/y/z/=E5/=E4/=F6 &&
-      echo Foo >=C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/=
x/y/z/=E5/=E4/=F6/g=E5rdets=E5g=E5rdet.txt &&
-      git add =C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/=
y/z/=E5/=E4/=F6/g=E5rdets=E5g=E5rdet.txt &&
-      cp ../test9200a.png =C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/=
s/t/u/v/w/x/y/z/=E5/=E4/=F6/g=E5rdets=E5g=E5rdet.png &&
-      git add =C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/=
y/z/=E5/=E4/=F6/g=E5rdets=E5g=E5rdet.png &&
-      git commit -a -m "G=E5r det s=E5 g=E5r det" && \
-      id=3D$(git rev-list --max-count=3D1 HEAD) &&
-      (cd "$CVSWORK" &&
-      git-cvsexportcommit -v -c $id &&
-      test "$(echo $(sort =C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/=
s/t/u/v/w/x/y/z/=E5/=E4/=F6/CVS/Entries|cut -d/ -f2,3,5))" =3D "g=E5rde=
ts=E5g=E5rdet.png/1.1/-kb g=E5rdets=E5g=E5rdet.txt/1.1/"
-      )'
+# This test contains UTF-8 characters and may fail on some filesystems
+mkdir -p "/=C3=A5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/=
y/z/=C3=A5/=C3=A4/=C3=B6" >/dev/null 2>&1
+if test $? -ne 0
+then
+    test_expect_success 'File with non-ascii file name skipped, file s=
ystem is incompatible with test data' :
+else
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
