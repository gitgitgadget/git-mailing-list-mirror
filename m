From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v3] t7700: demonstrate mishandling of objects in packs with
 a .keep file
Date: Mon, 03 Nov 2008 16:14:34 -0600
Message-ID: <5QaPpbqIy9l0n5_CfDoFgHU9t7eMkiXtyHTh8C6VkbUVh62Cajc2qw@cipher.nrlssc.navy.mil>
References: <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 23:16:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx7iH-00018w-AB
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 23:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbYKCWOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 17:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbYKCWOn
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 17:14:43 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39414 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbYKCWOm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 17:14:42 -0500
Received: by mail.nrlssc.navy.mil id mA3MEZjr019958; Mon, 3 Nov 2008 16:14:35 -0600
In-Reply-To: <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 03 Nov 2008 22:14:35.0434 (UTC) FILETIME=[8DF590A0:01C93E01]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100004>

From: Brandon Casey <drafnel@gmail.com>

Objects residing in pack files that have an associated .keep file are not
supposed to be repacked into new pack files, but they are.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Whoops, white space contaminated in two spots, this one fixes it.

-brandon


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
