From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/2] diff: don't read index when --no-index is given
Date: Tue, 10 Dec 2013 18:52:15 +0100
Message-ID: <1386697935-18635-2-git-send-email-t.gummerer@gmail.com>
References: <xmqqwqjdydga.fsf@gitster.dls.corp.google.com>
 <1386697935-18635-1-git-send-email-t.gummerer@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexey Borzenkov <snaury@gmail.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 10 18:53:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqRUm-0007VM-H4
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 18:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab3LJRxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 12:53:15 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:46172 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab3LJRxO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 12:53:14 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so4128016yha.17
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 09:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i79iZTJ+rd8rZoAofWb5H36zB1bDsQG/eoUZ5/F1msk=;
        b=fCNkfXHJc7RTRG7L7dtzQsPeawAZJidsQhrUvvx5POV9GPtC69w+kSHVWBj8Ja04Tl
         34cWuyU/p8gAq7kHXXI/cYuajYG4s3MD1Zsr0JmLuHIDE/NRrI80gnN6EAKcVdwIZHcd
         Ilw9us4FsG/TCi3Zz9KRAPv9wpgPX12IKTyEpS3yyxu0EYuJCQFS2rAsuTI1LCEUwwTv
         Jh9WpbA5Dqn+CoSdcjKEQZubqiZo/G58Zi6hPLDTNyh4RdCQKbcvhp4Lb1ZflQ3M5Gx9
         aQ5goRT5xIfmLtjrhlyaXhKphsE2PxVcutk/xLBqjxDOq46xinF0kUbegeeWJ0e7ne92
         n3DQ==
X-Received: by 10.236.28.162 with SMTP id g22mr8381087yha.52.1386697993571;
        Tue, 10 Dec 2013 09:53:13 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::f5b])
        by mx.google.com with ESMTPSA id w8sm7937159yhg.8.2013.12.10.09.53.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2013 09:53:13 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
In-Reply-To: <1386697935-18635-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239141>

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
 t/perf/p4001-diff-no-index.sh | 17 +++++++++++++++++
 t/t4053-diff-no-index.sh      | 15 +++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100755 t/perf/p4001-diff-no-index.sh

diff --git a/builtin/diff.c b/builtin/diff.c
index 7220b2c..9ce8bec 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -295,7 +295,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	prefix = setup_git_directory_gently(&nongit);
+	if (!no_index)
+		prefix = setup_git_directory_gently(&nongit);
+
 	/*
 	 * Treat git diff with at least one path outside of the
 	 * repo the same as if the command would have been executed
@@ -305,7 +307,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 */
 	nongit |= (argc == i + 2) && !(path_inside_repo(prefix, argv[i]) &&
 				       path_inside_repo(prefix, argv[i + 1]));
-	gitmodules_config();
+	if (!no_index && !nongit)
+		gitmodules_config();
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
