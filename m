From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [WIP] Implement a test for git-fetch-pack
Date: Tue, 25 Oct 2005 23:34:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510252333180.19596@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 25 23:37:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUWRH-0002EN-Se
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 23:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVJYVeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 17:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVJYVeH
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 17:34:07 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8586 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932398AbVJYVeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 17:34:04 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id E927B13F161
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 23:34:03 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id CD457B0D37
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 23:34:03 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id A80B1B0CBF
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 23:34:03 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 982B013F161
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 23:34:03 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10620>

It does some basic things right now, but I'll add more.

---

 t/t5500-fetch-pack.sh |  142 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 142 insertions(+), 0 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
new file mode 100755
index 0000000..a5d3a25
--- /dev/null
+++ b/t/t5500-fetch-pack.sh
@@ -0,0 +1,142 @@
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
+# Test fetching for an empty, a partial, a full copy, and for a repository,
+# which is not empty but has no common commits (think coolest merge ever).
+
+function add () {
+	local name=$1
+	local branch=$(expr $name : '\(.\)')
+	local text="$@"
+	local parents=""
+
+	shift
+	while test $1; do
+		local sha1=$(eval echo \$$1)
+		test -z "$sha1" && sha1=$1
+		parents="$parents -p $sha1"
+		shift
+	done
+
+	echo "$text" > test.txt
+	git-update-index --add test.txt
+	tree=$(git-write-tree)
+	commit=$(echo "$text" | git-commit-tree $tree $parents 2>/dev/null)
+	export $name=$commit
+	echo $commit > .git/refs/heads/$branch
+	git-symbolic-ref HEAD refs/heads/$branch 2>/dev/null
+}
+
+function tag () {
+	local name=$1
+	local commit=$(eval echo \$$2)
+	local text="$@"
+
+	git-tag -m "$text" $name $commit
+}
+
+function count_objects () {
+	local line="$(git-count-objects)"
+	expr "$line" : '\([^ ]*\)'
+}
+
+function test_expect_object_count () {
+	local repository=$1
+	local count=$2
+
+	expect="$count objects, $count kilobytes"
+	output="$(git-count-objects)"
+	test_expect_success "$repository repository is valid" \
+		"test \"$output\" = \"$expect\""
+}
+
+function check_rep () {
+	local rep=$1
+	local count=$2
+
+	cd $rep
+	test_expect_success "fetch from upstream into $rep" \
+		'git-fetch-pack -v .. A B C 2> log.txt'
+	git-update-ref HEAD $A46
+	test_expect_success "fsck $rep" 'git-fsck-objects --full'
+	test_expect_object_count $rep $count
+	cd ..
+}
+
+# A1 - A2 - A3 - A4 - A5 - .. - A47
+#    \    \     /   /
+# B1 - B2 ------ B3 - B4 - B5
+#         \   /     \
+#           C1 - C2 - C3
+
+# the partial copy is cloned at A1-B3-C2 time.
+
+(
+	mkdir empty &&
+	cd empty &&
+	git-init-db 2>/dev/null
+)
+
+add B1
+
+pre_tag_count=$(count_objects)
+
+i=1; while [ $i -le 40 ]; do
+	tag T$i B1
+	i=$(expr $i + 1)
+done
+
+post_tag_count=$(count_objects)
+
+add A1
+add B2 B1 A1
+add B3 B2
+add C1 B2
+add C2 C1
+
+# clone
+git-clone . partial 2>/dev/null
+
+partial_count=$(count_objects)
+
+add A2 A1
+add A3 A2
+add A4 A3 C1
+add C3 C2 B3
+add A5 A4 B3
+add B4 B3
+add B5 B4
+i=5
+while [ $i -le 46 ]; do
+	next=$(expr $i + 1)
+	add A$next A$i
+	i=$next
+done
+
+total_count=$(count_objects)
+
+git-clone . full 2>/dev/null
+
+# let the testing begin
+
+test_expect_success 'precalculated counts' \
+	"test $post_tag_count:$partial_count:$total_count = 43:58:205"
+
+tag_count=$(expr $post_tag_count - $pre_tag_count)
+empty_diff=$(expr $total_count - $tag_count)
+partial_diff=$(expr $total_count - $partial_count)
+
+check_rep empty $empty_diff
+check_rep partial $partial_diff
+check_rep full 0
+
+#gitk --all
+
+test_done
