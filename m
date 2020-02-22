Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C58C35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D09B206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fOGumpc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgBVUSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39078 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbgBVUSI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E1F876079C
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402688;
        bh=CxASxxZseqVuQ9wI1NUc7ZMyqmjyJr0SYO2iNrQ9zaU=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=fOGumpc78bjbtg3IvKTjBWhVkyqLjWCSe44hH1+tgM25jQ7yOYDtDsOmmM9n2edFO
         ULpyMzSuzxaamuoo/j+je54sDDMnhSTx7lShqZI4X/GqjNDKkrCXL2dsOV6ZD9YPT2
         HI7tNASOhbLY+9N+R8sCWsnKwsCWTXZer2pvHwZjJYbTZOqJZIbYuvo0/dL4QmIyDY
         s5WN3ruqkpSI/OqcjO/vPXuK7GMp/UK4C7yeqGd6VZJwHC8gFdOSGN510DLNYbFrNI
         /vSbYFt0tHlJs0sFkEHR8PXH0I55jSts4PVJb6SbS/5mzwOE5ycvXUY0IgN2Sp/+3a
         D7goKmBDRmyphnVl04wyBtt4DSoaZ5aloegrtJXREPjz9dfJjX+PRQ533ZOFedeOJB
         g/Cd+n6mPopM6PvV/0YlkpHzdKA7WuTE5myYol2sop5M9fN2NR4Yz2YNhnnQb8eTMm
         aDg3ETSw+M9Y6c8NAUiZ7DwC5N5VvjS4ieSOmCFh1qNXZwB6l3M
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 11/24] t/helper: make repository tests hash independent
Date:   Sat, 22 Feb 2020 20:17:36 +0000
Message-Id: <20200222201749.937983-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test currently hard-codes the hash algorithm as SHA-1 when calling
repo_set_hash_algo so that the_hash_algo is properly initialized.
However, this does not work with SHA-256 repositories. Read the
repository value that repo_init has read into the local repository
variable and set the algorithm based on that value.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/helper/test-repository.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index ecc768e4cb..56f0e3c1be 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -19,12 +19,11 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 
 	memset(the_repository, 0, sizeof(*the_repository));
 
-	/* TODO: Needed for temporary hack in hashcmp, see 183a638b7da. */
-	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
-
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
 
+	repo_set_hash_algo(the_repository, hash_algo_by_ptr(r.hash_algo));
+
 	c = lookup_commit(&r, commit_oid);
 
 	if (!parse_commit_in_graph(&r, c))
@@ -50,12 +49,11 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 
 	memset(the_repository, 0, sizeof(*the_repository));
 
-	/* TODO: Needed for temporary hack in hashcmp, see 183a638b7da. */
-	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
-
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
 
+	repo_set_hash_algo(the_repository, hash_algo_by_ptr(r.hash_algo));
+
 	c = lookup_commit(&r, commit_oid);
 
 	/*
