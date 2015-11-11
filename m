From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH 5/5] ff-refs: Add tests
Date: Tue, 10 Nov 2015 21:11:25 -0500
Message-ID: <1447207885-10911-6-git-send-email-rappazzo@gmail.com>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net,
	dturner@twopensource.com, pclouds@gmail.com,
	sunshine@sunshineco.com, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 11 03:13:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwKun-0007SP-1e
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 03:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbbKKCN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 21:13:28 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36108 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbbKKCN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 21:13:26 -0500
Received: by ykdr82 with SMTP id r82so28099574ykd.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 18:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D9hifd57HVLSp26hegJk1etQK8bxvCarstL+FSTMYYY=;
        b=LrGDEuaTxGJD2NmJ3Yek/1V2xy4pid8B7gRMCnxERjVAAWYRXRe0pdIXm+Mu421toI
         vEkgDpDMM8mH5YlnFNT17jpTuSN5UPZYYWhOE1Sf6wBnZuSsk+UxDre3rEQZSB1A+azi
         cQVBYm8iC2Pi7TPfeuX2T3Rk3+TN85hNCJHEbIkJG6vBsHnSBD+H1T+bkF8Nkw7Ft0Ww
         NEHklvbx73c4sT+t25QgsGZWjZWiyFfqUs52yguFTl6teFcOCNB8W6WSgiAKGa6heCOc
         i+pucRg5QFwrMCD40gnVXx7Jy/Ata1ghDzQMG0R9ZkEWZG+Y0KFa5SVxeXWjO8hQgsyH
         lEZQ==
X-Received: by 10.129.53.132 with SMTP id c126mr6563164ywa.108.1447208004888;
        Tue, 10 Nov 2015 18:13:24 -0800 (PST)
Received: from localhost.localdomain (ool-18e4990e.dyn.optonline.net. [24.228.153.14])
        by smtp.gmail.com with ESMTPSA id m128sm7948819ywm.34.2015.11.10.18.13.23
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Nov 2015 18:13:24 -0800 (PST)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281148>

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 t/t7900-ff-refs.sh | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100755 t/t7900-ff-refs.sh

diff --git a/t/t7900-ff-refs.sh b/t/t7900-ff-refs.sh
new file mode 100755
index 0000000..3cfbcb8
--- /dev/null
+++ b/t/t7900-ff-refs.sh
@@ -0,0 +1,164 @@
+#!/bin/sh
+
+# SKIPPED
+
+test_description='test ff-refs'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit init &&
+	for i in $(test_seq 1 9)
+	do
+		echo "data" >file_$i &&
+		git add file_$i &&
+		git commit -m"Commit $i" &&
+		git branch br_$i
+	done
+'
+
+test_expect_success 'UP-TO-DATE for equal branch' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git ff-refs >actual &&
+		grep "UP-TO-DATE" actual
+	)
+'
+
+test_expect_success 'UP-TO-DATE for ahead local branch' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git ff-refs >actual &&
+		echo "data" >file_new &&
+		git add file_new &&
+		git commit -m"Commit new" &&
+		grep "UP-TO-DATE" actual
+	)
+'
+
+test_expect_success 'REMOTE-MISSING by local config change' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git config --replace branch.master.merge refs/heads/nothing &&
+		git ff-refs >actual &&
+		grep "REMOTE-MISSING" actual
+	)
+'
+
+test_expect_success 'NON-FAST-FORWARD for diverged branch' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git reset --hard origin/br_3 &&
+		echo "data" >file_new &&
+		git add file_new &&
+		git commit -m"Commit new" &&
+		git ff-refs >actual &&
+		grep "NON-FAST-FORWARD" actual
+	)
+'
+
+test_expect_success 'UPDATED for fast-forwardable branch' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git reset --hard origin/br_3 &&
+		git ff-refs >actual &&
+		grep "UPDATED" actual
+	)
+'
+
+test_expect_success 'WOULD-UPDATE for dry-run on fast-forwardable branch' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git reset --hard origin/br_3 &&
+		git ff-refs --dry-run >actual &&
+		grep "WOULD-UPDATE" actual
+	)
+'
+
+test_expect_success 'SKIPPED for skip-worktrees on fast-forwardable branch' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git reset --hard origin/br_3 &&
+		git ff-refs --skip-worktrees >actual &&
+		grep "SKIPPED" actual
+	)
+'
+
+test_expect_success 'WOULD-SKIP for dry-run, skip-worktrees on fast-forwardable branch' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git reset --hard origin/br_3 &&
+		git ff-refs --dry-run --skip-worktrees >actual &&
+		grep "WOULD-SKIP" actual
+	)
+'
+
+test_expect_success 'UPDATE for fast-forwardable, not checked-out branch' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git reset --hard origin/br_3 &&
+		git checkout -b other origin/br_3 &&
+		git ff-refs >actual &&
+		grep "master" actual | grep "UPDATED"
+	)
+'
+
+test_expect_success 'UPDATE for fast-forwardable, not checked-out branch using --skip-worktrees' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git reset --hard origin/br_3 &&
+		git checkout -b other origin/br_3 &&
+		git ff-refs --skip-worktrees >actual &&
+		grep "master" actual | grep "UPDATED"
+	)
+'
+
+test_expect_success 'UPDATE multiple' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git reset --hard origin/br_3 &&
+		git checkout -b other origin/br_5 &&
+		git reset --hard origin/br_3 &&
+		git ff-refs >actual &&
+		grep "master" actual | grep "UPDATED" &&
+		grep "other" actual | grep "UPDATED"
+	)
+'
+
+test_expect_success 'UPDATE one, skip worktree on another' '
+	test_when_finished "rm -rf local" &&
+	git clone . local &&
+	(
+		cd local &&
+		git reset --hard origin/br_3 &&
+		git checkout -b other origin/br_5 &&
+		git reset --hard origin/br_3 &&
+		git ff-refs --skip-worktrees >actual &&
+		grep "master" actual | grep "UPDATED" &&
+		grep "other" actual | grep "SKIPPED"
+	)
+'
+
+test_done
-- 
2.6.2
