From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t7700: test that 'repack -a' packs alternate packed objects
Date: Wed, 12 Nov 2008 18:50:26 -0600
Message-ID: <E9qVE-t4Yve7ucbU-qz4xNKAAKLQr2fsS-7YejFpq3D1nvYFAzALqOj8GLVYLfJ_AlbpSpUJ_6o@cipher.nrlssc.navy.mil>
References: <WFmMnhNsYRw3IUD8hZk59At-5jc1rZU5GaB35sb1epRZ6zwd7IMw9V94SQyEliIEyriM4J5j3AM@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, git@vger.kernel.org, spearce@spearce.org,
	nico@cam.org, Brandon Casey <casey@nrlssc.navy.mil>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 13 01:52:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0QRS-0008DS-7K
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 01:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbYKMAu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 19:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbYKMAu7
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 19:50:59 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37373 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbYKMAu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 19:50:58 -0500
Received: by mail.nrlssc.navy.mil id mAD0oa0b009905; Wed, 12 Nov 2008 18:50:36 -0600
In-Reply-To: <WFmMnhNsYRw3IUD8hZk59At-5jc1rZU5GaB35sb1epRZ6zwd7IMw9V94SQyEliIEyriM4J5j3AM@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 13 Nov 2008 00:50:36.0283 (UTC) FILETIME=[D72D84B0:01C94529]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100839>

Previously, when 'repack -a' was called and there were no packs in the local
repository without a .keep file, the repack would fall back to calling
pack-objects with '--unpacked --incremental'. This resulted in the created
pack file, if any, to be missing the packed objects in the alternate object
store. Test that this specific case has been fixed.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Here is a test to demonstrate what
  [PATCH 5/6] repack: do not fall back to incremental repacking with [-a|-A]
fixes.

This should apply cleanly to next since it includes
  a836cfa3 t7700: demonstrate mishandling of loose objects in an alternate ODB
which has a few context lines showing through in the diff below.

-brandon


 t/t7700-repack.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 960bff4..3f602ea 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -53,5 +53,21 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	test -z "$found_duplicate_object"
 '
 
+test_expect_success 'packed obs in alt ODB are repacked even when local repo is packless' '
+	mkdir alt_objects/pack
+	mv .git/objects/pack/* alt_objects/pack &&
+	git repack -a &&
+	myidx=$(ls -1 .git/objects/pack/*.idx) &&
+	test -f "$myidx" &&
+	for p in alt_objects/pack/*.idx; do
+		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
+	done | while read sha1 rest; do
+		if ! ( git verify-pack -v $myidx | grep "^$sha1" ); then
+			echo "Missing object in local pack: $sha1"
+			return 1
+		fi
+	done
+'
+
 test_done
 
-- 
1.6.0.3.552.g12334
