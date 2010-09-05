From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 02/15] Add tests for client handling in a sparse repository
Date: Sat,  4 Sep 2010 18:13:54 -0600
Message-ID: <1283645647-1891-3-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rk-0008IQ-JK
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523Ab0IEANG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:06 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52689 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab0IEAMz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:12:55 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1002177pvg.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TVeGoofwERvD7eYvMTk0ic2i/Nqd18FjF60HHFpf6n8=;
        b=Kk3aCpOEVsfYP8vKU7f0A6MBa5NLjSXwt7TCFshynojM6+cv4sWZChHVttczlS27ze
         Bm+Q2cG+f5YhP+l71WlOF3/SWOnL73RojMdh4A2OJYRYVK6XGpKbt4an9XtcFnuIKbW2
         s7IBALHC+iqmhBAxKxzuoq2vcdzaPNLu85aQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dM+Txs5xsvsRoTT94tJYfLRLj6qYIZ4YhFYtKKLNgNUBmI5X4yEB+ipo1Z0pzE/0MB
         nuWZ3ybRSo8dRlIGaPwE57wzq262X2dXUIsCfH5VqZICMcXp/9Nkw2BpCxHYGZRHh//R
         XddrknRItSSDUza7AHX/PtSeRxTGMpOPa9vNM=
Received: by 10.114.52.1 with SMTP id z1mr1549673waz.64.1283645574830;
        Sat, 04 Sep 2010 17:12:54 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.12.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:12:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155402>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/sparse-lib.sh                     |   38 ++++++++++
 t/t5720-sparse-repository-basics.sh |  130 +++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 t/sparse-lib.sh
 create mode 100755 t/t5720-sparse-repository-basics.sh

diff --git a/t/sparse-lib.sh b/t/sparse-lib.sh
new file mode 100644
index 0000000..0b779c6
--- /dev/null
+++ b/t/sparse-lib.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+make_sparse() {
+	# We only want loose objects
+	mv .git/objects/pack/* . &&
+	for i in $(ls *.pack); do
+		git unpack-objects -q < $i
+	done &&
+	rm -f *.pack *.idx &&
+
+	cd .git/objects &&
+
+	# Find the objects need for the specified paths
+	for i in $(git rev-list master); do
+		echo $i;
+		git rev-parse $i^{tree};
+		git ls-tree -rt $i -- "$@" | awk '{print $3}';
+	done | sort | uniq > ../wanted &&
+
+	# Find all other objects and delete them
+	find . -type f | sed -e s#[\./]##g \
+		       | grep -v -F "$(cat ../wanted)" > ../bad &&
+	for i in $(cat ../bad); do
+		rm -f ./${i:0:2}/${i:2};
+	done &&
+
+	# Record the sparse limits
+	cd .. &&
+	echo -n "'--'" > sparse-limits &&
+	for i in "$@"; do
+		echo -n " '$i'" >> sparse-limits
+	done &&
+	echo >> sparse-limits &&
+
+	# Trim the index while we're at it
+	cd .. &&
+	git reset --hard HEAD
+}
diff --git a/t/t5720-sparse-repository-basics.sh b/t/t5720-sparse-repository-basics.sh
new file mode 100755
index 0000000..b8e9a3a
--- /dev/null
+++ b/t/t5720-sparse-repository-basics.sh
@@ -0,0 +1,130 @@
+#!/bin/sh
+
+test_description='sparse repository basics'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/sparse-lib.sh
+
+test_expect_success 'setup' '
+	rm -fr .git &&
+	test_create_repo src &&
+	(
+		cd src &&
+
+		mkdir -p sub/{a,b} &&
+		> sub/a/file &&
+		git add sub/a/file &&
+		test_tick &&
+		git commit -q -m initial &&
+
+		> sub/b/file &&
+		git add sub/b/file &&
+		test_tick &&
+		git commit -q -m two &&
+
+		echo unique > sub/file &&
+		git add sub/file &&
+		test_tick &&
+		git commit -q -m three &&
+
+		echo content > sub/b/file &&
+		test_tick &&
+		git commit -q -m subbfile sub/b/file &&
+
+		cp -a sub/b sub/bcopy &&
+		git add sub/bcopy &&
+		test_tick &&
+		git commit -q -m subbcopy &&
+
+		echo stuff > sub/a/file &&
+		test_tick &&
+		git commit -q -m subafile sub/a/file
+	)
+'
+
+test_expect_failure 'make sparse repository' '
+	git clone -q "file://$(pwd)/src" dst &&
+	(
+		cd dst &&
+		test 25 = "$(git rev-list --objects master | wc -l)" &&
+		make_sparse sub/b/file &&
+		test 0 = $(find .git/objects/pack -type f | wc -l) &&
+		test 22 = $(find .git/objects -type f | wc -l)
+	)
+'
+
+cd dst 2>/dev/null || test_done
+srcgit="--git-dir=../src/.git"
+
+test_expect_failure 'plumbing: ls-files works' '
+	git ls-files > output &&
+	test "sub/b/file" = "$(cat output)"
+'
+
+test_expect_failure 'plumbing: rev-list works' '
+	test "$(git rev-list HEAD)" = \
+	     "$(git $srcgit rev-list HEAD -- sub/b/)" &&
+	test "$(git rev-list --objects HEAD)" = \
+	     "$(git $srcgit rev-list --objects HEAD -- sub/b/)"
+'
+
+for i in $(git $srcgit rev-list HEAD | xargs git name-rev | cut -b 42-); do
+	git $srcgit rev-parse $i:sub/b/file >/dev/null 2>&1 &&
+	test_expect_success "plumbing: We can access $i:sub/b/file" "
+		git cat-file -t $i:sub/b/file
+	"
+done
+
+final_afile_sha=$(git $srcgit rev-parse master:sub/a/file)
+known_objects=$(git $srcgit rev-list --objects master \
+		| grep sub                            \
+		| grep -v $final_afile_sha            \
+		| cut -b -40)
+for i in $(git $srcgit rev-list HEAD | xargs git name-rev | cut -b 42-); do
+	git $srcgit ls-tree -rt $i | grep -F "$known_objects" >expect &&
+	test_expect_failure "plumbing: ls-tree -rt $i works" "
+		git ls-tree -rt $i 2>error >output &&
+		test_cmp output expect
+	"
+done
+
+test_expect_failure 'basic: log works' '
+	git log > /dev/null &&
+	git log -p > /dev/null &&
+	git log -Scontent > /dev/null
+'
+
+test_expect_failure 'basic: diff works' '
+	git diff master~3 master &&
+	git diff master~3
+'
+
+test_expect_failure 'basic: checkout works' '
+	git checkout master~2 &&
+	git checkout master
+'
+
+test_expect_failure 'basic: status works with modified stuff' '
+	git status &&
+	echo more content >> sub/b/file &&
+	echo newfile content >> sub/b/whatever &&
+	git status
+'
+
+test_expect_failure 'basic: add works' '
+	git add sub/b/file &&
+	git add sub/b/whatever
+'
+
+test_expect_failure 'basic: commit works' '
+	git commit -m "Commit in a sparse clone" &&
+	git rev-parse master^{tree} &&
+	git rev-parse master:sub &&
+	git rev-parse master:sub/b &&
+	git rev-parse master:sub/b/file &&
+	git rev-parse master:sub/bcopy &&
+	git rev-parse master:sub/bcopy/file &&
+	git rev-parse master:sub/a &&
+	git rev-parse master:sub/file
+'
+
+test_done
-- 
1.7.2.2.140.gd06af
