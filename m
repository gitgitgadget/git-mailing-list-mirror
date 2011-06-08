From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 11/48] t6036: criss-cross w/ rename/rename(1to2)/modify+rename/rename(2to1)/modify
Date: Wed,  8 Jun 2011 01:30:41 -0600
Message-ID: <1307518278-23814-12-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEt-0006q0-BB
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823Ab1FHH3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:23 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab1FHH3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:16 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OinCjUDVfSg7+iLdBXnIQPpw3HqboUBcdUcnYTL+4PI=;
        b=LTbML6pQYWk5rbPIAPQgo2iy9mVAk2kgE/unvA+9Z+3uPRYLXpDjlCqUWRLtNaF2v0
         dKtw0bOMIdA1kNSrH19/dnHIFWCLssBTFexrmrDKNyKlehn7sB/doJUEHQQBQe1sYvke
         sNpYC7vJZjkB5PyNR/QwhEXikuECGgJZkXD58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M5QGtC79c6xt9zoar0ybN01ijVjD+46ckZ8Pq6ksDgGfbDlliyN1sMJyh0mvV/rJld
         20nq3yQVhMMZFY8YY6CDlBrwndjirNSTybWApthbo9yBa5wbkDqXt9TfQpQc9G9A0wpm
         rd7T6m/MHkCpKOlwiBCSW/Pb0hSZk9nYWRM74=
Received: by 10.68.19.35 with SMTP id b3mr596471pbe.512.1307518156154;
        Wed, 08 Jun 2011 00:29:16 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.13
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175337>

This test is mostly just designed for testing optimality of the virtual
merge base in the event of a rename/rename(1to2) conflict.  The current
choice for resolving this in git seems somewhat confusing and suboptimal.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh |   76 +++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 4993f67..eee183e 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -545,5 +545,81 @@ test_expect_failure 'git detects conflict and handles merge of E2 & D correctly'
 	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file)
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
+	test 8 -eq $(wc -l < newname)
+'
 
 test_done
-- 
1.7.6.rc0.62.g2d69f
