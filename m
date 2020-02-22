Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1D5C35678
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AA7206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0Grxi0Rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgBVUS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:27 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39082 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727027AbgBVUSK (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:10 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 608AA609D3
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402689;
        bh=3rUyALPr6gaTUVFjPuW/yDECZUKrlrTfjt/IPw88zrI=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=0Grxi0Rjjv+mFGDx3oFSedZavMtJtlbpTk3Zn7ulZXlibOKuYQuTTbngYmQVat+/1
         Yrc7sRyzXAIeWLZBIgOgJWDL/W/zk6Y0FStZXw/69JQi9JzK0rh5XhJOuvCJqJ39do
         cfHn2lpZ76oD+QmlFM8ceace/m2HCrCrQNkStuInz+QGtQ8+XOQs/VFy2m1BZeO5uh
         VJ14BTT/DH+EGx6q+7Lsg6HzHHuUvI+mxKZRmbxMJrhqrSatVJcgfWGPzmXIn4rkfj
         89MA8ARqiyQRnQM21EvhKdcBtgU92F+E/uqk+WKFWtPEWErzqIMp24S+7FS71v6cMa
         SeJF1DFssp4uyXdRXObQQZAdlc7ewBK8REtqqS4rnmLlmyV2uxjEnl42X4EkN0dbB9
         HVfVeYCxWoaXVaTyHdFDCcCnul03kFNj17XL8rDKdUmPO8OejdVqPqFw3tfS958tLB
         cCufX7bdCk/tq8ZubD2Y3maQFX2Vv6pe796DVMJePR9I1XTVwg3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 15/24] init-db: move writing repo version into a function
Date:   Sat, 22 Feb 2020 20:17:40 +0000
Message-Id: <20200222201749.937983-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
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
 builtin/init-db.c | 42 ++++++++++++++++++++++++------------------
 cache.h           |  1 +
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index ab4fd682ab..5d96e59885 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -178,6 +178,29 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
+void initialize_repository_version(int hash_algo)
+{
+	char repo_version_string[10];
+	int repo_version = GIT_REPO_VERSION;
+
+#ifndef ENABLE_SHA256
+	if (hash_algo != GIT_HASH_SHA1)
+		die(_("The hash algorithm %s is not supported in this build."), hash_algos[hash_algo].name);
+#endif
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
@@ -185,12 +208,10 @@ static int create_default_files(const char *template_path,
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
@@ -248,22 +269,7 @@ static int create_default_files(const char *template_path,
 			exit(1);
 	}
 
-#ifndef ENABLE_SHA256
-	if (fmt->hash_algo != GIT_HASH_SHA1)
-		die(_("The hash algorithm %s is not supported in this build."), hash_algos[fmt->hash_algo].name);
-#endif
-
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
index 7a47e023ba..0653318d2b 100644
--- a/cache.h
+++ b/cache.h
@@ -629,6 +629,7 @@ int path_inside_repo(const char *prefix, const char *path);
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
 	    unsigned int flags);
+void initialize_repository_version(int hash_algo);
 
 void sanitize_stdfds(void);
 int daemonize(void);
