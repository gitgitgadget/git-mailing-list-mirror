Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5C0328635
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787481066; cv=none; b=YNgxxblq2/IgWVLkxoIfivlaBfBMRUa7Tt027XOFc1MahJ/sTq8qhjscsQlEc/+2EFDBqTT7PEBn/r/r0dhr9MXTPYcSJpSZPGAKe5HR9U9bYBAdRN8ZK5wo2y9YYSfXS9jhuK2LHNwtxViXgE5N/Qp++bQDhQGzsNXy3rX/s7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787481066; c=relaxed/simple;
	bh=ongbOQa8C3us1UnI07llcgBOP8uZR7xUoBD/V219MnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1EG9b9UkhzO1IGHblounb1AiyK7Ww80RoL5LsnZ2aX/RraX4z/zFrvTr8scCU1dxxU79eOh+9ZySS/DF/MiCbVpt35plSIXW5BwZQjNXKzYeAZxJgXgO1U/auC6BU0NBRslRQhj2QoAOLg7tUikbcQI+b+q11zauS8J7Voh3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dcJyrjTw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dcJyrjTw"
Received: from [192.168.4.34] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6EBA520B7129;
	Sun, 23 Aug 2026 03:30:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6EBA520B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787481032;
	bh=LLRc0n1qLwo/ZpdmyN4Uk0h0boSq62YzOXKzSh2ehZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dcJyrjTwXg60nqghXIJsxMCkJYHdBZApM5DAoNGK29sGBNrn2Qo0ZTFkdQ8hhSKhI
	 v1ATIU+r/NZyfOn4zFYnAUMtYXfXhi++CgYbU/2+8ppLimPk4nc0eH3tiY3zzbfJfo
	 G0V5hzSLLMVTejnlzt2Q07IFdw2m/xPAiCcHLKc0=
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Date: Sun, 23 Aug 2026 20:28:28 +1000
Subject: [PATCH v2 3/3] config: read global scope via config_sequence
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-fix-config-list-global-home-and-xdg-v2-3-b29cc63f017b@microsoft.com>
References: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
In-Reply-To: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
To: git@vger.kernel.org
Cc: Nils Fahldieck <nils@fahldieck.de>, Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Delilah Ashley Wu <delilahwu@microsoft.com>, 
 Derrick Stolee <stolee@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Jade Lovelace <lists@jade.fyi>, Glen Choo <glencbz@gmail.com>
X-Mailer: b4 0.15.2

From: Delilah Ashley Wu <delilahwu@microsoft.com>

When both `$HOME/.gitconfig` and `$XDG_CONFIG_HOME/git/config` exist,
`git config list --global` and `git config get --global` read the home
configuration file but ignore the XDG file. Bug reporters expected these
`--global` scoped commands to read both files [1][2], which would be
consistent with the documentation and the behaviour of the unscoped
variants. For example, `git config list` and `git config get` (without
`--global`) read from both files (in addition to system-wide and
repository-specific entries). We should address this inconsistency by
respecting both files during `--global` read operations.

The implementation assumes that each configuration scope corresponds to
a single file. So during `--global` read operations, Git selects one
file path to pass to `git_config_from_file_with_options(file)`. Because
the global scope can come from more than one file, we should use another
method to read the global configuration.

Since `git config list --show-scope --show-origin` reads both the home
and XDG files, there must be existing code that respects both locations,
namely `do_git_config_sequence()` which reads from all scopes. Introduce
flags to ignore all but the global scope (i.e. ignore system, local,
worktree, and cmdline). Then, reuse the function to read only the global
scope when `--global` is specified. This was the suggested solution [3]
in the original bug report [1].

Modify tests to check that both configuration files are respected during
`--global` read operations. Also, add additional tests to supplement the
regression tests from the previous patch, "config: let sequence require
a successful file". The expected behaviour of `git config list` is:
  - Without `--global`, it should not bail on unreadable/non-existent
    global config files.

  - With `--global`, it should bail when both `$HOME/.gitconfig` and
    `$XDG_CONFIG_HOME/git/config` are unreadable. It should not bail
    when one or more of them is readable.

