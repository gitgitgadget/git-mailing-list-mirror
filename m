From: drafnel@gmail.com
Subject: [PATCH] t7700: demonstrate mishandling of objects in packs with a .keep file
Date: Sat,  1 Nov 2008 22:35:19 -0500
Message-ID: <14536526.1225596838300.JavaMail.teamon@b301.teamon.com>
References: <1S3xpaVP1Cy1Rei_ODwlXsBdu64BGiPve-lj_4fN6cA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, nico@cam.org, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 04:46:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwTuW-0001Qw-34
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 04:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYKBDon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 23:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbYKBDom
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 23:44:42 -0400
Received: from mailproxy01.teamon.com ([64.85.68.137]:35286 "EHLO
	b301.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752745AbYKBDom (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 23:44:42 -0400
X-Greylist: delayed 641 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Nov 2008 23:44:42 EDT
Received: from b301.teamon.com (localhost [127.0.0.1])
	by b301.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id mA23Xwv15228;
	Sun, 2 Nov 2008 03:33:58 GMT
X-Mailer: git-send-email 1.6.0.2.588.g3102
In-Reply-To: <1S3xpaVP1Cy1Rei_ODwlXsBdu64BGiPve-lj_4fN6cA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99804>

From: Brandon Casey <drafnel@gmail.com>

Objects residing in pack files that have an associated .keep file are not
supposed to be repacked into new pack files, but they are.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t7700-repack.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100755 t/t7700-repack.sh

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
new file mode 100755
index 0000000..1489e68
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
+	git rev-list --objects --all | head -n -1 |
+		git pack-objects pack > /dev/null &&
+	# The second pack will contain the excluded object
+	packsha1=$(git rev-list --objects --all | tail -n 1 |
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
1.6.0.2.588.g3102
