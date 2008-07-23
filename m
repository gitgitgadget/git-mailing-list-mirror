From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 05/12] tests for sparse checkout, index protection
Date: Wed, 23 Jul 2008 21:56:32 +0700
Message-ID: <20080723145632.GA29100@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:58:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfmt-0002fk-H3
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbYGWO4z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbYGWO4z
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:56:55 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbYGWO4y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:56:54 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ALnNzOj7AclJ+DqT5PPyRcSolJLzQ3CJKQ26jv8xt1M=;
        b=yFLg305h9thhYhEv+oZp8qFQ8m9UhMkj26uZY52Mpqm0++B6RK4ogL0acJ2MnPECLR
         vCpZxxanmuXZKXAuEwzV1/RX/WHHWTR8i9VTUHaW/RFWSPBwwcygWPE3xsEMgvFruWJ0
         WEwiQ28Qp3Fr21QluMW4drzx+Rs/UJQq77hLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=k+pEFXScSMJ4jG3VU9XaKL0O1NSq6PYn6jf1OfFhrZB5+sFiWY3iZtO27KFZBUZCg8
         3w4JOQjaol/Yzo9KfcCySCv5RTdj5W5UDwhnDHDUQ4ReVGRsSBBKaXHiZOQvoAi0x0Ds
         qhpzVWnr1SEeWcLPvMyMzn1GRQ+6FxboTvYfs=
Received: by 10.110.105.10 with SMTP id d10mr85561tic.52.1216825013376;
        Wed, 23 Jul 2008 07:56:53 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id a4sm14726237tib.2.2008.07.23.07.56.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:56:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:56:33 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89675>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t2300-sparse-index.sh                 |  156 +++++++++++++++++++++
 t/t2300/diff-index-sub.expected         |    3 +
 t/t2300/log.expected                    |   64 +++++++++
 t/t2301-sparse-index-merge-recursive.sh |  226 +++++++++++++++++++++++=
++++++++
 4 files changed, 449 insertions(+), 0 deletions(-)
 create mode 100755 t/t2300-sparse-index.sh
 create mode 100644 t/t2300/diff-index-sub.expected
 create mode 100644 t/t2300/log.expected
 create mode 100755 t/t2301-sparse-index-merge-recursive.sh

