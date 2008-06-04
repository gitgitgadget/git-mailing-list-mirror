From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [WIP/RFC PATCH 2/2] Add tests for index prefix
Date: Wed, 4 Jun 2008 23:28:43 +0700
Message-ID: <20080604162843.GC23975@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 18:30:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3vrt-0001tQ-Ih
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 18:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbYFDQ2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 12:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYFDQ2w
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 12:28:52 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:62691 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987AbYFDQ2v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 12:28:51 -0400
Received: by yw-out-2324.google.com with SMTP id 9so106616ywe.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=ThV+AcVM48ncn7xXCNTskLbMjyoJIpUyyfs92wcGru0=;
        b=guU6EzAgzEu/iLM/kQlfXOGoiHpfbMlcDif9irkJkBiz9ntiwUeA1fNaggG9ZJGRmL
         ydje236ScW1+Sb2cY0GB+1TmfXBCd13E6sZdR9I8FaWS1cyyu7dNOR3ezs6ERasCGsiH
         h5qM8CRmqFvAIzk/td2P+j4GFUrR3tYB+QSaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=tT/6mjRhQpgHow5NYzw6TvptTeoA79+vvza5GYWLi7sMX5rBuZhfpEE3SZvZJPKCuq
         Rb85kcN9KhsmYHTpZwY/uc+8QFD7rRGOyjJwLM2D9cdcbpfnKmIqWeLX4gm9aEN6T5Oo
         W0X+7UhJG9i8fK0eoPIZ0dd+b1lG1+cGE6w18=
Received: by 10.143.1.12 with SMTP id d12mr36364wfi.297.1212596929853;
        Wed, 04 Jun 2008 09:28:49 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.6.88])
        by mx.google.com with ESMTPS id 29sm3227326wfg.0.2008.06.04.09.28.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 09:28:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  4 Jun 2008 23:28:43 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83795>

---
 t/t2300-index-prefix.sh                 |  207 +++++++++++++++++++++++++++++
 t/t2301-index-prefix-merge-recursive.sh |  221 +++++++++++++++++++++++++++++++
 2 files changed, 428 insertions(+), 0 deletions(-)
 create mode 100755 t/t2300-index-prefix.sh
 create mode 100755 t/t2301-index-prefix-merge-recursive.sh

