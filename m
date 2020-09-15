Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DFAC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 01:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F6B207EA
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 01:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIOB66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:58:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59866 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbgIOB64 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Sep 2020 21:58:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6F15460457;
        Tue, 15 Sep 2020 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600135133;
        bh=y3e5277jEjMen43AQpFmCN7a/eQPaISD9ReBw09HCGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=vB3srcDKT1ebNOdKQxLkksFD1YL7YYxjkG0/zv19hJtGaeoIz1hHlT4oQsTf3ZKZc
         dbXQvusKWRSJryHVTufjoiPzklY/2I27nGlRPnhECrLwXu+TkDOvwn4d9QDoZoonqM
         2Iqi0fb3RwetMAvKOZP0ecfpWIhhoxAxTkHe4VGrdewXHF1luQFsAwJQntC7j29nQr
         gZrPwWfE5o9pH8vQaSIySuPXoOM4ptDboGIet5v1KFx5R9Soz20SWjPUbtbJPq+ClN
         92vnBH8sDIh3HHmpuB1dptJ2v5wcbveVhMuc7zvaXjxkN6A2YIbZJzoBkYMj8KGCxD
         K9WWdfuyTNttxUhFmTVMR+e/uSfxV8wuxvkKuYS3zf2nnom1iLfyjkRRN9Lt/E8LkK
         fevyZQHjtkwVM3nj1Sj+f9XxD+rHOIBIJ3nCyMyeKxV7mR6ch3JBmEVOtky/UliF16
         c+n3Mqz7v1eEB15Zho4cKN46jNbubdwdZunt8wdcCgs3y2yh0PN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: [PATCH v2] builtin/clone: avoid failure with GIT_DEFAULT_HASH
Date:   Tue, 15 Sep 2020 01:58:45 +0000
Message-Id: <20200915015845.4149976-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200911233815.2808426-1-sandals@crustytoothpaste.net>
References: <20200911233815.2808426-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user is cloning a SHA-1 repository with GIT_DEFAULT_HASH set to
"sha256", then we can end up with a repository where the repository
format version is 0 but the extensions.objectformat key is set to
"sha256".  This is both wrong (the user has a SHA-1 repository) and
nonfunctional (because the extension cannot be used in a v0 repository).

This happens because in a clone, we initially set up the repository, and
then change its algorithm based on what the remote side tells us it's
using.  We've initially set up the repository as SHA-256 in this case,
and then later on reset the repository version without clearing the
extension.

We could just always set the extension in this case, but that would mean
that our SHA-1 repositories weren't compatible with older Git versions,
even though there's no reason why they shouldn't be.  And we also don't
want to initialize the repository as SHA-1 initially, since that means
if we're cloning an empty repository, we'll have failed to honor the
GIT_DEFAULT_HASH variable and will end up with a SHA-1 repository, not a
SHA-256 repository.

Neither of those are appealing, so let's tell the repository
initialization code if we're doing a reinit like this, and if so, to
clear the extension if we're using SHA-1.  This makes sure we produce a
valid and functional repository and doesn't break any of our other use
cases.

Reported-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes since v1:
* Use git_config_set_gently to make things work with SHA-1 repos as well
  as SHA-256 repos.

Diff-intervalle contre v1 :
1:  32d3357460 ! 1:  1becbbbb50 builtin/clone: avoid failure with GIT_DEFAULT_HASH
    @@ builtin/init-db.c: void initialize_repository_version(int hash_algo)
      		git_config_set("extensions.objectformat",
      			       hash_algos[hash_algo].name);
     +	else if (reinit)
    -+		git_config_set("extensions.objectformat", NULL);
    ++		git_config_set_gently("extensions.objectformat", NULL);
      }
      
      static int create_default_files(const char *template_path,

 builtin/clone.c   |  2 +-
 builtin/init-db.c |  6 ++++--
 cache.h           |  2 +-
 t/t5601-clone.sh  | 10 ++++++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b087ee40c2..925a2e3dd6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1235,7 +1235,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		 * Now that we know what algorithm the remote side is using,
 		 * let's set ours to the same thing.
 		 */
-		initialize_repository_version(hash_algo);
+		initialize_repository_version(hash_algo, 1);
 		repo_set_hash_algo(the_repository, hash_algo);
 
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index cd3e760541..01bc648d41 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -179,7 +179,7 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
-void initialize_repository_version(int hash_algo)
+void initialize_repository_version(int hash_algo, int reinit)
 {
 	char repo_version_string[10];
 	int repo_version = GIT_REPO_VERSION;
@@ -195,6 +195,8 @@ void initialize_repository_version(int hash_algo)
 	if (hash_algo != GIT_HASH_SHA1)
 		git_config_set("extensions.objectformat",
 			       hash_algos[hash_algo].name);
+	else if (reinit)
+		git_config_set_gently("extensions.objectformat", NULL);
 }
 
 static int create_default_files(const char *template_path,
@@ -277,7 +279,7 @@ static int create_default_files(const char *template_path,
 		free(ref);
 	}
 
-	initialize_repository_version(fmt->hash_algo);
+	initialize_repository_version(fmt->hash_algo, 0);
 
 	/* Check filemode trustability */
 	path = git_path_buf(&buf, "config");
diff --git a/cache.h b/cache.h
index cee8aa5dc3..c0072d43b1 100644
--- a/cache.h
+++ b/cache.h
@@ -629,7 +629,7 @@ int path_inside_repo(const char *prefix, const char *path);
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
 	    const char *initial_branch, unsigned int flags);
-void initialize_repository_version(int hash_algo);
+void initialize_repository_version(int hash_algo, int reinit);
 
 void sanitize_stdfds(void);
 int daemonize(void);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 15fb64c18d..570d989795 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -631,6 +631,16 @@ test_expect_success CASE_INSENSITIVE_FS 'colliding file detection' '
 	test_i18ngrep "the following paths have collided" icasefs/warning
 '
 
+test_expect_success 'clone with GIT_DEFAULT_HASH' '
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		git init test
+	) &&
+	test_commit -C test foo &&
+	git clone test test-clone &&
+	git -C test-clone status
+'
+
 partial_clone_server () {
 	       SERVER="$1" &&
 
