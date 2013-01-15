From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 02/19] reset $pathspec: exit with code 0 if successful
Date: Mon, 14 Jan 2013 21:47:34 -0800
Message-ID: <1358228871-7142-3-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:49:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzOR-0007EL-2p
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820Ab3AOFsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:48:36 -0500
Received: from mail-qc0-f202.google.com ([209.85.216.202]:43824 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab3AOFs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:48:28 -0500
Received: by mail-qc0-f202.google.com with SMTP id s25so588896qcq.5
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=eaCryi77HGZFsVRgARNZLHD3rIObfHX2+MVSe0VAm/k=;
        b=OQp6KZDL/EAm8n47LxrN48y7cJudlK8JeLniOKxqVcxEmDFC7/W4oZ1rEl+aGskmM9
         LmXGp/PwF0VnGQxS7OiguR8PtAu1q3OjyRXtftKLYYqmWb5UBz+CTnDm82/RMlc//ei/
         Y1IYf68yENPEUIdBvP7OfcWNhUyIHx0wa6rY7RAvIv0zJZQpiG+ae36JebCtiTGPeRzf
         IESZlet7X5/qrY/5v35oVsMYnkasTdjr/3U16mxz+tCASG8ia0A+LJUa/TyBREugrWx2
         8zOyrafFMsL+JQR0lRuR/qfZRx8zb7iERMw3RlGHXRn91jq8JknKQAMVgY4lGgUUKq3V
         JmTA==
X-Received: by 10.101.165.39 with SMTP id s39mr12700433ano.18.1358228907072;
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id s58si817819yhi.6.2013.01.14.21.48.27
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 4B8CA100048;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id EED48101465; Mon, 14 Jan 2013 21:48:25 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlW52KlAaX+ew7uTT24Zvx8QfaQkN7lGE1leR1StSFXtdDN2zE2eysE6Wev3SqR8QHPZM8xFodgM4Rtx8jYvWMPg6G592+H4d+8KWCTdPIHgdUq9cWE3UWOs+MeGcmzZThOJ0l+dpeUdxddNFlVejFX9O/KRg4Nvv+3gy2UF9xavsQ+cIMkncJedeKbV57hDSgJJX5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213579>

"git reset $pathspec" currently exits with a non-zero exit code if the
worktree is dirty after resetting, which is inconsistent with reset
without pathspec, and it makes it harder to know whether the command
really failed. Change it to exit with code 0 regardless of whether the
worktree is dirty so that non-zero indicates an error.

This makes the 4 "disambiguation" test cases in t7102 clearer since
they all used to "fail", 3 of which "failed" due to changes in the
work tree. Now only the ambiguous one fails.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
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
1.8.1.1.454.gce43f05
