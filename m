Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18A18FDDB
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592837; cv=none; b=Fyk3C+6JkYrcZimqdqjasUp5Lhf3BF0BGNPnAHXqRac3nAISPmNhHluGm1c7eoXBFhzehjKIxAsekr7VJA5eO8D7f311v1zI2VaDJ+Pq0o/3EjqhgzKRTBgOolX6PEDPlOk9xtCgqJqZkEVDZRJ5ym/ybvCAOwfHN4V22trF2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592837; c=relaxed/simple;
	bh=tLUl75gAKSLO0ANjk8Cw2gxTk+/9cc0HQXYbi8c4RLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cM1JYpwNIn00tGv3uMQCs27ztpKnLpvsB06+h1Fe0GRfXdkL87BE0/fdEuswL7yzybol22nSt6VzsGZ0BISLzovFB5cz/r8YttRDiFubFwLnZJ9T68hYJrbjgE4pJ2JFZi/OeYDsQg6fkVS4DBh9c97exERmoL7DGv7n4CfNbq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=f48zkj9J; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="f48zkj9J"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760592824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxYw6Lr4PY4nJ3KbhsZSv+DUc0hFGigsZiIDGZ3Zq0o=;
	b=f48zkj9J+03EIQaGK3Ghosue5Raa4Bwc2vgCUjJvx/eFOQ0woyq6JgKsRctxk+rFuynMxx
	7Fybz3Qp1ZURhQTaTFyrhlth+075mXNBfbf6zpl9P2K2+0wGY5Qv0V7gDKhr30f16VJDuu
	r1zyW4GaYyBIJGbCTqbye169xEvejjbFCLBEyJGp+duHngpQ2F0OcY2AG/ia8/QGd9lHY8
	q6SwmlrXLiXNT0NgLyb2L1Ywo1LBX0k3EIfprFUl6C+eIWl74nKg6ny6mgyag/WSmAU+Hh
	lZ6kHVcZcwVV9P4WrTFLLScCXk2GpaZUiH0rGzku5VWka51qGIfzzVqpjqT+5g==
To: git@lohmann.sh
Cc: git@vger.kernel.org
Subject: [PATCH v3 0/5] Allow skipping ownership of repo in safety consideration
Date: Thu, 16 Oct 2025 07:33:17 +0200
Message-ID: <20251016053322.44495-1-git@lohmann.sh>
In-Reply-To: <20251013094152.23597-1-git@lohmann.sh>
References: <20251013094152.23597-1-git@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduction
------------

As a first step to allow making git more resistant against accidental
arbitrary code execution, Jeff King suggested in

 https://lore.kernel.org/git/20251009224317.77565-1-git@lohmann.sh/T/#m6cce96f9ae58a4341ae3fbbc02110e20547c58bc

to make the "safe.directory" config enforceable.

Note about the different patches
--------------------------------

Patches 1/5 and 2/5 are renaming of functions to clarify their
functionality (especially needed once the additional options to mark
repositories as (un)safe are introduced)

Patch 3/5 is a refactoring that on its own has no change in behavior,
but it makes Patch 5/5 cleaner by it now only adding the check for
"GIT_ASSUME_UNSAFE" in one place instead of having to refactor it in
parallel.

Patch 4/5 adds `--allow-unsafe` flag to temporarily skip the
"safe.directory" checks

Patch 5/5 adds `--assume-unsafe` flag to skip ownership check when
evaluating if a repository is to be considered safe. This allows e.g.
running a command line git status only in repositories explicitly marked
as a "safe.directory" to prevent accidental arbitrary code invocations.

Changes since v2
----------------

Thanks to Junio C Hamano for a thorough review!

* patch 2: rename function with more concise name
* patch 2: fix commit message mentioning function name from patch 1
  instead
