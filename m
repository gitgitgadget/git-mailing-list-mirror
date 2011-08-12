From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 09/56] t6036: criss-cross with weird content can fool git into clean merge
Date: Thu, 11 Aug 2011 23:19:42 -0600
Message-ID: <1313126429-17368-10-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkDs-00066y-HZ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab1HLFUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:20:54 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab1HLFUu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:50 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YXobqeC/gC4JHkRAiG6yomNc1mWJJdpaFiN5TaoehmQ=;
        b=HkPq1p2Wa5LAPpCM3+y2cRb/7hW6EdMckpewLwSBeqdX6I4YBfBcf/LkmKgdWGRD1E
         s/M6Iue9/vx8ET/1BDuaAk94HN7WiD2ZwAv9qplupE82uANd3Q3PyzK9VT4YuYRQhhan
         70MOxsMFgE1aYZ7geCieA6XwWq9OMOlM872w8=
Received: by 10.231.130.105 with SMTP id r41mr1168936ibs.14.1313126450059;
        Thu, 11 Aug 2011 22:20:50 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.48
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179217>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 t/t6036-recursive-corner-cases.sh |   83 +++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 90b50bb..991c56d 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -314,4 +314,87 @@ test_expect_failure 'git detects conflict merging criss-cross+modify/delete, rev
 	test $(git rev-parse :3:file) = $(git rev-parse B:file)
 '
 
+#
+# criss-cross + modify/modify with very contrived file contents:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: file with contents 'A\n'
+#   Commit B: file with contents 'B\n'
+#   Commit C: file with contents 'C\n'
+#   Commit D: file with contents 'D\n'
+#   Commit E: file with contents:
+#      <<<<<<< Temporary merge branch 1
+#      C
+#      =======
+#      B
+#      >>>>>>> Temporary merge branch 2
+#
+# Now, when we merge commits D & E, does git detect the conflict?
+
+test_expect_success 'setup differently handled merges of content conflict' '
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	echo A >file &&
+	git add file &&
+	test_tick &&
+	git commit -m A &&
+
+	git branch B &&
+	git checkout -b C &&
+	echo C >file &&
+	git add file &&
+	test_tick &&
+	git commit -m C &&
+
+	git checkout B &&
+	echo B >file &&
+	git add file &&
+	test_tick &&
+	git commit -m B &&
+
+	git checkout B^0 &&
+	test_must_fail git merge C &&
+	echo D >file &&
+	git add file &&
+	test_tick &&
+	git commit -m D &&
+	git tag D &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	cat <<EOF >file &&
+<<<<<<< Temporary merge branch 1
+C
+=======
+B
+>>>>>>> Temporary merge branch 2
+EOF
+	git add file &&
+	test_tick &&
+	git commit -m E &&
+	git tag E
+'
+
+test_expect_failure 'git detects conflict w/ criss-cross+contrived resolution' '
+	git checkout D^0 &&
+
+	test_must_fail git merge -s recursive E^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :2:file) = $(git rev-parse D:file) &&
+	test $(git rev-parse :3:file) = $(git rev-parse E:file)
+'
+
 test_done
-- 
1.7.6.100.gac5c1
