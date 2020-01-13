Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0739C33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71119207FF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GqAZG48z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgAMMsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:19 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37780 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728816AbgAMMsD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:03 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 43D2360735
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919682;
        bh=MlTUwb1nQQOPfaXXmE/XzabVhVanLjy5BQyX1UNMmNw=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=GqAZG48zLDGu0NOjaO78XqOdaHyz2Sr/dbDBQLYB4IsXWZfYkPl/TSNLJ2QV+FoWB
         2OcReJWfzQYz+PBfzjIPnpJP6HK+mnVsBT3R3PKAhOmNfSpo/PBL55PbtB5AMf0WnJ
         HDxKofhRd9NtY8MTk/CUkamBBqYFzReKbvWu5CmGNsruspDp8nW+pKTrf3axHhqD1q
         U9KYo/x4zHzzXJkysu4XnQtCGwAWN5xoLrsS3/HfQ2WH7vCCaIGW1YWu25X/X53LAG
         ifywVMaWLHYWp3YL9qWwRTaOm1qveZ2SwVPkcmTFbAutQprGfU2M5clI+EQnqsweet
         L26yDXO3OJZqHhweHMX6pYBKDHxbkHUAh1DCeueGuWsIFGWNCcKCUT95TDXxKP4O1M
         aKLtGLBrE35qNCS4tvE51V76hqZFgfMN6KEvQuz//9afORTEBGCniBq5vYog1hXiw3
         Vsqw3wQxDArUhiJwipW4FAqug7c0UussswmCYl4JmwAuEKM/3Cr
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 12/22] builtin/init-db: add environment variable for new repo hash
Date:   Mon, 13 Jan 2020 12:47:19 +0000
Message-Id: <20200113124729.3684846-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the foreseeable future, SHA-1 will be the default algorithm for Git.
However, when running the testsuite, we want to be able to test an
arbitrary algorithm. It would be quite burdensome and very untidy to
have to specify the algorithm we'd like to test every time we
initialized a new repository somewhere in the testsuite, so add an
environment variable to allow us to specify the default hash algorithm
for Git.

This has the benefit that we can set it once for the entire testsuite
and not have to think about it. In the future, users can also use it to
set the default for their repositories if they would like to do so.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git.txt | 6 ++++++
 builtin/init-db.c     | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b1597ac002..d0e83fb7d7 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -479,6 +479,12 @@ double-quotes and respecting backslash escapes. E.g., the value
 	details. This variable has lower precedence than other path
 	variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...
 
+`GIT_DEFAULT_HASH_ALGORITHM`::
+	If this variable is set, the default hash algorithm for new
+	repositories will be set to this value. This value is currently
+	ignored when cloning; the setting of the remote repository
+	is used instead. The default is "sha1".
+
 Git Commits
 ~~~~~~~~~~~
 `GIT_AUTHOR_NAME`::
diff --git a/builtin/init-db.c b/builtin/init-db.c
index acb1fa1ad9..7b385aacfd 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -20,6 +20,8 @@
 #define TEST_FILEMODE 1
 #endif
 
+#define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
+
 static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
 static const char *init_db_template_dir;
@@ -351,6 +353,7 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 
 static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash)
 {
+	const char *env = getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
 	/*
 	 * If we already have an initialized repo, don't allow the user to
 	 * specify a different algorithm, as that could cause corruption.
@@ -360,6 +363,12 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 		die(_("attempt to reinitialize repository with different hash"));
 	else if (hash != GIT_HASH_UNKNOWN)
 		repo_fmt->hash_algo = hash;
+	else if (env) {
+		int env_algo = hash_algo_by_name(env);
+		if (env_algo == GIT_HASH_UNKNOWN)
+			die(_("unknown hash algorithm '%s'"), env);
+		repo_fmt->hash_algo = env_algo;
+	}
 }
 
 int init_db(const char *git_dir, const char *real_git_dir,
