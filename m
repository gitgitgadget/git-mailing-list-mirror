Received: from www133.your-server.de (www133.your-server.de [88.198.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B36BF4F8
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tb6.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tb6.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tb6.eu header.i=@tb6.eu header.b="bWRZx7Nz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tb6.eu;
	s=default2109; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CK30jb7VxSe7xNTs25gFONqgtfbPa2Usc0Kw49bR1RI=; b=bWRZx7NzqScXA+c05km//XM4de
	p/QvNJTDRWZVfZh2O/K0EmUpsxBtZL++xCmaiZoqgKL1dwyrnk7t/0RkwKb9XovrWP+6s4O9ONCmJ
	1+QYvTUukMifqX5c1L02N9R0DPnOhzj+M5dOvuj7W0TghPEorTlYT07HF0oT9rVOfsa0qm0XPyvqr
	QPB1ORaCHZ9Iy7i+nu7x0EtyjCnUzWj3DnAvmSoqGcy+Plp8K201JfHXuHLacHp1+UQsWEni5MrKR
	KkVKGniPiXr72zkkHlElibyP65ZJP0plb1Tz8PLQXxmfJv64SPxm60r8Atdod/tTGjvsRuD1PmXU3
	1wJk5xPA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www133.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@tb6.eu>)
	id 1rMDEe-000NFM-2u; Sat, 06 Jan 2024 21:25:36 +0100
Received: from [2a02:810d:1380:a8:3d72:5b35:9164:f910] (helo=localhost.localdomain)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <dev@tb6.eu>)
	id 1rMDEd-000Udz-SE; Sat, 06 Jan 2024 21:25:35 +0100
From: Tamino Bauknecht <dev@tb6.eu>
To: git@vger.kernel.org
Cc: Tamino Bauknecht <dev@tb6.eu>
Subject: [PATCH v3] fetch: add new config option fetch.all
Date: Sat,  6 Jan 2024 21:17:01 +0100
Message-ID: <20240106202352.7253-2-dev@tb6.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqa5pjpxm6.fsf@gitster.g>
References: <xmqqa5pjpxm6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: dev@tb6.eu
X-Virus-Scanned: Clear (ClamAV 0.103.10/27146/Sat Jan  6 10:36:45 2024)

This commit introduces the new boolean configuration option fetch.all
which allows to fetch all available remotes by default. The config
option can be overridden by explicitly specifying a remote or by using
--no-all.
The behavior for --all is unchanged and calling git-fetch with --all and
a remote will still result in an error.

The config option was also added to the config documentation and new
tests cover the expected behavior.
Additionally, --no-all was added to the command-line documentation of
git-fetch.

Signed-off-by: Tamino Bauknecht <dev@tb6.eu>
---
Thank you for your detailed explanation. I misunderstood your suggestion
and didn't know that the concept of negated options ("no-...") already
exists for most options in git and utilizing it definitely makes sense.
I also agree with you that "default" would be ambiguous.

I reworked the patch to respect --no-all and added the flag to the
documentation.

The previous tests also had an issue that the check could be true even
if no fetch was executed for those that tested for the "default" fetch
behavior (since all the branches from origin already existed anyway).
If someone can think of a more elegant solution, I'll gladly improve it
further.

 Documentation/config/fetch.txt  |   6 ++
 Documentation/fetch-options.txt |   5 +-
 builtin/fetch.c                 |  20 +++-
 t/t5514-fetch-multiple.sh       | 161 ++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index aea5b97477..d7dc461bd1 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -50,6 +50,12 @@ fetch.pruneTags::
 	refs. See also `remote.<name>.pruneTags` and the PRUNING
 	section of linkgit:git-fetch[1].
 
+fetch.all::
+	If true, fetch will attempt to update all available remotes.
+	This behavior can be overridden by passing `--no-all` or by
+	explicitly specifying one or more remote(s) to fetch from.
+	Defaults to false.
+
 fetch.output::
 	Control how ref update status is printed. Valid values are
 	`full` and `compact`. Default value is `full`. See the
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index a1d6633a4f..5e70f6d2e4 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,5 +1,6 @@
---all::
-	Fetch all remotes.
+--[no-]all::
+	Fetch all remotes. This overrides the configuration option
+	`fetch.all`.
 
 -a::
 --append::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a284b970ef..5a0b249c07 100644
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
@@ -2132,7 +2139,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	const char *bundle_uri;
 	struct string_list list = STRING_LIST_INIT_DUP;
 	struct remote *remote = NULL;
-	int all = 0, multiple = 0;
+	int all = -1, multiple = 0;
 	int result = 0;
 	int prune_tags_ok = 1;
 	int enable_auto_gc = 1;
