From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 2/2] diff: don't read index when --no-index is given
Date: Wed, 11 Dec 2013 10:58:43 +0100
Message-ID: <1386755923-22132-2-git-send-email-t.gummerer@gmail.com>
References: <20131210181655.GB2311@google.com>
 <1386755923-22132-1-git-send-email-t.gummerer@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 10:59:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqgZL-0006Ju-R1
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 10:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304Ab3LKJ7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 04:59:00 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:64224 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab3LKJ65 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 04:58:57 -0500
Received: by mail-qa0-f48.google.com with SMTP id w5so421662qac.0
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 01:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qVjys6qncZBhBnCr1cNXJ+I7Gb58OW+AcR37F4fO0mg=;
        b=BrzoW1kXppd9IhAou6cCBQwDNEs4l2Q795FD4HcwOITIA2lYjqLDE+naXm6JnIoRfZ
         c8udEjmo8hSSEENwAPPJHe4/tp3s7789wUkP41fLWOy6OwkgpoWbrt7hDCtRYmJLiAe1
         wV/hVcDiKXWAV4bZN8I85cVB6tCdOK4UNNBC5JzqBtd2L1lZxAcE/l+9xGHj3RxL9kSZ
         7tUbhwpE8tPF2Ow/6byr4a6FFVlmKc3WIRVP3450ZilcL5lLjO+K6gWcqSsFaErHxoGj
         hI/w0CteHo7aLm5x+x2ROM0TPC0jPgEPCWAbP7YUgN3esBHL1m8FVf/n4edmifnNjrsV
         w9PA==
X-Received: by 10.49.38.37 with SMTP id d5mr849162qek.17.1386755937204;
        Wed, 11 Dec 2013 01:58:57 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::589])
        by mx.google.com with ESMTPSA id p20sm55844507qay.0.2013.12.11.01.58.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2013 01:58:56 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
In-Reply-To: <1386755923-22132-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239182>

git diff --no-index ... currently reads the index, during setup, when
calling gitmodules_config().  This results in worse performance when the
index is not actually needed.  This patch avoids calling
gitmodules_config() when the --no-index option is given.  The times for
executing "git diff --no-index" in the WebKit repository are improved as
follows:

Test                      HEAD~3            HEAD
------------------------------------------------------------------
4001.1: diff --no-index   0.24(0.15+0.09)   0.01(0.00+0.00) -95.8%

An additional improvement of this patch is that "git diff --no-index" no
longer breaks when the index file is corrupt, which makes it possible to
use it for investigating the broken repository.

To improve the possible usage as investigation tool for broken
repositories, setup_git_directory_gently() is also not called when the
--no-index option is given.

Also add a test to guard against future breakages, and a performance
test to show the improvements.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/diff.c                |  7 +++++--
 t/perf/p4001-diff-no-index.sh | 22 ++++++++++++++++++++++
 t/t4053-diff-no-index.sh      | 15 +++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100755 t/perf/p4001-diff-no-index.sh

diff --git a/builtin/diff.c b/builtin/diff.c
index da69e4a..ea1dd65 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -298,7 +298,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	prefix = setup_git_directory_gently(&nongit);
+	if (!no_index)
+		prefix = setup_git_directory_gently(&nongit);
+
 	/*
 	 * Treat git diff with at least one path outside of the
 	 * repo the same as if the command would have been executed
@@ -311,7 +313,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			!path_inside_repo(prefix, argv[i + 1]))))
 		no_index = DIFF_NO_INDEX_IMPLICIT;
 
-	gitmodules_config();
+	if (!no_index)
+		gitmodules_config();
 	git_config(git_diff_ui_config, NULL);
 
 	init_revisions(&rev, prefix);
diff --git a/t/perf/p4001-diff-no-index.sh b/t/perf/p4001-diff-no-index.sh
new file mode 100755
index 0000000..683be69
--- /dev/null
+++ b/t/perf/p4001-diff-no-index.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description="Test diff --no-index performance"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+file1=$(git ls-files | tail -n 2 | head -1)
+file2=$(git ls-files | tail -n 1 | head -1)
+
+test_expect_success "empty files, so they take no time to diff" "
+	echo >$file1 &&
+	echo >$file2
+"
+
+test_perf "diff --no-index" "
+	git diff --no-index $file1 $file2 >/dev/null
+"
+
+test_done
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 979e983..077c775 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -29,4 +29,19 @@ test_expect_success 'git diff --no-index relative path outside repo' '
 	)
 '
 
+test_expect_success 'git diff --no-index with broken index' '
+	(
+		cd repo &&
+		echo broken >.git/index &&
+		git diff --no-index a ../non/git/a
+	)
+'
+
+test_expect_success 'git diff outside repo with broken index' '
+	(
+		cd repo &&
+		git diff ../non/git/a ../non/git/b
+	)
+'
+
 test_done
-- 
1.8.5.4.g8639e57
