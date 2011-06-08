From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 10/48] t6036: tests for criss-cross merges with various directory/file conflicts
Date: Wed,  8 Jun 2011 01:30:40 -0600
Message-ID: <1307518278-23814-11-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDH-0005pC-1f
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab1FHH3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43667 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab1FHH3O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:14 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so118978pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=1kmVwB3jkbuZSiOil5AccLvgUTz16qSg4CRRqjDZQg4=;
        b=hkrctxT7QXLR9zNgnwuioY98DWKKQU1Mqaetli/hFmGpvzB1hQ7nF32NOekdtTPB6D
         4PjhhnYrD4xG8R8NXdVx8+3Sm95PwF4/62T7IZobSB+4e5iEavEY8U5saXLSnQ3/jZ2C
         88ENTbaJJwGEKh2KIlC676VbC3mhBb15rFJM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wXaQTqfLTVilSCZl7txjY7UQ6OYtRx1MlN5cytT3mxBmFU/Kd4g3aIQA50Wu/TzFzf
         0e7NrOJY3CzhC1k/fKN/ul6QaeVvoYczJ3HdiZ2Dy9g5vk7HqULFI7ThpIeUbxYJahcT
         XQdvnJxfbV3uW+21zZEgR06cCCnc1K4b2EsGE=
Received: by 10.68.63.100 with SMTP id f4mr730415pbs.339.1307518153846;
        Wed, 08 Jun 2011 00:29:13 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.11
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175309>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh |  149 +++++++++++++++++++++++++++++++++++++
 1 files changed, 149 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index dab52a4..4993f67 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -397,4 +397,153 @@ test_expect_failure 'git detects conflict w/ criss-cross+contrived resolution' '
 	test $(git rev-parse :3:file) = $(git rev-parse E:file)
 '
 
+#
+# criss-cross + d/f conflict via add/add:
+#   Commit A: Neither file 'a' nor directory 'a/' exist.
+#   Commit B: Introduce 'a'
+#   Commit C: Introduce 'a/file'
+# Two different later cases:
+#   Commit D1: Merge B & C, keeping 'a' and deleting 'a/'
+#   Commit E1: Merge B & C, deleting 'a' but keeping 'a/file'
+#
+#   Commit D2: Merge B & C, keeping a modified 'a' and deleting 'a/'
+#   Commit E2: Merge B & C, deleting 'a' but keeping a modified 'a/file'
+#
+#   Note: D == D1.
+# Finally, someone goes to merge D1&E1 or D1&E2 or D2&E1.  What happens?
+#
+#      B   D1 or D2
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E1 or E2
+#
+
+test_expect_success 'setup differently handled merges of directory/file conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	>irrelevant-file &&
+	git add irrelevant-file &&
+	test_tick &&
+	git commit -m A &&
+
+	git branch B &&
+	git checkout -b C &&
+	mkdir a &&
+	echo 10 >a/file &&
+	git add a/file &&
+	test_tick &&
+	git commit -m C &&
+
+	git checkout B &&
+	echo 5 >a &&
+	git add a &&
+	test_tick &&
+	git commit -m B &&
+
+	git checkout B^0 &&
+	test_must_fail git merge C &&
+	git clean -f &&
+	rm -rf a/ &&
+	echo 5 >a &&
+	git add a &&
+	test_tick &&
+	git commit -m D &&
+	git tag D &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	git clean -f &&
+	git rm --cached a &&
+	echo 10 >a/file &&
+	git add a/file &&
+	test_tick &&
+	git commit -m E1 &&
+	git tag E1 &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	git clean -f &&
+	git rm --cached a &&
+	printf "10\n11\n" >a/file &&
+	git add a/file &&
+	test_tick &&
+	git commit -m E2 &&
+	git tag E2
+'
+
+test_expect_failure 'git detects conflict and handles merge of D & E1 correctly' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+	git checkout D^0 &&
+
+	# FIXME: If merge-base could keep both a and a/file in its tree, then
+	# we could this merge would actually be able to succeed.
+	test_must_fail git merge -s recursive E1^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :2:a) = $(git rev-parse B:a)
+'
+
+test_expect_failure 'git detects conflict and handles merge of E1 & D correctly' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+	git checkout E1^0 &&
+
+	# FIXME: If merge-base could keep both a and a/file in its tree, then
+	# we could this merge would actually be able to succeed.
+	test_must_fail git merge -s recursive D^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :3:a) = $(git rev-parse B:a)
+'
+
+test_expect_success 'git detects conflict and handles merge of D & E2 correctly' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+	git checkout D^0 &&
+
+	test_must_fail git merge -s recursive E2^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :2:a) = $(git rev-parse B:a) &&
+	test $(git rev-parse :3:a/file) = $(git rev-parse E1:a/file)
+	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file)
+'
+
+test_expect_failure 'git detects conflict and handles merge of E2 & D correctly' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+	git checkout E2^0 &&
+
+	test_must_fail git merge -s recursive D^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
+	test $(git rev-parse :2:a/file) = $(git rev-parse E1:a/file)
+	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file)
+'
+
+
 test_done
-- 
1.7.6.rc0.62.g2d69f
