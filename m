Received: from www133.your-server.de (www133.your-server.de [88.198.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349D2375A
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tb6.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tb6.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tb6.eu header.i=@tb6.eu header.b="A8ycutBT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tb6.eu;
	s=default2109; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PyjpT9hR8ejbGYkr4SpCUjXQ9GLV/wUtRO8o5WE5FQ8=; b=A8ycutBTlcBpBeZrR/hZ+LQjsx
	0mKKMEXp2Dh1OKn9Xx2MZf82SsalNJ2mGQYZpSVyj7ouctnEnIsg6dUHWZ1pVZwaIgLKYy5PlIzCg
	wIDeo6Pmi6Dq3jrH76XfgNrWYOWlEGhj6p7t7kXz1I2R2AWN10uydSg2cHIlhezCgEseD6FPgWXjD
	q7yJjHfSHRehnfwd/FC/9m8hmhrHu8F5BebBEc5AiMAnSwqOXkVXgWzYVFKBIv5u4SSsBsfU1mCof
	XpgymhbtlezPfuDy7L2osPcMAXB5f3Ce+bjU0FuUpTuRxGmR8P6m/btpdX7jPrnqdne7i4GyyXfqB
	3XT1YZZA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www133.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@tb6.eu>)
	id 1rLOqj-000OLh-8K; Thu, 04 Jan 2024 15:37:33 +0100
Received: from [2a02:810d:1380:a8:3d72:5b35:9164:f910] (helo=localhost.localdomain)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <dev@tb6.eu>)
	id 1rLOqi-000AS7-TI; Thu, 04 Jan 2024 15:37:32 +0100
From: Tamino Bauknecht <dev@tb6.eu>
To: git@vger.kernel.org
Cc: Tamino Bauknecht <dev@tb6.eu>
Subject: [PATCH] fetch: add new config option fetch.all
Date: Thu,  4 Jan 2024 15:33:55 +0100
Message-ID: <20240104143656.615117-1-dev@tb6.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: dev@tb6.eu
X-Virus-Scanned: Clear (ClamAV 0.103.10/27144/Thu Jan  4 10:39:55 2024)

This commit introduces the new boolean configuration option fetch.all
which allows to fetch all available remotes by default. The config
option can be overridden by explicitly specifying a remote.
The behavior for --all is unchanged and calling git-fetch with --all and
a remote will still result in an error.

The option was also added to the config documentation and new tests
cover the expected behavior.
---
 Documentation/config/fetch.txt |  4 ++
 builtin/fetch.c                | 18 +++++--
 t/t5514-fetch-multiple.sh      | 88 ++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index aea5b97477..4f12433874 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -50,6 +50,10 @@ fetch.pruneTags::
 	refs. See also `remote.<name>.pruneTags` and the PRUNING
 	section of linkgit:git-fetch[1].
 
+fetch.all::
+	If true, fetch will attempt to update all available remotes.
+	This behavior can be overridden by explicitly specifying a remote.
+
 fetch.output::
 	Control how ref update status is printed. Valid values are
 	`full` and `compact`. Default value is `full`. See the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a284b970ef..367f8d3c74 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -102,6 +102,7 @@ static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
+	int all;
 	int prune;
 	int prune_tags;
 	int show_forced_updates;
@@ -115,6 +116,11 @@ static int git_fetch_config(const char *k, const char *v,
 {
 	struct fetch_config *fetch_config = cb;
 
+	if (!strcmp(k, "fetch.all")) {
+		fetch_config->all = git_config_bool(k, v);
+		return 0;
+	}
+
 	if (!strcmp(k, "fetch.prune")) {
 		fetch_config->prune = git_config_bool(k, v);
 		return 0;
@@ -2121,6 +2127,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	struct fetch_config config = {
 		.display_format = DISPLAY_FORMAT_FULL,
+		.all = -1,
 		.prune = -1,
 		.prune_tags = -1,
 		.show_forced_updates = 1,
@@ -2337,11 +2344,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
 		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
 
-	if (all) {
-		if (argc == 1)
-			die(_("fetch --all does not take a repository argument"));
-		else if (argc > 1)
-			die(_("fetch --all does not make sense with refspecs"));
+	if (all && argc == 1) {
+		die(_("fetch --all does not take a repository argument"));
+	} else if (all && argc > 1) {
+		die(_("fetch --all does not make sense with refspecs"));
+	} else if (all || (config.all > 0 && argc == 0)) {
+		/* Only use fetch.all config option if no remotes were explicitly given */
 		(void) for_each_remote(get_one_remote_for_fetch, &list);
 
 		/* do not do fetch_multiple() of one */
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index a95841dc36..cd0aee97f9 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -209,4 +209,92 @@ test_expect_success 'git fetch --multiple --jobs=0 picks a default' '
 	 git fetch --multiple --jobs=0)
 '
 
+cat > expect << EOF
+  one/main
+  one/side
+  origin/HEAD -> origin/main
+  origin/main
+  origin/side
+  three/another
+  three/main
+  three/side
+  two/another
+  two/main
+  two/side
+EOF
+
+test_expect_success 'git fetch (fetch all remotes with fetch.all = true)' '
+	(git clone one test9 &&
+	 cd test9 &&
+	 git config fetch.all true &&
+	 git remote add one ../one &&
+	 git remote add two ../two &&
+	 git remote add three ../three &&
+	 git fetch &&
+	 git branch -r > output &&
+	 test_cmp ../expect output)
+'
+
+test_expect_success 'git fetch --all (works with fetch.all = true)' '
+	(git clone one test10 &&
+	 cd test10 &&
+	 git config fetch.all true &&
+	 git remote add one ../one &&
+	 git remote add two ../two &&
+	 git remote add three ../three &&
+	 git fetch --all &&
+	 git branch -r > output &&
+	 test_cmp ../expect output)
+'
+
+test_expect_success 'git fetch --all (works with fetch.all = false)' '
+	(git clone one test11 &&
+	 cd test11 &&
+	 git config fetch.all false &&
+	 git remote add one ../one &&
+	 git remote add two ../two &&
+	 git remote add three ../three &&
+	 git fetch --all &&
+	 git branch -r > output &&
+	 test_cmp ../expect output)
+'
+
+cat > expect << EOF
+  one/main
+  one/side
+  origin/HEAD -> origin/main
+  origin/main
+  origin/side
+EOF
+
+test_expect_success 'git fetch one (explicit remote overrides fetch.all)' '
+	(git clone one test12 &&
+	 cd test12 &&
+	 git config fetch.all true &&
+	 git remote add one ../one &&
+	 git remote add two ../two &&
+	 git remote add three ../three &&
+	 git fetch one &&
+	 git branch -r > output &&
+	 test_cmp ../expect output)
+'
+
+cat > expect << EOF
+  origin/HEAD -> origin/main
+  origin/main
+  origin/side
+EOF
+
+test_expect_success 'git config fetch.all false (fetch only default remote)' '
+	(git clone one test13 &&
+	 cd test13 &&
+	 git config fetch.all false &&
+	 git remote add one ../one &&
+	 git remote add two ../two &&
+	 git remote add three ../three &&
+	 git fetch &&
+	 git branch -r > output &&
+	 test_cmp ../expect output)
+'
+
 test_done
-- 
2.43.0

