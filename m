Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480E3EEB571
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbjIHXLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344737AbjIHXLp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:11:45 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538881FE5
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:11:38 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39356)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdV-006MnC-Gf; Fri, 08 Sep 2023 17:11:37 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdU-009u13-CB; Fri, 08 Sep 2023 17:11:37 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:23 -0500
Message-Id: <20230908231049.2035003-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdU-009u13-CB;;;mid=<20230908231049.2035003-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+LSpB3Tq+4y9fRsFAzEsFiNdFIvEiqSJk=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 06/32] repository: Implement core.compatMap
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Add a configuration option to enable updating and reading from
compatibility hash maps when git accesses the reposotiry.

Add a helper function repo_enable_compat_map that when passed false
disables the compatiblily hash algorithm and when passed true computes
the compatibilty hash algorithm and sets "repo->compat_hash_algo".

For now the option is limited to being specified in ".git/config".
Perhaps in the future we can allow specifying it in ".gitconfig" as
well.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 Documentation/config/core.txt |  6 ++++++
 repository.c                  | 11 +++++++++++
 repository.h                  |  1 +
 setup.c                       |  5 +++++
 setup.h                       |  1 +
 5 files changed, 24 insertions(+)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index dfbdaf00b8bc..a9eb2006cc32 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -736,3 +736,9 @@ core.abbrev::
 	If set to "no", no abbreviation is made and the object names
 	are shown in their full length.
 	The minimum length is 4.
+
+core.compatMap::
+	Enables the use of a compat map to recored the hash in the
+	other object format.  This allows repositories in different
+	objects formats to interoperate.  It allows looking up old oids
+	in a repository that has been converted from sha1 to sha256.
diff --git a/repository.c b/repository.c
index a7679ceeaa45..de620d82bfc6 100644
--- a/repository.c
+++ b/repository.c
@@ -104,6 +104,16 @@ void repo_set_hash_algo(struct repository *repo, int hash_algo)
 	repo->hash_algo = &hash_algos[hash_algo];
 }
 
+void repo_enable_compat_map(struct repository *repo, int enable_compat)
+{
+	const struct git_hash_algo *other_algo =
+		&hash_algos[(hash_algo_by_ptr(repo->hash_algo) == GIT_HASH_SHA1) ?
+			GIT_HASH_SHA256 :
+			GIT_HASH_SHA1];
+
+	repo->compat_hash_algo = enable_compat ? other_algo : NULL;
+}
+
 /*
  * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
  * Return 0 upon success and a non-zero value upon failure.
@@ -184,6 +194,7 @@ int repo_init(struct repository *repo,
 		goto error;
 
 	repo_set_hash_algo(repo, format.hash_algo);
+	repo_enable_compat_map(repo, format.use_compat_map);
 	repo->repository_format_worktree_config = format.worktree_config;
 
 	/* take ownership of format.partial_clone */
diff --git a/repository.h b/repository.h
index 6c4130f0c36e..03cadf6d9a98 100644
--- a/repository.h
+++ b/repository.h
@@ -202,6 +202,7 @@ void repo_set_gitdir(struct repository *repo, const char *root,
 		     const struct set_gitdir_args *extra_args);
 void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
+void repo_enable_compat_map(struct repository *repo, int enable_compat);
 void initialize_the_repository(void);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
diff --git a/setup.c b/setup.c
index 18927a847b86..b4d32bd820f1 100644
--- a/setup.c
+++ b/setup.c
@@ -623,6 +623,8 @@ static int check_repo_format(const char *var, const char *value,
 			return 0;
 		}
 	}
+	else if (strcmp(var, "core.compatmap") == 0)
+		data->use_compat_map = git_config_bool(var, value);
 
 	return read_worktree_config(var, value, ctx, vdata);
 }
@@ -1564,8 +1566,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+			repo_enable_compat_map(the_repository, repo_fmt.use_compat_map);
 			the_repository->repository_format_worktree_config =
 				repo_fmt.worktree_config;
+
 			/* take ownership of repo_fmt.partial_clone */
 			the_repository->repository_format_partial_clone =
 				repo_fmt.partial_clone;
@@ -1657,6 +1661,7 @@ void check_repository_format(struct repository_format *fmt)
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository = 1;
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
+	repo_enable_compat_map(the_repository, fmt->use_compat_map);
 	the_repository->repository_format_worktree_config =
 		fmt->worktree_config;
 	the_repository->repository_format_partial_clone =
diff --git a/setup.h b/setup.h
index 58fd2605dd26..afa05b2b64f3 100644
--- a/setup.h
+++ b/setup.h
@@ -86,6 +86,7 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
+	int use_compat_map;
 	int sparse_index;
 	char *work_tree;
 	struct string_list unknown_extensions;
-- 
2.41.0

