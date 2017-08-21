Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85B920899
	for <e@80x24.org>; Mon, 21 Aug 2017 00:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbdHUAAc (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 20:00:32 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57058 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753416AbdHUAAb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Aug 2017 20:00:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CE1B4280AE
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1503273630;
        bh=gxhaF3zuSH80xU8eSNvSAFTusj/0ryvNyrVi8bM8phM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SXBvVVqJN9ewbCI5DB3kGe51m3QcX6aC8UCIR7O3pFDbuXjStCPg8VKXxmNlAjAwi
         vAFzAvkMsmNywGkCH149FkbjpmqQuQhfml2MBfXtm6hxfMngrahFNf9/afQdC/gwwD
         QFCklYlSt1lAQjiiCrsTV9fEnvLqZZOXNHMWMIie3JNhWuz1W9legI4Vl2E12tWW/g
         /FvmZ8T3Bol8tU/4+34Ei3sH0qwPWwx/UAalH6OAEjxDjbgovRxJ+CvH5Rr6LO/VyA
         eHuDHGBAN7wgczp/O3/BQEletHVEEWRvTHfzs2UBpNIt0rlK70K2NOp7BKVUOdpcHy
         8ioHM1JbfYLNQ3uxGx91wE7Y9L6E0bbHHfMG+7eL2qmOtXCuhI89aR9Pk4o/+56D0e
         ELxnCmMOdi/TI+v8QUnKMlh9uSpKFOC0YcPZoHGEBmd1m5nbd33bgei15oGhmrGNsH
         v3STjyVS8Aup67faRfBkSbtCPfM6pPuKqsZh33gP7uVHLMIl6qE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 5/6] Integrate hash algorithm support with repo setup
Date:   Mon, 21 Aug 2017 00:00:21 +0000
Message-Id: <20170821000022.26729-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
In-Reply-To: <20170821000022.26729-1-sandals@crustytoothpaste.net>
References: <20170821000022.26729-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In future versions of Git, we plan to support an additional hash
algorithm.  Integrate the enumeration of hash algorithms with repository
setup, and store a pointer to the enumerated data in struct repository.
Of course, we currently only support SHA-1, so hard-code this value in
read_repository_format.  In the future, we'll enumerate this value from
the configuration.

Add a constant, current_hash, which points to the hash_algo structure
pointer in the repository global.  Include repository.h in cache.h since
we now need to have access to these struct and variable definitions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h      | 4 ++++
 repository.c | 7 +++++++
 repository.h | 5 +++++
 setup.c      | 2 ++
 4 files changed, 18 insertions(+)

diff --git a/cache.h b/cache.h
index 375a7fb15e..d759824803 100644
--- a/cache.h
+++ b/cache.h
@@ -13,6 +13,7 @@
 #include "hash.h"
 #include "path.h"
 #include "sha1-array.h"
+#include "repository.h"
 
 #ifndef platform_SHA_CTX
 /*
@@ -112,6 +113,8 @@ struct git_hash_algo {
 };
 extern const struct git_hash_algo hash_algos[1];
 
+#define current_hash the_repository->hash_algo
+
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
@@ -894,6 +897,7 @@ struct repository_format {
 	int version;
 	int precious_objects;
 	int is_bare;
+	int hash_algo;
 	char *work_tree;
 	struct string_list unknown_extensions;
 };
diff --git a/repository.c b/repository.c
index 1617467568..37764f627a 100644
--- a/repository.c
+++ b/repository.c
@@ -62,6 +62,11 @@ void repo_set_gitdir(struct repository *repo, const char *path)
 	repo_setup_env(repo);
 }
 
+void repo_set_hash_algo(struct repository *repo, int hash_algo)
+{
+	repo->hash_algo = &hash_algos[hash_algo];
+}
+
 /*
  * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
  * Return 0 upon success and a non-zero value upon failure.
@@ -134,6 +139,8 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 	if (read_and_verify_repository_format(&format, repo->commondir))
 		goto error;
 
+	repo->hash_algo = &hash_algos[format.hash_algo];
+
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
diff --git a/repository.h b/repository.h
index 417787f3ef..f171172150 100644
--- a/repository.h
+++ b/repository.h
@@ -4,6 +4,7 @@
 struct config_set;
 struct index_state;
 struct submodule_cache;
+struct git_hash_algo;
 
 struct repository {
 	/* Environment */
@@ -67,6 +68,9 @@ struct repository {
 	 */
 	struct index_state *index;
 
+	/* Repository's current hash algorithm. */
+	const struct git_hash_algo *hash_algo;
+
 	/* Configurations */
 	/*
 	 * Bit used during initialization to indicate if repository state (like
@@ -86,6 +90,7 @@ extern struct repository *the_repository;
 
 extern void repo_set_gitdir(struct repository *repo, const char *path);
 extern void repo_set_worktree(struct repository *repo, const char *path);
+extern void repo_set_hash_algo(struct repository *repo, int algo);
 extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
 extern int repo_submodule_init(struct repository *submodule,
 			       struct repository *superproject,
diff --git a/setup.c b/setup.c
index 115e70a4e8..289e24811c 100644
--- a/setup.c
+++ b/setup.c
@@ -491,6 +491,7 @@ int read_repository_format(struct repository_format *format, const char *path)
 	memset(format, 0, sizeof(*format));
 	format->version = -1;
 	format->is_bare = -1;
+	format->hash_algo = GIT_HASH_SHA1;
 	string_list_init(&format->unknown_extensions, 1);
 	git_config_from_file(check_repo_format, path, format);
 	return format->version;
@@ -1125,6 +1126,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			repo_set_gitdir(the_repository, gitdir);
 			setup_git_env();
 		}
+		repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	}
 
 	strbuf_release(&dir);
