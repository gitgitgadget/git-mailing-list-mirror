Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53D2FE047
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348564; cv=none; b=lrdY5KYicnJ8WwbYCGgxCQyGooPF7oJGH1w9PERvR7irkdfvwu7KX2MP41vFd9DDtZ7OHDMFe47VzCAHLh1ZH2TTvd0hao9qF+xNkIvfD00/FN9JpoG5L86A8xmwNIQGF1R4K2PjtNZX0HIGVRJiTW21dRbanAnhTh3khB72uF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348564; c=relaxed/simple;
	bh=jZ9p1luOdl8RqjNc2q8KJ6jd8xC2RYKnyIjgeb499Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msP7IFKGx8neZjYxfB4gWZyZmwTWbA2z45wmA+QeLSyTajAb1Z2P7eTGYnkszk4Iq5oZ13LZIyhVC2zXbdLNGJET1cc4xlJSZWgqqnCZYMyyPo3BKrg2JxHnQHvdxt3t1SQjlPNvjDVxuujZlCM7Kh773ai9wI/7et0okTGQQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=co6g7/h2; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="co6g7/h2"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760348558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klFpiRTungFeT5jOe/QyNUA1qGc0KC2dT9CymUxpIrU=;
	b=co6g7/h2m8vFPVQLxtXqnSjKMP1DrynkYjZeUlydXN5vKaz7gParS1FMHcdIwqOcqEQzbl
	ByfcwM6QipwF07fuIDCHd3ci7+QMKHOCkGZ2Bq6lyP724Q6UP3sMNn9/qVZCSvuQOCl68g
	fJTFMt7dFJUPdXHAqcEigJz3lCAh3zDNaebvxl5Co7nKvZISc/wtn7J/GykmIn/J2oVFAj
	TCz++HJGm9BZmDQxjHGsEi8jd5ujRr3u1n9zylNUm8P7ue7lEh86RP42Ly/TDCVuFYnF5I
	EZoee/YrNTnrVjWvFmKSjJb/covXjTUwKDnrKlQnwk0vWMfRIM7lEEqoRtFNrA==
To: git@vger.kernel.org
Cc: Michael Lohmann <git@lohmann.sh>
Subject: [PATCH 5/5] setup: allow not marking self owned repos as safe in `ensure_safe_repository()`
Date: Mon, 13 Oct 2025 11:41:46 +0200
Message-ID: <20251013094152.23597-6-git@lohmann.sh>
In-Reply-To: <20251013094152.23597-1-git@lohmann.sh>
References: <20251013094152.23597-1-git@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git considers all repositories as safe, if they are either
 - explicitly set in "safe.directory" config, or
 - the user owns the repo

Since a user could unzip a folder they downloaded from the internet and
unknown to them, it is a repository with malicious hooks/config, an
attacker could easily get code execution. Even a command line prompt
would automatically trigger this if executing `git status` after
entering the malicious directory.

Allow not to automatically treat all repos owned by the user as safe.
This can either be done by "--assume-unsafe", the environment variable
"GIT_ASSUME_UNSAFE" or by setting the configuration "safe.assumeUnsafe"
in a safe context (so not the repo config, as it should not be able to
allow list itself).

Signed-off-by: Michael Lohmann <git@lohmann.sh>
---
Question in setup.c: is setting the environment variable inside of
safe_directory_cb the best way to "communicate" this result?
Alternatively one could add a new member to the struct, but I thought
this was not the best either...


 Documentation/config/safe.adoc    |  9 +++++++
 Documentation/git.adoc            | 14 ++++++++++-
 environment.h                     |  1 +
 git.c                             |  6 ++++-
 setup.c                           |  9 +++++++
 t/t0036-allow-unsafe-directory.sh | 42 +++++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/safe.adoc b/Documentation/config/safe.adoc
index 2d45c98b12..2ac5d94762 100644
--- a/Documentation/config/safe.adoc
+++ b/Documentation/config/safe.adoc
@@ -60,3 +60,12 @@ which id the original user has.
 If that is not what you would prefer and want git to only trust
 repositories that are owned by root instead, then you can remove
 the `SUDO_UID` variable from root's environment before invoking git.
+
+safe.assumeUnsafe::
+	Boolean to indicate that the ownership of a repository should not
+	be taken into account when checking if the repository is safe. It
+	will prevent against accidental arbitrariy code execution
++
+To temporarily allow git execution in case of an assumed unsafe repository,
+run the command with `--allow-unsafe`. To permanently trust this path, add
+it to the `safe.directory` config.
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 7df51c38f9..162350f3db 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -14,7 +14,7 @@ SYNOPSIS
     [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]
     [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]
     [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]
-    [--allow-unsafe]
+    [--allow-unsafe] [--assume-unsafe]
     <command> [<args>]
 
 DESCRIPTION
@@ -238,6 +238,13 @@ If you just want to run git as if it was started in `<path>` then use
 	execution by hooks or configuration settings. Equivalent to setting
 	the environment variable `GIT_ALLOW_UNSAFE=1`.
 
