From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rev-list: add "--objects=self-sufficient" flag.
Date: Thu, 07 Jul 2005 16:50:04 -0700
Message-ID: <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 01:52:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqgAE-0006tN-9N
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 01:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVGGXwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 19:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVGGXvv
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 19:51:51 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:29894 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262335AbVGGXub (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 19:50:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050707235004.NODO22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 19:50:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 07 Jul 2005 16:16:47 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When --objects=self-sufficient is specified instead of usual
"--objects", rev-list shows all objects reachable from trees
associated with the commits in its output.  This can be used to
ensure that a single pack can be used to recreate the tree
associated with every commit in it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This makes things easier for the dumb puller because
*** self-sufficient pack means less falling back on traditional
*** http-pull.

 rev-list.c                 |    7 ++-
 t/t6100-rev-list-object.sh |   97 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 2 deletions(-)
 create mode 100644 t/t6100-rev-list-object.sh

60563326cea81f89098a88ab716fb4f02e326b43
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -27,6 +27,7 @@ static int bisect_list = 0;
 static int tag_objects = 0;
 static int tree_objects = 0;
 static int blob_objects = 0;
+static int objects_self_sufficient = 0;
 static int verbose_header = 0;
 static int show_parents = 0;
 static int hdr_termination = 0;
@@ -198,7 +199,7 @@ static void mark_tree_uninteresting(stru
 	struct object *obj = &tree->object;
 	struct tree_entry_list *entry;
 
-	if (!tree_objects)
+	if (!tree_objects || objects_self_sufficient)
 		return;
 	if (obj->flags & UNINTERESTING)
 		return;
@@ -448,7 +449,9 @@ int main(int argc, char **argv)
 			bisect_list = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--objects")) {
+		if (!strncmp(arg, "--objects", 9)) {
+			if (!strcmp(arg+9, "=self-sufficient"))
+				objects_self_sufficient = 1;
 			tag_objects = 1;
 			tree_objects = 1;
 			blob_objects = 1;
diff --git a/t/t6100-rev-list-object.sh b/t/t6100-rev-list-object.sh
new file mode 100644
--- /dev/null
+++ b/t/t6100-rev-list-object.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-rev-list --objects test.
+
+'
+. ./test-lib.sh
+
+GIT_AUTHOR_DATE='+0000 946684801'
+GIT_AUTHOR_NAME=none
+GIT_AUTHOR_EMAIL=none@none
+GIT_COMMITTER_DATE='+0000 946684801'
+GIT_COMMITTER_NAME=none
+GIT_COMMITTER_EMAIL=none@none
+export GIT_AUTHOR_DATE GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL \
+       GIT_COMMITTER_DATE GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+sedScript='s/^\('"$_x40"' [^ ]*\) .*/\1/p'
+
+test_expect_success setup '
+    for i in frotz nitfol
+    do
+	    echo $i >$i &&
+	    git-update-cache --add $i || exit
+    done &&
+    tree0=$(git-write-tree) &&
+    commit0=$(git-commit-tree $tree0) &&
+    echo $tree0 &&
+    echo $commit0 &&
+    git-ls-tree -r $tree0 &&
+    echo nitfol nitfol >nitfol &&
+    git-update-cache --add nitfol &&
+    tree1=$(git-write-tree) &&
+    commit1=$(git-commit-tree $tree1 -p $commit0) &&
+    echo $tree1 &&
+    echo $commit1 &&
+    git-ls-tree -r $tree1    
+' </dev/null
+
+test_expect_success 'pack #0' '
+    name0=$(git-rev-list --objects $commit0 | \
+            git-pack-objects pk0) &&
+    ls pk0-* &&
+    git-verify-pack -v pk0-$name0.idx |
+    sed -ne "$sedScript" | sort >contents.0
+'
+
+test_expect_success 'pack #1 (commit 1 except commit 0)' '
+    name1=$(git-rev-list --objects $commit1 ^$commit0 | \
+            git-pack-objects pk1) &&
+    ls pk1-* &&
+    git-verify-pack -v pk1-$name1.idx |
+    sed -ne "$sedScript" | sort >contents.1
+'
+
+test_expect_success 'there should not be any overlaps' '
+    case $(comm -12 contents.0 contents.1 | wc -l) in
+    0) ;;
+    *) false ;;
+    esac
+'
+
+test_expect_success 'pack #2 (commit 1 unpacked only)' '
+    ln pk0-* .git/objects/pack/. &&
+    name2=$(git-rev-list --objects --unpacked $commit1 | \
+            git-pack-objects pk2) &&
+    ls pk2-* &&
+    git-verify-pack -v pk1-$name2.idx |
+    sed -ne "$sedScript" | sort >contents.2
+'
+
+test_expect_success 'pack #1 and #2 should be the same' '
+    diff contents.1 contents.2
+'
+
+test_expect_success 'pack #3 (commit 1 except commit 0, self-sufficient)' '
+    name3=$(git-rev-list --objects=self-sufficient $commit1 ^$commit0 | \
+            git-pack-objects pk3) &&
+    ls pk3-* &&
+    git-verify-pack -v pk3-$name3.idx |
+    sed -ne "$sedScript" | sort >contents.3
+'
+
+ls_tree_to_invent='s/^[0-9]* \([^ ]*\) \('"$_x40"'\)	.*/\2 \1/'
+test_expect_success 'make sure pack #3 is not missing anything from commit1' '
+    (
+	echo "$tree1 tree"
+	echo "$commit1 commit"
+	git-ls-tree "$tree1" | sed -e "$ls_tree_to_invent"
+    ) | sort >tree-contents.1 &&
+    comm -23 tree-contents.1 contents.3 >missing.3 &&
+    diff /dev/null missing.3
+'
------------
