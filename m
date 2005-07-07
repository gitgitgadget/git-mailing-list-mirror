From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Write sed script directly into temp file, rather than a variable
Date: Thu, 07 Jul 2005 10:50:07 +1000
Message-ID: <20050707005007.9224.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 07 02:54:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqKea-0004g0-9X
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 02:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVGGAxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 20:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVGGAvH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 20:51:07 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:42370 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262378AbVGGAuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 20:50:09 -0400
Received: (qmail 9234 invoked by uid 500); 7 Jul 2005 00:50:07 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


When sed uses \n rather than ; as a separator (for BSD sed(1) compat),
it is cleaner to use a file directly, rather than an environment
variable containing \n characters.

This change changes t/t6000 write to sed.script directly and changes
the other tests to remove knowledge of sed.script.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 t/t6000-lib.sh                  |   12 +++++++-----
 t/t6001-rev-list-merge-order.sh |    9 ---------
 t/t6002-rev-list-bisect.sh      |   10 ----------
 t/t6003-rev-list-topo-order.sh  |    9 ---------
 4 files changed, 7 insertions(+), 33 deletions(-)

8e14d7142551c4eca6718894943e33a2a0a2a14f
diff --git a/t/t6000-lib.sh b/t/t6000-lib.sh
--- a/t/t6000-lib.sh
+++ b/t/t6000-lib.sh
@@ -1,6 +1,6 @@
 [ -d .git/refs/tags ] || mkdir -p .git/refs/tags
 
-sed_script="";
+:> sed.script
 
 # Answer the sha1 has associated with the tag. The tag must exist in .git or .git/refs/tags
 tag()
@@ -21,7 +21,7 @@ unique_commit()
 }
 
 # Save the output of a command into the tag specified. Prepend
-# a substitution script for the tag onto the front of $sed_script
+# a substitution script for the tag onto the front of sed.script
 save_tag()
 {
 	_tag=$1	
@@ -29,14 +29,16 @@ save_tag()
 	shift 1
     	"$@" >.git/refs/tags/$_tag
 
-       sed_script="s/$(tag $_tag)/$_tag/g
-$sed_script"
+        echo "s/$(tag $_tag)/$_tag/g" > sed.script.tmp
+	cat sed.script >> sed.script.tmp
+	rm sed.script
+	mv sed.script.tmp sed.script
 }
 
 # Replace unhelpful sha1 hashses with their symbolic equivalents 
 entag()
 {
-	sed "$sed_script"
+	sed -f sed.script
 }
 
 # Execute a command after first saving, then setting the GIT_AUTHOR_EMAIL
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -103,15 +103,6 @@ save_tag g4 unique_commit g6 tree -p g3 
 
 tag l5 > .git/HEAD
 
-#
-# cd to t/trash and use 
-#
-#    git-rev-list ... 2>&1 | sed "$(cat sed.script)" 
-#
-# if you ever want to manually debug the operation of git-rev-list
-#
-echo $sed_script > sed.script
-
 test_expect_success 'rev-list has correct number of entries' 'git-rev-list HEAD | wc -l | tr -s " "' <<EOF
 19
 EOF
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -113,16 +113,6 @@ on_committer_date "1971-08-16 00:00:04" 
 on_committer_date "1971-08-16 00:00:05" save_tag u5 unique_commit u5 tree -p u0
 on_committer_date "1971-08-16 00:00:06" save_tag V unique_commit V tree -p u1 -p u2 -p u3 -p u4 -p u5
 
-
-#
-# cd to t/trash and use 
-#
-#    git-rev-list ... 2>&1 | sed "$(cat sed.script)" 
-#
-# if you ever want to manually debug the operation of git-rev-list
-#
-echo $sed_script > sed.script
-
 test_sequence()
 {
 	_bisect_option=$1	
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -79,15 +79,6 @@ save_tag g4 unique_commit g6 tree -p g3 
 
 tag l5 > .git/HEAD
 
-#
-# cd to t/trash and use 
-#
-#    git-rev-list ... 2>&1 | sed "$(cat sed.script)" 
-#
-# if you ever want to manually debug the operation of git-rev-list
-#
-echo "$sed_script" | tr ' ' \\012 > sed.script
-
 test_expect_success 'rev-list has correct number of entries' 'git-rev-list HEAD | wc -l | tr -s " "' <<EOF
 19
 EOF
------------
