From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Sun, 22 Jul 2007 21:32:55 -0700
Message-ID: <7vd4yjoi2w.fsf@assigned-by-dhcp.cox.net>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net>
	<11851631511468-git-send-email-jasonsewall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, raa.lkml@gmail.com
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 06:33:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICpbd-0005GU-Er
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 06:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbXGWEc7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Jul 2007 00:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbXGWEc6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 00:32:58 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58153 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXGWEc6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 00:32:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070723043257.SECT1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Jul 2007 00:32:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SsYv1X00Q1kojtg0000000; Mon, 23 Jul 2007 00:32:56 -0400
In-Reply-To: <11851631511468-git-send-email-jasonsewall@gmail.com> (Jason
	Sewall's message of "Sun, 22 Jul 2007 20:59:11 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53388>

Jason Sewall <jasonsewall@gmail.com> writes:

> Test #7 of t9200 isn't likely to succeed because tests are executed t=
oo fast for cvs; add a delay to give it a chance to succeed.
> ---
>  I think I didn't send this through the proper server, so here it is =
finally.
>  t/t9200-git-cvsexportcommit.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportco=
mmit.sh
> index 4efa0c9..2096e59 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -164,6 +164,7 @@ test_expect_success \
>        git add "G g/with spaces.png" &&
>        git commit -a -m "Update with spaces" &&
>        id=3D$(git rev-list --max-count=3D1 HEAD) &&
> +      sleep 1 &&
>        (cd "$CVSWORK" &&
>        git-cvsexportcommit -c $id
>        test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" =3D "=
with spaces.png/1.2/-kb with spaces.txt/1.2/"

Thanks.

But this makes one wonder why only this test and nothing else is
affected.  Maybe our machines are not fast enough for other
tests to execute inside a second, but in 6 months others start
to become problem and we would need a similar fix again?

I am tempted to do this instead, although it would make it much
slower.

It may be that we may want to fix this inside cvsexportcommit
itself, instead of working it around in the tests.  If somebody
tries to push more than one commit from git using two
cvsexportcommit in a row, he would need to make sure that the
second run happens one or more seconds after the first run,
otherwise he will see the exact corruption in real life.

Anybody else have better ideas? =20

---
 t/t9200-git-cvsexportcommit.sh |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index 4efa0c9..28c7dfa 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -28,6 +28,13 @@ git add empty &&
 git commit -q -a -m "Initial" 2>/dev/null ||
 exit 1
=20
+git_cvsexportcommit () {
+	# CVS does not even look at files whose timestamps
+	# match the ones recorded in CVS/Entries
+	sleep 2 &&
+	git cvsexportcommit "$@"
+}
+
 test_expect_success \
     'New file' \
     'mkdir A B C D E F &&
@@ -42,7 +49,7 @@ test_expect_success \
      git commit -a -m "Test: New file" &&
      id=3D$(git rev-list --max-count=3D1 HEAD) &&
      (cd "$CVSWORK" &&
-     git cvsexportcommit -c $id &&
+     git_cvsexportcommit -c $id &&
      test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
1.txt/1.1/" &&
      test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
2.txt/1.1/" &&
      test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
3.png/1.1/-kb" &&
@@ -66,7 +73,7 @@ test_expect_success \
      git commit -a -m "Test: Remove, add and update" &&
      id=3D$(git rev-list --max-count=3D1 HEAD) &&
      (cd "$CVSWORK" &&
-     git cvsexportcommit -c $id &&
+     git_cvsexportcommit -c $id &&
      test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
1.txt/1.2/" &&
      test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
      test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
@@ -88,7 +95,7 @@ test_expect_success \
      git commit -a -m "generation 2" &&
      id=3D$(git rev-list --max-count=3D1 HEAD) &&
      (cd "$CVSWORK" &&
-     ! git cvsexportcommit -c $id
+     ! git_cvsexportcommit -c $id
      )'
=20
 #test_expect_success \
@@ -100,7 +107,7 @@ test_expect_success \
 #     git commit -a -m "generation 3" &&
 #     id=3D$(git rev-list --max-count=3D1 HEAD) &&
 #     (cd "$CVSWORK" &&
-#     ! git cvsexportcommit -c $id
+#     ! git_cvsexportcommit -c $id
 #     )'
=20
 # We reuse the state from two tests back here
@@ -114,7 +121,7 @@ test_expect_success \
      git commit -a -m "test: remove only a binary file" &&
      id=3D$(git rev-list --max-count=3D1 HEAD) &&
      (cd "$CVSWORK" &&
-     git cvsexportcommit -c $id &&
+     git_cvsexportcommit -c $id &&
      test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" =3D "newfile=
1.txt/1.2/" &&
      test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
      test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
@@ -132,7 +139,7 @@ test_expect_success \
      git commit -a -m "test: remove only a binary file" &&
      id=3D$(git rev-list --max-count=3D1 HEAD) &&
      (cd "$CVSWORK" &&
-     git cvsexportcommit -c $id &&
+     git_cvsexportcommit -c $id &&
      test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
      test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
      test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" =3D "" &&
@@ -153,7 +160,7 @@ test_expect_success \
       git commit -a -m "With spaces" &&
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
-      git-cvsexportcommit -c $id &&
+      git_cvsexportcommit -c $id &&
       test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" =3D "wi=
th spaces.png/1.1/-kb with spaces.txt/1.1/"
       )'
=20
@@ -165,7 +172,7 @@ test_expect_success \
       git commit -a -m "Update with spaces" &&
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
-      git-cvsexportcommit -c $id
+      git_cvsexportcommit -c $id
       test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" =3D "wi=
th spaces.png/1.2/-kb with spaces.txt/1.2/"
       )'
=20
@@ -190,7 +197,7 @@ test_expect_success \
       git commit -a -m "G=C3=A5r det s=C3=A5 g=C3=A5r det" && \
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
-      git-cvsexportcommit -v -c $id &&
+      git_cvsexportcommit -v -c $id &&
       test "$(echo $(sort =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q=
/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/CVS/Entries|cut -d/ -f2,3,5))" =
=3D "g=C3=A5rdets=C3=A5g=C3=A5rdet.png/1.1/-kb g=C3=A5rdets=C3=A5g=C3=A5=
rdet.txt/1.1/"
       )'
=20
@@ -208,7 +215,7 @@ test_expect_success \
       git commit -a -m "Update two" &&
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
-      ! git-cvsexportcommit -c $id
+      ! git_cvsexportcommit -c $id
       )'
=20
 case "$(git repo-config --bool core.filemode)" in
@@ -225,7 +232,7 @@ test_expect_success \
       git add G/off &&
       git commit -a -m "Execute test" &&
       (cd "$CVSWORK" &&
-      git-cvsexportcommit -c HEAD
+      git_cvsexportcommit -c HEAD
       test -x G/on &&
       ! test -x G/off
       )'
