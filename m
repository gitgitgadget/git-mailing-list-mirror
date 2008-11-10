From: drafnel@gmail.com
Subject: [PATCH 1/3] t7700: demonstrate mishandling of loose objects in an alternate ODB
Date: Sun,  9 Nov 2008 23:59:56 -0600
Message-ID: <11419048.1226296708027.JavaMail.teamon@b307.teamon.com>
References: <7v8wrwidi3.fsf@gitster.siamese.dyndns.org>
 <1226296798-31522-1-git-send-email-foo@foo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, nico@cam.org, ae@op5.se,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Mon Nov 10 06:59:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzPoS-00015b-9N
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 06:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYKJF6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 00:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbYKJF6g
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 00:58:36 -0500
Received: from www.teamon.com ([216.34.91.250]:4581 "EHLO b307.teamon.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751455AbYKJF6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 00:58:33 -0500
Received: from b307.teamon.com (localhost [127.0.0.1])
	by b307.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id mAA5wSo28405;
	Mon, 10 Nov 2008 05:58:28 GMT
X-Mailer: git-send-email 1.6.0.2.588.g3102
In-Reply-To: <1226296798-31522-1-git-send-email-foo@foo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100491>

From: Brandon Casey <drafnel@gmail.com>

Loose objects residing in an alternate object database should not be packed
when the -l option to repack is used.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t7700-repack.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 356afe3..43c9cf9 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -34,5 +34,24 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	test -z "$found_duplicate_object"
 '
 
+test_expect_failure 'loose objects in alternate ODB are not repacked' '
+	mkdir alt_objects &&
+	echo `pwd`/alt_objects > .git/objects/info/alternates &&
+	echo content3 > file3 &&
+	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
+	git add file3 &&
+	git commit -m commit_file3 &&
+	git repack -a -d -l &&
+	git prune-packed &&
+	for p in .git/objects/pack/*.idx; do
+		if git verify-pack -v $p | egrep "^$objsha1"; then
+			found_duplicate_object=1
+			echo "DUPLICATE OBJECT FOUND"
+			break
+		fi
+	done &&
+	test -z "$found_duplicate_object"
+'
+
 test_done
 
-- 
1.6.0.2.588.g3102
