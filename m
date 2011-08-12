From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 02/56] t6042: Add failing testcase for rename/modify/add-source conflict
Date: Thu, 11 Aug 2011 23:19:35 -0600
Message-ID: <1313126429-17368-3-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:20:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkAl-0004Sk-QE
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab1HLFUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:20:38 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab1HLFUh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:37 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=neiJu373UzHnYKnWVfpX7nm+043lhlK884hUkoTBmBg=;
        b=yFsqv/HL9bpLp94ygVPPSYx7rF6Jlv70Ubr7XILoYLOw4NrbZ63XrQIQhG5FT/WJSj
         kcFBsPc/5LXpRhcPX4HjPqUCbqVbgtvMoKsoYZoLldvCnCMtDnRXsEd9+iTPMFNDd9Qs
         QbH4MncDMHu2SpvRugBupkoRsE5P9YT3r67Zo=
Received: by 10.231.56.75 with SMTP id x11mr1014957ibg.98.1313126436904;
        Thu, 11 Aug 2011 22:20:36 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.35
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179163>

If there is a cleanly resolvable rename/modify conflict AND there is a new
file introduced on the renamed side of the merge whose name happens to
match that of the source of the rename (but is otherwise unrelated to the
rename), then git fails to cleanly resolve the merge despite the fact that
the new file should not cause any problems.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 t/t6042-merge-rename-corner-cases.sh |   39 ++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 5054459..276d7dd 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -33,4 +33,43 @@ test_expect_failure "Does git preserve Gollum's precious artifact?" '
 	test -f ring
 '
 
+# Testcase setup for rename/modify/add-source:
+#   Commit A: new file: a
+#   Commit B: modify a slightly
+#   Commit C: rename a->b, add completely different a
+#
+# We should be able to merge B & C cleanly
+
+test_expect_success 'setup rename/modify/add-source conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n6\n7\n" >a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	echo 8 >>a &&
+	git add a &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a b &&
+	echo something completely different >a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_failure 'rename/modify/add-source conflict resolvable' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 &&
+
+	test $(git rev-parse B:a) = $(git rev-parse b) &&
+	test $(git rev-parse C:a) = $(git rev-parse a)
+'
+
 test_done
-- 
1.7.6.100.gac5c1
