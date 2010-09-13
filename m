From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] tests: use test_cmp instead of piping to diff(1)
Date: Mon, 13 Sep 2010 20:59:42 +0000
Message-ID: <1284411582-1088-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 23:00:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvG8C-00080m-VI
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 23:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483Ab0IMU7x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 16:59:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55325 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab0IMU7v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 16:59:51 -0400
Received: by wyf22 with SMTP id 22so6666846wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=9R8+wH6TzSH6QVsBY1EqfO8It5aDjTjZwRddzYORCNo=;
        b=nWicePRwQWH2G4zL6VSF72gDTVBTHm79R0VUYt3G6XNbSJywSgMl0PhYbrqocXcGyr
         RO6bHmyYLvnf0Ky6fJJRFptBL7mIYkGdYI0TdpL6zV97OzET0Xt4xBy/b/QcfToL3N8a
         hbdc03EUxjIGppF+QkBpqZIoxl0R6wrMZZOAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ksdnJqO3f4zMXJX+o/x66yccQqN2/IHN63jKcl97RJIUmV/hw9PPivPIY07810gtwc
         MJQtn+PV8LzoTxup4tGWlEpMMPhbNpaDB3MDPbsnN+OVQ1uWhFV6uG9lJ3IQRrqv/2QI
         orxJ7uot9E89j0jXRrRTAUkq7/zO0fOTYo1/w=
Received: by 10.216.11.205 with SMTP id 55mr4891279wex.51.1284411590000;
        Mon, 13 Sep 2010 13:59:50 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id r18sm4240579weo.0.2010.09.13.13.59.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 13:59:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.121.g9cd82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156128>

Change submodule tests that piped to diff(1) to use test_cmp. The
resulting unified diff is easier to read.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t4041-diff-submodule-option.sh |   96 +++++++++++++++++++++++++-----=
--------
 t/t7401-submodule-summary.sh     |   45 ++++++++++++------
 2 files changed, 94 insertions(+), 47 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-=
option.sh
index 8e391cf..36a8a41 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -37,9 +37,10 @@ head1=3D$(add_file sm1 foo1 foo2)
 test_expect_success 'added submodule' "
 	git add sm1 &&
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 0000000...$head1 (new submodule)
 EOF
+    test_cmp expected actual
 "
=20
 commit_file sm1 &&
@@ -47,33 +48,36 @@ head2=3D$(add_file sm1 foo3)
=20
 test_expect_success 'modified submodule(forward)' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head1..$head2:
   > Add foo3
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule(forward)' "
 	git diff --submodule=3Dlog >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head1..$head2:
   > Add foo3
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule(forward) --submodule' "
 	git diff --submodule >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head1..$head2:
   > Add foo3
 EOF
+    test_cmp expected actual
 "
=20
 fullhead1=3D$(cd sm1; git rev-list --max-count=3D1 $head1)
 fullhead2=3D$(cd sm1; git rev-list --max-count=3D1 $head2)
 test_expect_success 'modified submodule(forward) --submodule=3Dshort' =
"
 	git diff --submodule=3Dshort >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 diff --git a/sm1 b/sm1
 index $head1..$head2 160000
 --- a/sm1
@@ -82,6 +86,7 @@ index $head1..$head2 160000
 -Subproject commit $fullhead1
 +Subproject commit $fullhead2
 EOF
+    test_cmp expected actual
 "
=20
 commit_file sm1 &&
@@ -92,24 +97,26 @@ cd ..
=20
 test_expect_success 'modified submodule(backward)' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head2..$head3 (rewind):
   < Add foo3
   < Add foo2
 EOF
+    test_cmp expected actual
 "
=20
 head4=3D$(add_file sm1 foo4 foo5) &&
 head4_full=3D$(GIT_DIR=3Dsm1/.git git rev-parse --verify HEAD)
 test_expect_success 'modified submodule(backward and forward)' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head2...$head4:
   > Add foo5
   > Add foo4
   < Add foo3
   < Add foo2
 EOF