@@ -2148,7 +2155,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	struct option builtin_fetch_options[] = {
 		OPT__VERBOSITY(&verbosity),
-		OPT_BOOL(0, "all", &all,
+		OPT_COUNTUP(0, "all", &all,
 			 N_("fetch from all remotes")),
 		OPT_BOOL(0, "set-upstream", &set_upstream,
 			 N_("set upstream for git pull/fetch")),
@@ -2337,11 +2344,18 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
 		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
 
-	if (all) {
+	if (all > 0) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
 		else if (argc > 1)
 			die(_("fetch --all does not make sense with refspecs"));
+	}
+
+	if (all > 0 || (config.all > 0 && !argc && all < 0)) {
+		/*
+		 * Only use fetch.all config option if no remotes were
+		 * explicitly given and if no --no-all was passed
+		 */
 		(void) for_each_remote(get_one_remote_for_fetch, &list);
 
 		/* do not do fetch_multiple() of one */
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index a95841dc36..63cd730718 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -24,6 +24,15 @@ setup_repository () {
 	)
 }
 
+setup_test_clone () {
+	test_dir="$1" &&
+	git clone one "$test_dir" &&
+	for r in one two three
+	do
+		git -C "$test_dir" remote add "$r" "../$r" || return 1
+	done
+}
+
 test_expect_success setup '
 	setup_repository one &&
 	setup_repository two &&
@@ -209,4 +218,156 @@ test_expect_success 'git fetch --multiple --jobs=0 picks a default' '
 	 git fetch --multiple --jobs=0)
 '
 
+create_fetch_all_expect () {
+	cat >expect <<-\EOF || return 1
+	  one/main
+	  one/side
+	  origin/HEAD -> origin/main
+	  origin/main
+	  origin/side
+	  three/another
+	  three/main
+	  three/side
+	  two/another
+	  two/main
+	  two/side
+	EOF
+}
+
+for fetch_all in true false
+do
+	test_expect_success "git fetch --all (works with fetch.all = $fetch_all)" '
+		test_dir="test_fetch_all_$fetch_all" &&
+		setup_test_clone "$test_dir" &&
+		(
+			cd "$test_dir" &&
+			git config fetch.all $fetch_all &&
+			git fetch --all &&
+			create_fetch_all_expect &&
+			git branch -r >actual &&
+			test_cmp expect actual
+		)
+	'
+done
+
+test_expect_success 'git fetch (fetch all remotes with fetch.all = true)' '
+	setup_test_clone test9 &&
+	(
+		cd test9 &&
+		git config fetch.all true &&
+		git fetch &&
+		git branch -r >actual &&
+		create_fetch_all_expect &&
+		test_cmp expect actual
+	)
+'
+
+create_fetch_one_expect () {
+	cat >expect <<-\EOF || return 1
+	  one/main
+	  one/side
+	  origin/HEAD -> origin/main
+	  origin/main
+	  origin/side
+	EOF
+}
+
+test_expect_success 'git fetch one (explicit remote overrides fetch.all)' '
+	setup_test_clone test10 &&
+	(
+		cd test10 &&
+		git config fetch.all true &&
+		git fetch one &&
+		create_fetch_one_expect &&
+		git branch -r >actual &&
+		test_cmp expect actual
+	)
+'
+
+create_fetch_two_as_origin_expect () {
+	cat >expect <<-\EOF || return 1
+	  origin/HEAD -> origin/main
+	  origin/another
+	  origin/main
+	  origin/side
+	EOF
+}
+
+test_expect_success 'git config fetch.all false (fetch only default remote)' '
+	setup_test_clone test11 &&
+	(
+		cd test11 &&
+		git config fetch.all false &&
+		git remote set-url origin ../two &&
+		git fetch &&
+		create_fetch_two_as_origin_expect &&
+		git branch -r >actual &&
+		test_cmp expect actual
+	)
+'
+
+for fetch_all in true false
+do
+	test_expect_success "git fetch --no-all (fetch only default remote with fetch.all = $fetch_all)" '
+		test_dir="test_no_all_fetch_all_$fetch_all" &&
+		setup_test_clone "$test_dir" &&
+		(
+			cd "$test_dir" &&
+			git config fetch.all $fetch_all &&
+			git remote set-url origin ../two &&
+			git fetch --no-all &&
+			create_fetch_two_as_origin_expect &&
+			git branch -r >actual &&
+			test_cmp expect actual
+		)
+	'
+done
+
+test_expect_success 'git fetch --no-all (fetch only default remote without fetch.all)' '
+	setup_test_clone test12 &&
+	(
+		cd test12 &&
+		git config --unset-all fetch.all || true &&
+		git remote set-url origin ../two &&
+		git fetch --no-all &&
+		create_fetch_two_as_origin_expect &&
+		git branch -r >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'git fetch --all --no-all (fetch only default remote)' '
+	setup_test_clone test13 &&
+	(
+		cd test13 &&
+		git remote set-url origin ../two &&
+		git fetch --all --no-all &&
+		create_fetch_two_as_origin_expect &&
+		git branch -r >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'git fetch --no-all one (fetch only explicit remote)' '
+	setup_test_clone test14 &&
+	(
+		cd test14 &&
+		git fetch --no-all one &&
+		create_fetch_one_expect &&
+		git branch -r >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'git fetch --no-all --all (fetch all remotes)' '
+	setup_test_clone test15 &&
+	(
+		cd test15 &&
+		git fetch --no-all --all &&
+		create_fetch_all_expect &&
+		git branch -r >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.43.0

