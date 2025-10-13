Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B632FE56B
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348563; cv=none; b=YZWiQAmMBkKyguGnu0iBa7gdJGPDeqxtoeYx1PqOyUpeTg2pDvPPgV/ed02K80Wix1CctFlp2HqhBW0DSSx/dhQen6V/z7F6NfiStTmAU2rlibAWH7/uaM760DsHbjSZ6K32DfRz8XiAV1L77qMavV61AJkPNvEZoezMtN/XRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348563; c=relaxed/simple;
	bh=meJxEX0NcboISlf1Y1Dy7lsS5TA9/LBNLQhldzjdDqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmah5yEsV/z8U4k/0ivN6XrZYfnXrbSdoROwwTknBkGcXZZFyeTWkFVzjFBt9JLQNmnissxrx3bHauMTEJHh6CkKqcKN6WoI01spRrByIg8BaeNGSeSuCQZwvbVt8l5r2jQcInpraT+IPF+yqwO+W/r8kK6ppR6QdyzIqijCMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=OLLbvqUe; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="OLLbvqUe"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760348558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYaL0Xd6yosO1pQWK41Dwo5ApzrhgKyCZzGxggViHQ8=;
	b=OLLbvqUehl4qBeypf7Cvh1YkiOQ1wEp7heqs8WjBXfIBiWPrs+bHqaODMcXVO8tXHKqPXe
	MsMkaxydKC3oWUr2YSIj/RS+7AjBioyimXuFh5qgchQalKH/ZcdVTEzqVGXn3NZhpLxOwJ
	Y9W0g8/xJJCGRdvGEPXv0j6E4Yitpw6NTq28Ok+FSzHg7PT3Pn41AK3So/WIwr+Cq6HRrZ
	D4AUCVgJwJPwTSF2hLBXmyh+R6Vz/4XagDD5aLBothQ9NHS7NV1M1r7eKO34RcNhvXLOoj
	hvb8kptyHUkNOH0Fd9wo2ewrDr+9JGe6NJ9Kpb7wO5aZDSHbOktlSYLy1+6TKw==
To: git@vger.kernel.org
Cc: Michael Lohmann <git@lohmann.sh>
Subject: [PATCH 4/5] setup: allow temporary bypass of `ensure_safe_repository()` checks
Date: Mon, 13 Oct 2025 11:41:45 +0200
Message-ID: <20251013094152.23597-5-git@lohmann.sh>
In-Reply-To: <20251013094152.23597-1-git@lohmann.sh>
References: <20251013094152.23597-1-git@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far, the only option to allow executing git in what it considers to
be an "unsafe context" is to set this repository as "safe.directory". If
a user only wants to temporarily execute one command, they would need to
set the path as safe, execute the command and then remove the path
again. Forgetting to do the latter would make the user vulnerable if
this repo was changed afterwards in a malicious way.

Allow temporarily bypassing `ensure_safe_repository()` checks with a new
flag "--allow-unsafe" or environment variable "GIT_ALLOW_UNSAFE".

Signed-off-by: Michael Lohmann <git@lohmann.sh>
---
This appends to the error message of the "dubious ownership". A first
draft had that reworded, but as Johannes Schindelin pointed out, this
could be "breaking the API" for external programs. Is appending fine?

Was adding the new test file to t/meson.build the only thing needed to
do? I didn't see anything documented on how to add a new test file, but
`make` complained without manually adding it.


 Documentation/git.adoc            | 13 +++++++++++++
 environment.h                     |  1 +
 git.c                             |  5 +++++
 setup.c                           | 13 +++++++++++--
 t/meson.build                     |  1 +
 t/t0036-allow-unsafe-directory.sh | 28 ++++++++++++++++++++++++++++
 6 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100755 t/t0036-allow-unsafe-directory.sh

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..7df51c38f9 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -14,6 +14,7 @@ SYNOPSIS
     [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]
     [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]
     [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]
+    [--allow-unsafe]
     <command> [<args>]
 
 DESCRIPTION
@@ -231,6 +232,12 @@ If you just want to run git as if it was started in `<path>` then use
 	linkgit:gitattributes[5]. This is equivalent to setting the
 	`GIT_ATTR_SOURCE` environment variable.
 
+--allow-unsafe::
+	Temporarily trust the repository regardless of "safe.directory"
+	configuration or ownership, potentially resulting in arbitrary code
+	execution by hooks or configuration settings. Equivalent to setting
+	the environment variable `GIT_ALLOW_UNSAFE=1`.
+
 GIT COMMANDS
 ------------
 