+    test_cmp expected actual
 "
=20
 commit_file sm1 &&
@@ -122,7 +129,7 @@ mv sm1-bak sm1
=20
 test_expect_success 'typechanged submodule(submodule->blob), --cached'=
 "
 	git diff --submodule=3Dlog --cached >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 41fbea9...0000000 (submodule deleted)
 diff --git a/sm1 b/sm1
 new file mode 100644
@@ -132,11 +139,12 @@ index 0000000..9da5fb8
 @@ -0,0 +1 @@
 +sm1
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'typechanged submodule(submodule->blob)' "
 	git diff --submodule=3Dlog >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 diff --git a/sm1 b/sm1
 deleted file mode 100644
 index 9da5fb8..0000000
@@ -146,13 +154,14 @@ index 9da5fb8..0000000
 -sm1
 Submodule sm1 0000000...$head4 (new submodule)
 EOF
+    test_cmp expected actual
 "
=20
 rm -rf sm1 &&
 git checkout-index sm1
 test_expect_success 'typechanged submodule(submodule->blob)' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head4...0000000 (submodule deleted)
 diff --git a/sm1 b/sm1
 new file mode 100644
@@ -162,6 +171,7 @@ index 0000000..$head5
 @@ -0,0 +1 @@
 +sm1
 EOF
+    test_cmp expected actual
 "
=20
 rm -f sm1 &&
@@ -170,15 +180,16 @@ head6=3D$(add_file sm1 foo6 foo7)
 fullhead6=3D$(cd sm1; git rev-list --max-count=3D1 $head6)
 test_expect_success 'nonexistent commit' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head4...$head6 (commits not present)
 EOF
+    test_cmp expected actual
 "
=20
 commit_file
 test_expect_success 'typechanged submodule(blob->submodule)' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 diff --git a/sm1 b/sm1
 deleted file mode 100644
 index $head5..0000000
@@ -188,21 +199,24 @@ index $head5..0000000
 -sm1
 Submodule sm1 0000000...$head6 (new submodule)
 EOF
+    test_cmp expected actual
 "
