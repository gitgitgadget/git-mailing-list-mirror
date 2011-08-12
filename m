From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 04/56] t6042: Add a testcase where undetected rename causes silent file deletion
Date: Thu, 11 Aug 2011 23:19:37 -0600
Message-ID: <1313126429-17368-5-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkB3-0004ab-58
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103Ab1HLFUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:20:47 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab1HLFUl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:41 -0400
Received: by iye16 with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=W7cSWZxAuseqq7JY6rwFzkqOZ4nO7cW8Qzj/6iCdsAA=;
        b=aFU9AvJTEYmjUVO/uuy1A/qdJqtQXeBFA7cYnalTs5YOhq3YRl76I9vMbmYNGkziu0
         hsZdYrkan7FdM7SbvtiiEJNRVt4B9mGnuHFpVUgNkqurnu+GhVwZr5GmqfZlvwZGhUzn
         gyjpNRseBzocPFYt99sDKAgWzrKD55an/uz8A=
Received: by 10.42.140.200 with SMTP id l8mr512171icu.371.1313126440547;
        Thu, 11 Aug 2011 22:20:40 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.38
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179167>

There are cases where history should merge cleanly, and which current git
does merge cleanly despite not detecting a rename; however the merge
currently nukes files that should not be removed.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 t/t6042-merge-rename-corner-cases.sh |   65 ++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index f338fb4..db5560c 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -133,4 +133,69 @@ test_expect_failure 'missed conflict if rename not detected' '
 	test_must_fail git merge -s recursive D^0
 '
 
+# Tests for undetected rename/add-source causing a file to erroneously be
+# deleted (and for mishandled rename/rename(1to1) causing the same issue).
+#
+# This test uses a rename/rename(1to1)+add-source conflict (1to1 means the
+# same file is renamed on both sides to the same thing; it should trigger
+# the 1to2 logic, which it would do if the add-source didn't cause issues
+# for git's rename detection):
+#   Commit A: new file: a
+#   Commit B: rename a->b
+#   Commit C: rename a->b, add unrelated a
+
+test_expect_success 'setup undetected rename/add-source causes data loss' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n" >a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a b &&
+	echo foobar >a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_failure 'detect rename/add-source and preserve all data' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test -f a &&
+	test -f b &&
+
+	test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
+	test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
+'
+
+test_expect_failure 'detect rename/add-source and preserve all data, merge other way' '
+	git checkout C^0 &&
+
+	git merge -s recursive B^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test -f a &&
+	test -f b &&
+
+	test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
+	test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
+'
+
 test_done
-- 
1.7.6.100.gac5c1
