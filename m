From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 1/2] mergetool: support delete/delete conflicts
Date: Wed,  9 Mar 2016 23:13:58 -0800
Message-ID: <1457594039-22629-1-git-send-email-davvid@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Joe Einertson <joe@kidblog.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 08:14:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adunQ-0003ak-V0
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 08:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935069AbcCJHOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 02:14:05 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34586 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932692AbcCJHOD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 02:14:03 -0500
Received: by mail-pf0-f177.google.com with SMTP id 129so61926748pfw.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 23:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1rLaLYbIV3wzEqNP5GY6w9DEBnHg8VKYotO8v0qSwYA=;
        b=rvgB1KPGnLJiX1nOzMJ7axXRaknuBYdaItsDZ0ezg2TGR1tT20CPGdLEj0JWoI0yLP
         SJJcaspan9q3X6cvUQ2D9Nob8fyOv6L4rq9ZwxhLzA3uPICdqdgJ+hSMbWApKomGXW4Q
         642VjKgCZbfy8QPJbWqn5J+s24/pRk6uND2DINaLxuGsNNg3+YiGqo8tc+BHzqdwbMYN
         Kc43kr/XZRd3UIVflX8HonV+LiqVBZ9tPrg2g1wTPIuXv1i3bBZksDyc2TaCXRXSNybP
         6yMUAX/7v63mT/6A1uNHIgjab42yfMGPgS1WAf48JmCJcHBH1Lk+uDDUaharwxYcRKOW
         eAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1rLaLYbIV3wzEqNP5GY6w9DEBnHg8VKYotO8v0qSwYA=;
        b=GBymHRIWXmcDjM+RI1Eu6mEbzuxI8dD2UoJJMkFjLm/MtegQeYZY4BROXTn/nDYJ4e
         FZo08WxY+Q4A88EpSHIk/yWXh8Ha+d6xjT7+l5HbPAbxOZa8SRUArfAW4ye6O0zDVhOR
         xexWXNfYW4WNAYHq8W3MvmiIVV4Ni6ZgEyrxJfsU37fSJAS8+e9tlMZpTYcRApLofrkZ
         n9PfioqiOKyO94mxSJ2ad3ptB2UPFBqZ9Z9qQuDFhtQMtHI91WeR3GtOp/xg46rdw3i1
         8p6GHGvFWfw1rCKT9QNUb6jxGUWxLMIvlMXdDOwOzFxaRcJqFY7s0LxIkFTREqDqrz7C
         ZvaQ==
X-Gm-Message-State: AD7BkJKKPVgXUY1C27BvRDWStwf1Hb2prjPR4wMszKER+eLx3H5B01lE3tk/JPQXRANkzQ==
X-Received: by 10.98.67.199 with SMTP id l68mr2842892pfi.18.1457594041996;
        Wed, 09 Mar 2016 23:14:01 -0800 (PST)
Received: from raptor.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by smtp.gmail.com with ESMTPSA id 9sm2929872pfm.10.2016.03.09.23.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 23:14:01 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc1.2.gb8cabf0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288596>

If two branches each move a file into different directories then
mergetool will fail because it assumes that the file being merged, and
its parent directory, are present in the worktree.

Create the merge file's parent directory to allow using the
deleted base version of the file for merge resolution when
encountering a delete/delete conflict.

The end result is that a delete/delete conflict is presented for the
user to resolve.

Reported-by: Joe Einertson <joe@kidblog.org>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Rebased to include tests and test fixes.

The series was also reordered so that this patch comes first
since it made the tests easier to incrementally update.

 git-mergetool.sh     | 14 +++++++++++---
 t/t7610-mergetool.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9f77e3a..b06ae78 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -282,8 +282,14 @@ merge_file () {
 		return
 	fi
 
-	mv -- "$MERGED" "$BACKUP"
-	cp -- "$BACKUP" "$MERGED"
+	if test -f "$MERGED"
+	then
+		mv -- "$MERGED" "$BACKUP"
+		cp -- "$BACKUP" "$MERGED"
+	fi
+	# Create a parent directory to handle delete/delete conflicts
+	# where the base's directory no longer exists.
+	mkdir -p "$(dirname "$MERGED")"
 
 	checkout_staged_file 1 "$MERGED" "$BASE"
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
@@ -295,7 +301,9 @@ merge_file () {
 		describe_file "$local_mode" "local" "$LOCAL"
 		describe_file "$remote_mode" "remote" "$REMOTE"
 		resolve_deleted_merge
-		return
+		status=$?
+		rmdir -p "$(dirname "$MERGED")" 2>/dev/null
+		return $status
 	fi
 
 	if is_symlink "$local_mode" || is_symlink "$remote_mode"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 6f12b23..39469d9 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -243,6 +243,45 @@ test_expect_success 'mergetool takes partial path' '
 	git reset --hard
 '
 
+test_expect_success 'mergetool delete/delete conflict' '
+	git checkout -b delete-base branch1 &&
+	mkdir -p a/a &&
+	(echo one; echo two; echo 3; echo 4) >a/a/file.txt &&
+	git add a/a/file.txt &&
+	git commit -m"base file" &&
+	git checkout -b move-to-b delete-base &&
+	mkdir -p b/b &&
+	git mv a/a/file.txt b/b/file.txt &&
+	(echo one; echo two; echo 4) >b/b/file.txt &&
+	git commit -a -m"move to b" &&
+	git checkout -b move-to-c delete-base &&
+	mkdir -p c/c &&
+	git mv a/a/file.txt c/c/file.txt &&
+	(echo one; echo two; echo 3) >c/c/file.txt &&
+	git commit -a -m"move to c" &&
+	test_must_fail git merge move-to-b &&
+	echo d | git mergetool a/a/file.txt &&
+	! test -f a/a/file.txt &&
+	git reset --hard HEAD &&
+	test_must_fail git merge move-to-b &&
+	echo m | git mergetool a/a/file.txt &&
+	test -f b/b/file.txt &&
+	git reset --hard HEAD &&
+	test_must_fail git merge move-to-b &&
+	! echo a | git mergetool a/a/file.txt &&
+	! test -f a/a/file.txt &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'mergetool produces no errors when keepBackup is used' '
+	test_config mergetool.keepBackup true &&
+	test_must_fail git merge move-to-b &&
+	: >expect &&
+	echo d | git mergetool a/a/file.txt 2>actual &&
+	test_cmp expect actual &&
+	git reset --hard HEAD
+'
+
 test_expect_success 'deleted vs modified submodule' '
 	git checkout -b test6 branch1 &&
 	git submodule update -N &&
-- 
2.8.0.rc1.2.gb8cabf0
