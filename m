Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0C11F437
	for <e@80x24.org>; Tue, 24 Jan 2017 21:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbdAXVDv (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 16:03:51 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34843 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdAXVDu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 16:03:50 -0500
Received: by mail-pf0-f181.google.com with SMTP id f144so52565297pfa.2
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 13:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/Y3P7N4/rbVRvGFuE6yVGtO0DFBCZJ0qhRVvXj5L3lk=;
        b=iz4LZBpyxFLOYIMFsd/xTweM04Oj3f5/B75CXLvodOYi8/9DZhEm6SoPABpqmggk8D
         GGFCFNe27gKP8ufXZ/EeQCmXzS050zRb6b5NvgRKNoIKCSJASEqMB4gBaV8hdn5r7IUZ
         wMKA+tkscqTI6jAHASh5/InnS9jFnYjVts1H11bTRoUqEG0/EL56aaIHtBoCR4mvC9LO
         Uo9SRHSNPX8n0wqDSGTvRtj0hBSWR/C+mU12qHhTOyf7t2xE4RSLut8KX7ZNuNqVVlTv
         +QZ0Ys2EnMANjWITJoIs+RvpDP4/xMlCFonzbLM/npSqgXlgdWh7LU3L1ZzOk6+MoSvk
         Qvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Y3P7N4/rbVRvGFuE6yVGtO0DFBCZJ0qhRVvXj5L3lk=;
        b=ElIGDbvNpUDx1V0849oIAU42UAxXFj/OUa+bTrmv7nLeEVW9tjkbLXwuNOhqVultB5
         6O1xataQ6SuYciRL9kr5W97X7+3/89eq9OdcPNTrFGvu3k/JIRmB5Cfb/s1b08CrSBJF
         oEWwdO0SJbug8FdXwoMCzjAt0m+kV+B176IQwogpnRyplDXDpgYhYkWQFzzrO7Alo/WE
         UzHM6i6KkjOBuY1x1WsTDu3CDLxpU4JfYSip8VVkbMEbkwDoPRva66Iu2xoiZ7uFr+C4
         BKberiMMt1Sl4YDbmxuhkMp6OzF9I+pHj00iUdW4EbcUg5THDRVApAzt9iLHSkIBiZ93
         uNSw==
X-Gm-Message-State: AIkVDXIL35YyCMCTqfoDCKexuBTu9kbjlbyfkIoUwGy1c6WFYDRx6SjZ8m5QJk4uUINEpGYE
X-Received: by 10.99.5.15 with SMTP id 15mr42230205pgf.109.1485291829428;
        Tue, 24 Jan 2017 13:03:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6936:a216:cb1:3482])
        by smtp.gmail.com with ESMTPSA id w125sm7833509pgb.11.2017.01.24.13.03.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 13:03:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule absorbing: fix worktree/gitdir pointers recursively for non-moves
Date:   Tue, 24 Jan 2017 13:03:46 -0800
Message-Id: <20170124210346.12060-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.486.g67830dbe1c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Consider having a submodule 'sub' and a nested submodule at 'sub/nested'.
When nested is already absorbed into sub, but sub is not absorbed into
its superproject, then we need to fixup the gitfile and core.worktree
setting for 'nested' when absorbing 'sub', but we do not need to move
its git dir around.

Previously 'nested's gitfile contained "gitdir: ../.git/modules/nested";
it has to be corrected to "gitdir: ../../.git/modules/sub1/modules/nested".

An alternative I considered to do this work lazily, i.e. when resolving
"../.git/modules/nested", we would notice the ".git" being a gitfile
linking to another path.  That seemed to be robuster by design, but harder
to get the implementation right.  Maybe we have to do that anyway once we
try to have submodules and worktrees working nicely together, but for now
just produce 'correct' (i.e. direct) pointers.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  cc Jeff and Brandon, who worked on the setup code recently,
  and the alternative design mentioned was messing around a lot in setup.c.
  
  Thanks,
  Stefan

 submodule.c                        | 41 +++++++++++++++++++-------------------
 t/t7412-submodule-absorbgitdirs.sh | 27 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4c4f033e8a..7deb0fca6a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1393,16 +1393,9 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	const char *new_git_dir;
 	const struct submodule *sub;
