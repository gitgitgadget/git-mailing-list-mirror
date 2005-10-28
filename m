From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/8] Implement a test for git-fetch-pack/git-upload-pack
Date: Fri, 28 Oct 2005 04:47:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510280447190.20516@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 04:48:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVKHP-0000h8-3U
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 04:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbVJ1Crk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 22:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbVJ1Crk
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 22:47:40 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:39887 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965065AbVJ1Crk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 22:47:40 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2E64113F2ED; Fri, 28 Oct 2005 04:47:39 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 086A29EFD1; Fri, 28 Oct 2005 04:47:39 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BD5C49EFCE; Fri, 28 Oct 2005 04:47:38 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B86D813F2ED; Fri, 28 Oct 2005 04:47:38 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10744>


This test provides a minimal example of what went wrong with the old
git-fetch-pack (and now works beautifully).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 t/t5500-fetch-pack.sh |  136 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 136 insertions(+), 0 deletions(-)
 create mode 100644 t/t5500-fetch-pack.sh

applies-to: 641053c478870febdf3b6c525821f1bfdc43a2a5
1dfccc68d5700ea5c0f062aaf77fdf76a9c06a5e
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
new file mode 100644
index 0000000..0781bd2
--- /dev/null
+++ b/t/t5500-fetch-pack.sh
@@ -0,0 +1,136 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Johannes Schindelin
+#
+
+test_description='Testing multi_ack pack fetching
+
+'
+. ./test-lib.sh
+
+# Test fetch-pack/upload-pack pair.
+
+# Some convenience functions
+
+function show_count () {
+	commit_count=$(($commit_count+1))
+	printf "      %d\r" $commit_count
+}
+
+function add () {
+	local name=$1
+	local text="$@"
+	local branch=${name:0:1}
+	local parents=""
+
+	shift
+	while test $1; do
+		parents="$parents -p $1"
+		shift
+	done
+
+	echo "$text" > test.txt
+	git-update-index --add test.txt
+	tree=$(git-write-tree)
+	# make sure timestamps are in correct order
+	sec=$(($sec+1))
+	commit=$(echo "$text" | GIT_AUTHOR_DATE=$sec \
+		git-commit-tree $tree $parents 2>>log2.txt)
+	export $name=$commit
+	echo $commit > .git/refs/heads/$branch
+	eval ${branch}TIP=$commit
+}
+
+function count_objects () {
+	ls .git/objects/??/* 2>>log2.txt | wc -l | tr -d " "
+}
+
+function test_expect_object_count () {
+	local message=$1
+	local count=$2
+
+	output="$(count_objects)"
+	test_expect_success \
+		"new object count $message" \
+		"test $count = $output"
+}
+
+function test_repack () {
+	local rep=$1
+
+	test_expect_success "repack && prune-packed in $rep" \
+		'(git-repack && git-prune-packed)2>>log.txt'
+}
+
+function pull_to_client () {
+	local number=$1
+	local heads=$2
+	local count=$3
+	local no_strict_count_check=$4
+
+	cd client
+	test_expect_success "$number pull" \
+		"git-fetch-pack -v .. $heads > log.txt 2>&1"
+	case "$heads" in *A*) echo $ATIP > .git/refs/heads/A;; esac
+	case "$heads" in *B*) echo $BTIP > .git/refs/heads/B;; esac
+	git-symbolic-ref HEAD refs/heads/${heads:0:1}
+	test_expect_success "fsck" 'git-fsck-objects --full > fsck.txt 2>&1'
+	test_expect_object_count "after $number pull" $count
+	pack_count=$(grep Packing log.txt|tr -dc "0-9")
+	test -z "$pack_count" && pack_count=0
+	if [ -z "$no_strict_count_check" ]; then
+		test_expect_success "minimal count" "test $count = $pack_count"
+	else
+		test $count != $pack_count && \
+			echo "WARNING: $pack_count objects transmitted, only $count of which were needed"
+	fi
+	cd ..
+}
+
+# Here begins the actual testing
+
+# A1 - ... - A20 - A21
+#    \
+#      B1  -   B2 - .. - B70
+
+# client pulls A20, B1. Then tracks only B. Then pulls A.
+
+(
+	mkdir client &&
+	cd client &&
+	git-init-db 2>> log2.txt
+)
+
+add A1
+
+prev=1; cur=2; while [ $cur -le 10 ]; do
+	add A$cur $(eval echo \$A$prev)
+	prev=$cur
+	cur=$(($cur+1))
+done
+
+add B1 $A1
+
+echo $ATIP > .git/refs/heads/A
+echo $BTIP > .git/refs/heads/B
+git-symbolic-ref HEAD refs/heads/B
+
+pull_to_client 1st "B A" $((11*3))
+
+(cd client; test_repack client)
+
+add A11 $A10
+
+prev=1; cur=2; while [ $cur -le 65 ]; do
+	add B$cur $(eval echo \$B$prev)
+	prev=$cur
+	cur=$(($cur+1))
+done
+
+pull_to_client 2nd "B" $((64*3))
+
+(cd client; test_repack client)
+
+pull_to_client 3rd "A" $((1*3)) # old fails
+
+test_done
---
0.99.8.GIT
