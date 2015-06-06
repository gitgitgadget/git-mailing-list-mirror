From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 5/6] am --abort: support aborting to unborn branch
Date: Sat,  6 Jun 2015 19:46:11 +0800
Message-ID: <1433591172-27077-6-git-send-email-pyokagan@gmail.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 13:46:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1CYr-0005Il-TP
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 13:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbbFFLqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 07:46:45 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36235 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbFFLqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 07:46:42 -0400
Received: by pabqy3 with SMTP id qy3so65430266pab.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4h3qtgSmCJKUf+fyyKM/uQxa2LVe79r393RLiPjDk6o=;
        b=tpHxZUJk49ypIbonA2Tq0+6/o7M56CL4OzEi4UEmpMTc+AMIl50lkBeUI4CBn7yQuc
         iYdXHbYNc9VLUjhL1nE00hPpnv4pPu2HazQOFVx8wRGIx1A5l/yc/OPghyj7N9I4UPTP
         0uDQ9yOpuSQr0O1jiYH9ttJ8Jg2TvIo6AGlW8aZV3a5w+tN1u7Ft45M08mrRshlGO+fu
         tjizqEKwmBTSAYgQuzOmBrQXzigBY5975UyZ9jnsu8RGuK5vgShoOxHOt1BbqfzD0O/9
         VczugZ1+9dWkWAsYNdUDWoq1sWzCWQaXGAl+P/O6OCXygOb++NR2hbmZMZvZKHoLMPu4
         Bbcg==
X-Received: by 10.68.131.65 with SMTP id ok1mr13912749pbb.16.1433591201528;
        Sat, 06 Jun 2015 04:46:41 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id on3sm9344587pbc.69.2015.06.06.04.46.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 04:46:39 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270921>

When git-am is first run on an unborn branch, no ORIG_HEAD is created.
As such, any applied commits will remain even after a git am --abort.

To be consistent with the behavior of git am --abort when it is not run
from an unborn branch, we empty the index, and then destroy the branch
pointed to by HEAD if there is no ORIG_HEAD.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-am.sh           |  9 ++++++++-
 t/t4151-am-abort.sh | 17 +++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index e4fe3ed..95f90a0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -524,7 +524,14 @@ then
 			index_tree=$(git write-tree) &&
 			orig_head=$(git rev-parse --verify -q ORIG_HEAD || echo $empty_tree) &&
 			git read-tree -m -u $index_tree $orig_head
-			git reset ORIG_HEAD
+			if git rev-parse --verify -q ORIG_HEAD >/dev/null 2>&1
+			then
+				git reset ORIG_HEAD
+			else
+				git read-tree $empty_tree
+				curr_branch=$(git symbolic-ref HEAD 2>/dev/null) &&
+				git update-ref -d $curr_branch
+			fi
 		fi
 		rm -fr "$dotest"
 		exit ;;
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 2366042..b2a7fc5 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -14,6 +14,7 @@ test_expect_success setup '
 	git add file-1 file-2 &&
 	git commit -m initial &&
 	git tag initial &&
+	git format-patch --stdout --root initial >initial.patch &&
 	for i in 2 3 4 5 6
 	do
 		echo $i >>file-1 &&
@@ -125,4 +126,20 @@ test_expect_success 'am -3 --abort removes otherfile-4 on unborn branch' '
 	test_path_is_missing otherfile-4
 '
 
+test_expect_success 'am -3 --abort on unborn branch removes applied commits' '
+	git checkout -f --orphan orphan &&
+	git reset &&
+	rm -f otherfile-4 otherfile-2 file-1 file-2 &&
+	test_must_fail git am -3 initial.patch 0003-*.patch &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 4 = "$(cat otherfile-4)" &&
+	git am --abort &&
+	test -z "$(git ls-files -u)" &&
+	test_path_is_missing otherfile-4 &&
+	test_path_is_missing file-1 &&
+	test_path_is_missing file-2 &&
+	test 0 -eq $(git log --oneline 2>/dev/null | wc -l) &&
+	test refs/heads/orphan = "$(git symbolic-ref HEAD)"
+'
+
 test_done
-- 
2.1.4
