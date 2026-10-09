Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FF6373C1A
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535987; cv=none; b=qkrbF3e0gIPID3Wa/Ntvn9m8TKsmNxdBWunBnYOzoujWc7kJtDXNezThJoLIehyxcVmTQsUAphsfZ00dBa9R1qNhUHvGVBHNjLvHUnRNT7cQGjM555+tWwY/cbcM7vu11GH++eAd7Uy6VgOaihHym8CY9TMnUjdFlj5gTtng23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535987; c=relaxed/simple;
	bh=tdCDDDSuD80MtAruHwyR1S54bKhpgxp6QmUJflDt0mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GIM9XjMqZIQcLacKEWKPU27t/+H19o/q0TC0vsssR3F8KwZ5KlpH8mdZiccLKbwPKwjui+VW1zddhPvvyqvU1ybn5gMKI6Vw7QaHtb2nJJLgOLS/t7UmEePlh6x0azuZPiLp77LoUqbXHscg+D9sGV6OxY0Qr2/WlNfyhtxr2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SfE6vTZ4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SfE6vTZ4"
Received: from [192.168.4.34] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4604F20B7168;
	Fri,  9 Oct 2026 01:52:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4604F20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791535984;
	bh=wamzCfUYbOAqBKUY/Gr05Vq5NV9lihDGjpfExZXkpy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SfE6vTZ4BRUq1FP81iJsLQfy0sL4l2PM99hvIi9iQwW3LV205xoFxVSUIqzLiR/Bb
	 8pTTK36QKNkwLks6tP00OjFyQ9jV8tp3ub3b06UZTI0PUWD1c29EvZJ1KbzrMvuZrR
	 BFEc0xrpxPZq+PuIrBtTOeCOycotHhfqkw07usHE=
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Date: Fri, 09 Oct 2026 19:51:46 +1100
Subject: [PATCH v3 2/2] config: read global scope via config_sequence
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-fix-config-list-global-home-and-xdg-v3-2-f936b9c8a0cc@microsoft.com>
References: <20261009-fix-config-list-global-home-and-xdg-v3-0-f936b9c8a0cc@microsoft.com>
In-Reply-To: <20261009-fix-config-list-global-home-and-xdg-v3-0-f936b9c8a0cc@microsoft.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Chris Torek <chris.torek@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Delilah Ashley Wu <delilahwu@microsoft.com>, 
 Ben Knoble <ben.knoble@gmail.com>, Nils Fahldieck <nils@fahldieck.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
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
an `ignore_system` flag and modify `git_config_system()` to respect it.
This makes `config_options` the primary way to disable parts of the
configuration sequence and allows callers of `do_git_config_sequence()`
to ignore all but the global scope (i.e. ignore system, local, worktree,
and cmdline). Reuse the function to read only the global scope when
`--global` is specified. This was the suggested solution [3] in the
original bug report [1].

The previous patch, "t1300: test list with missing global config",
recorded existing behaviour: when no global configuration file exists,
`git config list` should succeed whereas `git config list --global`
should fail. Since the configuration sequence gracefully ignores missing
global configuration files, track whether we successfully read at least
one of them and adjust the return code accordingly.

Keep populating `opts->source.file` in `builtin/config.c` as the
destination for write operations. Read operations use the configuration
sequence instead, which can be confusing. Add a comment to explain this
distinction.

Lastly, modify tests to check that both home and XDG configuration files
are respected during `--global` read operations.

[1] https://lore.kernel.org/git/CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com/
[2] https://lore.kernel.org/git/CAAdFe9yhBk-WecVzCTsjQ-4Z3AZAbpP+w+B076ouM3qX6d1WAg@mail.gmail.com/
[3] https://lore.kernel.org/git/kl6ly1oze7wb.fsf@chooglen-macbookpro.roam.corp.google.com/

