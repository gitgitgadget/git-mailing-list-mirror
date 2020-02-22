Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04CDC35666
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9761B20702
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="L7Xv6dFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgBVUSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39080 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727004AbgBVUSJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:09 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 098746079A
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402689;
        bh=/+wAdgSNPymC+SBSQKv8hTZuTinHbkdJcC5cVRd9xKM=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=L7Xv6dFRdgCwAq/Ktp+C9wJGREN0T683tskxB7SDC+0lUdsdNQG9W34ktjg4qefdg
         /hjsKqhTuXM+KsEG0x2XNT8gqlDQdz/xsBlRGRmKEbmcqqUQum9PZEA//4Dd4P7weI
         yd4AVqa82mYIgEb2zC/kyTFQuKtbjUzfs3ejaKvitob2+FUw2f6MyrSEoQypW05Z/C
         HgqO7e8P6yDmH9OQn01eL9ydylJiV2u2vAt3nLzY16t/49KS89XZrSb2yuE+x6wJ10
         5fa2F8EFA2MXnaf1rb/Yny9NdZXybizLTIqU+nGB8aUejdjyldzoeaCge1eNFbBCeq
         s0q0LgnSoCG3Anlyg++ATlTwTbl0ueeVBy8BQfFwfj7vhgBbdLrzWJ/Z8ENsnettQN
         SfTXUlvI81oj9JSAEIjTu5Hc2JrSCmlq77BwE1Xf31riNvn4wnU5s3VSRvirmr4bS8
         J/xd2eUOy5YnR9JB1L2bxRgqrZ/pTh0bb2iN2bDzkp4UiYaMseL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 14/24] builtin/init-db: add environment variable for new repo hash
Date:   Sat, 22 Feb 2020 20:17:39 +0000
Message-Id: <20200222201749.937983-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
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
index b0672bd806..9d6769e95a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -493,6 +493,12 @@ double-quotes and respecting backslash escapes. E.g., the value
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
index d05552f0ae..ab4fd682ab 100644
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
@@ -356,6 +358,7 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 
 static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash)
 {
+	const char *env = getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
 	/*
 	 * If we already have an initialized repo, don't allow the user to
 	 * specify a different algorithm, as that could cause corruption.
@@ -365,6 +368,12 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
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
