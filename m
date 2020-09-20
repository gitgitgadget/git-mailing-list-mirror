Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538ECC43463
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 22:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014582076B
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 22:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgITWft (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 18:35:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35244 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgITWft (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Sep 2020 18:35:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7B4BD60734;
        Sun, 20 Sep 2020 22:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600641347;
        bh=IxAqL8qMXT8BFYPaL8bRjM8WitikKlTWhiS0/agxyiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=N9QivO9et/o3v+Cz+QSenv9/9I9YL4nCDspN1zIU4mdaZZ42PWetY0YbxQzTVchxl
         atsiX24u5mTdPlpr91C+OXFlXA2kAgOV8f3uUHkamIQ8GeuBK4B5thwybtCQOUmTFJ
         9XZqkI53nB7VBTf3AU4UplGW6RS/oICFiEVcnYD9pfV52BtBJ7K2kiG6iaMdoSa2SG
         cWkqiEdH0yPmSo303AKQycHDzYSi3eGSQDg47UJD7gC/h2QhzxoQ+3SaOr1ysCRsze
         MFNi8Ixa50rt6RR+9va3fZ50Xo4+wLx0L9mbLKpgQbzdTaTI5I8WKWxQFxZsaRwBHd
         csgT/Qi+F7tQlrSVilNeTLxG3hMtvmUWLkFTpGhr7ZVzH0mj8yaKMXqYcz44BIfHQE
         UHRO3kyj8lAxvs418gKlVKwZBy4xE+BRFOYx0OhqWLDwkHLk9WjoOlEDvREE6lxTSg
         4h7XqZgJjU966Qz/vh1jjaLdgUXubC1a/7KXZkqENamFmOldPYa
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: [PATCH v3] builtin/clone: avoid failure with GIT_DEFAULT_HASH
Date:   Sun, 20 Sep 2020 22:35:41 +0000
Message-Id: <20200920223541.1299038-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200911233815.2808426-1-sandals@crustytoothpaste.net>
References: <20200911233815.2808426-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Diff-intervalle contre v2 :
1:  1becbbbb50 ! 1:  004a7b86f8 builtin/clone: avoid failure with GIT_DEFAULT_HASH
    @@ t/t5601-clone.sh: test_expect_success CASE_INSENSITIVE_FS 'colliding file detect
     +test_expect_success 'clone with GIT_DEFAULT_HASH' '
     +	(
     +		sane_unset GIT_DEFAULT_HASH &&
    -+		git init test
    ++		git init --object-format=sha1 test-sha1 &&
    ++		git init --object-format=sha256 test-sha256
     +	) &&
    -+	test_commit -C test foo &&
    -+	git clone test test-clone &&
    -+	git -C test-clone status
    ++	test_commit -C test-sha1 foo &&
    ++	test_commit -C test-sha256 foo &&
    ++	GIT_DEFAULT_HASH=sha1 git clone test-sha256 test-clone-sha256 &&
    ++	GIT_DEFAULT_HASH=sha256 git clone test-sha1 test-clone-sha1 &&
    ++	git -C test-clone-sha1 status &&
    ++	git -C test-clone-sha256 status
     +'
     +
      partial_clone_server () {

 builtin/clone.c   |  2 +-
 builtin/init-db.c |  6 ++++--
 cache.h           |  2 +-
 t/t5601-clone.sh  | 14 ++++++++++++++
 4 files changed, 20 insertions(+), 4 deletions(-)

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
index 15fb64c18d..b6c8312da1 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -631,6 +631,20 @@ test_expect_success CASE_INSENSITIVE_FS 'colliding file detection' '
 	test_i18ngrep "the following paths have collided" icasefs/warning
 '
 
+test_expect_success 'clone with GIT_DEFAULT_HASH' '
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		git init --object-format=sha1 test-sha1 &&
+		git init --object-format=sha256 test-sha256
+	) &&
+	test_commit -C test-sha1 foo &&
+	test_commit -C test-sha256 foo &&
+	GIT_DEFAULT_HASH=sha1 git clone test-sha256 test-clone-sha256 &&
+	GIT_DEFAULT_HASH=sha256 git clone test-sha1 test-clone-sha1 &&
+	git -C test-clone-sha1 status &&
+	git -C test-clone-sha256 status
+'
+
 partial_clone_server () {
 	       SERVER="$1" &&
 