Implementation notes:
  - The `ignore_global` flag is not set anywhere, so the
    `if (!opts->ignore_global)` condition is always met. Include the
    flag for completeness, but we can remove it if desired.

  - Keep populating `opts->source.file` in `builtin/config.c` because it
    is used as the destination config file for write operations. The
    proposed changes could convolute the code because there is no single
    source of truth for the config file locations in the global scope.
    Add a comment to clarify this.

[1] https://lore.kernel.org/git/CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com/
[2] https://lore.kernel.org/git/CAAdFe9yhBk-WecVzCTsjQ-4Z3AZAbpP+w+B076ouM3qX6d1WAg@mail.gmail.com/
[3] https://lore.kernel.org/git/kl6ly1oze7wb.fsf@chooglen-macbookpro.roam.corp.google.com

Reported-by: Jade Lovelace <lists@jade.fyi>
Reported-by: Nils Fahldieck <nils@fahldieck.de>
Suggested-by: Glen Choo <glencbz@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
---
 builtin/config.c     | 11 ++++++++
 config.c             | 37 +++++++++++++++------------
 config.h             |  2 ++
 t/t1300-config.sh    | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t1306-xdg-files.sh |  5 +++-
 5 files changed, 109 insertions(+), 17 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 0882899c3f..a7468e86d3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -957,6 +957,17 @@ static void location_options_init(struct config_location_options *opts,
 	}
 
 	if (opts->use_global_config) {
+		/*
+		 * Since global config is sourced from more than one location,
+		 * read it using `do_git_config_sequence()` with other scopes
+		 * ignored. However, writing global config should point to a
+		 * single destination, set in `opts->source.file`.
+		 */
+		opts->options.ignore_repo = 1;
+		opts->options.ignore_cmdline = 1;
+		opts->options.ignore_worktree = 1;
+		opts->options.ignore_system = 1;
+
 		opts->source.file = opts->file_to_free = git_global_config();
 		if (!opts->source.file)
 			/*
diff --git a/config.c b/config.c
index 4c958f46bf..acad89102d 100644
--- a/config.c
+++ b/config.c
@@ -1587,26 +1587,31 @@ static int do_git_config_sequence(const struct config_options *opts,
 		worktree_config = NULL;
 	}
 
-	if (git_config_system() && system_config &&
+	if (!opts->ignore_system && git_config_system() && system_config &&
 	    !access_or_die(system_config, R_OK,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
 		attempt_git_config_from_file_with_options(fn, system_config, data,
 							  CONFIG_SCOPE_SYSTEM, NULL,
 							  &success_count, &ret);
 
-	git_global_config_paths(&user_config, &xdg_config);
+	if (!opts->ignore_global) {
+		git_global_config_paths(&user_config, &xdg_config);
 
-	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
-		attempt_git_config_from_file_with_options(fn, xdg_config,
-							  data,
-							  CONFIG_SCOPE_GLOBAL,
-							  NULL, &success_count, &ret);
+		if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
+			attempt_git_config_from_file_with_options(fn, xdg_config,
+								  data,
+								  CONFIG_SCOPE_GLOBAL,
+								  NULL, &success_count, &ret);
 
-	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
-		attempt_git_config_from_file_with_options(fn, user_config,
-							  data,
-							  CONFIG_SCOPE_GLOBAL,
-							  NULL, &success_count, &ret);
+		if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
+			attempt_git_config_from_file_with_options(fn, user_config,
+								  data,
+								  CONFIG_SCOPE_GLOBAL,
+								  NULL, &success_count, &ret);
+
+		free(xdg_config);
+		free(user_config);
+	}
 
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
@@ -1624,8 +1629,6 @@ static int do_git_config_sequence(const struct config_options *opts,
 		die(_("unable to parse command-line config"));
 
 	free(system_config);
-	free(xdg_config);
-	free(user_config);
 	free(repo_config);
 	free(worktree_config);
 
@@ -1659,7 +1662,8 @@ int config_with_options(config_fn_t fn, void *data,
 	 */
 	if (config_source && config_source->use_stdin) {
 		ret = git_config_from_stdin(fn, data, config_source->scope);
-	} else if (config_source && config_source->file) {
+	} else if (config_source && config_source->file &&
+		   config_source->scope != CONFIG_SCOPE_GLOBAL) {
 		ret = git_config_from_file_with_options(fn, config_source->file,
 							data, config_source->scope,
 							NULL);
@@ -1667,7 +1671,8 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 					       data, config_source->scope);
 	} else {
-		ret = do_git_config_sequence(opts, repo, fn, data, 0);
+		ret = do_git_config_sequence(opts, repo, fn, data,
+					     config_source && config_source->scope == CONFIG_SCOPE_GLOBAL);
 	}
 
 	if (inc.remote_urls) {
diff --git a/config.h b/config.h
index 31fe3e2961..eb2d7a2843 100644
--- a/config.h
+++ b/config.h
@@ -87,6 +87,8 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 
 struct config_options {
 	unsigned int respect_includes : 1;
+	unsigned int ignore_system : 1;
+	unsigned int ignore_global : 1;
 	unsigned int ignore_repo : 1;
 	unsigned int ignore_worktree : 1;
 	unsigned int ignore_cmdline : 1;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 2ce85b76ff..b6fd6e24ea 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2469,6 +2469,77 @@ test_expect_success 'list --global with nonexistent global config fails' '
 	test_must_fail git config ${mode_prefix}list --global --show-scope
 '
 
+test_expect_success 'list and get --global with only home' '
+	rm -f "$HOME"/.config/git/config &&
+
+	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
+	cat >"$HOME"/.gitconfig <<-EOF &&
+	[home]
+		config = true
+	EOF
+
+	cat >expect <<-EOF &&
+	global	home.config=true
+	EOF
+	git config ${mode_prefix}list --global --show-scope >actual &&
+	test_cmp expect actual &&
+
+	echo true >expect &&
+	git config ${mode_get} --global home.config >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'list and get --global with only xdg' '
+	rm -f "$HOME"/.gitconfig &&
+
+	test_when_finished rm -rf \"\$HOME\"/.config/git &&
+	mkdir -p "$HOME"/.config/git &&
+	cat >"$HOME"/.config/git/config <<-EOF &&
+	[xdg]
+		config = true
+	EOF
+
+	cat >expect <<-EOF &&
+	global	xdg.config=true
+	EOF
+	git config ${mode_prefix}list --global --show-scope >actual &&
+	test_cmp expect actual &&
+
+	echo true >expect &&
+	git config ${mode_get} --global xdg.config >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'list and get --global with both home and xdg' '
+	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
+	cat >"$HOME"/.gitconfig <<-EOF &&
+	[home]
+		config = home
+	EOF
+
+	test_when_finished rm -rf \"\$HOME\"/.config/git &&
+	mkdir -p "$HOME"/.config/git &&
+	cat >"$HOME"/.config/git/config <<-EOF &&
+	[xdg]
+		config = xdg
+	EOF
+
+	cat >expect <<-EOF &&
+	global	file:$HOME/.config/git/config	xdg.config=xdg
+	global	file:$HOME/.gitconfig	home.config=home
+	EOF
+	git config ${mode_prefix}list --global --show-scope --show-origin >actual &&
+	test_cmp expect actual &&
+
+	echo xdg >expect &&
+	git config ${mode_get} --global xdg.config >actual &&
+	test_cmp expect actual &&
+
+	echo home >expect &&
+	git config ${mode_get} --global home.config >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'override global and system config' '
 	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
 	cat >"$HOME"/.gitconfig <<-EOF &&
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 40d3c42618..3a9a04bcc1 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -52,6 +52,8 @@ test_expect_success 'read with --get: xdg file exists and ~/.gitconfig exists' '
 	echo "	name = read_gitconfig" >>.gitconfig &&
 	echo read_gitconfig >expected &&
 	git config --get user.name >actual &&
+	test_cmp expected actual &&
+	git config --global --get user.name >actual &&
 	test_cmp expected actual
 '
 
@@ -68,7 +70,8 @@ test_expect_success 'read with --list: xdg file exists and ~/.gitconfig exists'
 	>.gitconfig &&
 	echo "[user]" >.gitconfig &&
 	echo "	name = read_gitconfig" >>.gitconfig &&
-	echo user.name=read_gitconfig >expected &&
+	echo user.name=read_config >expected &&
+	echo user.name=read_gitconfig >>expected &&
 	git config --global --list >actual &&
 	test_cmp expected actual
 '

-- 
2.54.0

