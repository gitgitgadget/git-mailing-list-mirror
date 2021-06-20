Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4249CC49EA2
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277A0610CD
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFTPO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:14:29 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:21526 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhFTPO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id C89834112C
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201932; x=1626016333;
         bh=7L8zKENofrIsSsrsrOBmvwBuKyUHkeAJxiLYIsETYsU=; b=c4A5ZMmdkIPl
        rd5arXjvm6Y4p2s5bzcQ8URqbuRPjUKtfq89LryLFfMWcBsLpZRKnn518WnMlD6e
        VyCRL6bE0FbYLKCsqjLC4RW6ykNBc+z6UX4fPfDSOGU6rhlNCxdL4CgE2Mu/XeI+
        R2zlpHsmGO8mNXygJcagvt2zuQrh1oq3cdwDrBPrxRiIDc+DZHevh1wehA5aOmjo
        eUyA9TFvegMeaN3l66LjaJG3CWRy6LRhni6mm1MQV3gaA/VZliEUhNdvVXEJ0EMS
        zhV6Y6BmgLbjcz300khUmSOnjEBvVxU7hh6XMzIB+8hyw314c0g0vik5sFMGJggj
        6YQxg7ob19w2jr5JUF85mtdggO8sA4LRQtWuYXtPTsw0hufwiVqRyyApJgAo5vKN
        PF3yx0wgwVBH9tzbB619I1hxu38tXbX/nGaJH9yfgwtGfPjvGiKiIyA+twwDWcbF
        8rmZbfUvzjnrZ2K+4aeSCfbEpqLMZxXoFwInjsTFCVdBfn93eYIs29SMF/InslFt
        uHqJJdvjb9I5LYMbV8FbBiTtC+H+X8YLkonvliJjU7TVdrhlgzNcX9VvmftwcY8b
        aATF84djjRDppwdRK9ziNrpfdnxavhwCgN7NGjcehrdC4aFCt3wI5Kkb7o12ExU2
        Yl+fMDmpohKf1MiFUbsUwo73qCWMC3k=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vO7IHNJaFKXZ for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:12 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 4AACC407B7
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:12 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id C267F3357;
        Sun, 20 Jun 2021 17:12:10 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 02/12] environment: move strbuf into block to plug leak
Date:   Sun, 20 Jun 2021 17:11:54 +0200
Message-Id: <20210620151204.19260-3-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

realpath is only populated if we execute the git_work_tree_initialized
block. However that block also causes us to return early, meaning we
never actually release the strbuf in the case where we populated it.
Therefore we move all strbuf related code into the block to guarantee
that we can't leak it.

LSAN output from t0095:

Direct leak of 129 byte(s) in 1 object(s) allocated from:
    #0 0x49a9b9 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x78f585 in xrealloc wrapper.c:126:8
    #2 0x713ff4 in strbuf_grow strbuf.c:98:2
    #3 0x713ff4 in strbuf_getcwd strbuf.c:597:3
    #4 0x4f0c18 in strbuf_realpath_1 abspath.c:99:7
    #5 0x5ae4a4 in set_git_work_tree environment.c:259:3
    #6 0x6fdd8a in setup_discovered_git_dir setup.c:931:2
    #7 0x6fdd8a in setup_git_directory_gently setup.c:1235:12
    #8 0x4cb50d in get_bloom_filter_for_commit t/helper/test-bloom.c:41:2
    #9 0x4cb50d in cmd__bloom t/helper/test-bloom.c:95:3
    #10 0x4caa1f in cmd_main t/helper/test-tool.c:124:11
    #11 0x4caded in main common-main.c:52:11
    #12 0x7f0869f02349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 129 byte(s) leaked in 1 allocation(s).

It looks like this leak has existed since realpath was first added to
set_git_work_tree() in:
  3d7747e318 (real_path: remove unsafe API, 2020-03-10)

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 environment.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/environment.c b/environment.c
index 2f27008424..d6b22ede7e 100644
--- a/environment.c
+++ b/environment.c
@@ -249,25 +249,24 @@ static int git_work_tree_initialized;
 /*
  * Note.  This works only before you used a work tree.  This was added
  * primarily to support git-clone to work in a new repository it just
  * created, and is not meant to flip between different work trees.
  */
 void set_git_work_tree(const char *new_work_tree)
 {
-	struct strbuf realpath = STRBUF_INIT;
-
 	if (git_work_tree_initialized) {
+		struct strbuf realpath = STRBUF_INIT;
+
 		strbuf_realpath(&realpath, new_work_tree, 1);
 		new_work_tree = realpath.buf;
 		if (strcmp(new_work_tree, the_repository->worktree))
 			die("internal error: work tree has already been set\n"
 			    "Current worktree: %s\nNew worktree: %s",
 			    the_repository->worktree, new_work_tree);
+		strbuf_release(&realpath);
 		return;
 	}
 	git_work_tree_initialized = 1;
 	repo_set_worktree(the_repository, new_work_tree);
-
-	strbuf_release(&realpath);
 }
 
 const char *get_git_work_tree(void)
-- 
2.26.2

