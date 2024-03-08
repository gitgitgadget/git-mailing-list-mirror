Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB865F56A
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932812; cv=none; b=JQBjp2f0pqPMGl20D0jAy84buihd+QRKMtpgkdFMt1ZHEdawaU3cqWkY37XPWcZU+JgYQrfZ8bULS0RRtoas28UYnxLfxy+kFj3ZBItFEMa3lmknE2SF2Y9zc8Swooo+cVv4sZEqnMVyur2dZprAsRZ3J6g3daREiNbRyY2Z8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932812; c=relaxed/simple;
	bh=vujvJ66yCSrLQLfuEdfAHL4Lx3O0yN5vH2YOoRTV3Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9Ss3fOJttjYcK6NVaD9W8z/sQt0BTMFUXh/78JsZR9rF+OHvTa2sbByjIvvpPeP2W2L5rw95TKCgk2NkvNLp0K9bXuIj0FQ+Ilx/lxjy8Eza4ZlcnJSighAYggEFmB4fLQELiYOKKEM4PzVi+zQf1SCFnk15dh0u/fO7UteQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=e1lBWklE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e1lBWklE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A78B21EF29F;
	Fri,  8 Mar 2024 16:20:09 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=vujvJ66yCSrLQLfuEdfAHL4Lx
	3O0yN5vH2YOoRTV3Jc=; b=e1lBWklERljYlPRb9OgrQ3UzXaUdG8PSo3gwgrBOa
	cW5v52rp7WwUB6qk20ERUYoQzuVk8Y0fcISpYYmjDNmWq6zXGkNsoT7md5q+wX2j
	AN9hrb8pL2733YfBvQMYB3H0s8UbXp92wsGqjZF77pwPvgYb/TcOxPIX++I1m3bB
	Wg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9910F1EF29D;
	Fri,  8 Mar 2024 16:20:09 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B90D91EF29B;
	Fri,  8 Mar 2024 16:20:08 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>
Subject: [PATCH 2/2] setup: make bareRepository=explicit work in GIT_DIR of a secondary worktree
Date: Fri,  8 Mar 2024 13:19:57 -0800
Message-ID: <20240308211957.3758770-3-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-165-ge09f1254c5
In-Reply-To: <20240308211957.3758770-1-gitster@pobox.com>
References: <xmqqv85zqniu.fsf@gitster.g>
 <20240308211957.3758770-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A416BE2C-DD91-11EE-83E6-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

If you have /var/tmp/primary/ as a repository, and if you create a
secondary worktree of it at /var/tmp/secondary/, the layout would
look like this:

    $ cd /var/tmp/
    $ git init primary
    $ cd primary
    $ pwd
    /var/tmp/primary
    $ git worktree add ../secondary
    $ cat ../seconary/.git
    gitdir: /var/tmp/primary/.git/worktrees/secondary
    $ ls /var/tmp/primary/.git/worktrees/secondary
    commondir  gitdir  HEAD  index  refs
    $ cat /var/tmp/primary/.git/worktrees/secondary/gitdir
    /var/tmp/secondary/.git

When the configuration variable 'safe.bareRepository=3Dexplicit' is
set to explicit, the change made by 45bb9162 (setup: allow cwd=3D.git
w/ bareRepository=3Dexplicit, 2024-01-20) allows you to work in the
/var/tmp/primary/.git directory (i.e., $GIT_DIR of the primary
worktree).  The idea is that if it is safe to work in the repository
in its working tree, it should be equally safe to work in the
".git/" directory of that working tree, too.

Now, for the same reason, let's allow command execution from within
the $GIT_DIR directory of a secondary worktree.  This is useful for
tools working with secondary worktrees when the 'bareRepository'
setting is set to 'explicit'.

In the previous commit, we created a helper function to house the
logic that checks if a directory that looks like a bare repository
is actually a part of a non-bare repository.  Extend the helper
function to also check if the apparent bare-repository is a $GIT_DIR
of a secondary worktree, by checking three things:

 * The path to the $GIT_DIR must be a subdirectory of
   ".git/worktrees/", which is the primary worktree [*].

 * Such $GIT_DIR must have file "gitdir", that records the path of
   the ".git" file that is at the root level of the secondary
   worktree.

 * That ".git" file in turn points back at the $GIT_DIR we are
   inspecting.