* patch 3: clarify that this patch on its own does not make sense, but
  is preparation for a later commit. (Sorry if it took additional time
  to understand the patch - I tried "not to tell the future" with the
  commit message, but an explicit "this is preparation for a later
  patch" is much better)
* patch 5: add missing newline in test

Note: I accidentally replied to the review comment with v2 instead of
the cover letter:

 https://lore.kernel.org/git/20251013214608.33581-1-git@lohmann.sh/#t

Tests
-----

Ran all tests. On my setup even on the main branch
t/t3900-i18n-commit.sh is failing the three test cases on ISO-2022-JP.
Since no code related to commit or i18n was changed, it is very unlikely
that this patch set has any impact on said tests.

Range-diff since v2
-------------------

Michael Lohmann (5):
  setup: rename `ensure_safe_repository()` for clarity
  setup: rename `die_upon_unsafe_repo()` to align with check
  setup: refactor `ensure_safe_repository()` testing priorities
  setup: allow temporary bypass of `ensure_safe_repository()` checks
  setup: allow not marking self owned repos as safe in
    `ensure_safe_repository()`

 Documentation/config/safe.adoc    |  9 ++++
 Documentation/git.adoc            | 25 +++++++++++
 builtin/clone.c                   |  2 +-
 environment.h                     |  2 +
 git.c                             |  9 ++++
 path.c                            |  4 +-
 setup.c                           | 45 ++++++++++++++------
 setup.h                           |  2 +-
 t/meson.build                     |  1 +
 t/t0036-allow-unsafe-directory.sh | 71 +++++++++++++++++++++++++++++++
 10 files changed, 154 insertions(+), 16 deletions(-)
 create mode 100755 t/t0036-allow-unsafe-directory.sh

Range-diff against v2:
1:  3f8805eb96 = 1:  5d886c0461 setup: rename `ensure_safe_repository()` for clarity
2:  aa09159dec ! 2:  6fbbf4185d setup: rename `die_upon_assumed_unsafe_repo()` to align with check
    @@ Metadata
     Author: Michael Lohmann <git@lohmann.sh>
     
      ## Commit message ##
    -    setup: rename `die_upon_assumed_unsafe_repo()` to align with check
    +    setup: rename `die_upon_unsafe_repo()` to align with check
     
         This function dies if the repo in question is deemed to be unsafe and
         the ownership is only part of the verification. In addition it already
         checks for "safe.directory" config, making the name
    -    `ensure_valid_ownership()` not expressive.
    +    `die_upon_dubious_ownership()` not expressive.
         When additional options to check if a repository is considered to be
         safe are added, this name is more indicative of the content.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Michael Lohmann <git@lohmann.sh>
     
      ## builtin/clone.c ##
    @@ builtin/clone.c: static void copy_or_link_directory(struct strbuf *src, struct s
      	 * potentially-untrusted user. We thus refuse to do so by default.
      	 */
     -	die_upon_dubious_ownership(NULL, NULL, src_repo);
    -+	die_upon_assumed_unsafe_repo(NULL, NULL, src_repo);
    ++	die_upon_unsafe_repo(NULL, NULL, src_repo);
      
      	mkdir_if_missing(dest->buf, 0777);
      
    @@ path.c: const char *enter_repo(const char *path, unsigned flags)
      		gitfile = read_gitfile(used_path.buf);
      		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
     -			die_upon_dubious_ownership(gitfile, NULL, used_path.buf);
    -+			die_upon_assumed_unsafe_repo(gitfile, NULL, used_path.buf);
    ++			die_upon_unsafe_repo(gitfile, NULL, used_path.buf);
      		if (gitfile) {
      			strbuf_reset(&used_path);
      			strbuf_addstr(&used_path, gitfile);
    @@ path.c: const char *enter_repo(const char *path, unsigned flags)
      		const char *gitfile = read_gitfile(path);
      		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
     -			die_upon_dubious_ownership(gitfile, NULL, path);
    -+			die_upon_assumed_unsafe_repo(gitfile, NULL, path);
    ++			die_upon_unsafe_repo(gitfile, NULL, path);
      		if (gitfile)
      			path = gitfile;
      		if (chdir(path))
    @@ setup.c: static int ensure_safe_repository(const char *gitfile,
      }
      
     -void die_upon_dubious_ownership(const char *gitfile, const char *worktree,
    -+void die_upon_assumed_unsafe_repo(const char *gitfile, const char *worktree,
    ++void die_upon_unsafe_repo(const char *gitfile, const char *worktree,
      				const char *gitdir)
      {
      	struct strbuf report = STRBUF_INIT, quoted = STRBUF_INIT;
    @@ setup.h: const char *resolve_gitdir_gently(const char *suspect, int *return_erro
       * added, for bare ones their git directory.
       */
     -void die_upon_dubious_ownership(const char *gitfile, const char *worktree,
    -+void die_upon_assumed_unsafe_repo(const char *gitfile, const char *worktree,
    ++void die_upon_unsafe_repo(const char *gitfile, const char *worktree,
      				const char *gitdir);
      
      void setup_work_tree(void);
3:  ad4f64fdb8 ! 3:  1925b3f093 setup: refactor `ensure_safe_repository()` testing priorities
    @@ Metadata
      ## Commit message ##
         setup: refactor `ensure_safe_repository()` testing priorities
     
    -    The implicit ownership test takes precedence over the explicit
    -    allow-listing of a path by "safe.directory" config. Sort by "priority"
    -    (explicitness). This also allows to more easily integrate additional
    -    checks.
    -
    -    Make the explicit safe.directory check take precedence over owner check.
    +    With the current code, this change does not make any difference because
    +    there is no explicit rule that lets you reject a directory that the
    +    ownership-based rule may accept.  In a later step in this series,
    +    however, we will introduce a mechanism to allow such an explicit rule,
    +    at which point the order of checks, i.e. seeing the explicit rule reject
    +    a directory and failing the operation before consulting the
    +    ownership-based rule, will start to matter.  As a preliminary change,
    +    reorder the existing checks.
     
         Signed-off-by: Michael Lohmann <git@lohmann.sh>
     
    @@ setup.c: static int ensure_safe_repository(const char *gitfile,
     +	return 0;
      }
      
    - void die_upon_assumed_unsafe_repo(const char *gitfile, const char *worktree,
    + void die_upon_unsafe_repo(const char *gitfile, const char *worktree,
4:  db31fdef4e ! 4:  385250b16c setup: allow temporary bypass of `ensure_safe_repository()` checks
    @@ setup.c: static int ensure_safe_repository(const char *gitfile,
      	/*
      	 * normalize the data.path for comparison with normalized paths
      	 * that come from the configuration file.  The path is unsafe
    -@@ setup.c: void die_upon_assumed_unsafe_repo(const char *gitfile, const char *worktree,
    +@@ setup.c: void die_upon_unsafe_repo(const char *gitfile, const char *worktree,
      	      "%s"
      	      "To add an exception for this directory, call:\n"
      	      "\n"
5:  6f710af1da ! 5:  ba8eb928b4 setup: allow not marking self owned repos as safe in `ensure_safe_repository()`
    @@ t/t0036-allow-unsafe-directory.sh: test_expect_success 'GIT_ALLOW_UNSAFE bool al
     +	test_must_fail git --assume-unsafe status 2>err &&
     +	grep "dubious ownership" err
     +'
    ++
     +test_expect_success 'GIT_ASSUME_UNSAFE prevents execution if not in safe.directory' '
     +	test_must_fail env GIT_ASSUME_UNSAFE=1 \
     +			   git status 2>err &&
-- 
2.51.1.476.g147428281d

