From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 02/19] reset $pathspec: exit with code 0 if successful
Date: Wed,  9 Jan 2013 00:15:59 -0800
Message-ID: <1357719376-16406-3-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:17:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqqo-0001yR-Dh
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341Ab3AIIRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:17:08 -0500
Received: from mail-gg0-f202.google.com ([209.85.161.202]:45148 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213Ab3AIIRF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:17:05 -0500
Received: by mail-gg0-f202.google.com with SMTP id k1so191066ggn.5
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=AQncJV7PtwTRXHOlnxlJDs+xEoWbKgNg8k2UeheaKSE=;
        b=LN/0BpmKw9xwLrWPn6Ff1mDtsOf3AdyhIv0qethwWM3ipbU96RYuwKlghUoTra7F47
         Vt6ohSBnL1bPeYDOyfrk3Gy9AiSyCRUXwX/zkJ/LnA8HlFuStGOOt7wDmMR1yzvhXiP4
         iFXYvdKb8GK2rIGJ8LlaJzKwOwvzxfUv7mrPufox1590JYhwAikjaq1CjZGoAyEpM9XP
         GKQtilgT5VNkcAFzb5mrU6UW3ed17+uyAJfO7L//q3wim2ICPZaqyFNKFRUOQO/xiioa
         SRBwzEXS0Y/RIfAJy29DJyulXtpewzEH38LYNmX6BVEu6tUHb0oq6Y9ENP/WM3LytS/l
         08Vg==
X-Received: by 10.100.77.19 with SMTP id z19mr9828715ana.27.1357719424340;
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i27si5738650yhe.4.2013.01.09.00.17.04
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 23C1182004A;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id CE3A7100F9D; Wed,  9 Jan 2013 00:17:03 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmJRBhjjAdAQ848EmTKQA/oDibfPg5e+HDjv8RKouqgJRHnfqIHlCDLSdpyZKFwBO6LDAt9VVMX1eoTohMOJPOgJnDRAKq7Wvvsh9HLPhpVndzPiKlyJzfhaDHTZbaXGzLNhGYdMnAsnwQ7osWyKtatBsv20VmlzbOIsLXC71hBYWPQNAGPJ3YO6FUoxp48Jn9OOk6z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213031>

"git reset $pathspec" currently exits with a non-zero exit code if the
worktree is dirty after resetting, which is inconsistent with reset
without pathspec, and it makes it harder to know whether the command
really failed. Change it to exit with code 0 regardless of whether the
worktree is dirty so that non-zero indicates an error.

This makes the 4 "disambiguation" test cases in t7102 clearer since
they all used to "fail", 3 of which "failed" due to changes in the
work tree. Now only the ambiguous one fails.
---
I suppose this makes documenting the exit code unnecessary, since
"return zero iff successful" is probably understood to be the default.

The variable in refresh_index() containing the value to be returned is
called has_errors. I'm guessing I shouldn't take the name too
seriously.

 builtin/reset.c               |  8 +++-----
 t/t2013-checkout-submodule.sh |  2 +-
 t/t7102-reset.sh              | 18 ++++++++++++------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 8cc7c72..65413d0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -119,19 +119,17 @@ static void print_new_head_line(struct commit *commit)
 
 static int update_index_refresh(int fd, struct lock_file *index_lock, int flags)
 {
-	int result;
-
 	if (!index_lock) {
 		index_lock = xcalloc(1, sizeof(struct lock_file));
 		fd = hold_locked_index(index_lock, 1);
 	}
 
-	result = refresh_index(&the_index, (flags), NULL, NULL,
-			       _("Unstaged changes after reset:")) ? 1 : 0;
+	refresh_index(&the_index, (flags), NULL, NULL,
+		      _("Unstaged changes after reset:"));
 	if (write_cache(fd, active_cache, active_nr) ||
 			commit_locked_index(index_lock))
 		return error ("Could not refresh index");
-	return result;
+	return 0;
 }
 
 static void update_index_from_diff(struct diff_queue_struct *q,
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 70edbb3..06b18f8 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -23,7 +23,7 @@ test_expect_success '"reset <submodule>" updates the index' '
 	git update-index --refresh &&
 	git diff-files --quiet &&
 	git diff-index --quiet --cached HEAD &&
-	test_must_fail git reset HEAD^ submodule &&
+	git reset HEAD^ submodule &&
 	test_must_fail git diff-files --quiet &&
 	git reset submodule &&
 	git diff-files --quiet
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index b096dc8..81b2570 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -388,7 +388,8 @@ test_expect_success 'test --mixed <paths>' '
 	echo 4 > file4 &&
 	echo 5 > file1 &&
 	git add file1 file3 file4 &&
-	test_must_fail git reset HEAD -- file1 file2 file3 &&
+	git reset HEAD -- file1 file2 file3 &&
+	test_must_fail git diff --quiet &&
 	git diff > output &&
 	test_cmp output expect &&
 	git diff --cached > output &&
@@ -402,7 +403,8 @@ test_expect_success 'test resetting the index at give paths' '
 	>sub/file2 &&
 	git update-index --add sub/file1 sub/file2 &&
 	T=$(git write-tree) &&
-	test_must_fail git reset HEAD sub/file2 &&
+	git reset HEAD sub/file2 &&
+	test_must_fail git diff --quiet &&
 	U=$(git write-tree) &&
 	echo "$T" &&
 	echo "$U" &&
@@ -440,7 +442,8 @@ test_expect_success 'resetting specific path that is unmerged' '
 		echo "100644 $F3 3	file2"
 	} | git update-index --index-info &&
 	git ls-files -u &&
-	test_must_fail git reset HEAD file2 &&
+	git reset HEAD file2 &&
+	test_must_fail git diff --quiet &&
 	git diff-index --exit-code --cached HEAD
 '
 
@@ -449,7 +452,8 @@ test_expect_success 'disambiguation (1)' '
 	git reset --hard &&
 	>secondfile &&
 	git add secondfile &&
-	test_must_fail git reset secondfile &&
+	git reset secondfile &&
+	test_must_fail git diff --quiet -- secondfile &&
 	test -z "$(git diff --cached --name-only)" &&
 	test -f secondfile &&
 	test ! -s secondfile
@@ -474,7 +478,8 @@ test_expect_success 'disambiguation (3)' '
 	>secondfile &&
 	git add secondfile &&
 	rm -f secondfile &&
-	test_must_fail git reset HEAD secondfile &&
+	git reset HEAD secondfile &&
+	test_must_fail git diff --quiet &&
 	test -z "$(git diff --cached --name-only)" &&
 	test ! -f secondfile
 
@@ -486,7 +491,8 @@ test_expect_success 'disambiguation (4)' '
 	>secondfile &&
 	git add secondfile &&
 	rm -f secondfile &&
-	test_must_fail git reset -- secondfile &&
+	git reset -- secondfile &&
+	test_must_fail git diff --quiet &&
 	test -z "$(git diff --cached --name-only)" &&
 	test ! -f secondfile
 '
-- 
1.8.1.rc3.331.g1ef2165
