Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A91096F
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 23:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710026840; cv=none; b=OZlje12EMJSIedxX+LwRU02tm7g9akZ+iw3FQdvnhbFavK+i0Z1gpbzoqz+DFDgFbD1YYX3gPMI9c+rl3NTwfc4BhCEFra5sNaJyPTh/lVKNwJ3Xm5f7QfcrA7bHPoiE7hIedh4qOim4dDaqLs9vEkvrCC1yB95nHNGU7Tm8JTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710026840; c=relaxed/simple;
	bh=BMZPqUlSyibSu2oc2l8AQb7PQpHZ7CDOYguIHvmscf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s4nZyMq8pzyrBk8SD1Phhs9A1hH+OhOfp9dV25hIjIBu9vLLGStaEqmfUVk967MzOe08NriPkMz0++1YBkmVmR0SNvOpWk/a1MudTKCh+0FtkdF0peiKE8fmQ/+aXKmsr4BJi0IRHcW8hDsUX3l+Rg2+IAP3oJu8wSwrXQE6ykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JhS+fQKm; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JhS+fQKm"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C9061ECCE4;
	Sat,  9 Mar 2024 18:27:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BMZPqUlSyibSu2oc2l8AQb7PQpHZ7CDOYguIHv
	mscf8=; b=JhS+fQKmmIqLbzPcdixQqifh8ddLU31Y1MctIDr2oQfZdsd/l66DnL
	uxByUiDUTaG8kAZ4OMLna0jjBGxDS3J5s1OS3yEBCV34zFK5oV7WbI3/UmRXW8J7
	FYlSnnHCsFXwv2GnbpkDASClgpM7xpk0Iun8R9sfAeUpFZPxNl8lA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 542521ECCE3;
	Sat,  9 Mar 2024 18:27:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B30981ECCE2;
	Sat,  9 Mar 2024 18:27:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>, Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH v2] setup: notice more types of implicit bare repositories
In-Reply-To: <20240308211957.3758770-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Fri, 8 Mar 2024 13:19:55 -0800")
References: <xmqqv85zqniu.fsf@gitster.g>
	<20240308211957.3758770-1-gitster@pobox.com>
Date: Sat, 09 Mar 2024 15:27:09 -0800
Message-ID: <xmqq5xxv0ywi.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8D892ACE-DE6C-11EE-968B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Builds directly on top of 45bb9162 (setup: allow cwd=.git w/
bareRepository=explicit, 2024-01-20).

Instead of saying "primary worktree's $GIT_DIR is OK", "secondary
worktree's $GIT_DIR is OK", and "submodule's $GIT_DIR is OK"
separately, let's give them a name to call them collectively,
"implicit bare repository" (for now, to reuse what an earlier commit
used, which may not be an optimum name), as these share the same
security guarantee and convenience benefit.

The code got significantly simpler, and test moderately more
complex, having to set up submodule tests.

------- >8 ------------- >8 ------------- >8 -------
Setting the safe.bareRepository configuration variable to explicit
stops git from using a bare repository, unless the repository is
explicitly specified, either by the "--git-dir=<path>" command line
option, or by exporting $GIT_DIR environment variable.  This may be
a reasonable measure to safeguard users from accidentally straying
into a bare repository in unexpected places, but often gets in the
way of users who need valid accesses too the repository.

Earlier, 45bb9162 (setup: allow cwd=.git w/ bareRepository=explicit,
2024-01-20) loosened the rule such that being inside the ".git"
directory of a non-bare repository does not really count as
accessing a "bare" repository.  The reason why such a loosening is
needed is because often hooks and third-party tools run from within
$GIT_DIR while working with a non-bare repository.

More importantly, the reason why this is safe is because a directory
whose contents look like that of a "bare" repository cannot be a
bare repository that came embedded within a checkout of a malicious
project, as long as its directory name is ".git", because ".git" is
not a name allowed for a directory in payload.

There are at least two other cases where tools have to work in a
bare-repository looking directory that is not an embedded bare
repository, and accesses to them are still not allowed by the recent
change.

 - A secondary worktree (whose name is $name) has its $GIT_DIR
   inside "worktrees/$name/" subdirectory of the $GIT_DIR of the
   primary worktree of the same repository.

 - A submodule worktree (whose name is $hame) has its $GIT_DIR
   inside "modules/$name/" subdirectory of the $GIT_DIR of its
   superproject.