The latter two points are merely for checking sanity.  The security
lies in the first requirement.

Remember that a tree object with an entry whose pathname component
is ".git" is forbidden at various levels (fsck, object transfer and
checkout), so malicious projects cannot cause users to clone and
checkout a crafted ".git" directory in a shell directory that
pretends to be a working tree with that ".git" thing at its root
level.  That is where 45bb9162 (setup: allow cwd=3D.git w/
bareRepository=3Dexplicit, 2024-01-20) draws its security guarantee
from.  And the solution for secondary worktrees in this commit draws
its security guarantee from the same place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c                         | 52 ++++++++++++++++++++++++++++++++-
 t/t0035-safe-bare-repository.sh |  8 ++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 3081be4970..68860dcd18 100644
--- a/setup.c
+++ b/setup.c
@@ -1231,9 +1231,59 @@ static const char *allowed_bare_repo_to_string(
 	return NULL;
 }
=20
+static int is_git_dir_of_secondary_worktree(const char *path)
+{
+	int result =3D 0; /* assume not */
+	struct strbuf gitfile_here =3D STRBUF_INIT;
+	struct strbuf gitfile_there =3D STRBUF_INIT;
+	const char *gitfile_contents;
+	int error_code =3D 0;
+
+	/*
+	 * We should be a subdirectory of /.git/worktrees inside
+	 * the $GIT_DIR of the primary worktree.
+	 *
+	 * NEEDSWORK: some folks create secondary worktrees out of a
+	 * bare repository; they don't count ;-), at least not yet.
+	 */
+	if (!strstr(path, "/.git/worktrees/"))
+		goto out;
+
+	/*
+	 * Does gitdir that points at the ".git" file at the root of
+	 * the secondary worktree roundtrip here?
+	 */
+	strbuf_addf(&gitfile_here, "%s/gitdir", path);
+	if (!file_exists(gitfile_here.buf))
+		goto out;
+	if (strbuf_read_file(&gitfile_there, gitfile_here.buf, 0) < 0)
+		goto out;
+	strbuf_trim_trailing_newline(&gitfile_there);
+
+	gitfile_contents =3D read_gitfile_gently(gitfile_there.buf, &error_code=
);
+	if ((!gitfile_contents) || strcmp(gitfile_contents, path))
+		goto out;
+
+	/* OK, we are happy */
+	result =3D 1;
+
+out:
+	strbuf_release(&gitfile_here);
+	strbuf_release(&gitfile_there);
+	return result;
+}
+
 static int is_repo_with_working_tree(const char *path)
 {
-	return ends_with_path_components(path, ".git");
+	/* $GIT_DIR immediately below the primary working tree */
+	if (ends_with_path_components(path, ".git"))
+		return 1;
+
+	/* Are we in $GIT_DIR of a secondary worktree? */
+	if (is_git_dir_of_secondary_worktree(path))
+		return 1;
+
+	return 0;
 }
=20
 /*
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-reposito=
ry.sh
index 8048856379..62cdfcefc1 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -31,7 +31,9 @@ expect_rejected () {
=20
 test_expect_success 'setup bare repo in worktree' '
 	git init outer-repo &&
-	git init --bare outer-repo/bare-repo
+	git init --bare outer-repo/bare-repo &&
+	git -C outer-repo worktree add ../outer-secondary &&
+	test_path_is_dir outer-secondary
 '
=20
 test_expect_success 'safe.bareRepository unset' '
@@ -86,4 +88,8 @@ test_expect_success 'no trace when "bare repository" is=
 a subdir of .git' '
 	expect_accepted_implicit -C outer-repo/.git/objects
 '
=20
+test_expect_success 'no trace in $GIT_DIR of secondary worktree' '
+	expect_accepted_implicit -C outer-repo/.git/worktrees/outer-secondary
+'
+
 test_done
--=20
2.44.0-165-ge09f1254c5

