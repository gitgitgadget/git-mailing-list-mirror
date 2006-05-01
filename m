From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] repack: honor -d even when no new pack was created
Date: Mon, 1 May 2006 12:57:48 +0200
Message-ID: <20060501105748.GE20847@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 01 12:58:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaW6O-0002pW-RM
	for gcvg-git@gmane.org; Mon, 01 May 2006 12:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWEAK5u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 06:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWEAK5u
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 06:57:50 -0400
Received: from admingilde.org ([213.95.32.146]:50650 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751173AbWEAK5t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 May 2006 06:57:49 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FaW68-0000vM-E7
	for git@vger.kernel.org; Mon, 01 May 2006 12:57:48 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19377>

If all objects are reachable via an alternate object store then we
still have to remove all obsolete local packs.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

Without this patch I got the following behaviour:

".git/objects/info/alternates" [Neu] 1L, 38C geschrieben
admingilde:~/src/linux-2.6 > git count-objects
107852 objects, 665596 kilobytes
admingilde:~/src/linux-2.6 > git repack -a -l -d
Generating pack...
Done counting 0 objects.
Nothing new to pack.
admingilde:~/src/linux-2.6 > git prune
admingilde:~/src/linux-2.6 > git count-objects
0 objects, 0 kilobytes
admingilde:~/src/linux-2.6 > ls .git/objects/pack
pack-b3c6fbdfa36a326815de6358885c7a570a986b1b.idx
pack-b3c6fbdfa36a326815de6358885c7a570a986b1b.pack
pack-e0d76ffe354ef5665028a6cb4506ea902f72e1d0.idx
pack-e0d76ffe354ef5665028a6cb4506ea902f72e1d0.pack

After changing git-repack, objects/pack was empty, as expected.

 git-repack.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

c58513fa76e10007fdf15b49a593a2b9c6a080be
diff --git a/git-repack.sh b/git-repack.sh
index e0c9f32..4fb3f26 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -48,15 +48,15 @@ name=$(git-rev-list --objects --all $rev
 	exit 1
 if [ -z "$name" ]; then
 	echo Nothing new to pack.
-	exit 0
-fi
-echo "Pack pack-$name created."
+else
+	echo "Pack pack-$name created."
 
-mkdir -p "$PACKDIR" || exit
+	mkdir -p "$PACKDIR" || exit
 
-mv .tmp-pack-$name.pack "$PACKDIR/pack-$name.pack" &&
-mv .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" ||
-exit
+	mv .tmp-pack-$name.pack "$PACKDIR/pack-$name.pack" &&
+	mv .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" ||
+	exit
+fi
 
 if test "$remove_redundant" = t
 then
-- 
1.3.1.g8971-dirty


-- 
Martin Waitz
