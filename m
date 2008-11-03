From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in packs
 with a .keep file
Date: Mon, 03 Nov 2008 14:37:05 -0600
Message-ID: <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil>
References: <20081103161202.GJ15463@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:38:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx6CM-0004Tu-Pb
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 21:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbYKCUhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 15:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754606AbYKCUhj
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 15:37:39 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49323 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbYKCUhi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 15:37:38 -0500
Received: by mail.nrlssc.navy.mil id mA3Kb61D013632; Mon, 3 Nov 2008 14:37:06 -0600
In-Reply-To: <20081103161202.GJ15463@spearce.org>
X-OriginalArrivalTime: 03 Nov 2008 20:37:06.0131 (UTC) FILETIME=[EF80C230:01C93DF3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99991>

From: Brandon Casey <drafnel@gmail.com>

Objects residing in pack files that have an associated .keep file are not
supposed to be repacked into new pack files, but they are.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This version replaces the use of 'head -n -1' with a grep, and should work on
all platforms.

-brandon


 t/t7700-repack.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100755 t/t7700-repack.sh

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
new file mode 100755
index 0000000..27af5ab
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
+        git rev-list --objects --all | grep -v file2 |
+		git pack-objects pack > /dev/null &&
+	# The second pack will contain the excluded object
+        packsha1=$(git rev-list --objects --all | grep file2 |
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
