From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t9200: Be careful when checking CVS/Entries
Date: Tue, 24 Jul 2007 23:39:56 -0700
Message-ID: <7vtzrtdm0z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 08:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDaXw-0002uN-Qo
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 08:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763452AbXGYGkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 25 Jul 2007 02:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761587AbXGYGkE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 02:40:04 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44532 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758527AbXGYGj6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2007 02:39:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725063957.IYYV1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Jul 2007 02:39:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Tifw1X00J1kojtg0000000; Wed, 25 Jul 2007 02:39:57 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53668>

CVS/Entries file can contain a line with a single D to say "this
directory does not have any subdirectories".  Do not get
confused with such an entry.  In the tests, we are only
interested in the tracked files, so we should only look at the
lines that begin with a '/'.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I haven't figured out why, but sometimes CVS leaves such a
   'D' line in a directory without a subdirectory, which really
   screws up the comparison.

   Moreover, test $(echo $(sort ... | ...)) =3D "e x p e c t e d"
   was simply too ugly to read.

 t/t9200-git-cvsexportcommit.sh |   64 ++++++++++++++++++++++++--------=
-------
 1 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index 4efa0c9..910c584 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -28,6 +28,18 @@ git add empty &&
 git commit -q -a -m "Initial" 2>/dev/null ||
 exit 1
=20
+check_entries () {
+	# $1 =3D=3D directory, $2 =3D=3D expected
+	grep '^/' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
+	if test -z "$2"
+	then
+		>expected
+	else
+		printf '%s\n' "$2" | tr '|' '\012' >expected
+	fi
+	diff -u expected actual
+}
+
 test_expect_success \
     'New file' \
     'mkdir A B C D E F &&
@@ -43,10 +55,10 @@ test_expect_success \
      id=3D$(git rev-list --max-count=3D1 HEAD) &&
      (cd "$CVSWORK" &&
      git cvsexportcommit -c $id &&
-     test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
1.txt/1.1/" &&
-     test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
2.txt/1.1/" &&
-     test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
3.png/1.1/-kb" &&
-     test "$(echo $(sort D/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
4.png/1.1/-kb" &&
+     check_entries A "newfile1.txt/1.1/" &&
+     check_entries B "newfile2.txt/1.1/" &&
+     check_entries C "newfile3.png/1.1/-kb" &&
+     check_entries D "newfile4.png/1.1/-kb" &&
      diff A/newfile1.txt ../A/newfile1.txt &&
      diff B/newfile2.txt ../B/newfile2.txt &&
      diff C/newfile3.png ../C/newfile3.png &&
@@ -67,12 +79,12 @@ test_expect_success \
      id=3D$(git rev-list --max-count=3D1 HEAD) &&
      (cd "$CVSWORK" &&
      git cvsexportcommit -c $id &&
-     test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
1.txt/1.2/" &&
-     test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
-     test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
-     test "$(echo $(sort D/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
4.png/1.2/-kb" &&
-     test "$(echo $(sort E/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
5.txt/1.1/" &&
-     test "$(echo $(sort F/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
6.png/1.1/-kb" &&
+     check_entries A "newfile1.txt/1.2/" &&
+     check_entries B "" &&
+     check_entries C "" &&
+     check_entries D "newfile4.png/1.2/-kb" &&
+     check_entries E "newfile5.txt/1.1/" &&
+     check_entries F "newfile6.png/1.1/-kb" &&
      diff A/newfile1.txt ../A/newfile1.txt &&
      diff D/newfile4.png ../D/newfile4.png &&
      diff E/newfile5.txt ../E/newfile5.txt &&
@@ -115,12 +127,12 @@ test_expect_success \
      id=3D$(git rev-list --max-count=3D1 HEAD) &&
      (cd "$CVSWORK" &&
      git cvsexportcommit -c $id &&
-     test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
1.txt/1.2/" &&
-     test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
-     test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
-     test "$(echo $(sort D/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
-     test "$(echo $(sort E/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
5.txt/1.1/" &&
-     test "$(echo $(sort F/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
6.png/1.1/-kb" &&
+     check_entries A "newfile1.txt/1.2/" &&
+     check_entries B "" &&
+     check_entries C "" &&
+     check_entries D "" &&
+     check_entries E "newfile5.txt/1.1/" &&
+     check_entries F "newfile6.png/1.1/-kb" &&
      diff A/newfile1.txt ../A/newfile1.txt &&
      diff E/newfile5.txt ../E/newfile5.txt &&
      diff F/newfile6.png ../F/newfile6.png
@@ -133,12 +145,12 @@ test_expect_success \
      id=3D$(git rev-list --max-count=3D1 HEAD) &&
      (cd "$CVSWORK" &&
      git cvsexportcommit -c $id &&
-     test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
-     test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
-     test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
-     test "$(echo $(sort D/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
-     test "$(echo $(sort E/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
5.txt/1.1/" &&
-     test "$(echo $(sort F/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
6.png/1.1/-kb" &&
+     check_entries A "" &&
+     check_entries B "" &&
+     check_entries C "" &&
+     check_entries D "" &&
+     check_entries E "newfile5.txt/1.1/" &&
+     check_entries F "newfile6.png/1.1/-kb" &&
      diff E/newfile5.txt ../E/newfile5.txt &&
      diff F/newfile6.png ../F/newfile6.png
      )'
@@ -154,7 +166,7 @@ test_expect_success \
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
       git-cvsexportcommit -c $id &&
-      test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" =3D "wi=
th spaces.png/1.1/-kb with spaces.txt/1.1/"
+      check_entries "G g" "with spaces.png/1.1/-kb|with spaces.txt/1.1=
/"
       )'
=20
 test_expect_success \
@@ -166,7 +178,7 @@ test_expect_success \
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
       git-cvsexportcommit -c $id
-      test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" =3D "wi=
th spaces.png/1.2/-kb with spaces.txt/1.2/"
+      check_entries "G g" "with spaces.png/1.2/-kb|with spaces.txt/1.2=
/"
       )'
=20
 # Some filesystems mangle pathnames with UTF-8 characters --
@@ -191,7 +203,9 @@ test_expect_success \
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
       git-cvsexportcommit -v -c $id &&
-      test "$(echo $(sort =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q=
/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/CVS/Entries|cut -d/ -f2,3,5))" =
=3D "g=C3=A5rdets=C3=A5g=C3=A5rdet.png/1.1/-kb g=C3=A5rdets=C3=A5g=C3=A5=
rdet.txt/1.1/"
+      check_entries \
+      "=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=
=C3=A5/=C3=A4/=C3=B6" \
+      "g=C3=A5rdets=C3=A5g=C3=A5rdet.png/1.1/-kb|g=C3=A5rdets=C3=A5g=C3=
=A5rdet.txt/1.1/"
       )'
=20
 fi
--=20
1.5.3.rc3
