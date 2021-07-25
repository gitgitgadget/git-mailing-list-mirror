Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A32C432BE
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2D960E78
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhGYM27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:28:59 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:38618 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230244AbhGYM2W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:28:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id A58E140BCA;
        Sun, 25 Jul 2021 15:08:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1627218520; x=1629032921;
         bh=8/FKFnvqTqw73g96MjnuKPOwSdBPD8pGOoyeNu6u2+Q=; b=vy+5Zv926mRJ
        XdOC6QPlcWlDTKKBGCenifg5dR+lEw6Zxa8cAwyjnJ63ku0awNJm7jcEh+/RBX32
        z27MGT8UzrjrD6tkYnSyld0IsU0FWW7ce/rqtOmXBtErvEtAJ6RQ7bp5zo/u6Nfs
        CHgNlcnZvtnvTn/KoiaUdCn/nOXqEW4ZXVp+LgYG9Bc5pJ9oTQRcljQj/4slEP4x
        2yFVt6eI8LT1bXTP6sQBUBvue+gNXNieWeM0nbdvLYfwH29/i8AQnbmUJQDRgIyy
        VwpyTD3RHlN2vPFsealnqvExL3Bv30yq+dl9jUcLQLJsr1E3BTEaHwJ49+YqiTyv
        QiQBAcza+euHULamuKPgPlBfdo5fnChszFWtcmqXH2l79j9f/cGPOVhzg7BQmnVv
        1uJH6luikLRmYoV3S+mgeSi9DeIb1dYeV6IJM9LisdwB85g4oqCIZ7FbT70Z22Cm
        9dv9qyWmxAmzR1WOb2yZz1p3Rwv5BSfzYvYZXyJpjWovXcswQStvHyMK1t3hORFZ
        wm4dHptASY5losZphkXj9NY0NVnhoOOH05bXup3OHAtgcPxvU+4yHyXkQsD4mBLU
        7u5qdiaYcaiFxAz1L46ZOwsgvZX/NWTdRckubT/uPgA7/eEr4aivjTJkQ0AtUtc3
        Pocrdy95xPcfnmG+TKM10R+aRp0r1MY=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YpEpx9n8wkwB; Sun, 25 Jul 2021 15:08:40 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 074C0404BD;
        Sun, 25 Jul 2021 15:08:39 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id D089D17C;
        Sun, 25 Jul 2021 15:08:37 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: [PATCH v2 02/12] environment: move strbuf into block to plug leak
Date:   Sun, 25 Jul 2021 15:08:20 +0200
Message-Id: <20210725130830.5145-3-andrzej@ahunt.org>
In-Reply-To: <20210725130830.5145-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210725130830.5145-1-andrzej@ahunt.org>
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
@@ -253,21 +253,20 @@ static int git_work_tree_initialized;
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

