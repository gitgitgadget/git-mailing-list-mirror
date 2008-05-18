From: drafnel@gmail.com
Subject: [PATCH] t7701-repack-unpack-unreachable.sh: check timestamp of unpacked objects
Date: Sat, 17 May 2008 23:00:00 -0500
Message-ID: <16342222.1211083116270.JavaMail.teamon@b306.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun May 18 05:59:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxa3W-000162-T0
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 05:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbYERD6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 23:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbYERD6j
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 23:58:39 -0400
Received: from mailproxy06.teamon.com ([64.14.130.37]:23767 "EHLO
	b306.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751499AbYERD6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 23:58:38 -0400
Received: from b306.teamon.com (localhost [127.0.0.1])
	by b306.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m4I3wad30244;
	Sun, 18 May 2008 03:58:36 GMT
X-Mailer: git-send-email 1.5.5.1.447.geb0a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82373>

From: Brandon Casey <drafnel@gmail.com>

Unpacked objects should receive the timestamp of the pack they were
unpacked from. Check.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t7701-repack-unpack-unreachable.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 6a5211f..bdb00d4 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -4,6 +4,10 @@ test_description='git-repack works correctly'
 
 . ./test-lib.sh
 
+fsha1=
+csha1=
+tsha1=
+
 test_expect_success '-A option leaves unreachable objects unpacked' '
 	echo content > file1 &&
 	git add . &&
@@ -44,4 +48,28 @@ test_expect_success '-A option leaves unreachable objects unpacked' '
 	git show $tsha1
 '
 
+test_expect_success 'unpacked objects receive timestamp of pack file' '
+	fsha1path=$(echo "$fsha1" | sed -e "s/\(..\)\(.*\)/\1\/\2/") &&
+	fsha1path=".git/objects/$fsha1path" &&
+	csha1path=$(echo "$csha1" | sed -e "s/\(..\)\(.*\)/\1\/\2/") &&
+	csha1path=".git/objects/$csha1path" &&
+	tsha1path=$(echo "$tsha1" | sed -e "s/\(..\)\(.*\)/\1\/\2/") &&
+	tsha1path=".git/objects/$tsha1path" &&
+	git branch transient_branch $csha1 &&
+	git repack -a -d -l &&
+	test ! -f "$fsha1path" &&
+	test ! -f "$csha1path" &&
+	test ! -f "$tsha1path" &&
+	test 1 = $(ls -1 .git/objects/pack/pack-*.pack | wc -l) &&
+	packfile=$(ls .git/objects/pack/pack-*.pack) &&
+	git branch -D transient_branch &&
+	git repack -A -l &&
+	test -f "$fsha1path" -a ! "$fsha1path" -nt "$packfile" -a \
+				! "$fsha1path" -ot "$packfile" &&
+	test -f "$csha1path" -a ! "$csha1path" -nt "$packfile" -a \
+				! "$csha1path" -ot "$packfile" &&
+	test -f "$tsha1path" -a ! "$tsha1path" -nt "$packfile" -a \
+				! "$tsha1path" -ot "$packfile"
+'
+
 test_done
-- 
1.5.5.1.447.geb0a7
