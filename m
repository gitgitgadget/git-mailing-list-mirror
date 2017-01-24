Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85FB1F437
	for <e@80x24.org>; Tue, 24 Jan 2017 23:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbdAXX5I (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 18:57:08 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36597 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbdAXX5E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 18:57:04 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so53437057pfu.3
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 15:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MmH2utt5lsHBwMdoD10WxvUxEH0KewkqEcHEBKQE0DA=;
        b=j6aBNdqxby/3/Myu0Z0VF2/cBVblGgDFnDlDRw/5/Vm+I/J7Gw9D8MyRftG0leqys0
         HyqAMJRt4eP59ov9v2MQEarzKF8zBXFpQndaKMi0zcEim5c+PVD5yxKbpZ252VRNXui2
         zh21b/Ro15m88Ts7L3UsBeDT5PUHN4KE9vvnskVz9qDmH1pyNpjC6gbrjRWGEh8YZTcp
         e+XE6e1w1QdKCG2bbncjxvpmpMDEA32iTT030ezkwW9hgozYXmgb0DqoGxJxVaaKFSV8
         crEvGmV2NCreegama3yzYG54niArpf/Sa8fcXfO003HcpZx0tvp9KcfzjRiLVLeEJ6OG
         eUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MmH2utt5lsHBwMdoD10WxvUxEH0KewkqEcHEBKQE0DA=;
        b=cTxErnP7MfxncAfbmFUI9ToEnXvNT40cXl+K+PW70Bzg7So5R18lE38TxJTOoQmZB+
         dq8guvz+gzjvAKia5USgRZ+lgCJsNLZxOV0s1BOKLVDqHfjRxUWPLQF4acWoVGKJ63Kh
         Qf59RSQuTG5ftm2QdRTKPgJGmkxBU/RkpB4HnLHcSfLRDn3SnGWDtUOVpXNKJXR3btA7
         1D8g36EsZq5ElqQ8c88BjoTBNRJLiRxfIaiOEGozN/yX0ux57EjF1I7XVsqpsG9nrO8G
         zrGuG9CIacBEMq7+WV2T/Ayf6GfXLhJFg8zxOdu5aym3gfQsLc9qTccD3eeapHpwKzbh
         x+ZA==
X-Gm-Message-State: AIkVDXJ/3XpJTxZ5aBYeBCyk4EPrnPEVn9FkxRJxji9zaUrxpcxawRM24rGQ8GFZiV9zP74e
X-Received: by 10.98.64.3 with SMTP id n3mr43167965pfa.2.1485302223918;
        Tue, 24 Jan 2017 15:57:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6936:a216:cb1:3482])
        by smtp.gmail.com with ESMTPSA id h14sm8189599pgn.41.2017.01.24.15.57.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 15:57:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/3] submodule absorbing: fix worktree/gitdir pointers recursively for non-moves
Date:   Tue, 24 Jan 2017 15:56:51 -0800
Message-Id: <20170124235651.18749-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.495.g04f60290a0.dirty
In-Reply-To: <20170124235651.18749-1-sbeller@google.com>
References: <20170124221948.GB58021@google.com>
 <20170124235651.18749-1-sbeller@google.com>
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
 submodule.c                        | 43 ++++++++++++++++++++++++++++++--------
 t/t7412-submodule-absorbgitdirs.sh | 27 ++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4c4f033e8a..95437105bf 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1437,22 +1437,47 @@ void absorb_git_dir_into_superproject(const char *prefix,
 				      const char *path,
 				      unsigned flags)
 {
+	int err_code;
 	const char *sub_git_dir, *v;
 	char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
 	struct strbuf gitdir = STRBUF_INIT;
-
 	strbuf_addf(&gitdir, "%s/.git", path);
-	sub_git_dir = resolve_gitdir(gitdir.buf);
+	sub_git_dir = resolve_gitdir_gently(gitdir.buf, &err_code);
 
 	/* Not populated? */
-	if (!sub_git_dir)
-		goto out;
+	if (!sub_git_dir) {
+		char *real_new_git_dir;
+		const char *new_git_dir;
+		const struct submodule *sub;
+
+		if (err_code == READ_GITFILE_ERR_STAT_FAILED)
+			goto out; /* unpopulated as expected */
+		if (err_code != READ_GITFILE_ERR_NOT_A_REPO)
+			/* We don't know what broke here. */
+			read_gitfile_error_die(err_code, path, NULL);
 
-	/* Is it already absorbed into the superprojects git dir? */
-	real_sub_git_dir = real_pathdup(sub_git_dir);
-	real_common_git_dir = real_pathdup(get_git_common_dir());
-	if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
-		relocate_single_git_dir_into_superproject(prefix, path);
+		/*
+		* Maybe populated, but no git directory was found?
+		* This can happen if the superproject is a submodule
+		* itself and was just absorbed. The absorption of the
+		* superproject did not rewrite the git file links yet,
+		* fix it now.
+		*/
+		sub = submodule_from_path(null_sha1, path);
+		if (!sub)
+			die(_("could not lookup name for submodule '%s'"), path);
+		new_git_dir = git_path("modules/%s", sub->name);
+		if (safe_create_leading_directories_const(new_git_dir) < 0)
+			die(_("could not create directory '%s'"), new_git_dir);
+		real_new_git_dir = real_pathdup(new_git_dir);
+		connect_work_tree_and_git_dir(path, real_new_git_dir);
+	} else {
+		/* Is it already absorbed into the superprojects git dir? */
+		real_sub_git_dir = real_pathdup(sub_git_dir);
+		real_common_git_dir = real_pathdup(get_git_common_dir());
+		if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
+			relocate_single_git_dir_into_superproject(prefix, path);
+	}
 
 	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
 		struct child_process cp = CHILD_PROCESS_INIT;
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
2.11.0.495.g04f60290a0.dirty

