From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 07/18] Add testcase for --index-only merges with the resolve strategy
Date: Thu,  7 Apr 2016 23:58:35 -0700
Message-ID: <1460098726-5958-8-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 09:00:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQOj-0002y6-FN
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 09:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475AbcDHG7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:46 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36275 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900AbcDHG7L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:11 -0400
Received: by mail-pa0-f67.google.com with SMTP id k3so4759196pav.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kWp1SyQynd2EPT3d1wlUs2P3T7xIT5kXSgROaookeTg=;
        b=z0ZNT+gunnr705HyK+EWGPS0l1b66WHgMV0jqhl5gQXbWdMGHEYOCuR5FZyYgQez+g
         pnOV48/Y5k0syj9pDnquCqZ5CzqzlIGO+DezhFzaGLcHTJ8jiGYExMUWM7I2IH3S770Z
         toX/iY2jD4VtBVMEZxvjZbToopgekfte8Q9kqiIxMGrOp7xgr1K5mkk2eCP+XGiH8JE7
         rpDS5sc9Bmic98eT8JntlZ8JzwubhwF70Uqyq1MzG0oplHmvQUMyM62AlDHXLMiQZNoL
         agdsNUhQ7Klj83aZuyGC3Sd1FRMFzCgvqM8Nhechj7igAc03p0plm0qCztjLrRagn3Q8
         oj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kWp1SyQynd2EPT3d1wlUs2P3T7xIT5kXSgROaookeTg=;
        b=ZJMcXoIi9LuHEi2SG5QZjrxT66yIAsKrppm9rqxMFU20RiCxdKe+VEwPmnXD6qrFfB
         5PgWf4QGP3DC10GvixrOTWT2XjLkJND0rMkMqJuqQLHMj/Cyb7xevQU8fn+V75NTWypq
         wJa0O6BUpHNCL57O4shDyLH1JXnr5lXzNx1Ev3Or87NgLXpKClIDM7FpxxUyMXOjO5JT
         N4jIMkEbo5Jtd/b4X6Y7RHcmc+BSloUHFfgmcRx1RROBWr+Svtxs+21WMfdpgYPlP/c4
         6oJlr/HTWprugJTtkZ9xUVg6l3/VKF4O4FgYkR2ZmiE5eSyo32px34UAvyCh5r3msQz4
         PicQ==
X-Gm-Message-State: AD7BkJJD15oJ6+bU731SP+e9mivwxIdVgwgg78GlKTYNsZO1pY8R5o9iffqiPUCqX1goaA==
X-Received: by 10.66.255.65 with SMTP id ao1mr10527881pad.38.1460098745638;
        Thu, 07 Apr 2016 23:59:05 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:04 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291013>

Including both tests which can be handled without calling the actual
git-merge-resolve program (because the merge is trivially resolvable
without worrying about 3-way file merges), and ones that do need it to be
invoked.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-index-only.sh | 104 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 4 deletions(-)

diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
index 67c8e92..4c3c40a 100755
--- a/t/t6043-merge-index-only.sh
+++ b/t/t6043-merge-index-only.sh
@@ -167,14 +167,22 @@ test_expect_failure 'recursive --index-only in bare repo' '
 	)
 '
 
-# Testcase for a simple ff update
+# Testcase for some simple merges
 #   A
-#   o-----o E
-#
+#   o-----o B
+#    \
+#     \---o C
+#      \
+#       \-o D
+#        \
+#         o E
 #   Commit A: some file a
+#   Commit B: adds file b, modifies end of a
+#   Commit C: adds file c
+#   Commit D: adds file d, modifies beginning of a
 #   Commit E: renames a->subdir/a, adds subdir/e
 
-test_expect_success 'setup simple ff update' '
+test_expect_success 'setup simple merges' '
 	git reset --hard &&
 	git rm -rf . &&
 	git clean -fdqx &&
@@ -186,8 +194,28 @@ test_expect_success 'setup simple ff update' '
 	test_tick && git commit -m A &&
 
 	git branch A &&
+	git branch B &&
+	git branch C &&
+	git branch D &&
 	git branch E &&
 
+	git checkout B &&
+	echo b >b &&
+	echo 11 >>a &&
+	git add a b &&
+	test_tick && git commit -m B &&
+
+	git checkout C &&
+	echo c >c &&
+	git add c &&
+	test_tick && git commit -m C &&
+
+	git checkout D &&
+	seq 2 10 >a &&
+	echo d >d &&
+	git add a d &&
+	test_tick && git commit -m D &&
+
 	git checkout E &&
 	mkdir subdir &&
 	git mv a subdir/a &&
@@ -237,4 +265,72 @@ test_expect_failure '--index-only ff update, non-bare with uncommitted changes'
 	test ! -d subdir
 '
 
+test_expect_failure '--index-only w/ resolve, trivial, non-bare' '
+	git clean -fdx &&
+	git reset --hard &&
+	git checkout B^0 &&
+
+	git merge --index-only -s resolve C^0 | grep Wonderful &&
+
+	test "$(git rev-list --count HEAD)" -eq 4 &&
+	test $(git rev-parse :a) = $(git rev-parse B:a) &&
+	test $(git rev-parse :b) = $(git rev-parse B:b) &&
+	test $(git rev-parse :c) = $(git rev-parse C:c) &&
+	test ! -f c
+'
+
+test_expect_failure '--index-only w/ resolve, trivial, bare' '
+	rm -rf bare.clone &&
+	git clone --bare . bare.clone &&
+	(cd bare.clone &&
+
+	 git update-ref --no-deref HEAD B &&
+	 git read-tree HEAD &&
+
+	 git merge --index-only -s resolve C^0 | grep Wonderful &&
+
+	 test "$(git rev-list --count HEAD)" -eq 4 &&
+	 test $(git rev-parse :a) = $(git rev-parse B:a) &&
+	 test $(git rev-parse :b) = $(git rev-parse B:b) &&
+	 test $(git rev-parse :c) = $(git rev-parse C:c) &&
+	 test ! -f a &&
+	 test ! -f b &&
+	 test ! -f c
+	)
+'
+
+test_expect_failure '--index-only w/ resolve, non-trivial, non-bare' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	git merge --index-only -s resolve D^0 &&
+
+	test "$(git rev-list --count HEAD)" -eq 4 &&
+	test $(git rev-parse :a) != $(git rev-parse B:a) &&
+	test $(git rev-parse :a) != $(git rev-parse D:a) &&
+	test $(git rev-parse :b) = $(git rev-parse B:b) &&
+	test $(git rev-parse :d) = $(git rev-parse D:d) &&
+	test $(git hash-object a) = $(git rev-parse B:a) &&
+	test ! -f d
+'
+
+test_expect_failure '--index-only w/ resolve, non-trivial, bare' '
+	rm -rf bare.clone &&
+	git clone --bare . bare.clone &&
+	(cd bare.clone &&
+
+	 git update-ref --no-deref HEAD B &&
+	 git read-tree HEAD &&
+
+	 git merge --index-only -s resolve D^0 &&
+
+	 test "$(git rev-list --count HEAD)" -eq 4 &&
+	 test $(git rev-parse :a) != $(git rev-parse B:a) &&
+	 test $(git rev-parse :a) != $(git rev-parse D:a) &&
+	 test $(git rev-parse :b) = $(git rev-parse B:b) &&
+	 test $(git rev-parse :d) = $(git rev-parse D:d) &&
+	 test ! -f a
+	)
+'
+
 test_done
-- 
2.8.0.18.gc685494
