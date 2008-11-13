From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] repack: only unpack-unreachable if we are deleting redundant packs
Date: Thu, 13 Nov 2008 14:11:46 -0600
Message-ID: <ZpRBYSzxOgXYGvqPdRjOj6xEw2pJOdnr_qPneol8bh34gB4qYV-2ioB6a-uYxoUk0qdZSQJ9Y5E@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 13 21:13:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0iZ9-0004Pg-CX
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 21:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbYKMUMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 15:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbYKMUME
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 15:12:04 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58206 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbYKMUMC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 15:12:02 -0500
Received: by mail.nrlssc.navy.mil id mADKBs0E025554; Thu, 13 Nov 2008 14:11:54 -0600
X-OriginalArrivalTime: 13 Nov 2008 20:11:54.0281 (UTC) FILETIME=[12804190:01C945CC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100907>

The -A option calls pack-objects with the --unpack-unreachable option so
that the unreachable objects in local packs are left in the local object
store loose. But if the -d option to repack was _not_ used, then these
unpacked loose objects are redundant and unnecessary.

Update tests in t7701.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Here is another patch for bc/maint-keep-pack that seems to make sense.
I can't think of a reason why porcelain repack should unpack the
unreferenced objects if it's not going to delete the packs they were in.

-brandon


 Documentation/git-repack.txt         |   11 +++++------
 git-repack.sh                        |    3 ++-
 t/t7701-repack-unpack-unreachable.sh |   18 +++++++++++++++---
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index bbe1485..aaa8852 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -38,12 +38,11 @@ OPTIONS
 	dangling.
 
 -A::
-	Same as `-a`, but any unreachable objects in a previous
-	pack become loose, unpacked objects, instead of being
-	left in the old pack.  Unreachable objects are never
-	intentionally added to a pack, even when repacking.
-	When used with '-d', this option
-	prevents unreachable objects from being immediately
+	Same as `-a`, unless '-d' is used.  Then any unreachable
+	objects in a previous pack become loose, unpacked objects,
+	instead of being left in the old pack.  Unreachable objects
+	are never intentionally added to a pack, even when repacking.
+	This option prevents unreachable objects from being immediately
 	deleted by way of being left in the old pack and then
 	removed.  Instead, the loose unreachable objects
 	will be pruned according to normal expiry rules
diff --git a/git-repack.sh b/git-repack.sh
index 4d313d1..458a497 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -71,7 +71,8 @@ case ",$all_into_one," in
 				existing="$existing $e"
 			fi
 		done
-		if test -n "$args" -a -n "$unpack_unreachable"
+		if test -n "$args" -a -n "$unpack_unreachable" -a \
+			-n "$remove_redundant"
 		then
 			args="$args $unpack_unreachable"
 		fi
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index b48046e..63a8225 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -8,7 +8,7 @@ fsha1=
 csha1=
 tsha1=
 
-test_expect_success '-A option leaves unreachable objects unpacked' '
+test_expect_success '-A with -d option leaves unreachable objects unpacked' '
 	echo content > file1 &&
 	git add . &&
 	git commit -m initial_commit &&
@@ -58,7 +58,7 @@ compare_mtimes ()
 		' -- "$@"
 }
 
-test_expect_success 'unpacked objects receive timestamp of pack file' '
+test_expect_success '-A without -d option leaves unreachable objects packed' '
 	fsha1path=$(echo "$fsha1" | sed -e "s|\(..\)|\1/|") &&
 	fsha1path=".git/objects/$fsha1path" &&
 	csha1path=$(echo "$csha1" | sed -e "s|\(..\)|\1/|") &&
@@ -75,7 +75,19 @@ test_expect_success 'unpacked objects receive timestamp of pack file' '
 	git branch -D transient_branch &&
 	sleep 1 &&
 	git repack -A -l &&
-	compare_mtimes "$packfile" "$fsha1path" "$csha1path" "$tsha1path"
+	test ! -f "$fsha1path" &&
+	test ! -f "$csha1path" &&
+	test ! -f "$tsha1path" &&
+	git show $fsha1 &&
+	git show $csha1 &&
+	git show $tsha1
+'
+
+test_expect_success 'unpacked objects receive timestamp of pack file' '
+	tmppack=".git/objects/pack/tmp_pack" &&
+	ln "$packfile" "$tmppack" &&
+	git repack -A -l -d &&
+	compare_mtimes "$tmppack" "$fsha1path" "$csha1path" "$tsha1path"
 '
 
 test_done
-- 
1.6.0.3.552.g12334
