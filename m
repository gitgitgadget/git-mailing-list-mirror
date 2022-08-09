Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E5CC25B08
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbiHITJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbiHITJH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1421F624
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j7so15333867wrh.3
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Tb0RwUZ46/MxCQYiDDQvnRO982rWhA3+X/4oEcbOulo=;
        b=iJwVN1YYSAKoJ7d5AJgKdIRgIfdL9Wu8lioDrQSotDMg2S4rAmXfq1+M5xF2MoH2Cs
         BXxMpiSkQQKgCevKzmURHFM9CiLvJ7Lsscr5S94m8YMd9IhxLnF2Ec1JFIHCpC1oPq2H
         OgSEs5SM4ktprc03EAvBxwo7ZKXJyzmGe9xggMjH291qkPf/BOuEKmBW6TQQ8EoQdhg6
         O48npMmavpB7sVGy6IA0ts7pgrjTfrJ58wE+WM5rW/Tvvv0aW6tYr6xxBha6FTePwFev
         sbvISAoIgtRuydvV7kXeTpPBw65MIPbqvbGaRJOcl5U3MLSrlhvDyaSEkebYusW8TIB+
         xeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Tb0RwUZ46/MxCQYiDDQvnRO982rWhA3+X/4oEcbOulo=;
        b=yQi5O4ZfqMBJ+I+Bx6AQ8AnGwV9ZDpUy2rUaUzQ3r1X+Fqq57ZXIwaYOej69PaszFO
         hi/AOMtbmjSPTT9GsQycWpRLNaqh5wt6sydzfPEQnSmL5RsnfmdhDASVUpSVg8puWD2X
         GelhgIx7cK8NyyNZNdjbqcOZyjHJ3vXQpQcJQTCLSxMO3hHF4/G/allpxrro61jQ/HWO
         a42LjGFhDqyiX3rfRMvGSkvULHW2qmRqmsZmjx7BJx1FbLRr1MR7LaNNKOwDTcbJ40Ta
         Z8U1eMtqJEBdNj011DEN0ktS0/4HyD5kj7GxuBeFaNAhgjIk4qH2E34VchNHjprGd74o
         GBGw==
X-Gm-Message-State: ACgBeo0gn390x54rUAW2CQ/89jZ8wPEEUimdiVfqRVN/LPDjM2GEiYaV
        Cv2UBT2E9ELVwAIW/l/QniBAztflA6M=
X-Google-Smtp-Source: AA6agR53LjRO8L6/6w41xxsHlmMgdghbKIj4I9+AEsJSADdOAT0U7u23beQAaK0REgjDZEIYy1UxbQ==
X-Received: by 2002:a5d:6c63:0:b0:220:5e4d:c6e9 with SMTP id r3-20020a5d6c63000000b002205e4dc6e9mr15660954wrz.250.1660071328678;
        Tue, 09 Aug 2022 11:55:28 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:28 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 05/14] merge-index: add a new way to invoke `git-merge-one-file'
Date:   Tue,  9 Aug 2022 20:54:20 +0200
Message-Id: <20220809185429.20098-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since `git-merge-one-file' will be rewritten and libified, there may be
cases where there is no executable named this way (ie. when git is
compiled with `SKIP_DASHED_BUILT_INS' enabled).  This adds a new way to
invoke this particular program even if it does not exist, by passing
`--use=merge-one-file' to merge-index.  For now, it still forks.

The test suite and shell scripts (git-merge-octopus.sh and
git-merge-resolve.sh) are updated to use this new convention.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 Documentation/git-merge-index.txt |  7 ++++---
 builtin/merge-index.c             | 25 ++++++++++++++++++++++---
 git-merge-octopus.sh              |  2 +-
 git-merge-resolve.sh              |  2 +-
 t/t6060-merge-index.sh            |  8 ++++----
 5 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index eea56b3154..622638a13b 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -9,7 +9,7 @@ git-merge-index - Run a merge for files needing merging
 SYNOPSIS
 --------
 [verse]
-'git merge-index' [-o] [-q] <merge-program> (-a | ( [--] <file>...) )
+'git merge-index' [-o] [-q] (<merge-program> | --use=merge-one-file) (-a | ( [--] <file>...) )
 
 DESCRIPTION
 -----------
@@ -44,8 +44,9 @@ code.
 Typically this is run with a script calling Git's imitation of
 the 'merge' command from the RCS package.
 
-A sample script called 'git merge-one-file' is included in the
-distribution.
+A sample script called 'git merge-one-file' used to be included in the
+distribution. This program must now be called with
+'--use=merge-one-file'.
 
 ALERT ALERT ALERT! The Git "merge object order" is different from the
 RCS 'merge' program merge object order. In the above ordering, the
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 9d74b6e85c..aba3ba5694 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "lockfile.h"
 #include "merge-strategies.h"
 #include "run-command.h"
 
@@ -37,7 +38,10 @@ static int merge_one_file_spawn(struct index_state *istate,
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
 	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
+	merge_fn merge_action = merge_one_file_spawn;
+	struct lock_file lock = LOCK_INIT;
 	struct repository *r = the_repository;
+	const char *use_internal = NULL;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -45,7 +49,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
+		usage("git merge-index [-o] [-q] (<merge-program> | --use=merge-one-file) (-a | [--] [<filename>...])");
 
 	if (repo_read_index(r) < 0)
 		die("invalid index");
@@ -64,6 +68,14 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	}
 
 	pgm = argv[i++];
+	setup_work_tree();
+
+	if (skip_prefix(pgm, "--use=", &use_internal)) {
+		if (!strcmp(use_internal, "merge-one-file"))
+			pgm = "git-merge-one-file";
+		else
+			die(_("git merge-index: unknown internal program %s"), use_internal);
+	}
 
 	for (; i < argc; i++) {
 		const char *arg = argv[i];
@@ -74,13 +86,20 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "-a")) {
 				err |= merge_all_index(r->index, one_shot, quiet,
-						       merge_one_file_spawn, NULL);
+						       merge_action, NULL);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
 		err |= merge_index_path(r->index, one_shot, quiet, arg,
-					merge_one_file_spawn, NULL);
+					merge_action, NULL);
+	}
+
+	if (is_lock_file_locked(&lock)) {
+		if (err)
+			rollback_lock_file(&lock);
+		else
+			return write_locked_index(r->index, &lock, COMMIT_LOCK);
 	}
 
 	return err;
diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 7d19d37951..2770891960 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -100,7 +100,7 @@ do
 	if test $? -ne 0
 	then
 		gettextln "Simple merge did not work, trying automatic merge."
-		git merge-index -o git-merge-one-file -a ||
+		git merge-index -o --use=merge-one-file -a ||
 		OCTOPUS_FAILURE=1
 		next=$(git write-tree 2>/dev/null)
 	fi
diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
index 77e93121bf..e59175eb75 100755
--- a/git-merge-resolve.sh
+++ b/git-merge-resolve.sh
@@ -55,7 +55,7 @@ then
 	exit 0
 else
 	echo "Simple merge failed, trying Automatic merge."
-	if git merge-index -o git-merge-one-file -a
+	if git merge-index -o --use=merge-one-file -a
 	then
 		exit 0
 	else
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index bb4da4bbb2..3845a9d3cc 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -48,8 +48,8 @@ test_expect_success 'read-tree does not resolve content merge' '
 	test_cmp expect unmerged
 '
 
-test_expect_success 'git merge-index git-merge-one-file resolves' '
-	git merge-index git-merge-one-file -a &&
+test_expect_success 'git merge-index --use=merge-one-file resolves' '
+	git merge-index --use=merge-one-file -a &&
 	git diff-files --name-only --diff-filter=U >unmerged &&
 	test_must_be_empty unmerged &&
 	test_cmp expect-merged file &&
@@ -81,7 +81,7 @@ test_expect_success 'merge-one-file respects GIT_WORK_TREE' '
 	 export GIT_WORK_TREE &&
 	 GIT_INDEX_FILE=$PWD/merge.index &&
 	 export GIT_INDEX_FILE &&
-	 git merge-index git-merge-one-file -a &&
+	 git merge-index --use=merge-one-file -a &&
 	 git cat-file blob :file >work/file-index
 	) &&
 	test_cmp expect-merged bare.git/work/file &&
@@ -96,7 +96,7 @@ test_expect_success 'merge-one-file respects core.worktree' '
 	 export GIT_DIR &&
 	 git config core.worktree "$PWD/child" &&
 	 git read-tree -i -m base ten two &&
-	 git merge-index git-merge-one-file -a &&
+	 git merge-index --use=merge-one-file -a &&
 	 git cat-file blob :file >file-index
 	) &&
 	test_cmp expect-merged subdir/child/file &&
-- 
2.37.1.412.gcfdce49ffd

