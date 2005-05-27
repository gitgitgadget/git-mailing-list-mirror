From: Stephen Tweedie <sct@redhat.com>
Subject: [PATCH] Fix git-deltafy-script off-by-one errors
Date: Fri, 27 May 2005 06:36:31 -0400
Message-ID: <20050527103631.GA17730@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Tweedie <sct@redhat.com>
X-From: git-owner@vger.kernel.org Fri May 27 12:36:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbcBC-0003Zi-MV
	for gcvg-git@gmane.org; Fri, 27 May 2005 12:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVE0Kgx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 06:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVE0Kgx
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 06:36:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262424AbVE0Kgd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 06:36:33 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j4RAaVsA000305;
	Fri, 27 May 2005 06:36:31 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4RAaVO08746;
	Fri, 27 May 2005 06:36:31 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j4RAaVdT018789;
	Fri, 27 May 2005 06:36:31 -0400
Received: (from sct@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j4RAaVFk018787;
	Fri, 27 May 2005 06:36:31 -0400
To: git@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Content-Disposition: inline; filename="fix-deltafy-offbyone.patch"
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-deltafy-script contains two off-by-one errors that prevent it from
deltafying either the last file it encounters, or the oldest version of
any file.

The script decides that it needs to run git-mkdelta when it encounters
the next filename in its inner loop.  The last file obviously doesn't 
have a next file, so does not get processed.  Fix this by factoring
out the test that runs the file processing, and forcibly run that test
again at the end of the loop to catch the last file.

There's a second problem; the script only passes one revision to
git-mkdelta per change it finds in the tree history.  For each change,
it only adds the hash of the file's new version to the list of hashes
being built up.  The oldest version is ignored.  Fix this by outputing
both the old AND new versions when we encounter an "M" line in the tree
diff; that will mean that hashes crop up multiple times if the old 
version from one commit matches the new version of an older commit, but
we're already doing a "uniq" which strips those duplicates out.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

---
commit a1d358812e6796a1ebdac740dcd666a567adb462
tree 9bfe10668d8220dd1a6642e06fa9c8d726134675
parent a95abde1074b8bf5bb4e4dab930397188e1bb3fa
author Stephen Tweedie <sct@redhat.com> Fri, 27 May 2005 11:25:51 +0100
committer Stephen Tweedie <sct@redhat.com> Fri, 27 May 2005 11:25:51 +0100

 git-deltafy-script |   38 +++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 15 deletions(-)

Index: git-deltafy-script
===================================================================
--- af5e58731609986ed53e05508b55f801b3d5c51d/git-deltafy-script  (mode:100644)
+++ 9bfe10668d8220dd1a6642e06fa9c8d726134675/git-deltafy-script  (mode:100644)
@@ -19,22 +19,30 @@
 depth=
 [ "$1" == "-d" ] && depth="--max-depth=$2" && shift 2
 
-curr_file=""
+function process_one () {
+	if [ "$list" ]; then
+		echo "Processing $curr_file"
+		echo "$head $list" | xargs git-mkdelta $depth -v
+	fi
+}
+
 
 git-rev-list HEAD |
 git-diff-tree -r --stdin |
-awk '/^:/ { if ($5 == "M" || $5 == "N") print $4, $6 }' |
-LC_ALL=C sort -s -k 2 | uniq |
-while read sha1 file; do
-	if [ "$file" == "$curr_file" ]; then
-		list="$list $sha1"
-	else
-		if [ "$list" ]; then
-			echo "Processing $curr_file"
-			echo "$head $list" | xargs git-mkdelta $depth -v
+awk '/^:/ { if ($5 == "M" || $5 == "N") print $4, $6; 
+	    if ($5 == "M") print $3, $6 }' |
+LC_ALL=C sort -s -k 2 | uniq | 
+{
+	curr_file=""
+	while read sha1 file; do
+		if [ "$file" == "$curr_file" ]; then
+			list="$list $sha1"
+		else
+			process_one
+			curr_file="$file"
+			list=""
+			head="$sha1"
 		fi
-		curr_file="$file"
-		list=""
-		head="$sha1"
-	fi
-done
+	done
+	process_one
+}
