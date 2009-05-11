From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: [PATCH 5/6] Fix tests to work with core.autocrlf=true
Date: Mon, 11 May 2009 15:29:00 -0400
Message-ID: <1242070141-2936-6-git-send-email-Don.Slutz@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242070141-2936-2-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242070141-2936-3-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242070141-2936-4-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242070141-2936-5-git-send-email-Don.Slutz@SierraAtlantic.com>
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 21:30:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3bCI-0007Nk-Pf
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758665AbZEKT3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 15:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758158AbZEKT3X
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:29:23 -0400
Received: from krl.krl.com ([192.147.32.3]:46857 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758156AbZEKT3P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:29:15 -0400
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4BJTDN0003009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 May 2009 15:29:13 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4BJTDuj003008;
	Mon, 11 May 2009 15:29:13 -0400
X-Mailer: git-send-email 1.6.3.15.g49878
In-Reply-To: <1242070141-2936-5-git-send-email-Don.Slutz@SierraAtlantic.com>
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118832>

Switch from using cmp to using test_cmp in these tests.

Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
---
 t/t0021-conversion.sh        |   12 ++++++------
 t/t1020-subdirectory.sh      |   12 ++++++------
 t/t4127-apply-same-fn.sh     |    2 +-
 t/t6021-merge-criss-cross.sh |    2 +-
 t/t6026-merge-attr.sh        |   10 +++++-----
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 8fc39d7..7a6d8c7 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -33,17 +33,17 @@ test_expect_success setup '
 	git checkout -- test test.t test.i
 '
 
-script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
-
 test_expect_success check '
 
-	cmp test.o test &&
-	cmp test.o test.t &&
+	test_cmp test.o test &&
+	test_cmp test.o test.t &&
 
 	# ident should be stripped in the repository
 	git diff --raw --exit-code :test :test.i &&
 	id=$(git rev-parse --verify :test) &&
-	embedded=$(sed -ne "$script" test.i) &&
+	test_debug "echo id=$id"
+	embedded=$(grep Id: test.i | cut -d\  -f2) &&
+	test_debug "echo embedded=$embedded"
 	test "z$id" = "z$embedded" &&
 
 	git cat-file blob :test.t > test.r &&
@@ -85,7 +85,7 @@ test_expect_success expanded_in_repo '
 	rm -f expanded-keywords &&
 	git checkout -- expanded-keywords &&
 	cat expanded-keywords &&
-	cmp expanded-keywords expected-output
+	test_cmp expanded-keywords expected-output
 '
 
 test_done
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 210e594..ce67e6c 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -86,10 +86,10 @@ test_expect_success 'write-tree' '
 test_expect_success 'checkout-index' '
 	cd "$HERE" &&
 	git checkout-index -f -u one &&
-	cmp one original.one &&
+	test_cmp one original.one &&
 	cd dir &&
 	git checkout-index -f -u two &&
-	cmp two ../original.two
+	test_cmp two ../original.two
 '
 
 test_expect_success 'read-tree' '
@@ -97,13 +97,13 @@ test_expect_success 'read-tree' '
 	rm -f one dir/two &&
 	tree=`git write-tree` &&
 	git read-tree --reset -u "$tree" &&
-	cmp one original.one &&
-	cmp dir/two original.two &&
+	test_cmp one original.one &&
+	test_cmp dir/two original.two &&
 	cd dir &&
 	rm -f two &&
 	git read-tree --reset -u "$tree" &&
-	cmp two ../original.two &&
-	cmp ../one ../original.one
+	test_cmp two ../original.two &&
+	test_cmp ../one ../original.one
 '
 
 test_expect_success 'no file/rev ambiguity check inside .git' '
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index 3a8202e..66b774f 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -27,7 +27,7 @@ test_expect_success 'apply same filename with independent changes' '
 	cp same_fn same_fn2 &&
 	git reset --hard &&
 	git apply patch0 &&
-	diff same_fn same_fn2
+	test_cmp same_fn same_fn2
 '
 
 test_expect_success 'apply same filename with overlapping changes' '
diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.sh
index 331b9b0..53fdfd8 100755
--- a/t/t6021-merge-criss-cross.sh
+++ b/t/t6021-merge-criss-cross.sh
@@ -87,7 +87,7 @@ cat > file-expect <<EOF
 9
 EOF
 
-test_expect_success 'Criss-cross merge result' 'cmp file file-expect'
+test_expect_success 'Criss-cross merge result' 'test_cmp file file-expect'
 
 test_expect_success 'Criss-cross merge fails (-s resolve)' \
 'git reset --hard A^ &&
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 1ba0a25..0b57c68 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -63,7 +63,7 @@ test_expect_success 'check merge result in working tree' '
 
 	git cat-file -p HEAD:binary >binary-orig &&
 	grep "<<<<<<<" text &&
-	cmp binary-orig binary &&
+	test_cmp binary-orig binary &&
 	! grep "<<<<<<<" union &&
 	grep Master union &&
 	grep Side union
@@ -104,14 +104,14 @@ test_expect_success 'custom merge backend' '
 
 	git merge master &&
 
-	cmp binary union &&
+	test_cmp binary union &&
 	sed -e 1,3d text >check-1 &&
 	o=$(git unpack-file master^:text) &&
 	a=$(git unpack-file side^:text) &&
 	b=$(git unpack-file master:text) &&
 	sh -c "./custom-merge $o $a $b 0" &&
 	sed -e 1,3d $a >check-2 &&
-	cmp check-1 check-2 &&
+	test_cmp check-1 check-2 &&
 	rm -f $o $a $b
 '
 
@@ -131,14 +131,14 @@ test_expect_success 'custom merge backend' '
 		echo "Ok, conflicted"
 	fi &&
 
-	cmp binary union &&
+	test_cmp binary union &&
 	sed -e 1,3d text >check-1 &&
 	o=$(git unpack-file master^:text) &&
 	a=$(git unpack-file anchor:text) &&
 	b=$(git unpack-file master:text) &&
 	sh -c "./custom-merge $o $a $b 0" &&
 	sed -e 1,3d $a >check-2 &&
-	cmp check-1 check-2 &&
+	test_cmp check-1 check-2 &&
 	rm -f $o $a $b
 '
 
-- 
1.6.3.15.g49878
