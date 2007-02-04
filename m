From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-clone --reference: saner handling of borrowed symrefs.
Date: Sun, 04 Feb 2007 03:25:12 -0800
Message-ID: <7v64airwpz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 12:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDfUj-0005IH-EF
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 12:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbXBDLZO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 06:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbXBDLZO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 06:25:14 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:40552 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752279AbXBDLZN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 06:25:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204112513.PYTC1306.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 06:25:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KPRC1W0071kojtg0000000; Sun, 04 Feb 2007 06:25:12 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38687>

When using --reference to borrow objects from a neighbouring
repository while cloning, we copy the entire set of refs under
temporary "refs/reference-tmp/refs" space and set up the object
alternates.  However, a textual symref copied this way would not
point at the right place, and later steps emit error messages
(which is harmless but still alarming and annoying).  This is
most visible when using a clone created with the separate-remote
layout as a reference, as such a repository would have
refs/remotes/origin/HEAD with 'ref: refs/remotes/origin/master'
as its contents.

Although we do not create symbolic-link based refs anymore, they
have the problem because they are always supposed to be relative
to refs/ hierarchy (we dereference by hand, so it only is good
for HEAD and nothing else).

In either case, the solution is simply to remove them after
copying under refs/reference-tmp; if a symref points at a true
ref, that true ref itself is enough to ensure that objects
reachable from it do not needlessly get fetched.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-clone.sh               |   29 ++++++++++++++++++++++++++++-
 t/t5700-clone-reference.sh |   40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 4ddfa77..1710996 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -190,7 +190,34 @@ then
 		(cd "$GIT_DIR/refs" &&
 		 mkdir reference-tmp &&
 		 cd reference-tmp &&
-		 tar xf -)
+		 tar xf - &&
+		 find refs ! -type d -print |
+		 while read ref
+		 do
+			if test -h "$ref"
+			then
+				# Old-style symbolic link ref.  Not likely
+				# to appear under refs/ but we might as well
+				# deal with them.
+				:
+			elif test -f "$ref"
+			then
+				point=$(cat "$ref") &&
+					case "$point" in
+					'ref: '*) ;;
+					*) continue ;;
+					esac
+			fi
+			# The above makes true ref to 'continue' and
+			# we will come here when we are looking at
+			# symbolic link ref or a textual symref (or
+			# garbage, like fifo).
+			# The true ref pointed at by it is enough to
+			# ensure that we do not fetch objects reachable
+			# from it.
+			rm -f "$ref"
+		 done
+		)
 	else
 		die "reference repository '$reference' is not a local directory."
 	fi
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index dd9caad..6d43252 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -26,7 +26,7 @@ git prune'
 
 cd "$base_dir"
 
-test_expect_success 'cloning with reference' \
+test_expect_success 'cloning with reference (-l -s)' \
 'git clone -l -s --reference B A C'
 
 cd "$base_dir"
@@ -50,6 +50,28 @@ diff expected current'
 
 cd "$base_dir"
 
+test_expect_success 'cloning with reference (no -l -s)' \
+'git clone --reference B A D'
+
+cd "$base_dir"
+
+test_expect_success 'existence of info/alternates' \
+'test `wc -l <D/.git/objects/info/alternates` = 1'
+
+cd "$base_dir"
+
+test_expect_success 'pulling from reference' \
+'cd D && git pull ../B'
+
+cd "$base_dir"
+
+test_expect_success 'that reference gets used' \
+'cd D && echo "0 objects, 0 kilobytes" > expected &&
+git count-objects > current &&
+diff expected current'
+
+cd "$base_dir"
+
 test_expect_success 'updating origin' \
 'cd A &&
 echo third > file3 &&
@@ -75,4 +97,20 @@ diff expected current'
 
 cd "$base_dir"
 
+test_expect_success 'pulling changes from origin' \
+'cd D &&
+git pull origin'
+
+cd "$base_dir"
+
+# the 5 local objects are expected; file3 blob, commit in A to add it
+# and its tree, and 2 are our tree and the merge commit.
+test_expect_success 'check objects expected to exist locally' \
+'cd D &&
+echo "5 objects" > expected &&
+git count-objects | cut -d, -f1 > current &&
+diff expected current'
+
+cd "$base_dir"
+
 test_done
-- 
1.5.0.rc3.40.g2a08d-dirty