diff --git a/t/t2300-sparse-index.sh b/t/t2300-sparse-index.sh
new file mode 100755
index 0000000..8b9d61f
--- /dev/null
+++ b/t/t2300-sparse-index.sh
@@ -0,0 +1,156 @@
+#!/bin/sh
+
+test_description=3D'sparse checkout -- index update
+
+This test makes sure all commands that touch index will not
+be able to write outside sparse prefix, once set.
+
+It also makes sure some full index operation like git-checkout
+or git-read-tree can function even with index prefix set.
+'
+
+. ./test-lib.sh
+
+setup_repo() {
+	test "$#" =3D 1 ||
+	error 'bug in the test script: not 1 parameter to setup_repo'
+	test_create_repo "$1" &&
+	(
+		cd "$1" &&
+		mkdir -p work/sub/dir &&
+		touch untracked tracked modified added &&
+		touch work/untracked work/tracked work/modified work/added &&
+		git add tracked work/tracked &&
+		git add modified work/modified &&
+		git commit -m initial &&
+		git add added work/added &&
+		echo modified > modified &&
+		echo work/modified > work/modified
+	)
+}
+
+# this prevent sparse checkout's worktree protection
+# so you can access everything in worktree
+# index modification is limited though
+export GIT_SPARSE_CHECKOUT_INDEX_ONLY=3D1
+
+test_expect_success 'setup update-index and --show-parse-prefix' '
+	setup_repo update-index &&
+	cd update-index &&
+	git config core.sparsecheckout work:nonwork &&
+	test nonwork:work =3D "$(git rev-parse --show-sparse-prefix)" &&
+	git config core.sparsecheckout work &&
+	test work =3D "$(git rev-parse --show-sparse-prefix)"
+'
+
+test_expect_success 'ls-files --with-tree does not bail out' '
+	git ls-files --with-tree=3DHEAD
+'
+
+test_expect_success 'update-index --refresh with new mtime outside ind=
ex prefix' '
+	touch tracked &&
+	test -z "$(git update-index --refresh 2>&1 >/dev/null)"
+'
+
+test_expect_success 'update inside' 'git update-index work/modified'
+test_expect_success 'remove inside' 'git update-index --force-remove w=
ork/tracked'
+test_expect_success 'add inside' 'git update-index --add work/untracke=
d'
+
+test_expect_success 'update outside' '! git update-index modified'
+test_expect_success 'remove outside' '! git update-index --force-remov=
e modified'
+test_expect_success 'add outside' '! git update-index --add untracked'
+
+test_expect_success 'setup add' '
+	cd .. &&
+	setup_repo add &&
+	cd add
+	git config core.sparsecheckout work &&
+	test work =3D "$(git rev-parse --show-sparse-prefix)"
+'
+
+test_expect_success 'add inside' 'git add work/modified'
+test_expect_success 'add outside' '! git add untracked'
+
+test_expect_success 'setup rm' '
+	cd .. &&
+	setup_repo rm &&
+	cd rm &&
+	git config core.sparsecheckout work
+	test work =3D "$(git rev-parse --show-sparse-prefix)"
+'
+
+test_expect_success 'inside:  rm' 'git rm work/tracked'
+test_expect_success 'outside:  rm' '! git rm tracked'
+
+test_expect_success 'setup apply' '
+	cd .. &&
+	test_create_repo apply &&
+	cd apply &&
+	mkdir -p work/sub/dir &&
+	touch modified work/modified &&
+	git add modified work/modified &&
+	git config core.sparsecheckout work &&
+	test work =3D "$(git rev-parse --show-sparse-prefix)"
+'
+
+cat <<EOF > outside.patch
+diff --git a/modified b/modified
+index e69de29..2e09960 100644
+--- a/modified
++++ b/modified
+@@ -0,0 +1 @@
++modified
+EOF
+
+cat <<EOF > inside.patch
+diff --git a/work/modified b/work/modified
+index e69de29..4bd2893 100644
+--- a/work/modified
++++ b/work/modified
+@@ -0,0 +1 @@
++work/modified
+EOF
+
+
+test_expect_success 'inside:  apply --cached' 'git apply --cached insi=
de.patch'
+test_expect_success 'outside:  apply --cached' '! git apply --cached o=
utside.patch'
+
+test_expect_success 'setup read-tree (clean worktree)' '
+	cd ..
+	test_create_repo read-tree &&
+	cd read-tree &&
+	test_tick &&
+	mkdir -p work/sub/dir &&
+	echo one > one && git add one && git commit -m one &&
+	echo two >> one && git add one && git commit -m two &&
+	echo one > work/one && git add work/one && git commit -m work/one &&
+	echo two >> work/one && git add work/one && git commit -m work/two &&
+	echo one > work/sub/one && git add work/sub/one && git commit -m work=
/sub/one &&
+	echo two >> work/sub/one && git add work/sub/one && git commit -m wor=
k/sub/two &&
+	echo one > work/sub/dir/one && echo three >> work/one &&
+		git add work/sub/dir/one work/one &&
+		git commit -m work/sub/dir/one &&
+	echo two >> work/sub/dir/one &&
+		git add work/sub/dir/one &&
+		git commit -m work/sub/dir/two &&
+	git log --raw > ../log.result &&
+	cmp ../../t2300/log.expected ../log.result &&
+	git config core.sparsecheckout work/sub &&
+	test work/sub =3D "$(git rev-parse --show-sparse-prefix)"
+'
+
+test_expect_success 'read-tree inside index prefix' '
+	git read-tree 47b2996ef7d1dd7d5fd146c520ed90995e2d7e0d &&
+	test -z "$(git diff-index --cached 47b2996ef7d1dd7d5fd146c520ed90995e=
2d7e0d)"'
+
+test_expect_success 'read-tree outside index prefix' '
+	! git read-tree b64ae04f6be47b3d729f731de1ce804223f45113'
+
+test_expect_success 'read-tree with --prefix outside' '
+	! git read-tree --prefix=3Dwork/newsub/ b64ae04f6be47b3d729f731de1ce8=
04223f45113'
+
+test_expect_success 'read-tree with --prefix inside' '
+	git read-tree --prefix=3Dwork/sub/dir/newsub/ b64ae04f6be47b3d729f731=
de1ce804223f45113 &&
+	git diff-index --cached 47b2996ef7d1dd7d5fd146c520ed90995e2d7e0d|cmp =
=2E./../t2300/diff-index-sub.expected'
+
+test_done
diff --git a/t/t2300/diff-index-sub.expected b/t/t2300/diff-index-sub.e=
xpected
new file mode 100644
index 0000000..49b1a47
--- /dev/null
+++ b/t/t2300/diff-index-sub.expected
@@ -0,0 +1,3 @@
+:000000 100644 0000000000000000000000000000000000000000 814f4a422927b8=
2f5f8a43f8fab6d3839e3983f2 A	work/sub/dir/newsub/one
+:000000 100644 0000000000000000000000000000000000000000 814f4a422927b8=
2f5f8a43f8fab6d3839e3983f2 A	work/sub/dir/newsub/work/one
+:000000 100644 0000000000000000000000000000000000000000 5626abf0f72e58=
d7a153368ba57db4c673c0e171 A	work/sub/dir/newsub/work/sub/one
diff --git a/t/t2300/log.expected b/t/t2300/log.expected
new file mode 100644
index 0000000..58b69bd
--- /dev/null
+++ b/t/t2300/log.expected
@@ -0,0 +1,64 @@
+commit 69798ebb265c266292b4919f7a943bc30d72dfa3
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    work/sub/dir/two
+
+:100644 100644 5626abf... 814f4a4... M	work/sub/dir/one
+
+commit 47b2996ef7d1dd7d5fd146c520ed90995e2d7e0d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    work/sub/dir/one
+
+:100644 100644 814f4a4... 4cb29ea... M	work/one
+:000000 100644 0000000... 5626abf... A	work/sub/dir/one
+
+commit dd5fc8b46ac73c49bb046e16b0d9980a8142de51
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    work/sub/two
+
+:100644 100644 5626abf... 814f4a4... M	work/sub/one
+
+commit b64ae04f6be47b3d729f731de1ce804223f45113
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    work/sub/one
+
+:000000 100644 0000000... 5626abf... A	work/sub/one
+
+commit 69da5948890ae9caff70388451ba5ede78b77d08
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    work/two
+
+:100644 100644 5626abf... 814f4a4... M	work/one
+
+commit e63957619e33be2985dacdbb077f4c2ca7210319
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    work/one
+
+:000000 100644 0000000... 5626abf... A	work/one
+
+commit e6742a1800d08c749ebbc01d1f4ca03b66ff44e1
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    two
+
+:100644 100644 5626abf... 814f4a4... M	one
+
+commit 1c60dc5aa63dc2956ceb3ccc399d04245bc2cc1b
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    one
+
+:000000 100644 0000000... 5626abf... A	one
diff --git a/t/t2301-sparse-index-merge-recursive.sh b/t/t2301-sparse-i=
ndex-merge-recursive.sh
new file mode 100755
index 0000000..61b3766
--- /dev/null
+++ b/t/t2301-sparse-index-merge-recursive.sh
@@ -0,0 +1,226 @@
+#!/bin/sh
+
+test_description=3D'merge-recursive backend test'
+
+. ./test-lib.sh
+
+# this prevent sparse checkout's worktree protection
+# so you can access everything in worktree
+# index modification is limited though
+export GIT_SPARSE_CHECKOUT_INDEX_ONLY=3D1
+
+test_expect_success 'setup 1' '
+
+	echo hello >a &&
+	o0=3D$(git hash-object a) &&
+	cp a b &&
+	cp a c &&
+	mkdir d &&
+	cp a d/e &&
+
+	test_tick &&
+	git add a b c d/e &&
+	git commit -m initial &&
+	c0=3D$(git rev-parse --verify HEAD) &&
+	git branch noconflict &&
+	git branch conflict &&
+	git branch conflict-inside &&
+
+	echo hello >>a &&
+	cp a d/e &&
+	o1=3D$(git hash-object a) &&
+
+	git add a d/e &&
+
+	test_tick &&
+	git commit -m "master modifies a and d/e" &&
+	c1=3D$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o1	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o1	d/e"
+		echo "100644 $o1 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o1 0	d/e"
+	) >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'setup 2' '
+
+	rm -rf [abcd] &&
+	git checkout conflict &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	test_cmp expected actual &&
+
+	echo goodbye >>a &&
+	o2=3D$(git hash-object a) &&
+
+	git add a &&
+
+	test_tick &&
+	git commit -m "conflict modifies a" &&
+	c2=3D$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o2	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o2 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'setup 3' '
+
+	rm -rf [abcd] &&
+	git checkout noconflict &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	test_cmp expected actual &&
+
+	echo hello >>a &&
+	o3=3D$(git hash-object a) &&
+
+	git add a &&
+
+	test_tick &&
+	git commit -m "noconflict modifies a" &&
+	c3=3D$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o3	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o3 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'setup 4' '
+
+	rm -rf [abcd] &&
+	git checkout conflict-inside &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	test_cmp expected actual &&
+
+	mkdir d &&
+	echo goodbye >>d/e &&
+	o4=3D$(git hash-object d/e) &&
+
+	git add d/e &&
+
+	test_tick &&
+	git commit -m "conflict-inside modifies d/e" &&
+	c4=3D$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o4	d/e"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o4 0	d/e"
+	) >expected &&
+	test_cmp expected actual
+'
+
+export GIT_INDEX_PREFIX=3Dd/
+
+test_expect_success 'merge-recursive conflict inside' '
+
+	rm -fr [abcd] &&
+	git checkout -f "$c4" &&
+
+	git-merge-recursive "$c0" -- "$c4" "$c1"
+	status=3D$?
+	case "$status" in
+	1)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_expect_success 'merge-recursive no conflict outside' '
+
+	rm -fr [abcd] &&
+	git checkout -f "$c3" &&
+
+	git-merge-recursive "$c0" -- "$c3" "$c1"
+	status=3D$?
+	case "$status" in
+	0)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_expect_success 'merge-recursive conflict outside' '
+
+	rm -fr [abcd] &&
+	git checkout -f "$c2" &&
+
+	git-merge-recursive "$c0" -- "$c2" "$c1"
+	status=3D$?
+	case "$status" in
+	1)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_done
--=20
1.5.5.GIT
