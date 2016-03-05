From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] mergetool: support delete/delete conflicts
Date: Fri,  4 Mar 2016 22:39:08 -0800
Message-ID: <1457159948-10645-2-git-send-email-davvid@gmail.com>
References: <1457159948-10645-1-git-send-email-davvid@gmail.com>
Cc: Joe Einertson <joe@kidblog.org>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 05 07:39:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac5s4-0004UB-A2
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 07:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbcCEGjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 01:39:17 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35513 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbcCEGjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 01:39:15 -0500
Received: by mail-pf0-f179.google.com with SMTP id x188so23932149pfb.2
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 22:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/3bKAnvl+7x3RivAbncdbu0n5Q+DMz8Kw2jtpbuESFY=;
        b=TTWmW4Gd1oxQ8TGVSzdQvudAMHkAhgZ+2Qr83o5Sn7YFYR7YpvqC39fyEWs9MeJWZi
         9MS0yhdPcwW1J3vwS1KfwVFZkwOVB+tAtRKZC8uaJWYcGrrPh0cvP4QMQDT/Z/eXAU6A
         rWSiJ1uHpq+K/26xEU2eTd+ItqVAtMETwiYAmgTxO5aw634ai70SOLZGdT+MPQABS5fm
         cBImO/p2+zmwoUjMZ4bloyVtHktFl8th7wW+Di3YM6iTviV9sxwYdFMBwAn+qjX19GfN
         xwFiEdasS7BWHrPHBZwh+9fzmTHSFxi729FU0++ibaN5wwEhREJVWrbkYxLZeZfHAnd7
         HpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/3bKAnvl+7x3RivAbncdbu0n5Q+DMz8Kw2jtpbuESFY=;
        b=F0TD/woc5ItpywZexHKYGbVlII6ZAqxE54RmHBdHQyokH5cuOjNL5ETQZscHg0PjTd
         +fYvQWFLwSNJvBAqx5zYX+FMZicMc/GQUXmBnYSK5MguX5x1xHXuOnkD5zTV8Fo1c96f
         VmGlOjb3YOkXHOgqMzSuCf9kGTvb1ezfi7Bc9Jqa8+nOq/Yc/eSIkf4c18RS+RcSMt9h
         A95njRl4u+65iovedlueKAZSmndHklSfXXje46fWe0cdQ2ohA5v9yx3LfU0iibOt4c44
         ZmatkIhEphzm47RI4mA0vU9azKsVeVn6PvD6+GdGJs+g88NJOH1/vwuT/2wpLP7cgGLg
         yemw==
X-Gm-Message-State: AD7BkJI5i/NGyoVtq5yo5hAs6W/GDmxXCdgAelHWNJZ7yyYmpzzrUEJg34Sik9Q1KuQyEA==
X-Received: by 10.98.16.150 with SMTP id 22mr17940979pfq.128.1457159954720;
        Fri, 04 Mar 2016 22:39:14 -0800 (PST)
Received: from localhost.localdomain ([166.170.36.242])
        by smtp.gmail.com with ESMTPSA id xn8sm9759612pab.15.2016.03.04.22.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 22:39:13 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc1.2.g28ba210
In-Reply-To: <1457159948-10645-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288297>

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
 git-mergetool.sh     | 14 +++++++++++---
 t/t7610-mergetool.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 615265d..000f167 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -291,8 +291,14 @@ merge_file () {
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
@@ -304,7 +310,9 @@ merge_file () {
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
index 6f12b23..f1668be 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -243,6 +243,36 @@ test_expect_success 'mergetool takes partial path' '
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
+	! git merge move-to-b &&
+	echo d | git mergetool a/a/file.txt &&
+	! test -f a/a/file.txt &&
+	git reset --hard HEAD &&
+	! git merge move-to-b &&
+	echo m | git mergetool a/a/file.txt &&
+	test -f b/b/file.txt &&
+	git reset --hard HEAD &&
+	! git merge move-to-b &&
+	! echo a | git mergetool a/a/file.txt &&
+	! test -f a/a/file.txt &&
+	git reset --hard HEAD
+'
+
 test_expect_success 'deleted vs modified submodule' '
 	git checkout -b test6 branch1 &&
 	git submodule update -N &&
-- 
2.8.0.rc1.2.g28ba210
