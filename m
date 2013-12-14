From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 2/2] diff: don't read index when --no-index is given
Date: Sat, 14 Dec 2013 14:07:21 +0100
Message-ID: <1387026441-14539-2-git-send-email-t.gummerer@gmail.com>
References: <20131214004347.GZ2311@google.com>
 <1387026441-14539-1-git-send-email-t.gummerer@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 14:07:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrowN-0004Jc-Aj
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 14:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab3LNNHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 08:07:22 -0500
Received: from mail-bk0-f48.google.com ([209.85.214.48]:53867 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab3LNNHU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 08:07:20 -0500
Received: by mail-bk0-f48.google.com with SMTP id r7so1751080bkg.35
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 05:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ohr/6vPbWDMsPaH8mzYwpSS87g+kMGP+YVvc1qATUkI=;
        b=Y7XrtNPLVvtMx88IK6CBtotU7gd7Yodcoh5QhayOEhE00SyAyfIHQVFHsAivTwcgYk
         QKb3wg5p5/NS/X/GcPUEcMNmgULQ/32U9DcNWtSBMRmyslFEIlOQAqTihmWQgCPd9xUM
         Vf6gCub2AgVnN1KC7jQrDbcEU15YPAWlzy0W4iG+WWTNLOPVF0uY4dgR/InYKi3W48dn
         JDL/BU9J6PQcBqKub+UBwoBirL+J7PLylhMGRRSpgdwZkEVw92GDRGGB1ty/Ha4xJ4xR
         KaGzFmrvfOlTBFn8+mlrOb4bYPpe8AnmRfd0It09E3C+yW+x51COu90FEgzjk6Da1Jxx
         +mKQ==
X-Received: by 10.204.123.199 with SMTP id q7mr1859271bkr.10.1387026439664;
        Sat, 14 Dec 2013 05:07:19 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::103b])
        by mx.google.com with ESMTPSA id j6sm4751070bki.17.2013.12.14.05.07.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Dec 2013 05:07:18 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
In-Reply-To: <1387026441-14539-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239307>

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

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/diff.c                |  5 +++--
 t/perf/p4001-diff-no-index.sh | 22 ++++++++++++++++++++++
 t/t4053-diff-no-index.sh      | 15 +++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100755 t/perf/p4001-diff-no-index.sh

diff --git a/builtin/diff.c b/builtin/diff.c
index f49a938..a8569a4 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -298,8 +298,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	prefix = setup_git_directory_gently(&nongit);
 	if (!no_index) {
+		prefix = setup_git_directory_gently(&nongit);
 		/*
 		 * Treat git diff with at least one path outside of the
 		 * repo the same as if the command would have been executed
@@ -313,7 +313,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			no_index = DIFF_NO_INDEX_IMPLICIT;
 	}
 
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
