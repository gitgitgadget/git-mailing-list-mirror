From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 55/56] t6036: criss-cross + rename/rename(1to2)/add-dest + simple modify
Date: Thu, 11 Aug 2011 23:20:28 -0600
Message-ID: <1313126429-17368-56-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkD7-0005ix-34
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab1HLFWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:36 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59248 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab1HLFWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:33 -0400
Received: by gwaa12 with SMTP id a12so1770941gwa.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VBF4/TBX9ebUcZFnpJmfwkwbAxIdoaa/OaOSlbCbKdk=;
        b=XogilkuXbHLZBVHrzBEpn1oGqfdrKq6JoIRjVqVhgh2J3hGZf8kXsUtbGAsABHcnVA
         f9/rd/nF8ukSvCQzQQ0bTuufH2YoDGTHJ/D+k16msU9lP3EsK5IOs4gA1poaK+tf5QyK
         75qf28V71/Y52H+Mw1J/CvKXEUffxoyRuLv1Q=
Received: by 10.42.169.198 with SMTP id c6mr540270icz.271.1313126552656;
        Thu, 11 Aug 2011 22:22:32 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.30
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179207>

This is another testcase trying to exercise the virtual merge base
creation in the rename/rename(1to2) code.  A testcase is added that we
should be able to merge cleanly, but which requires a virtual merge base
to be created that correctly handles rename/add-dest conflicts within the
rename/rename(1to2) testcase handling.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Completely new patch (about a problem that existed previous to v1, but which
I hadn't noticed).

 t/t6036-recursive-corner-cases.sh |   69 +++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index d8c6bda..e9c7a25 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -704,4 +704,73 @@ test_expect_failure 'detect rename/rename/add-source for virtual merge-base' '
 	test "$(cat a)" = "$(printf "1\n2\n3\n4\n5\n6\n7\n8\n")"
 '
 
+#
+# criss-cross with rename/rename(1to2)/add-dest + simple modify:
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
+#   Commit B: rename a->b, add c
+#   Commit C: rename a->c
+#   Commit D: merge B&C, keeping A:a and B:c
+#   Commit E: merge B&C, keeping A:a and slightly modified c from B
+#
+# Merging commits D & E should result in no conflict.  The virtual merge
+# base of B & C needs to not delete B:c for that to work, though...
+
+test_expect_success 'setup criss-cross+rename/rename/add-dest + simple modify' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	>a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	printf "1\n2\n3\n4\n5\n6\n7\n" >c &&
+	git add c &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a c &&
+	git commit -m C &&
+
+	git checkout B^0 &&
+	git merge --no-commit -s ours C^0 &&
+	git mv b a &&
+	git commit -m "D is like B but renames b back to a" &&
+	git tag D &&
+
+	git checkout B^0 &&
+	git merge --no-commit -s ours C^0 &&
+	git mv b a &&
+	echo 8 >>c &&
+	git add c &&
+	git commit -m "E like D but has mod in c" &&
+	git tag E
+'
+
+test_expect_failure 'virtual merge base handles rename/rename(1to2)/add-dest' '
+	git checkout D^0 &&
+
+	git merge -s recursive E^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse HEAD:a) = $(git rev-parse A:a) &&
+	test $(git rev-parse HEAD:c) = $(git rev-parse E:c)
+'
+
 test_done
-- 
1.7.6.100.gac5c1
