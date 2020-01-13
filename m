Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560EC33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082FB207FF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jx1GzljC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgAMMsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37782 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728841AbgAMMsD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:03 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9C656607F8
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919682;
        bh=WrByQK3KLtMskMM1z6KZg71CsdCNiihzqG/B7iHhD9I=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=jx1GzljCTRfKA/+EPXAIlwob4I10gBN6Om6U3QVYgwWoPHNfbZnMVGqHDt7j6ECJG
         gdMan23E9JZKnSg8o65S37ajlWxbpxDWXMxZsa0cv2WDbpzvZjQqFFYedYTqh1VFJQ
         WYnUz3mS3lDsxNZM5MOldc4GGx+cI/XiitqBXLbYW43QUPlObr1X2MANJykUyiiUt0
         NciVfewm9tUn88rYvvw9cWQLadz0TgIFASt/4q/qDQgnyKNPgpACxxkkzCI+I/2dG+
         R1Ja7XIW13ZIu2SWVz6Y4OnSTJg8/RoazavAc19vp0QiJcFJwzvoMiihGEP/RTVwKB
         qAZjypPlg/8h5QmHC4t2ueRyFwYbMuzy4n8FE91BE0T1e39rKj5vsV2NBg8xyb3h2u
         Tc4oyMXzY6cEhXI9oHb4FZCE77mBHiCqK1Z5gLBTQrnhHIDN3CZYaDahSnv0OKcIih
         OkI+de8hh1sngz3ITUu4JRqtNYlpUaA8lMR5s7bePNb1wbtGjtY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 13/22] init-db: move writing repo version into a function
Date:   Mon, 13 Jan 2020 12:47:20 +0000
Message-Id: <20200113124729.3684846-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we perform a clone, we won't know the remote side's hash algorithm
until we've read the heads.  Consequently, we'll need to rewrite the
repository format version and hash algorithm once we know what the
remote side has.  Move the code that does this into its own function so
that we can call it from clone in the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/init-db.c | 32 +++++++++++++++++++-------------
 cache.h           |  1 +
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 7b385aacfd..9df9a54d20 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -178,6 +178,24 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
+void initialize_repository_version(int hash_algo)
+{
+	char repo_version_string[10];
+	int repo_version = GIT_REPO_VERSION;
+
+	if (hash_algo != GIT_HASH_SHA1)
+		repo_version = GIT_REPO_VERSION_READ;
+
+	/* This forces creation of new config file */
+	xsnprintf(repo_version_string, sizeof(repo_version_string),
+		  "%d", repo_version);
+	git_config_set("core.repositoryformatversion", repo_version_string);
+
+	if (hash_algo != GIT_HASH_SHA1)
+		git_config_set("extensions.objectformat",
+			       hash_algos[hash_algo].name);
+}
+
 static int create_default_files(const char *template_path,
 				const char *original_git_dir,
 				const struct repository_format *fmt)
@@ -185,12 +203,10 @@ static int create_default_files(const char *template_path,
 	struct stat st1;
 	struct strbuf buf = STRBUF_INIT;
 	char *path;
-	char repo_version_string[10];
 	char junk[2];
 	int reinit;
 	int filemode;
 	struct strbuf err = STRBUF_INIT;
-	int repo_version = GIT_REPO_VERSION;
 
 	/* Just look for `init.templatedir` */
 	init_db_template_dir = NULL; /* re-set in case it was set before */
@@ -248,17 +264,7 @@ static int create_default_files(const char *template_path,
 			exit(1);
 	}
 
-	if (fmt->hash_algo != GIT_HASH_SHA1)
-		repo_version = GIT_REPO_VERSION_READ;
-
-	/* This forces creation of new config file */
-	xsnprintf(repo_version_string, sizeof(repo_version_string),
-		  "%d", repo_version);
-	git_config_set("core.repositoryformatversion", repo_version_string);
-
-	if (fmt->hash_algo != GIT_HASH_SHA1)
-		git_config_set("extensions.objectformat",
-			       hash_algos[fmt->hash_algo].name);
+	initialize_repository_version(fmt->hash_algo);
 
 	/* Check filemode trustability */
 	path = git_path_buf(&buf, "config");
diff --git a/cache.h b/cache.h
index 14321f55da..a47a9f5dbd 100644
--- a/cache.h
+++ b/cache.h
@@ -629,6 +629,7 @@ int path_inside_repo(const char *prefix, const char *path);
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
 	    unsigned int flags);
+void initialize_repository_version(int hash_algo);
 
 void sanitize_stdfds(void);
 int daemonize(void);
