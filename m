From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] Test case that demonstrates problem with --merge-order, --max-age interaction
Date: Fri, 17 Jun 2005 08:26:15 +1000
Message-ID: <20050616222615.18213.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Fri Jun 17 00:22:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dj2k0-0000sS-Bu
	for gcvg-git@gmane.org; Fri, 17 Jun 2005 00:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVFPW0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 18:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVFPW0l
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 18:26:41 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:43139 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261834AbVFPW0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2005 18:26:18 -0400
Received: (qmail 18223 invoked by uid 500); 16 Jun 2005 22:26:15 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The t/t6001-rev-list-merge-order.sh test case has been modified to demonstrate
a problem with the interaction of the merge_order and max-age flags.

The problem was first reported by Paul Mackerras on the linux-2.6 repository

$> git-rev-list --max-age=1116330140 bcfff0b471a60df350338bcd727fc9b8a6aa54b2 | wc -l
655
$> git-rev-list --merge-order --max-age=1116330140 bcfff0b471a60df350338bcd727fc9b8a6aa54b2 | wc -l
173

The problem is that --merge-order is aborting the scan too early when it
encounters an old commit that happens to sort first because of its
merge order.

Note: Test 10 is expected to fail in this patch - there is actually a problem.
A subsequent patch in this series will fix this problem.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 t/t6001-rev-list-merge-order.sh |   83 ++++++++++++++++++++++++++++++---------
 1 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
old mode 100644
new mode 100755
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -9,7 +9,15 @@ test_description='Test rev-list --merge-
 
 function do_commit
 {
-    git-commit-tree "$@" </dev/null
+    _text=$1
+    shift 1
+    (
+cat <<EOF
+title $_text
+
+A description.
+EOF
+    )   | git-commit-tree "$@"
 }
 
 function check_adjacency
@@ -36,31 +44,38 @@ function sed_script
    done
 }
 
+
+function on_committer_date {
+    _date=$1
+    shift 1
+    GIT_COMMITTER_DATE=$_date "$@"
+}
+
 date >path0
 git-update-cache --add path0
 tree=$(git-write-tree)
-root=$(do_commit $tree 2>/dev/null)
+root=$(on_committer_date "1971-08-16 00:00" do_commit root $tree 2>/dev/null)
 export GIT_COMMITTER_NAME=foobar  # to guarantee that the commit is different
-l0=$(do_commit $tree -p $root)
-l1=$(do_commit $tree -p $l0)
-l2=$(do_commit $tree -p $l1)
-a0=$(do_commit $tree -p $l2)
-a1=$(do_commit $tree -p $a0)
+l0=$(on_committer_date "1971-08-16 00:01" do_commit l0 $tree -p $root)
+l1=$(on_committer_date "1971-08-16 00:02" do_commit l1 $tree -p $l0)
+l2=$(on_committer_date "1971-08-16 00:03" do_commit l2 $tree -p $l1)
+a0=$(on_committer_date "1971-08-16 00:04" do_commit a0 $tree -p $l2)
+a1=$(on_committer_date "1971-08-16 00:05" do_commit a1 $tree -p $a0)
 export GIT_COMMITTER_NAME=foobar2 # to guarantee that the commit is different
-b1=$(do_commit $tree -p $a0)
-c1=$(do_commit $tree -p $b1)
+b1=$(on_committer_date "1971-08-16 00:06" do_commit b1 $tree -p $a0)
+c1=$(on_committer_date "1971-08-16 00:07" do_commit c1 $tree -p $b1)
 export GIT_COMMITTER_NAME=foobar3 # to guarantee that the commit is different
-b2=$(do_commit $tree -p $b1)
-b3=$(do_commit $tree -p $b2)
-c2=$(do_commit $tree -p $c1 -p $b2)
-c3=$(do_commit $tree -p $c2)
-a2=$(do_commit $tree -p $a1)
-a3=$(do_commit $tree -p $a2)
-b4=$(do_commit $tree -p $b3 -p $a3)
-a4=$(do_commit $tree -p $a3 -p $b4 -p $c3)
-l3=$(do_commit $tree -p $a4)
-l4=$(do_commit $tree -p $l3)
-l5=$(do_commit $tree -p $l4)
+b2=$(on_committer_date "1971-08-16 00:08" do_commit b2 $tree -p $b1)
+b3=$(on_committer_date "1971-08-16 00:09" do_commit b3 $tree -p $b2)
+c2=$(on_committer_date "1971-08-16 00:10" do_commit c2 $tree -p $c1 -p $b2)
+c3=$(on_committer_date "1971-08-16 00:11" do_commit c3 $tree -p $c2)
+a2=$(on_committer_date "1971-08-16 00:12" do_commit a2 $tree -p $a1)
+a3=$(on_committer_date "1971-08-16 00:13" do_commit a3 $tree -p $a2)
+b4=$(on_committer_date "1971-08-16 00:14" do_commit b4 $tree -p $b3 -p $a3)
+a4=$(on_committer_date "1971-08-16 00:15" do_commit a4 $tree -p $a3 -p $b4 -p $c3)
+l3=$(on_committer_date "1971-08-16 00:16" do_commit l3 $tree -p $a4)
+l4=$(on_committer_date "1971-08-16 00:17" do_commit l4 $tree -p $l3)
+l5=$(on_committer_date "1971-08-16 00:18" do_commit l5 $tree -p $l4)
 echo $l5 > .git/HEAD
 
 git-rev-list --merge-order --show-breaks HEAD | sed "$(sed_script)" > actual-merge-order
@@ -172,4 +187,32 @@ test_expect_success 'Testing duplicated 
 
 test_expect_success 'Testing exclusion near merge' 'git-rev-list --merge-order $a4 ^$c3 2>/dev/null'
 
+
+cat > expected-merge-order-6 <<EOF
+l5
+l4
+l3
+a4
+b4
+a3
+a2
+c3
+EOF
+git-rev-list --max-age=51149460 $l5 | sed "$(sed_script)" > actual-merge-order-6
+test_expect_success 'Testing --max-age=c3 (no --merge-order)' 'diff expected-merge-order-6 actual-merge-order-6'
+
+cat > expected-merge-order-7 <<EOF
+l5
+l4
+l3
+a4
+c3
+b4
+a3
+a2
+EOF
+
+git-rev-list --merge-order --max-age=51149460 $l5 | sed "$(sed_script)" > actual-merge-order-7
+test_expect_success 'Testing --max-age=c3, --merge-order' 'diff expected-merge-order-7 actual-merge-order-7'
+
 test_done
------------
