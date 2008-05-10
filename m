From: drafnel@gmail.com
Subject: [PATCH 1/3] repack: modify behavior of -A option to leave unreferenced objects unpacked
Date: Fri,  9 May 2008 23:01:55 -0500
Message-ID: <3927888.1210392047922.JavaMail.teamon@b303.teamon.com>
References: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 10 06:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JugHw-0000Ax-1q
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 06:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbYEJEBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 00:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbYEJEBX
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 00:01:23 -0400
Received: from mailproxy03.teamon.com ([64.85.68.139]:44612 "EHLO
	b303.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750961AbYEJEBE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 00:01:04 -0400
Received: from b303.teamon.com (localhost [127.0.0.1])
	by b303.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m4A40lU18379;
	Sat, 10 May 2008 04:00:47 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
In-Reply-To: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81647>

From: Brandon Casey <drafnel@gmail.com>

The previous behavior of the -A option was to retain any previously
packed objects which had become unreferenced, and place them into the newly
created pack file.  Since git-gc, when run automatically with the --auto
option, calls repack with the -A option, this had the effect of retaining
unreferenced packed objects indefinitely. To avoid this scenario, the
user was required to run git-gc with the little known --prune option or
to manually run repack with the -a option.

This patch changes the behavior of the -A option so that unreferenced
objects that exist in any pack file being replaced, will be unpacked into
the repository. The unreferenced loose objects can then be garbage collected
by git-gc (i.e. git-prune) based on the gc.pruneExpire setting.

Also add new tests for checking whether unreferenced objects which were
previously packed are properly left in the repository unpacked after
repacking.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 git-repack.sh                        |   18 +++++++++---
 t/t7701-repack-unpack-unreachable.sh |   47 ++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 5 deletions(-)
 create mode 100755 t/t7701-repack-unpack-unreachable.sh

diff --git a/git-repack.sh b/git-repack.sh
index e18eb3f..a0e06ed 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -30,7 +30,7 @@ do
 	-n)	no_update_info=t ;;
 	-a)	all_into_one=t ;;
 	-A)	all_into_one=t
-		keep_unreachable=--keep-unreachable ;;
+		keep_unreachable=t ;;
 	-d)	remove_redundant=t ;;
 	-q)	quiet=-q ;;
 	-f)	no_reuse=--no-reuse-object ;;
@@ -78,9 +78,6 @@ case ",$all_into_one," in
 	if test -z "$args"
 	then
 		args='--unpacked --incremental'
-	elif test -n "$keep_unreachable"
-	then
-		args="$args $keep_unreachable"
 	fi
 	;;
 esac
@@ -130,7 +127,18 @@ then
 		  do
 			case " $fullbases " in
 			*" $e "*) ;;
-			*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
+			*)
+				rm -f "$e.idx" "$e.keep"
+				if test -n "$keep_unreachable" &&
+				   test -f "$e.pack"
+				then
+					git unpack-objects < "$e.pack" || {
+						echo >&2 "Failed unpacking unreachable objects from redundant pack file $e.pack"
+						exit 1
+					}
+				fi
+				rm -f "$e.pack"
+			;;
 			esac
 		  done
 		)
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
new file mode 100755
index 0000000..6a5211f
--- /dev/null
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='git-repack works correctly'
+
+. ./test-lib.sh
+
+test_expect_success '-A option leaves unreachable objects unpacked' '
+	echo content > file1 &&
+	git add . &&
+	git commit -m initial_commit &&
+	# create a transient branch with unique content
+	git checkout -b transient_branch &&
+	echo more content >> file1 &&
+	# record the objects created in the database for file, commit, tree
+	fsha1=$(git hash-object file1) &&
+	git commit -a -m more_content &&
+	csha1=$(git rev-parse HEAD^{commit}) &&
+	tsha1=$(git rev-parse HEAD^{tree}) &&
+	git checkout master &&
+	echo even more content >> file1 &&
+	git commit -a -m even_more_content &&
+	# delete the transient branch
+	git branch -D transient_branch &&
+	# pack the repo
+	git repack -A -d -l &&
+	# verify objects are packed in repository
+	test 3 = $(git verify-pack -v -- .git/objects/pack/*.idx |
+		   grep -e "^$fsha1 " -e "^$csha1 " -e "^$tsha1 " |
+		   sort | uniq | wc -l) &&
+	git show $fsha1 &&
+	git show $csha1 &&
+	git show $tsha1 &&
+	# now expire the reflog
+	sleep 1 &&
+	git reflog expire --expire-unreachable=now --all &&
+	# and repack
+	git repack -A -d -l &&
+	# verify objects are retained unpacked
+	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
+		   grep -e "^$fsha1 " -e "^$csha1 " -e "^$tsha1 " |
+		   sort | uniq | wc -l) &&
+	git show $fsha1 &&
+	git show $csha1 &&
+	git show $tsha1
+'
+
+test_done
-- 
1.5.5.67.g9a49
