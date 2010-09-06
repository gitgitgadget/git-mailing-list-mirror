From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/3] t3509: Add rename + D/F conflict testcases that recursive strategy fails
Date: Mon,  6 Sep 2010 14:47:48 -0600
Message-ID: <1283806070-22027-2-git-send-email-newren@gmail.com>
References: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
Cc: gitster@pobox.com, oinksocket@letterboxes.org,
	ken.schalk@intel.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 22:46:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsiaM-00008F-AD
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab0IFUqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 16:46:32 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44616 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088Ab0IFUqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 16:46:30 -0400
Received: by pvg2 with SMTP id 2so1524811pvg.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Dow5Pk3E+WtsRDcxl2vid8A94CTyNQ20W3i7JbGBDww=;
        b=l3ZBCXTSHRpwLGJ6MZn+B84soqeQyAXMv9yTZHfrtF+JyQtghoYxN7fDfe08eyegW0
         8nayoE9mUZzq2k9rSqjR+MoaS34+xzpFWVGuo/eJtYjs26IK3Gn7hcGEAPk1c9BEa0nE
         GeL4qeE8Ih3yVIt5M7UrN244MlTOM8pNXAQcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oUMnhVSK8QBs1uPIMwAC6nR2DRNrpUDtW/xJ63s1vohisUEqV8DOUbRiZ49s9IsT0S
         vYwd495kvmeHN5kKCufFxRMulaDCMv+hHxWbzI4czIcgNQfEpmb5laJkrTZpJjx6ylN8
         9UaNo+//D8yi8KkJZPhQLUxArpDwyNU7GuEUk=
Received: by 10.114.76.3 with SMTP id y3mr4222664waa.11.1283805990548;
        Mon, 06 Sep 2010 13:46:30 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d39sm11973876wam.4.2010.09.06.13.46.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 13:46:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc0.170.g5cfb0.dirty
In-Reply-To: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155616>

When one side of a file rename matches a directory name on the other side,
the recursive merge strategy will fail.  This is true even if the merge is
trivially resolvable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3509-cherry-pick-merge-df.sh |   66 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index a5ccdbf..eb5826f 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -32,4 +32,70 @@ test_expect_success SYMLINKS 'Cherry-pick succeeds with rename across D/F confli
 	git cherry-pick branch
 '
 
+test_expect_success 'Setup rename with file on one side matching directory name on other' '
+	git checkout --orphan nick-testcase &&
+	git rm -rf . &&
+
+	>empty &&
+	git add empty &&
+	git commit -m "Empty file" &&
+
+	git checkout -b simple &&
+	mv empty file &&
+	mkdir empty &&
+	mv file empty &&
+	git add empty/file &&
+	git commit -m "Empty file under empty dir" &&
+
+	echo content >newfile &&
+	git add newfile &&
+	git commit -m "New file"
+'
+
+test_expect_success 'Cherry-pick succeeds with was_a_dir/file -> was_a_dir (resolve)' '
+	git reset --hard &&
+	git checkout -q nick-testcase^0 &&
+	git cherry-pick --strategy=resolve simple
+'
+
+test_expect_failure 'Cherry-pick succeeds with was_a_dir/file -> was_a_dir (recursive)' '
+	git reset --hard &&
+	git checkout -q nick-testcase^0 &&
+	git cherry-pick --strategy=recursive simple
+'
+
+test_expect_success 'Setup rename with file on one side matching different dirname on other' '
+	git reset --hard &&
+	git checkout --orphan mergeme &&
+	git rm -rf . &&
+
+	mkdir sub &&
+	mkdir othersub &&
+	echo content > sub/file &&
+	echo foo > othersub/whatever &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git rm -rf othersub &&
+	git mv sub/file othersub &&
+	git commit -m "Commit to merge" &&
+
+	git checkout -b newhead mergeme~1 &&
+	>independent-change &&
+	git add independent-change &&
+	git commit -m "Completely unrelated change"
+'
+
+test_expect_success 'Cherry-pick with rename to different D/F conflict succeeds (resolve)' '
+	git reset --hard &&
+	git checkout -q newhead^0 &&
+	git cherry-pick --strategy=resolve mergeme
+'
+
+test_expect_failure 'Cherry-pick with rename to different D/F conflict succeeds (recursive)' '
+	git reset --hard &&
+	git checkout -q newhead^0 &&
+	git cherry-pick --strategy=recursive mergeme
+'
+
 test_done
-- 
1.7.3.rc0.170.g5cfb0.dirty
