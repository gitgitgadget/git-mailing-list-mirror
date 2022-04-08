Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3504BC433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 03:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiDHDOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 23:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiDHDOo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 23:14:44 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58067101F2B
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 20:12:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1649387556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+av01Ge8SHiXxlz/OsV5dn3Ll6GkLeui3i+vyTNY0ig=;
        b=GIc1+pv5r7OEN9B5zjM284TPKc0SrapcpUFm7oS5+qmBypWC75HhGLMSBeeXIYLF7qZHFX
        QM2UOY2bhEahZcHHXBNxLEa4qkBK242yHYhZE9VpLDz8gx6sbHX3MtXbso7AvQIOcxRFrV
        2ZUHVueFW89uTPtWi4LI7w/ZwiGHn/W7LGRwE3WUfMAw6xvJIhOIGsAoMoyEqDq/Jagc5L
        1JRmXPhIcUYCXlcHPbIRCNAetK/xs5lB9zNNJPjUrqvo2mnMm5uz8MARXK4Azp2rSh3zAg
        ycNnWuDJTndxUlrd0pcpZahLGELt5m2UVhmK4fwom7LCwlfSu4s+/o2YqbvMmw==
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, joostkremers@fastmail.fm
Subject: [PATCH] stash: disable literal treatment when passing top pathspec
Date:   Thu,  7 Apr 2022 23:12:28 -0400
Message-Id: <20220408031228.782547-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: kyleam.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

do_push_stash() passes ":/" as the pathspec to two subprocess calls.
When pathspecs are interpreted literally for the main process, these
subprocess calls do not behave as intended:

 * the 'git clean' call, triggered by --include-untracked, does not
   remove untracked files from the working tree

 * the 'git checkout' call, triggered by --keep-index, fails with a
   message about ":/" not matching any known files, and the main
   command exits with a non-zero status

Fix both of these spots by passing --no-literal-pathspecs to the
subprocess commands.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 builtin/stash.c                    | 5 ++++-
 t/t3903-stash.sh                   | 5 +++++
 t/t3905-stash-include-untracked.sh | 5 +++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 0c7b6a9588..afc8400c5d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1529,7 +1529,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 					     GIT_WORK_TREE_ENVIRONMENT,
 					     the_repository->worktree);
 			}
-			strvec_pushl(&cp.args, "clean", "--force",
+			strvec_pushl(&cp.args, "--no-literal-pathspecs",
+				     "clean", "--force",
 				     "--quiet", "-d", ":/", NULL);
 			if (include_untracked == INCLUDE_ALL_FILES)
 				strvec_push(&cp.args, "-x");
@@ -1592,6 +1593,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
+			if (!ps->nr)
+				strvec_push(&cp.args, "--no-literal-pathspecs");
 			strvec_pushl(&cp.args, "checkout", "--no-overlay",
 				     oid_to_hex(&info.i_tree), "--", NULL);
 			if (!ps->nr)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 4abbc8fcca..f85c3a06cb 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1383,6 +1383,11 @@ test_expect_success 'stash --keep-index with file deleted in index does not resu
 	test_path_is_missing to-remove
 '
 
+test_expect_success 'stash --keep-index succeeds with --literal-pathspecs' '
+	echo modified >file &&
+	git --literal-pathspecs stash --keep-index
+'
+
 test_expect_success 'stash apply should succeed with unmodified file' '
 	echo base >file &&
 	git add file &&
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 5390eec4e3..2f216274b2 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -427,5 +427,10 @@ test_expect_success 'stash -u ignores sub-repository' '
 	git init sub-repo &&
 	git stash -u
 '
+test_expect_success 'stash -u works with --literal-pathspecs' '
+	>untracked &&
+	git --literal-pathspecs stash -u &&
+	test_path_is_missing untracked
+'
 
 test_done

base-commit: bf23fe5c37d62f37267d31d4afa1a1444f70cdac
-- 
2.34.0