@@ -493,6 +500,12 @@ These environment variables apply to 'all' core Git commands. Nb: it
 is worth noting that they may be used/overridden by SCMS sitting above
 Git so take care if using a foreign front-end.
 
+`GIT_ALLOW_UNSAFE`::
+	This Boolean environment variable can be set to true to skip the
+	safety checks of "safe.directory" configuration and if the user
+	owns the repository before potentially executing arbitrary code
+	from hooks or config.
+
 `GIT_INDEX_FILE`::
 	This environment variable specifies an alternate
 	index file. If not specified, the default of `$GIT_DIR/index`
diff --git a/environment.h b/environment.h
index 51898c99cd..ee9e1b9514 100644
--- a/environment.h
+++ b/environment.h
@@ -42,6 +42,7 @@
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
+#define GIT_ALLOW_UNSAFE "GIT_ALLOW_UNSAFE"
 
 /*
  * Environment variable used to propagate the --no-advice global option to the
diff --git a/git.c b/git.c
index c5fad56813..a7581a6805 100644
--- a/git.c
+++ b/git.c
@@ -42,6 +42,7 @@ const char git_usage_string[] =
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]\n"
 	   "           [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]\n"
 	   "           [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]\n"
+	   "           [--allow-unsafe]\n"
 	   "           <command> [<args>]");
 
 const char git_more_info_string[] =
@@ -354,6 +355,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_ADVICE_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--allow-unsafe")) {
+			setenv(GIT_ALLOW_UNSAFE, "1", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git a/setup.c b/setup.c
index 41a12a85ab..10975fd9a3 100644
--- a/setup.c
+++ b/setup.c
@@ -1307,6 +1307,9 @@ static int ensure_safe_repository(const char *gitfile,
 {
 	struct safe_directory_data data = { 0 };
 
+	if (git_env_bool("GIT_ALLOW_UNSAFE", 0))
+		return 1;
+
 	/*
 	 * normalize the data.path for comparison with normalized paths
 	 * that come from the configuration file.  The path is unsafe
@@ -1353,7 +1356,10 @@ void die_upon_assumed_unsafe_repo(const char *gitfile, const char *worktree,
 	      "%s"
 	      "To add an exception for this directory, call:\n"
 	      "\n"
-	      "\tgit config --global --add safe.directory %s"),
+	      "\tgit config --global --add safe.directory %s\n"
+	      "\n"
+	      "To temporarily bypass safety-checks, run 'git --allow-unsafe <command>'\n"
+	      "or set the environment variable 'GIT_ALLOW_UNSAFE=true'."),
 	    path, report.buf, quoted.buf);
 }
 
@@ -1797,7 +1803,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			      "%s"
 			      "To add an exception for this directory, call:\n"
 			      "\n"
-			      "\tgit config --global --add safe.directory %s"),
+			      "\tgit config --global --add safe.directory %s\n"
+			      "\n"
+			      "To temporarily bypass safety-checks, run 'git --allow-unsafe <command>'\n"
+			      "or set the environment variable 'GIT_ALLOW_UNSAFE=true'."),
 			    dir.buf, report.buf, quoted.buf);
 		}
 		*nongit_ok = 1;
diff --git a/t/meson.build b/t/meson.build
index 11376b9e25..c55fb55784 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -100,6 +100,7 @@ integration_tests = [
   't0033-safe-directory.sh',
   't0034-root-safe-directory.sh',
   't0035-safe-bare-repository.sh',
+  't0036-allow-unsafe-directory.sh',
   't0040-parse-options.sh',
   't0041-usage.sh',
   't0050-filesystem.sh',
diff --git a/t/t0036-allow-unsafe-directory.sh b/t/t0036-allow-unsafe-directory.sh
new file mode 100755
index 0000000000..4b98e815ff
--- /dev/null
+++ b/t/t0036-allow-unsafe-directory.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='verify safe.directory checks'
+
+. ./test-lib.sh
+
+GIT_TEST_ASSUME_DIFFERENT_OWNER=1
+export GIT_TEST_ASSUME_DIFFERENT_OWNER
+
+expect_rejected_dir () {
+	test_must_fail git status 2>err &&
+	grep "dubious ownership" err
+}
+
+test_expect_success 'safe.directory is not set' '
+	expect_rejected_dir
+'
+
+test_expect_success '--allow-unsafe allows execution in unsafe directory' '
+	git --allow-unsafe status
+'
+
+test_expect_success 'GIT_ALLOW_UNSAFE bool allows unsafe directory' '
+	env GIT_ALLOW_UNSAFE=true \
+	    git status
+'
+
+test_done
-- 
2.50.1 (Apple Git-155)

