Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06ECD1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbdAYXEy (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:04:54 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35992 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbdAYXEx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:04:53 -0500
Received: by mail-pg0-f54.google.com with SMTP id 3so9360469pgj.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 15:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nfn8yIRIFQuZPP44aWmazf5PpUlUF40A6FDOP7RqZck=;
        b=p9yFoxdz3SBHkOVLmAkus+KqohOHWGYAG8wG4TFvFSz5Gfn5ZDtno/xzwEgEmgnQaI
         OLYpPoqXwH1zcFUv28V0kgUk5CtFs5v1ztaDrKVxfVnaGqWd6wcvfGMZSkTpcjqoc3Fc
         IkibGQj4ZmfUaKzzIIm4KlYsKMMjXFPEIBuhtAFeWJ5LATfYlKEAsKpa1QTjKH2vnpBd
         mfT6MdkChAuo7/DDBW8bZyXsD3c61V9xWIf1WFvj3LA1dKBjddtve96+3tppyAPrMwqj
         bNl18nEXnphrJhYOXnLEqc8p1jzZS+y1/9dMZoAXtnUQHeM0zKG3C99uMXiZIH+jcIqc
         nLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nfn8yIRIFQuZPP44aWmazf5PpUlUF40A6FDOP7RqZck=;
        b=Nzk+YIFtefWtxm3tk9geCCoOGR3JfvlVTDN541pPl6X0OFkrV7PNYb5kJSCG7L7QqY
         5UbUNm4N6Alsx5RqxCzT31n3yBkKZ05/mwdZA2KJ++tC3OgPGQTOFJmPNn6y8rcH4H9l
         Fwe1CAvpptdeAEc6agqdWllWyqdSUng61+IgFLC1CUOth+itxd77KOmps4yu+K3avTv8
         1qJP/UC9Se1HuRjmq2WKKQnggG2CsSosuNhR6ZG02FvCJ8CsO/Ay4aZAKYOTsGxfPJwy
         8hqQHSkYPIpQqnHiMmIQnmRuNK7UeJVf5z2CBeKemwlyjALLaXbLeG/E7zHKpKXTg4YL
         ktDw==
X-Gm-Message-State: AIkVDXJ9+/fkAKygNXN4X6cgSm8Kiz1OuJf8qiarJXp2aiATClBUluubNFBHJfgWxtiJxtLa
X-Received: by 10.99.229.17 with SMTP id r17mr1915008pgh.81.1485385492456;
        Wed, 25 Jan 2017 15:04:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3993:32c0:4ba2:a648])
        by smtp.gmail.com with ESMTPSA id b75sm3466913pfb.90.2017.01.25.15.04.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 15:04:51 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/3] submodule absorbing: fix worktree/gitdir pointers recursively for non-moves
Date:   Wed, 25 Jan 2017 15:04:50 -0800
Message-Id: <20170125230450.4393-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.495.g04f60290a0.dirty
In-Reply-To: <xmqq37g692da.fsf@gitster.mtv.corp.google.com>
References: <xmqq37g692da.fsf@gitster.mtv.corp.google.com>
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

 This replaces the last patch of the series, containing Brandons SQUASH proposal
 as well as the removal of the goto.
 Thanks,
 Stefan

 submodule.c                        | 62 ++++++++++++++++++++++++++++----------
 t/t7412-submodule-absorbgitdirs.sh | 27 +++++++++++++++++
 2 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4c4f033e8a..3b98766a6b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1437,22 +1437,57 @@ void absorb_git_dir_into_superproject(const char *prefix,
 				      const char *path,
 				      unsigned flags)
 {
-	const char *sub_git_dir, *v;
-	char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
+	int err_code;
+	const char *sub_git_dir;
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
+		if (err_code == READ_GITFILE_ERR_STAT_FAILED) {
+			/* unpopulated as expected */
+			strbuf_release(&gitdir);
+			return;
+		}
+
+		if (err_code != READ_GITFILE_ERR_NOT_A_REPO)
+			/* We don't know what broke here. */
+			read_gitfile_error_die(err_code, path, NULL);
+
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
+
+		free(real_new_git_dir);
+	} else {
+		/* Is it already absorbed into the superprojects git dir? */
+		char *real_sub_git_dir = real_pathdup(sub_git_dir);
+		char *real_common_git_dir = real_pathdup(get_git_common_dir());
 
-	/* Is it already absorbed into the superprojects git dir? */
-	real_sub_git_dir = real_pathdup(sub_git_dir);
-	real_common_git_dir = real_pathdup(get_git_common_dir());
-	if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
-		relocate_single_git_dir_into_superproject(prefix, path);
+		if (!starts_with(real_sub_git_dir, real_common_git_dir))
+			relocate_single_git_dir_into_superproject(prefix, path);
+
+		free(real_sub_git_dir);
+		free(real_common_git_dir);
+	}
+	strbuf_release(&gitdir);
 
 	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -1478,9 +1513,4 @@ void absorb_git_dir_into_superproject(const char *prefix,
 
 		strbuf_release(&sb);
 	}
-
-out:
-	strbuf_release(&gitdir);
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
2.11.0.495.g04f60290a0.dirty

