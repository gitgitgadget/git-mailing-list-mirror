Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5A348465
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787481061; cv=none; b=mu33nMEXoFFkJLXGWcBN1Hs2p9R0aVemvOcknQodQWvkdCMwo0bYeuJd1d+EnnylAlwJtyYzQf94/uSzmmD8nnY6PaNhyz318z1NJR0mIIgSxflrhY7397jxSBOVwd1X82TV1nHI4h884T1tRP4LVMbaCeUABoKgw2bMjosbjYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787481061; c=relaxed/simple;
	bh=y1a+X5PL3/vNDKXEW3UajOOWYhhIjFPDbgzMKOw88gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXHidxjIyA7pSvQSxfY87pOtr7I8BKC1mmfZIP1sUjwb8P5ZDi14VuNGuWxpq5BuTeawrO5YD3qo3BH/e14AsSiCC8e/x6Q3wl63hl+/t+NC8UgDRJGAy6c09+PA1a6C/K3LINjU5qO+excuU9vpqi1g4y46KVJ14AJDgxH1ALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HQPHDH1Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HQPHDH1Z"
Received: from [192.168.4.34] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 30B3420B7128;
	Sun, 23 Aug 2026 03:30:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30B3420B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787481027;
	bh=njdmNuyp7zLhJMLH9F1CkUSTp860MpnVbW/tXvu3LfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HQPHDH1ZpC5ZYzSgFpSTkIeEIR0suLJ9hPSLi8/R6uuVKoNkA1y8MFJbZeBiChdfI
	 MZ3EyrhMEtcQnt0b3mthHvmJOdQss3JA+HMmFkp4BJAbypYWTJetx7ZeEwLlDjZpxk
	 q+zQpbcjJQRxwQNzjO343prNH9nJ2qQ+zOaa12+Y=
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Date: Sun, 23 Aug 2026 20:28:27 +1000
Subject: [PATCH v2 2/3] config: let sequence require a successful file
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-fix-config-list-global-home-and-xdg-v2-2-b29cc63f017b@microsoft.com>
References: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
In-Reply-To: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
To: git@vger.kernel.org
Cc: Nils Fahldieck <nils@fahldieck.de>, Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Delilah Ashley Wu <delilahwu@microsoft.com>, 
 Derrick Stolee <stolee@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

From: Delilah Ashley Wu <delilahwu@microsoft.com>

Teach `do_git_config_sequence()` to optionally report an error if no
configuration files in the sequence were successfully processed. Gate
this new behaviour with a flag and keep it disabled for now.

Add tests to record existing behaviour and prevent regressions in the
next patch, "config: read global scope via config_sequence", which adds
a code path that enables the flag. When no global configuration file
exists, `git config list` succeeds whereas `git config list --global`
fails. The command output is irrelevant, so only check the exit code.

Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
---
 config.c          | 57 ++++++++++++++++++++++++++++++++++++++-----------------
 t/t1300-config.sh | 12 ++++++++++++
 2 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/config.c b/config.c
index 1bdd702e7a..4c958f46bf 100644
--- a/config.c
+++ b/config.c
@@ -1544,11 +1544,27 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
+static void attempt_git_config_from_file_with_options(config_fn_t fn,
+						      const char *filename,
+						      void *data,
+						      enum config_scope scope,
+						      const struct config_options *opts,
+						      int *success_count,
+						      int *cumulative_ret)
+{
+	int ret = git_config_from_file_with_options(fn, filename, data,
+						    scope, opts);
+	if (!ret)
+		(*success_count)++;
+	*cumulative_ret += ret;
+}
+
 static int do_git_config_sequence(const struct config_options *opts,
-				  const struct repository *repo,
-				  config_fn_t fn, void *data)
+				  const struct repository *repo, config_fn_t fn,
+				  void *data, int require_successful_config)
 {
 	int ret = 0;
+	int success_count = 0;
 	char *system_config = git_system_config();
 	char *xdg_config = NULL;
 	char *user_config = NULL;
@@ -1574,32 +1590,35 @@ static int do_git_config_sequence(const struct config_options *opts,
 	if (git_config_system() && system_config &&
 	    !access_or_die(system_config, R_OK,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
-		ret += git_config_from_file_with_options(fn, system_config,
-							 data, CONFIG_SCOPE_SYSTEM,
-							 NULL);
+		attempt_git_config_from_file_with_options(fn, system_config, data,
+							  CONFIG_SCOPE_SYSTEM, NULL,
+							  &success_count, &ret);
 
 	git_global_config_paths(&user_config, &xdg_config);
 
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file_with_options(fn, xdg_config, data,
-							 CONFIG_SCOPE_GLOBAL, NULL);
+		attempt_git_config_from_file_with_options(fn, xdg_config,
+							  data,
+							  CONFIG_SCOPE_GLOBAL,
+							  NULL, &success_count, &ret);
 
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file_with_options(fn, user_config, data,
-							 CONFIG_SCOPE_GLOBAL, NULL);
+		attempt_git_config_from_file_with_options(fn, user_config,
+							  data,
+							  CONFIG_SCOPE_GLOBAL,
+							  NULL, &success_count, &ret);
 
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
-		ret += git_config_from_file_with_options(fn, repo_config, data,
-							 CONFIG_SCOPE_LOCAL, NULL);
+		attempt_git_config_from_file_with_options(fn, repo_config, data,
+							  CONFIG_SCOPE_LOCAL, NULL, &success_count, &ret);
 
 	if (!opts->ignore_worktree && worktree_config &&
 	    repo && repo->repository_format_worktree_config &&
-	    !access_or_die(worktree_config, R_OK, 0)) {
-			ret += git_config_from_file_with_options(fn, worktree_config, data,
-								 CONFIG_SCOPE_WORKTREE,
-								 NULL);
-	}
+	    !access_or_die(worktree_config, R_OK, 0))
+		attempt_git_config_from_file_with_options(fn, worktree_config, data,
+							  CONFIG_SCOPE_WORKTREE,
+							  NULL, &success_count, &ret);
 
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
@@ -1609,6 +1628,10 @@ static int do_git_config_sequence(const struct config_options *opts,
 	free(user_config);
 	free(repo_config);
 	free(worktree_config);
+
+	if (require_successful_config && !success_count && !ret)
+		ret = -1;
+
 	return ret;
 }
 
@@ -1644,7 +1667,7 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 					       data, config_source->scope);
 	} else {
-		ret = do_git_config_sequence(opts, repo, fn, data);
+		ret = do_git_config_sequence(opts, repo, fn, data, 0);
 	}
 
 	if (inc.remote_urls) {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 329407a73d..2ce85b76ff 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2457,6 +2457,18 @@ test_expect_success '--show-scope with --default' '
 	test_cmp expect actual
 '
 
+test_expect_success 'list with nonexistent global config gracefully exits' '
+	rm -f "$HOME"/.gitconfig "$HOME"/.config/git/config &&
+	git config ${mode_prefix}list &&
+	git config ${mode_prefix}list --show-scope
+'
+
+test_expect_success 'list --global with nonexistent global config fails' '
+	rm -f "$HOME"/.gitconfig "$HOME"/.config/git/config &&
+	test_must_fail git config ${mode_prefix}list --global &&
+	test_must_fail git config ${mode_prefix}list --global --show-scope
+'
+
 test_expect_success 'override global and system config' '
 	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
 	cat >"$HOME"/.gitconfig <<-EOF &&

-- 
2.54.0

