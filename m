From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 12/48] t6036: criss-cross + rename/rename(1to2)/add-source + modify/modify
Date: Wed,  8 Jun 2011 01:30:42 -0600
Message-ID: <1307518278-23814-13-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:32:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDFU-0007JK-DM
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab1FHH3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:21 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:37577 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab1FHH3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:19 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so191910pxi.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ZMUI6kbpiTxqhvA9qC8/dYmTwJUu5yxFiuSehlAKHJc=;
        b=m6q5oe+QsrhpRxCBImwGqFB9aQoWgU1UCfpTwQkeGT0AJeg0lRwYTm1hKdPGbpM85A
         aWAuPBRxCV/00k/ZMHSqarKw5WpaBgQu8mxjsO1MvjoiIxcSERa4sb1+xczx7IpIuEbi
         DmsC3JYLJnPKlC6ZajAOXtA/lO69ZNyQYw5TA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eHB7k4t8xfDCxizZohRwOIbehzIsF65cninxN/Lio32G5WJ0xhnu9SxoFEuu0xOrdy
         q05DKfjTF2Agg90fbBOQZMmaE0Vr3LScpxq7MGWqiMYDykzAIYK3jMgxod631XMM6qDg
         r3K1NFV0FtleCiMjHzcLviEX7HMFWiWg4sl+g=
Received: by 10.142.52.20 with SMTP id z20mr225599wfz.212.1307518158705;
        Wed, 08 Jun 2011 00:29:18 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.16
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175338>

Now THAT's a corner case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh |   72 +++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index eee183e..2fa7c3e 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -622,4 +622,76 @@ test_expect_failure 'handle rename/rename(1to2)/modify followed by what looks li
 	test 8 -eq $(wc -l < newname)
 '
 
+#
+# criss-cross with rename/rename(1to2)/add-source + resolvable modify/modify:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: new file: a
+#   Commit B: rename a->b
+#   Commit C: rename a->c, add different a
+#   Commit D: merge B&C, keeping b&c and (new) a modified at beginning
+#   Commit E: merge B&C, keeping b&c and (new) a modified at end
+#
+# Now, when we merge commits D & E, there should be no conflict...
+
+test_expect_success 'setup criss-cross + rename/rename/add + modify/modify' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "lots\nof\nwords\nand\ncontent\n" >a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a c &&
+	printf "2\n3\n4\n5\n6\n7\n" >a &&
+	git add a &&
+	git commit -m C &&
+
+	git checkout B^0 &&
+	git merge --no-commit -s ours C^0 &&
+	git checkout C -- a c &&
+	mv a old_a &&
+	echo 1 >a &&
+	cat old_a >>a &&
+	rm old_a &&
+	git add -u &&
+	git commit -m "Merge commit C^0 into HEAD" &&
+	git tag D &&
+
+	git checkout C^0 &&
+	git merge --no-commit -s ours B^0 &&
+	git checkout B -- b &&
+	echo 8 >> a &&
+	git add -u &&
+	git commit -m "Merge commit B^0 into HEAD" &&
+	git tag E
+'
+
+test_expect_failure 'correctly resolves criss-cross with rename/rename/add and modify/modify conflict' '
+	git checkout D^0 &&
+
+	git merge -s recursive E^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test 6 -eq $(wc -l < a)
+'
+
 test_done
-- 
1.7.6.rc0.62.g2d69f
