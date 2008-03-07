From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] t5300: add test for "index-pack --strict"
Date: Fri,  7 Mar 2008 08:39:53 +0100
Message-ID: <12048755932645-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 08:40:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXXCF-0002kl-2p
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 08:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756468AbYCGHj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 02:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbYCGHj4
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 02:39:56 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:38771 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbYCGHjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 02:39:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 4A33C73B5FB2;
	Fri,  7 Mar 2008 08:39:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9cVmIle8es0E; Fri,  7 Mar 2008 08:39:53 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 2F3777091B99; Fri,  7 Mar 2008 08:39:53 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76464>

This adds test for indexing packs with --strict option,
basically the same as c0e809e5c027443d6f77714a1c5f8c6233ca0a20
do for unpack-objects.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 t/t5300-pack-object.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 7647f21..007b136 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -322,4 +322,51 @@ test_expect_success 'unpacking with --strict' '
 	)
 '
 
+test_expect_success 'index-pack with --strict' '
+
+	for j in a b c d e f g
+	do
+		for i in 0 1 2 3 4 5 6 7 8 9
+		do
+			o=$(echo $j$i | git hash-object -w --stdin) &&
+			echo "100644 $o	0 $j$i"
+		done
+	done >LIST &&
+	rm -f .git/index &&
+	git update-index --index-info <LIST &&
+	LIST=$(git write-tree) &&
+	rm -f .git/index &&
+	head -n 10 LIST | git update-index --index-info &&
+	LI=$(git write-tree) &&
+	rm -f .git/index &&
+	tail -n 10 LIST | git update-index --index-info &&
+	ST=$(git write-tree) &&
+	PACK5=$( git rev-list --objects "$LIST" "$LI" "$ST" | \
+		git pack-objects test-5 ) &&
+	PACK6=$( (
+			echo "$LIST"
+			echo "$LI"
+			echo "$ST"
+		 ) | git pack-objects test-6 ) &&
+	test_create_repo test-7 &&
+	(
+		cd test-7 &&
+		git index-pack --strict --stdin <../test-5-$PACK5.pack &&
+		git ls-tree -r $LIST &&
+		git ls-tree -r $LI &&
+		git ls-tree -r $ST
+	) &&
+	test_create_repo test-8 &&
+	(
+		# tree-only into empty repo -- many unreachables
+		cd test-8 &&
+		test_must_fail git index-pack --strict --stdin <../test-6-$PACK6.pack
+	) &&
+	(
+		# already populated -- no unreachables
+		cd test-7 &&
+		git index-pack --strict --stdin <../test-6-$PACK6.pack
+	)
+'
+
 test_done
-- 
gitgui.0.9.3.ge659