=20
 commit_file sm1 &&
 test_expect_success 'submodule is up to date' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'submodule contains untracked content' "
 	echo new > sm1/new-file &&
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 contains untracked content
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'submodule contains untracked content (untracked i=
gnored)' "
@@ -223,18 +237,20 @@ test_expect_success 'submodule contains untracked=
 content (all ignored)' "
 test_expect_success 'submodule contains untracked and modifed content'=
 "
 	echo new > sm1/foo6 &&
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 contains untracked content
 Submodule sm1 contains modified content
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'submodule contains untracked and modifed content =
(untracked ignored)' "
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules=3Duntracked --submodule=3Dlog H=
EAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 contains modified content
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'submodule contains untracked and modifed content =
(dirty ignored)' "
@@ -252,45 +268,50 @@ test_expect_success 'submodule contains untracked=
 and modifed content (all ignor
 test_expect_success 'submodule contains modifed content' "
 	rm -f sm1/new-file &&
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 contains modified content
 EOF
+    test_cmp expected actual
 "
=20
 (cd sm1; git commit -mchange foo6 >/dev/null) &&
 head8=3D$(cd sm1; git rev-parse --verify HEAD | cut -c1-7) &&
 test_expect_success 'submodule is modified' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head6..$head8:
   > change
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule contains untracked content' "
 	echo new > sm1/new-file &&
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 contains untracked content
 Submodule sm1 $head6..$head8:
   > change
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule contains untracked content (un=
tracked ignored)' "
 	git diff-index -p --ignore-submodules=3Duntracked --submodule=3Dlog H=
EAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head6..$head8:
   > change
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule contains untracked content (di=
rty ignored)' "
 	git diff-index -p --ignore-submodules=3Ddirty --submodule=3Dlog HEAD =
>actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head6..$head8:
   > change
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule contains untracked content (al=
l ignored)' "
@@ -301,31 +322,34 @@ test_expect_success 'modified submodule contains =
untracked content (all ignored)
 test_expect_success 'modified submodule contains untracked and modifed=
 content' "
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 contains untracked content
 Submodule sm1 contains modified content
 Submodule sm1 $head6..$head8:
   > change
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule contains untracked and modifed=
 content (untracked ignored)' "
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules=3Duntracked --submodule=3Dlog H=
EAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 contains modified content
 Submodule sm1 $head6..$head8:
   > change
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule contains untracked and modifed=
 content (dirty ignored)' "
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules=3Ddirty --submodule=3Dlog HEAD =
>actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head6..$head8:
   > change
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule contains untracked and modifed=
 content (all ignored)' "
@@ -337,19 +361,21 @@ test_expect_success 'modified submodule contains =
untracked and modifed content (
 test_expect_success 'modified submodule contains modifed content' "
 	rm -f sm1/new-file &&
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 contains modified content
 Submodule sm1 $head6..$head8:
   > change
 EOF
+    test_cmp expected actual
 "
=20
 rm -rf sm1
 test_expect_success 'deleted submodule' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head6...0000000 (submodule deleted)
 EOF
+    test_cmp expected actual
 "
=20
 test_create_repo sm2 &&
@@ -358,41 +384,45 @@ git add sm2
=20
 test_expect_success 'multiple submodules' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head6...0000000 (submodule deleted)
 Submodule sm2 0000000...$head7 (new submodule)
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'path filter' "
 	git diff-index -p --submodule=3Dlog HEAD sm2 >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm2 0000000...$head7 (new submodule)
 EOF
+    test_cmp expected actual
 "
=20
 commit_file sm2
 test_expect_success 'given commit' "
 	git diff-index -p --submodule=3Dlog HEAD^ >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head6...0000000 (submodule deleted)
 Submodule sm2 0000000...$head7 (new submodule)
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'given commit --submodule' "
 	git diff-index -p --submodule HEAD^ >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head6...0000000 (submodule deleted)
 Submodule sm2 0000000...$head7 (new submodule)
 EOF
+    test_cmp expected actual
 "
=20
 fullhead7=3D$(cd sm2; git rev-list --max-count=3D1 $head7)
=20
 test_expect_success 'given commit --submodule=3Dshort' "
 	git diff-index -p --submodule=3Dshort HEAD^ >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 diff --git a/sm1 b/sm1
 deleted file mode 160000
 index $head6..0000000
@@ -408,6 +438,7 @@ index 0000000..$head7
 @@ -0,0 +1 @@
 +Subproject commit $fullhead7
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'setup .git file for sm2' '
@@ -419,10 +450,11 @@ test_expect_success 'setup .git file for sm2' '
=20
 test_expect_success 'diff --submodule with .git file' '
 	git diff --submodule HEAD^ >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 Submodule sm1 $head6...0000000 (submodule deleted)
 Submodule sm2 0000000...$head7 (new submodule)
 EOF
+    test_cmp expected actual
 '
=20
 test_done
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.s=
h
index cee319d..6a320cc 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -37,11 +37,12 @@ head1=3D$(add_file sm1 foo1 foo2)
 test_expect_success 'added submodule' "
 	git add sm1 &&
 	git submodule summary >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 * sm1 0000000...$head1 (2):
   > Add foo2
=20
 EOF
+    test_cmp expected actual
 "
=20
 commit_file sm1 &&
@@ -49,20 +50,22 @@ head2=3D$(add_file sm1 foo3)
=20
 test_expect_success 'modified submodule(forward)' "
 	git submodule summary >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 * sm1 $head1...$head2 (1):
   > Add foo3
=20
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule(forward), --files' "
 	git submodule summary --files >actual &&
-	diff actual - <<-EOF
+	cat >expected <<-EOF &&
 * sm1 $head1...$head2 (1):
   > Add foo3
=20
 EOF
+    test_cmp expected actual
 "
=20
 commit_file sm1 &&
@@ -73,19 +76,20 @@ cd ..
=20
 test_expect_success 'modified submodule(backward)' "
     git submodule summary >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm1 $head2...$head3 (2):
   < Add foo3
   < Add foo2
=20
 EOF
+    test_cmp expected actual
 "
=20
 head4=3D$(add_file sm1 foo4 foo5) &&
 head4_full=3D$(GIT_DIR=3Dsm1/.git git rev-parse --verify HEAD)
 test_expect_success 'modified submodule(backward and forward)' "
     git submodule summary >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm1 $head2...$head4 (4):
   > Add foo5
   > Add foo4
@@ -93,17 +97,19 @@ test_expect_success 'modified submodule(backward an=
d forward)' "
   < Add foo2
=20
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success '--summary-limit' "
     git submodule summary -n 3 >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm1 $head2...$head4 (4):
   > Add foo5
   > Add foo4
   < Add foo3
=20
 EOF
+    test_cmp expected actual
 "
=20
 commit_file sm1 &&
@@ -116,30 +122,33 @@ mv sm1-bak sm1
=20
 test_expect_success 'typechanged submodule(submodule->blob), --cached'=
 "
     git submodule summary --cached >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm1 $head4(submodule)->$head5(blob) (3):
   < Add foo5
=20
 EOF
+    test_cmp actual expected
 "
=20
 test_expect_success 'typechanged submodule(submodule->blob), --files' =
"
     git submodule summary --files >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm1 $head5(blob)->$head4(submodule) (3):
   > Add foo5
=20
 EOF
+    test_cmp actual expected
 "
=20
 rm -rf sm1 &&
 git checkout-index sm1
 test_expect_success 'typechanged submodule(submodule->blob)' "
     git submodule summary >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm1 $head4(submodule)->$head5(blob):
=20
 EOF
+    test_cmp actual expected
 "
=20
 rm -f sm1 &&
@@ -147,31 +156,34 @@ test_create_repo sm1 &&
 head6=3D$(add_file sm1 foo6 foo7)
 test_expect_success 'nonexistent commit' "
     git submodule summary >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm1 $head4...$head6:
   Warn: sm1 doesn't contain commit $head4_full
=20
 EOF
+    test_cmp actual expected
 "
=20
 commit_file
 test_expect_success 'typechanged submodule(blob->submodule)' "
     git submodule summary >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm1 $head5(blob)->$head6(submodule) (2):
   > Add foo7
=20
 EOF
+    test_cmp expected actual
 "
=20
 commit_file sm1 &&
 rm -rf sm1
 test_expect_success 'deleted submodule' "
     git submodule summary >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm1 $head6...0000000:
=20
 EOF
+    test_cmp expected actual
 "
=20
 test_create_repo sm2 &&
@@ -180,34 +192,37 @@ git add sm2
=20
 test_expect_success 'multiple submodules' "
     git submodule summary >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm1 $head6...0000000:
=20
 * sm2 0000000...$head7 (2):
   > Add foo9
=20
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success 'path filter' "
     git submodule summary sm2 >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm2 0000000...$head7 (2):
   > Add foo9
=20
 EOF
+    test_cmp expected actual
 "
=20
 commit_file sm2
 test_expect_success 'given commit' "
     git submodule summary HEAD^ >actual &&
-    diff actual - <<-EOF
+    cat >expected <<-EOF &&
 * sm1 $head6...0000000:
=20
 * sm2 0000000...$head7 (2):
   > Add foo9
=20
 EOF
+    test_cmp expected actual
 "
=20
 test_expect_success '--for-status' "
--=20
1.7.3.rc1.121.g9cd82