+--assume-unsafe::
+	Prevent arbitrary code execution by hooks or configuration if not
+	executed in a "safe.directory". With setting this, filesystem ownership
+	of the repository in question no longer satisfies to mark it as safe.
+	Equivalent to setting `GIT_ASSUME_UNSAFE=1`. This is overwritten if
+	`--allow-unsafe` is passed as well.
+
 GIT COMMANDS
 ------------
 
@@ -506,6 +513,11 @@ Git so take care if using a foreign front-end.
 	owns the repository before potentially executing arbitrary code
 	from hooks or config.
 
+`GIT_ASSUME_UNSAFE`::
+	This Boolean environment variable can be set to true enforce
+	explicit "safe.directory" configuration for the repository. This
+	can be overwritten by setting `GIT_ALLOW_UNSAFE`.
+
 `GIT_INDEX_FILE`::
 	This environment variable specifies an alternate
 	index file. If not specified, the default of `$GIT_DIR/index`
diff --git a/environment.h b/environment.h
index ee9e1b9514..89036a9460 100644
--- a/environment.h
+++ b/environment.h
@@ -43,6 +43,7 @@
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
 #define GIT_ALLOW_UNSAFE "GIT_ALLOW_UNSAFE"
+#define GIT_ASSUME_UNSAFE "GIT_ASSUME_UNSAFE"
 
 /*
  * Environment variable used to propagate the --no-advice global option to the
diff --git a/git.c b/git.c
index a7581a6805..40ef89558d 100644
--- a/git.c
+++ b/git.c
@@ -42,7 +42,7 @@ const char git_usage_string[] =
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]\n"
 	   "           [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]\n"
 	   "           [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]\n"
-	   "           [--allow-unsafe]\n"
+	   "           [--allow-unsafe] [--assume-unsafe]\n"
 	   "           <command> [<args>]");
 
 const char git_more_info_string[] =
@@ -359,6 +359,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_ALLOW_UNSAFE, "1", 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--assume-unsafe")) {
+			setenv(GIT_ASSUME_UNSAFE, "1", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git a/setup.c b/setup.c
index 10975fd9a3..0d6cddfcb9 100644
--- a/setup.c
+++ b/setup.c
@@ -1238,6 +1238,12 @@ static int safe_directory_cb(const char *key, const char *value,
 {
 	struct safe_directory_data *data = d;
 
+	if (!strcmp(key, "safe.assumeunsafe")) {
+		if (git_config_bool(key, value))
+			setenv(GIT_ASSUME_UNSAFE, value, 0);
+		return 0;
+	}
+
 	if (strcmp(key, "safe.directory"))
 		return 0;
 
@@ -1330,6 +1336,9 @@ static int ensure_safe_repository(const char *gitfile,
 	if (data.is_safe)
 		return 1;
 
+	if (git_env_bool("GIT_ASSUME_UNSAFE", 0))
+		return 0;
+
 	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
 	    (!gitfile || is_path_owned_by_current_user(gitfile, report)) &&
 	    (!worktree || is_path_owned_by_current_user(worktree, report)) &&
diff --git a/t/t0036-allow-unsafe-directory.sh b/t/t0036-allow-unsafe-directory.sh
index 4b98e815ff..7e08c261bc 100755
--- a/t/t0036-allow-unsafe-directory.sh
+++ b/t/t0036-allow-unsafe-directory.sh
@@ -25,4 +25,46 @@ test_expect_success 'GIT_ALLOW_UNSAFE bool allows unsafe directory' '
 	    git status
 '
 
+test_expect_success '--assume-unsafe prevents execution if not in safe.directory' '
+	sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+	git status &&
+	test_must_fail git --assume-unsafe status 2>err &&
+	grep "dubious ownership" err
+'
+test_expect_success 'GIT_ASSUME_UNSAFE prevents execution if not in safe.directory' '
+	test_must_fail env GIT_ASSUME_UNSAFE=1 \
+			   git status 2>err &&
+	grep "dubious ownership" err
+'
+
+test_expect_success 'safe.assumeUnsafe on the command line' '
+	test_must_fail git -c safe.assumeUnsafe="true" status 2>err &&
+	grep "dubious ownership" err
+'
+
+test_expect_success 'safe.assumeUnsafe in the environment' '
+	test_must_fail env GIT_CONFIG_COUNT=1 \
+	    GIT_CONFIG_KEY_0="safe.assumeUnsafe" \
+	    GIT_CONFIG_VALUE_0="true" \
+	    git status 2>err &&
+	grep "dubious ownership" err
+'
+
+test_expect_success 'safe.assumeUnsafe in GIT_CONFIG_PARAMETERS' '
+	test_must_fail env GIT_CONFIG_PARAMETERS="${SQ}safe.assumeUnsafe${SQ}=${SQ}true${SQ}" \
+	    git status 2>err &&
+	grep "dubious ownership" err
+'
+
+test_expect_success 'ignoring safe.assumeUnsafe in repo config' '
+	git config safe.assumeUnsafe "false" &&
+	git config --global safe.assumeUnsafe "true" &&
+	test_must_fail git status 2>err &&
+	grep "dubious ownership" err
+'
+
+test_expect_success 'allow-unsafe must overwrite assume-unsafe' '
+	env GIT_ASSUME_UNSAFE=1 git --allow-unsafe status
+'
+
 test_done
-- 
2.50.1 (Apple Git-155)

