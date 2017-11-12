Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D24201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 21:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbdKLV3O (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 16:29:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55980 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750991AbdKLV3I (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 16:29:08 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DC0F5604A0;
        Sun, 12 Nov 2017 21:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1510522147;
        bh=YeDX4gD3I+ogMS5lROcj4j29pAfvY8k3T7nt6fS0JpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Qh7W0HrLWZPfkA+rVQxS1OYB+ihsipO93Gkoz3MBIvMbGDpvl4TEGGQ6B4scC8MCi
         gffw/gDSFCZtMNKB+cFWbdFTdRexDdvqUDzo8vL+AcWDd+RrgPjy2E4pRZqr46pkC8
         NM2wNqu57NC04KYkkfOON1jCcuX85Yywtj7Yxu0lI1eO1FYyLYl570xkyh5c1Ph339
         WH73PkBJcrY915P60Fdb5wIsRsQ7DGEotx7r4wScI4vyzm1F2aQ1cMZGClJ2KuLv63
         EA7T4RK0QLtMUqx3FQBPHZ10gMUg2SA2eYZHweu3GrmgHKM3v6Xc5kR5Q1XANaaP5O
         wABrUGEbb5GLpcgLBYSY39MgYrOMe7LLJLZFQayxaiEqJ1lLqXI+5lfPAs3hCje3LX
         W8TqNHtIOpjVYPgYh8LqqBD12HkpV1saixYpPRv2GnEvGnrSe36SaLKJu7E6BBMupt
         UJsoJXc2hoMndMcC9FQS05FrRkEFEGIvKtn9DlEy/7ZiD+kwfzm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 3/4] Integrate hash algorithm support with repo setup
Date:   Sun, 12 Nov 2017 21:28:53 +0000
Message-Id: <20171112212854.791179-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a
In-Reply-To: <20171112212854.791179-1-sandals@crustytoothpaste.net>
References: <20171112212854.791179-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
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

Add a constant, the_hash_algo, which points to the hash_algo structure
pointer in the repository global.  Note that this is the hash which is
used to serialize data to disk, not the hash which is used to display
items to the user.  The transition plan anticipates that these may be
different.  We can add an additional element in the future (say,
ui_hash_algo) to provide for this case.

Include repository.h in cache.h since we now need to have access to
these struct and variable definitions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h      | 4 ++++
 repository.c | 7 +++++++
 repository.h | 5 +++++
 setup.c      | 3 +++
 4 files changed, 19 insertions(+)

diff --git a/cache.h b/cache.h
index cb7fb7c004..c238688f6c 100644
--- a/cache.h
+++ b/cache.h
@@ -14,6 +14,7 @@
 #include "hash.h"
 #include "path.h"
 #include "sha1-array.h"
+#include "repository.h"
 
 #ifndef platform_SHA_CTX
 /*
@@ -77,6 +78,8 @@ struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
 };
 
+#define the_hash_algo the_repository->hash_algo
+
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
@@ -888,6 +891,7 @@ struct repository_format {
 	int version;
 	int precious_objects;
 	int is_bare;
+	int hash_algo;
 	char *work_tree;
 	struct string_list unknown_extensions;
 };
diff --git a/repository.c b/repository.c
index bb2fae5446..c6ceb9f9e4 100644
--- a/repository.c
+++ b/repository.c
@@ -64,6 +64,11 @@ void repo_set_gitdir(struct repository *repo, const char *path)
 	free(old_gitdir);
 }
 
+void repo_set_hash_algo(struct repository *repo, int hash_algo)
+{
+	repo->hash_algo = &hash_algos[hash_algo];
+}
+
 /*
  * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
  * Return 0 upon success and a non-zero value upon failure.
@@ -136,6 +141,8 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 	if (read_and_verify_repository_format(&format, repo->commondir))
 		goto error;
 
+	repo_set_hash_algo(repo, format.hash_algo);
+
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
diff --git a/repository.h b/repository.h
index 7f5e24a0a2..0329e40c7f 100644
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
 
+	/* Repository's current hash algorithm, as serialized on disk. */
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
index cf1b22cd30..50c6b2ab11 100644
--- a/setup.c
+++ b/setup.c
@@ -488,6 +488,7 @@ int read_repository_format(struct repository_format *format, const char *path)
 	memset(format, 0, sizeof(*format));
 	format->version = -1;
 	format->is_bare = -1;
+	format->hash_algo = GIT_HASH_SHA1;
 	string_list_init(&format->unknown_extensions, 1);
 	git_config_from_file(check_repo_format, path, format);
 	return format->version;
@@ -1113,6 +1114,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			repo_set_gitdir(the_repository, gitdir);
 			setup_git_env();
 		}
+		if (startup_info->have_repository)
+			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	}
 
 	strbuf_release(&dir);
