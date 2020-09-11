Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7461FC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 23:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32366221EB
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 23:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKXj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 19:39:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57912 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgIKXjP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Sep 2020 19:39:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2C39260457;
        Fri, 11 Sep 2020 23:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599867510;
        bh=bSnv8rO5zyGlLq3BS8U56KCN1agj+UmGOjq70VzbUeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lnz2sDy1on37xjWi0PogKG/21v181tzgEPkddrfNxxK/r9LNwIo0v+e05dzV4AJ2r
         9H2SJdwW/KxR2TTRlVftUrAy5B3m1Zfq6Mc7A+4nwF+/skBnrL3zZ2YymoR1moIa3o
         B0bRbHF3mvGwTqtsmVN6FZkpBYXjLKsEM1vWLcs3pB5fciieCVo4ta123KU2LX2D6e
         ezUnZ3PiDANDrwqeaQlWUw7gdnkKoivgPLrPQzZaVCXVZkF1XOg11hXBv9kMcvmtmz
         TQnudDCOz7pDzXJvaB3zaxkqo97usBMdRBX4E7teNiW31NpkohzPeDHlZ0lJ1sVz4m
         R7CGaFVRe0+JDVVrI1xTh/5/QU45KsB3k+wkEv+bbmg84SO652KXWOKEn2vnF7l6V6
         VJPDmLmUfv+JJETUWEKVpvY4Co7+yvd/lpECpJi9s/xklY5lHDtqVKEDTyZdsD+dzt
         B9XLPuLCNrUAGdse0oyGc4F4oaUIxtRz022ftlcrE3LzilwtRlM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>
Subject: [PATCH] builtin/clone: avoid failure with GIT_DEFAULT_HASH
Date:   Fri, 11 Sep 2020 23:38:15 +0000
Message-Id: <20200911233815.2808426-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200911151717.43475-1-matheus.bernardino@usp.br>
References: <20200911151717.43475-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
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
index cd3e760541..57e15e93da 100644
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
+		git_config_set("extensions.objectformat", NULL);
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
 