Reported-by: Jade Lovelace <lists@jade.fyi>
Reported-by: Nils Fahldieck <nils@fahldieck.de>
Suggested-by: Glen Choo <glencbz@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
---
 builtin/config.c     |  11 ++++++
 builtin/var.c        |   4 +-
 config.c             |  50 ++++++++++++++++++-------
 config.h             |   3 +-
 t/t1300-config.sh    | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t1306-xdg-files.sh |   5 ++-
 6 files changed, 160 insertions(+), 17 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2554322317..cdef5ebb00 100644
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
diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..e999e72a2d 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -82,7 +82,9 @@ static char *git_attr_val_global(int ident_flag UNUSED)
 
 static char *git_config_val_system(int ident_flag UNUSED)
 {
-	if (git_config_system()) {
+	const struct config_options opts = { 0 };
+
+	if (git_config_system(&opts)) {
 		char *file = git_system_config();
 		normalize_path_copy(file, file);
 		return file;
diff --git a/config.c b/config.c
index e0bb29b53d..17b098fa0d 100644
--- a/config.c
+++ b/config.c
@@ -1554,16 +1554,18 @@ void git_global_config_paths(char **user_out, char **xdg_out)
 	*xdg_out = xdg_config;
 }
 
-int git_config_system(void)
+int git_config_system(const struct config_options *opts)
 {
-	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
+	return !opts->ignore_system && !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
 static int do_git_config_sequence(const struct config_options *opts,
-				  const struct repository *repo,
-				  config_fn_t fn, void *data)
+				  const struct repository *repo, config_fn_t fn,
+				  void *data, int require_global_scope_success)
 {
+	int tmp_ret;
 	int ret = 0;
+	int global_had_success = 0;
 	char *system_config = git_system_config();
 	char *xdg_config = NULL;
 	char *user_config = NULL;
@@ -1586,7 +1588,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 		worktree_config = NULL;
 	}
 
-	if (git_config_system() && system_config &&
+	if (git_config_system(opts) && system_config &&
 	    !access_or_die(system_config, R_OK,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
 		ret += git_config_from_file_with_options(fn, system_config,
@@ -1595,13 +1597,25 @@ static int do_git_config_sequence(const struct config_options *opts,
 
 	git_global_config_paths(&user_config, &xdg_config);
 
-	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file_with_options(fn, xdg_config, data,
-							 CONFIG_SCOPE_GLOBAL, NULL);
+	if (xdg_config &&
+	    !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK)) {
+		tmp_ret = git_config_from_file_with_options(fn, xdg_config,
+							    data, CONFIG_SCOPE_GLOBAL,
+							    NULL);
+		ret += tmp_ret;
+		if (!tmp_ret)
+			global_had_success = 1;
+	}
 
-	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file_with_options(fn, user_config, data,
-							 CONFIG_SCOPE_GLOBAL, NULL);
+	if (user_config &&
+	    !access_or_die(user_config, R_OK, ACCESS_EACCES_OK)) {
+		tmp_ret = git_config_from_file_with_options(fn, user_config,
+							    data, CONFIG_SCOPE_GLOBAL,
+							    NULL);
+		ret += tmp_ret;
+		if (!tmp_ret)
+			global_had_success = 1;
+	}
 
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
@@ -1624,6 +1638,10 @@ static int do_git_config_sequence(const struct config_options *opts,
 	free(user_config);
 	free(repo_config);
 	free(worktree_config);
+
+	if (require_global_scope_success && !global_had_success && !ret)
+		ret = -1;
+
 	return ret;
 }
 
@@ -1646,11 +1664,15 @@ int config_with_options(config_fn_t fn, void *data,
 	}
 
 	/*
-	 * If we have a specific filename, use it. Otherwise, follow the
-	 * regular lookup sequence.
+	 * Use the specified file when provided, except for the global scope,
+	 * which can come from more than one file. With no explicit source,
+	 * follow the regular lookup sequence.
 	 */
 	if (config_source && config_source->use_stdin) {
 		ret = git_config_from_stdin(fn, data, config_source->scope);
+	} else if (config_source && config_source->file &&
+		   config_source->scope == CONFIG_SCOPE_GLOBAL) {
+		ret = do_git_config_sequence(opts, repo, fn, data, 1);
 	} else if (config_source && config_source->file) {
 		ret = git_config_from_file_with_options(fn, config_source->file,
 							data, config_source->scope,
@@ -1659,7 +1681,7 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 					       data, config_source->scope);
 	} else {
-		ret = do_git_config_sequence(opts, repo, fn, data);
+		ret = do_git_config_sequence(opts, repo, fn, data, 0);
 	}
 
 	if (inc.remote_urls) {
diff --git a/config.h b/config.h
index b048f63571..154ae66b3b 100644
--- a/config.h
+++ b/config.h
@@ -88,6 +88,7 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 
 struct config_options {
 	unsigned int respect_includes : 1;
+	unsigned int ignore_system : 1;
 	unsigned int ignore_repo : 1;
 	unsigned int ignore_worktree : 1;
 	unsigned int ignore_cmdline : 1;
@@ -423,7 +424,7 @@ int repo_config_rename_section(struct repository *, const char *, const char *);
 int repo_config_rename_section_in_file(struct repository *, const char *, const char *, const char *);
 int repo_config_copy_section(struct repository *, const char *, const char *);
 int repo_config_copy_section_in_file(struct repository *, const char *, const char *, const char *);
-int git_config_system(void);
+int git_config_system(const struct config_options *opts);
 int config_error_nonbool(const char *);
 #if defined(__GNUC__)
 #define config_error_nonbool(s) (config_error_nonbool(s), const_error())
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index df8c14da0d..15b1d713af 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2437,6 +2437,110 @@ test_expect_success 'list --global with nonexistent global config fails' '
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
+	# Git uses HOME and XDG_CONFIG_HOME to determine the location of the
+	# XDG config file. On Windows, the default values lead to mixed forward
+	# and backward slashes in the output --show-origin path for XDG config.
+	# Explicitly set XDG_CONFIG_HOME with only forward slashes, allowing us
+	# to use the same expected path across all platforms.
+	XDG_CONFIG_HOME="$HOME/.config" \
+		git config ${mode_prefix}list --global \
+		--show-scope --show-origin >actual &&
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
+test_expect_success 'list --global ignores other scopes' '
+	test_when_finished rm -f system_config &&
+	cat >system_config <<-EOF &&
+	[system]
+		config = true
+	EOF
+
+	test_config core.repositoryformatversion 1 &&
+	test_config extensions.worktreeConfig true &&
+	test_config --worktree worktree.config true &&
+
+	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
+	cat >"$HOME"/.gitconfig <<-EOF &&
+	[home]
+		config = home
+	EOF
+
+	test_config repo.config true &&
+
+	echo "global	home.config=home" >expect &&
+	GIT_CONFIG_NOSYSTEM=false GIT_CONFIG_SYSTEM=system_config \
+		git -c cmdline.config=true config ${mode_prefix}list \
+		--global --show-scope >actual &&
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

