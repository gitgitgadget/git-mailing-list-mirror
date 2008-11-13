From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [RFC PATCH] repack: make repack -a equivalent to repack -A and drop previous -a behavior
Date: Thu, 13 Nov 2008 17:22:36 -0600
Message-ID: <7xh1_tFsJkHTjg4Hjm-R4mGSRfYyGFmLI62OMmaNg32f86EbVIYvYrGiYpEGkvooY4pUM1e7CHk@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 00:24:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0lXc-0008Pb-NG
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 00:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbYKMXWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 18:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbYKMXWq
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 18:22:46 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58704 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYKMXWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 18:22:45 -0500
Received: by mail.nrlssc.navy.mil id mADNMiq5003213; Thu, 13 Nov 2008 17:22:44 -0600
X-OriginalArrivalTime: 13 Nov 2008 23:22:45.0143 (UTC) FILETIME=[BBBF2270:01C945E6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, repack had only a single option which began with the first
letter of the alphabet.  Then, a second was created which would repack
unreachable objects into the newly created pack so that git-gc --auto could
be invented.  But, the -a option was still necessary so that it could be
called every now and then to discard the unreachable objects that were being
repacked over and over and over into newly generated packs. Later, -A was
changed so that instead of repacking the unreachable objects, it ejected
them from the pack so that they resided in the object store in loose form,
to be garbage collected by prune-packed according to normal expiry rules.

And so, -a lost its raison d'etre.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This is on top of bc/maint-keep-pack

-brandon


 Documentation/git-repack.txt |   25 ++++++++++++-------------
 git-repack.sh                |    8 ++++----
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index aaa8852..d04d5c2 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -32,21 +32,20 @@ OPTIONS
 	pack everything referenced into a single pack.
 	Especially useful when packing a repository that is used
 	for private development and there is no need to worry
-	about people fetching via dumb protocols from it.  Use
-	with '-d'.  This will clean up the objects that `git prune`
-	leaves behind, but `git fsck --full` shows as
-	dangling.
+	about people fetching via dumb protocols from it.  If used
+	with '-d' , then any unreachable objects in a previous pack will
+	become loose, unpacked objects, instead of being left in the
+	old pack.  Unreachable objects are never intentionally added to
+	a pack, even when repacking.  This option prevents unreachable
+	objects from being immediately deleted by way of being left in
+	the old pack and then removed.  Instead, the loose unreachable
+	objects will be pruned according to normal expiry rules
+	with the next 'git-gc' invocation. See linkgit:git-gc[1].
 
 -A::
-	Same as `-a`, unless '-d' is used.  Then any unreachable
-	objects in a previous pack become loose, unpacked objects,
-	instead of being left in the old pack.  Unreachable objects
-	are never intentionally added to a pack, even when repacking.
-	This option prevents unreachable objects from being immediately
-	deleted by way of being left in the old pack and then
-	removed.  Instead, the loose unreachable objects
-	will be pruned according to normal expiry rules
-	with the next 'git-gc' invocation. See linkgit:git-gc[1].
+	Same as `-a`. Historical note: the -a and -A options used to differ
+	in that -a did not leave unreachable objects unpacked.  Instead,
+	they were removed along with the redundant pack (when -d was used).
 
 -d::
 	After packing, if the newly created packs make some
diff --git a/git-repack.sh b/git-repack.sh
index 458a497..f1e21b9 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -7,8 +7,9 @@ OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git repack [options]
 --
-a               pack everything in a single pack
-A               same as -a, and turn unreachable objects loose
+a               pack everything in a single pack, and turn unreachable objects
+                loose
+A               same as -a
 d               remove redundant packs, and run git-prune-packed
 f               pass --no-reuse-object to git-pack-objects
 n               do not run git-update-server-info
@@ -29,8 +30,7 @@ while test $# != 0
 do
 	case "$1" in
 	-n)	no_update_info=t ;;
-	-a)	all_into_one=t ;;
-	-A)	all_into_one=t
+	-a|-A)	all_into_one=t
 		unpack_unreachable=--unpack-unreachable ;;
 	-d)	remove_redundant=t ;;
 	-q)	quiet=-q ;;
-- 
1.6.0.3.552.g12334
