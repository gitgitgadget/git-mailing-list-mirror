From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 11/56] t6036: criss-cross w/ rename/rename(1to2)/modify+rename/rename(2to1)/modify
Date: Thu, 11 Aug 2011 23:19:44 -0600
Message-ID: <1313126429-17368-12-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:24:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkDu-00066y-Tw
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab1HLFXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:23:31 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab1HLFUy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:54 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ozFUzWVccXJleVKAiUXH2pYX7TeGAmeEDsip33wIVmA=;
        b=yCkYaVtQGZAdPvFUZHkKgDZjcOgFG7K2BKfrPu9JMh7BQwHb3janWo5SnD+dwsuxkv
         BhFKo3kynfqz/1TRajUiZYH93lgmR/gEKJ7zBIjKhAa8kidRkm7pdjqUN7m+8byi0MGz
         k4NkEBFPf/a/lNDulDyiZIY842ST0Pu55G69w=
Received: by 10.231.113.32 with SMTP id y32mr1185703ibp.5.1313126454304;
        Thu, 11 Aug 2011 22:20:54 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.52
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179219>

This test is mostly just designed for testing optimality of the virtual
merge base in the event of a rename/rename(1to2) conflict.  The current
choice for resolving this in git seems somewhat confusing and suboptimal.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1: More thorough testing of results, usage of some of
  Junio's wording in a comment.

 t/t6036-recursive-corner-cases.sh |   88 +++++++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index acff84d..38cace6 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -556,4 +556,92 @@ test_expect_failure 'merge of E2 & D fails but has appropriate contents' '
 	test -f a~D^0
 '
 
+#
+# criss-cross with rename/rename(1to2)/modify followed by
+# rename/rename(2to1)/modify:
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
+#   Commit B: rename a->b, modifying by adding a line
+#   Commit C: rename a->c
+#   Commit D: merge B&C, resolving conflict by keeping contents in newname
+#   Commit E: merge B&C, resolving conflict similar to D but adding another line
+#
+# There is a conflict merging B & C, but one of filename not of file
+# content.  Whoever created D and E chose specific resolutions for that
+# conflict resolution.  Now, since: (1) there is no content conflict
+# merging B & C, (2) D does not modify that merged content further, and (3)
+# both D & E resolve the name conflict in the same way, the modification to
+# newname in E should not cause any conflicts when it is merged with D.
+# (Note that this can be accomplished by having the virtual merge base have
+# the merged contents of b and c stored in a file named a, which seems like
+# the most logical choice anyway.)
+#
+# Comment from Junio: I do not necessarily agree with the choice "a", but
+# it feels sound to say "B and C do not agree what the final pathname
+# should be, but we know this content was derived from the common A:a so we
+# use one path whose name is arbitrary in the virtual merge base X between
+# D and E" and then further let the rename detection to notice that that
+# arbitrary path gets renamed between X-D to "newname" and X-E also to
+# "newname" to resolve it as both sides renaming it to the same new
+# name. It is akin to what we do at the content level, i.e. "B and C do not
+# agree what the final contents should be, so we leave the conflict marker
+# but that may cancel out at the final merge stage".
+
+test_expect_success 'setup rename/rename(1to2)/modify followed by what looks like rename/rename(2to1)/modify' '
+	git reset --hard &&
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n6\n" >a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	echo 7 >>b &&
+	git add -u &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a c &&
+	git commit -m C &&
+
+	git checkout -q B^0 &&
+	git merge --no-commit -s ours C^0 &&
+	git mv b newname &&
+	git commit -m "Merge commit C^0 into HEAD" &&
+	git tag D &&
+
+	git checkout -q C^0 &&
+	git merge --no-commit -s ours B^0 &&
+	git mv c newname &&
+	printf "7\n8\n" >>newname &&
+	git add -u &&
+	git commit -m "Merge commit B^0 into HEAD" &&
+	git tag E
+'
+
+test_expect_failure 'handle rename/rename(1to2)/modify followed by what looks like rename/rename(2to1)/modify' '
+	git checkout D^0 &&
+
+	git merge -s recursive E^0 &&
+
+	test 1 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse HEAD:newname) = $(git rev-parse E:newname)
+'
+
 test_done
-- 
1.7.6.100.gac5c1