diff --git a/t/t2300-index-prefix.sh b/t/t2300-index-prefix.sh
new file mode 100755
index 0000000..a7fa559
--- /dev/null
+++ b/t/t2300-index-prefix.sh
@@ -0,0 +1,207 @@
+#!/bin/sh
+
+test_description='index prefix test
+
+This test makes sure all commands that touch index will not
+be able to write outside index prefix once set.
+
+It also make sure some full index operation like git-checkout
+or git-read-tree can function even with index prefix set.
+'
+. ./test-lib.sh
+#. ../lib-read-tree-m-3way.sh
+
+setup_repo() {
+	test "$#" = 1 ||
+	error 'bug in the test script: not 1 parameter to setup_repo'
+	unset GIT_INDEX_PREFIX &&
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
+
+test_expect_success 'setup update-index' 'setup_repo update-index && cd update-index'
+export GIT_INDEX_PREFIX='work/'
+
+test_expect_success 'rev-parse --show-index-prefix' 'test work/ = "$(git rev-parse --show-index-prefix)"'
+test_expect_success 'update-index --refresh with mtime outside index prefix' '
+	touch tracked &&
+	test -z "$(git update-index --refresh 2>&1 >/dev/null)"'
+test_expect_success 'inside:  update' 'git update-index work/modified'
+test_expect_success 'inside:  remove' 'git update-index --force-remove work/tracked'
+test_expect_success 'inside:  add' 'git update-index --add work/untracked'
+test_expect_success 'outside:  update' '! git update-index modified'
+test_expect_success 'outside:  remove' '! git update-index --force-remove modified'
+test_expect_success 'outside:  add' '! git update-index --add untracked'
+
+test_expect_success 'setup add' 'cd .. && setup_repo add && cd add'
+export GIT_INDEX_PREFIX='work/'
+
+test_expect_success 'rev-parse --show-index-prefix' 'test work/ = "$(git rev-parse --show-index-prefix)"'
+test_expect_success 'inside:  add' 'git add work/modified'
+test_expect_success 'outside:  add' '! git add untracked'
+
+test_expect_success 'setup rm' 'cd .. && setup_repo rm && cd rm'
+export GIT_INDEX_PREFIX='work/'
+
+test_expect_success 'rev-parse --show-index-prefix' 'test work/ = "$(git rev-parse --show-index-prefix)"'
+test_expect_success 'inside:  rm' 'git rm work/tracked'
+test_expect_success 'outside:  rm' '! git rm tracked'
+
+test_expect_success 'setup apply' '
+	cd .. &&
+	unset GIT_INDEX_PREFIX &&
+	test_create_repo apply &&
+	cd apply &&
+	mkdir -p work/sub/dir &&
+	touch modified work/modified &&
+	git add modified work/modified'
+export GIT_INDEX_PREFIX='work/'
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
+test_expect_success 'rev-parse --show-index-prefix' 'test work/ = "$(git rev-parse --show-index-prefix)"'
+test_expect_success 'inside:  apply --cached' 'git apply --cached inside.patch'
+test_expect_success 'outside:  apply --cached' '! git apply --cached outside.patch'
+
+cd ..
+cat >expected-log <<\EOF
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
+EOF
+READ_TREE_HEAD=69798ebb265c266292b4919f7a943bc30d72dfa3
+export READ_TREE_HEAD
+
+test_expect_success 'setup read-tree (clean worktree)' '
+	unset GIT_INDEX_PREFIX &&
+	test_create_repo read-tree &&
+	cd read-tree &&
+	test_tick &&
+	mkdir -p work/sub/dir &&
+	echo one > one && git add one && git commit -m one &&
+	echo two >> one && git add one && git commit -m two &&
+	echo one > work/one && git add work/one && git commit -m work/one &&
+	echo two >> work/one && git add work/one && git commit -m work/two &&
+	echo one > work/sub/one && git add work/sub/one && git commit -m work/sub/one &&
+	echo two >> work/sub/one && git add work/sub/one && git commit -m work/sub/two &&
+	echo one > work/sub/dir/one && echo three >> work/one &&
+		git add work/sub/dir/one work/one &&
+		git commit -m work/sub/dir/one &&
+	echo two >> work/sub/dir/one &&
+		git add work/sub/dir/one &&
+		git commit -m work/sub/dir/two &&
+	git log --raw > ../real-log &&
+	cmp ../expected-log ../real-log &&
+	test $READ_TREE_HEAD = $(git rev-parse HEAD)'
+export GIT_INDEX_PREFIX='work/sub/'
+
+test_expect_success 'read-tree inside index prefix' '
+	git read-tree 47b2996ef7d1dd7d5fd146c520ed90995e2d7e0d &&
+	test -z "$(git diff-index --cached 47b2996ef7d1dd7d5fd146c520ed90995e2d7e0d)"'
+
+test_expect_success 'read-tree outside index prefix' '
+	! git read-tree b64ae04f6be47b3d729f731de1ce804223f45113'
+
+test_expect_success 'read-tree with --prefix outside' '
+	! git read-tree --prefix=work/newsub/ b64ae04f6be47b3d729f731de1ce804223f45113'
+
+cat >newsub.diff <<\EOF
+:000000 100644 0000000000000000000000000000000000000000 814f4a422927b82f5f8a43f8fab6d3839e3983f2 A	work/sub/dir/newsub/one
+:000000 100644 0000000000000000000000000000000000000000 814f4a422927b82f5f8a43f8fab6d3839e3983f2 A	work/sub/dir/newsub/work/one
+:000000 100644 0000000000000000000000000000000000000000 5626abf0f72e58d7a153368ba57db4c673c0e171 A	work/sub/dir/newsub/work/sub/one
+EOF
+test_expect_success 'read-tree with --prefix inside' '
+	git read-tree --prefix=work/sub/dir/newsub/ b64ae04f6be47b3d729f731de1ce804223f45113 &&
+	git diff-index --cached 47b2996ef7d1dd7d5fd146c520ed90995e2d7e0d|cmp newsub.diff'
+
+test_done
diff --git a/t/t2301-index-prefix-merge-recursive.sh b/t/t2301-index-prefix-merge-recursive.sh
new file mode 100755
index 0000000..4121878
--- /dev/null
+++ b/t/t2301-index-prefix-merge-recursive.sh
@@ -0,0 +1,221 @@
+#!/bin/sh
+
+test_description='merge-recursive backend test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup 1' '
+
+	echo hello >a &&
+	o0=$(git hash-object a) &&
+	cp a b &&
+	cp a c &&
+	mkdir d &&
+	cp a d/e &&
+
+	test_tick &&
+	git add a b c d/e &&
+	git commit -m initial &&
+	c0=$(git rev-parse --verify HEAD) &&
+	git branch noconflict &&
+	git branch conflict &&
+	git branch conflict-inside &&
+
+	echo hello >>a &&
+	cp a d/e &&
+	o1=$(git hash-object a) &&
+
+	git add a d/e &&
+
+	test_tick &&
+	git commit -m "master modifies a and d/e" &&
+	c1=$(git rev-parse --verify HEAD) &&
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
+	o2=$(git hash-object a) &&
+
+	git add a &&
+
+	test_tick &&
+	git commit -m "conflict modifies a" &&
+	c2=$(git rev-parse --verify HEAD) &&
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
+	o3=$(git hash-object a) &&
+
+	git add a &&
+
+	test_tick &&
+	git commit -m "noconflict modifies a" &&
+	c3=$(git rev-parse --verify HEAD) &&
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
+	o4=$(git hash-object d/e) &&
+
+	git add d/e &&
+
+	test_tick &&
+	git commit -m "conflict-inside modifies d/e" &&
+	c4=$(git rev-parse --verify HEAD) &&
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
+export GIT_INDEX_PREFIX=d/
+
+test_expect_success 'merge-recursive conflict inside' '
+
+	rm -fr [abcd] &&
+	git checkout -f "$c4" &&
+
+	git-merge-recursive "$c0" -- "$c4" "$c1"
+	status=$?
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
+	status=$?
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
+	status=$?
+	case "$status" in
+	128)
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
-- 
1.5.5.GIT
