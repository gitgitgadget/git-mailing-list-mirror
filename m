From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/6] t7700: demonstrate mishandling of objects in packs with a .keep file
Date: Wed, 12 Nov 2008 11:59:02 -0600
Message-ID: <WFmMnhNsYRw3IUD8hZk59JmvLQlpuqo-hsW2L51xXUJ0ETOpVPtrZvZzBrrquDq1PlXDGK5BhsQ@cipher.nrlssc.navy.mil>
References: <NRnq_JA3Ngz2v6EUhSwtVu5zewgvJgLsW85zZZqzrYE@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59MeWg__Hu_J0586FDlwkv7_Bb80SFy_3xVB_YmBMzdF0byAGksl5Rnk@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, git@vger.kernel.org, spearce@spearce.org,
	nico@cam.org, Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 19:01:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0K1o-0002fL-FE
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbYKLR7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbYKLR7m
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:59:42 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50127 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbYKLR7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:59:35 -0500
Received: by mail.nrlssc.navy.mil id mACHxHUA019934; Wed, 12 Nov 2008 11:59:17 -0600
In-Reply-To: <WFmMnhNsYRw3IUD8hZk59MeWg__Hu_J0586FDlwkv7_Bb80SFy_3xVB_YmBMzdF0byAGksl5Rnk@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 12 Nov 2008 17:59:17.0075 (UTC) FILETIME=[61393A30:01C944F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100791>

From: Brandon Casey <drafnel@gmail.com>

Objects residing in pack files that have an associated .keep file are not
supposed to be repacked into new pack files, but they are.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7700-repack.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100755 t/t7700-repack.sh

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
new file mode 100755
index 0000000..7aaff0b
--- /dev/null
+++ b/t/t7700-repack.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='git repack works correctly'
+
+. ./test-lib.sh
+
+test_expect_failure 'objects in packs marked .keep are not repacked' '
+	echo content1 > file1 &&
+	echo content2 > file2 &&
+	git add . &&
+	git commit -m initial_commit &&
+	# Create two packs
+	# The first pack will contain all of the objects except one
+	git rev-list --objects --all | grep -v file2 |
+		git pack-objects pack > /dev/null &&
+	# The second pack will contain the excluded object
+	packsha1=$(git rev-list --objects --all | grep file2 |
+		git pack-objects pack) &&
+	touch -r pack-$packsha1.pack pack-$packsha1.keep &&
+	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
+		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
+	mv pack-* .git/objects/pack/ &&
+	git repack -A -d -l &&
+	git prune-packed &&
+	for p in .git/objects/pack/*.idx; do
+		idx=$(basename $p)
+		test "pack-$packsha1.idx" = "$idx" && continue
+		if git verify-pack -v $p | egrep "^$objsha1"; then
+			found_duplicate_object=1
+			echo "DUPLICATE OBJECT FOUND"
+			break
+		fi
+	done &&
+	test -z "$found_duplicate_object"
+'
+
+test_done
+
-- 
1.6.0.3.552.g12334
