From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2] diff: don't read index when --no-index is given
Date: Mon,  9 Dec 2013 21:40:34 +0100
Message-ID: <1386621634-25444-1-git-send-email-t.gummerer@gmail.com>
References: <20131209192000.GS29959@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexey Borzenkov <snaury@gmail.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 21:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7dN-000816-0M
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984Ab3LIUkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:40:49 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:40176 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932976Ab3LIUks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:40:48 -0500
Received: by mail-yh0-f51.google.com with SMTP id c41so3130028yho.38
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 12:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2bZOGN59KaImL5G/PHRSWS9GGMbrsW8nvTxssq4t9Eo=;
        b=NJhum9jHdoZ8jogQZgcg9bK0CRTqc4l71TqtJ+xorEVP7WbVOpAcr7bM07AnVgR+H6
         i8Xt3/KwTvwC4OXN8VkPyaRIF828tZlBut6jGZGAbrE5v83kS+UDl5hU9blYVIzIQBZL
         Wlj9lIXxh/xpNUtcvP6d0ocgeobfhwm0oLf62y0JT9qz0HiejFkutTRL3bnhrHiqLY6/
         LnwYT29GbaSPSaIX46mtbxwkwHWE98r9sXyd3/EgGAtHlerSmLO8le1WH8eGL5jtnCi+
         ZvalcZHMImDBmrYr3pizi5fPpSBOgssjgE4T0SM8cOlci3dHkVdJeGaBe3l5G78tyq4+
         L/2A==
X-Received: by 10.236.143.131 with SMTP id l3mr4527815yhj.95.1386621647578;
        Mon, 09 Dec 2013 12:40:47 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::1267])
        by mx.google.com with ESMTPSA id q9sm18527817yhk.16.2013.12.09.12.40.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2013 12:40:46 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
In-Reply-To: <20131209192000.GS29959@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239091>

git diff --no-index ... currently reads the index, during setup, when
calling gitmodules_config().  This results in worse performance when
the index is not actually needed.  This patch avoids calling
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

Thanks to Jonathan and Jens for comments on the previous round.
Changes:
 - Don't all setup_git_directory_gently when --no-index is given
 - Add performance test
 - Commit message improvements

 builtin/diff.c                | 16 +++++++++++++---
 t/perf/p4001-diff-no-index.sh | 17 +++++++++++++++++
 t/t4053-diff-no-index.sh      |  6 ++++++
 3 files changed, 36 insertions(+), 3 deletions(-)
 create mode 100755 t/perf/p4001-diff-no-index.sh

diff --git a/builtin/diff.c b/builtin/diff.c
index adb93a9..5f09a0b 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -257,7 +257,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int blobs = 0, paths = 0;
 	const char *path = NULL;
 	struct blobinfo blob[2];
-	int nongit;
+	int nongit, no_index = 0;
 	int result = 0;
 
 	/*
@@ -282,9 +282,19 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 *
 	 * Other cases are errors.
 	 */
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--"))
+			break;
+		if (!strcmp(argv[i], "--no-index")) {
+			no_index = 1;
+			break;
+		}
+	}
 
-	prefix = setup_git_directory_gently(&nongit);
-	gitmodules_config();
+	if (!no_index) {
+		prefix = setup_git_directory_gently(&nongit);
+		gitmodules_config();
+	}
 	git_config(git_diff_ui_config, NULL);
 
 	init_revisions(&rev, prefix);
diff --git a/t/perf/p4001-diff-no-index.sh b/t/perf/p4001-diff-no-index.sh
new file mode 100755
index 0000000..81c7aa0
--- /dev/null
+++ b/t/perf/p4001-diff-no-index.sh
@@ -0,0 +1,17 @@
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
+test_perf "diff --no-index" "
+	git diff --no-index $file1 $file2 >/dev/null
+"
+
+test_done
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 979e983..d3dbf6b 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -29,4 +29,10 @@ test_expect_success 'git diff --no-index relative path outside repo' '
 	)
 '
 
+test_expect_success 'git diff --no-index with broken index' '
+	cd repo &&
+	echo broken >.git/index &&
+	git diff --no-index a ../non/git/a &&
+'
+
 test_done
-- 
1.8.5.4.g8639e57