-
-	if (submodule_uses_worktrees(path))
-		die(_("relocate_gitdir for submodule '%s' with "
-		      "more than one worktree not supported"), path);
+	int err_code;
 
 	old_git_dir = xstrfmt("%s/.git", path);
-	if (read_gitfile(old_git_dir))
-		/* If it is an actual gitfile, it doesn't need migration. */
-		return;
-
 	real_old_git_dir = real_pathdup(old_git_dir);
 
 	sub = submodule_from_path(null_sha1, path);
@@ -1414,6 +1407,24 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 		die(_("could not create directory '%s'"), new_git_dir);
 	real_new_git_dir = real_pathdup(new_git_dir);
 
+	if (read_gitfile_gently(old_git_dir, &err_code) ||
+	    err_code == READ_GITFILE_ERR_NOT_A_REPO) {
+		/*
+		 * If it is an actual gitfile, it doesn't need migration,
+		 * however in case of a recursively nested submodule, the
+		 * gitfile content may be stale, as its superproject
+		 * (which may be a submodule of another superproject)
+		 * may have been moved. So expect a bogus pointer to be read,
+		 * which materializes as error READ_GITFILE_ERR_NOT_A_REPO.
+		 */
+		connect_work_tree_and_git_dir(path, real_new_git_dir);
+		return;
+	}
+
+	if (submodule_uses_worktrees(path))
+		die(_("relocate_gitdir for submodule '%s' with "
+		      "more than one worktree not supported"), path);
+
 	if (!prefix)
 		prefix = get_super_prefix();
 
@@ -1437,22 +1448,14 @@ void absorb_git_dir_into_superproject(const char *prefix,
 				      const char *path,
 				      unsigned flags)
 {
-	const char *sub_git_dir, *v;
-	char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
 	struct strbuf gitdir = STRBUF_INIT;
-
 	strbuf_addf(&gitdir, "%s/.git", path);
-	sub_git_dir = resolve_gitdir(gitdir.buf);
 
 	/* Not populated? */
-	if (!sub_git_dir)
+	if (!file_exists(gitdir.buf))
 		goto out;
 
-	/* Is it already absorbed into the superprojects git dir? */
-	real_sub_git_dir = real_pathdup(sub_git_dir);
-	real_common_git_dir = real_pathdup(get_git_common_dir());
-	if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
-		relocate_single_git_dir_into_superproject(prefix, path);
+	relocate_single_git_dir_into_superproject(prefix, path);
 
 	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -1481,6 +1484,4 @@ void absorb_git_dir_into_superproject(const char *prefix,
 
 out:
 	strbuf_release(&gitdir);
-	free(real_sub_git_dir);
-	free(real_common_git_dir);
 }
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 1c47780e2b..e2bbb449b6 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -64,6 +64,33 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	test_cmp expect.2 actual.2
 '
 
+test_expect_success 're-setup nested submodule' '
+	# un-absorb the direct submodule, to test if the nested submodule
+	# is still correct (needs a rewrite of the gitfile only)
+	rm -rf sub1/.git &&
+	mv .git/modules/sub1 sub1/.git &&
+	GIT_WORK_TREE=. git -C sub1 config --unset core.worktree &&
+	# fixup the nested submodule
+	echo "gitdir: ../.git/modules/nested" >sub1/nested/.git &&
+	GIT_WORK_TREE=../../../nested git -C sub1/.git/modules/nested config \
+		core.worktree "../../../nested" &&
+	# make sure this re-setup is correct
+	git status --ignore-submodules=none
+'
+
+test_expect_success 'absorb the git dir in a nested submodule' '
+	git status >expect.1 &&
+	git -C sub1/nested rev-parse HEAD >expect.2 &&
+	git submodule absorbgitdirs &&
+	test -f sub1/.git &&
+	test -f sub1/nested/.git &&
+	test -d .git/modules/sub1/modules/nested &&
+	git status >actual.1 &&
+	git -C sub1/nested rev-parse HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
 test_expect_success 'setup a gitlink with missing .gitmodules entry' '
 	git init sub2 &&
 	test_commit -C sub2 first &&
-- 
2.11.0.486.g67830dbe1c