As long as the primary worktree or the superproject in these cases
are not bare, the pathname of these "looks like bare but not really"
directories will have "/.git/worktrees/" and "/.git/modules/" as a
substring in its leading part, and we can take advantage of the same
security guarantee allow git to work from these places.

Extend the earlier "in a directory called '.git' we are OK" logic
used for the primary worktree to also cover the secondary worktree's
and non-embedded submodule's $GIT_DIR, by moving the logic to a
helper function "is_implicit_bare_repo()".  We deliberately exclude
secondary worktrees and submodules of a bare repository, as these
are exactly what safe.bareRepository=explicit setting is designed to
forbid accesses to without an explicit GIT_DIR/--git-dir=<path>

Helped-by: Kyle Lippincott <spectral@google.com>
Helped-by: Kyle Meyer <kyle@kyleam.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c                         | 28 +++++++++++++++++++++++++++-
 t/t0035-safe-bare-repository.sh | 26 ++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/setup.c b/setup.c
index a09b7b87ec..25d98ee6dd 100644
--- a/setup.c
+++ b/setup.c
@@ -1231,6 +1231,32 @@ static const char *allowed_bare_repo_to_string(
 	return NULL;
 }
 
+static int is_implicit_bare_repo(const char *path)
+{
+	/*
+	 * what we found is a ".git" directory at the root of
+	 * the working tree.
+	 */
+	if (ends_with_path_components(path, ".git"))
+		return 1;
+
+	/*
+	 * we are inside $GIT_DIR of a secondary worktree of a
+	 * non-bare repository.
+	 */
+	if (strstr(path, "/.git/worktrees/"))
+		return 1;
+
+	/*
+	 * we are inside $GIT_DIR of a worktree of a non-embedded
+	 * submodule, whose superproject is not a bare repository.
+	 */
+	if (strstr(path, "/.git/modules/"))
+		return 1;
+
+	return 0;
+}
+
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
@@ -1360,7 +1386,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		if (is_git_directory(dir->buf)) {
 			trace2_data_string("setup", NULL, "implicit-bare-repository", dir->buf);
 			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT &&
-			    !ends_with_path_components(dir->buf, ".git"))
+			    !is_implicit_bare_repo(dir->buf))
 				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
 				return GIT_DIR_INVALID_OWNERSHIP;
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
index 8048856379..d3cb2a1cb9 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -29,9 +29,20 @@ expect_rejected () {
 	grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
 }
 
-test_expect_success 'setup bare repo in worktree' '
+test_expect_success 'setup an embedded bare repo, secondary worktree and submodule' '
 	git init outer-repo &&
-	git init --bare outer-repo/bare-repo
+	git init --bare --initial-branch=main outer-repo/bare-repo &&
+	git -C outer-repo worktree add ../outer-secondary &&
+	test_path_is_dir outer-secondary &&
+	(
+		cd outer-repo &&
+		test_commit A &&
+		git push bare-repo +HEAD:refs/heads/main &&
+		git -c protocol.file.allow=always \
+			submodule add --name subn -- ./bare-repo subd
+	) &&
+	test_path_is_dir outer-repo/.git/worktrees/outer-secondary &&
+	test_path_is_dir outer-repo/.git/modules/subn
 '
 
 test_expect_success 'safe.bareRepository unset' '
@@ -53,8 +64,7 @@ test_expect_success 'safe.bareRepository in the repository' '
 	# safe.bareRepository must not be "explicit", otherwise
 	# git config fails with "fatal: not in a git directory" (like
 	# safe.directory)
-	test_config -C outer-repo/bare-repo safe.bareRepository \
-		all &&
+	test_config -C outer-repo/bare-repo safe.bareRepository all &&
 	test_config_global safe.bareRepository explicit &&
 	expect_rejected -C outer-repo/bare-repo
 '
@@ -86,4 +96,12 @@ test_expect_success 'no trace when "bare repository" is a subdir of .git' '
 	expect_accepted_implicit -C outer-repo/.git/objects
 '
 
+test_expect_success 'no trace in $GIT_DIR of secondary worktree' '
+	expect_accepted_implicit -C outer-repo/.git/worktrees/outer-secondary
+'
+
+test_expect_success 'no trace in $GIT_DIR of a submodule' '
+	expect_accepted_implicit -C outer-repo/.git/modules/subn
+'
+
 test_done
-- 
2.44.0-165-ge09f1254c5

