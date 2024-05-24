Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CCF3F9D2
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580063; cv=none; b=qHzFA1dXIxsCk3IWUaUTtEPaAJQMct/e2zm+GwqN84RQXEPfvqo0trQlhBfLDbHRakDiwnC+2ZXPV9pD5sR4Cd5cmk5Ytu4XLe/PDnr9DWDIQPt1pPWV8wF70W2IVfpRgtgJh9i+n1RpQQ4z05L7quXwr8UqqmYZe9e4krqng5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580063; c=relaxed/simple;
	bh=V8DwcWj3hSpxROWdHaYBMlJm8rOkMHNFFEpa4c/8+5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7ZqbgZ2Hk0J4zrsOnVWBSVPeDwFQbhSQnoeJr87FvgtpAD766JXsGAO7D7q7dIhJz9SwHhwV2o53WElwfqRjaUPDolZEKAyQbqAHD13QFtTn0h5ByCYwjcAdOb+b2SmrlT9wTzZM80hSLRHRCYwnhUscEr7LG0r513bpnc9xtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wPSCXcv9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wPSCXcv9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BD6DE2B22A;
	Fri, 24 May 2024 15:47:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=V8DwcWj3hSpxROWdHaYBMlJm8
	rOkMHNFFEpa4c/8+5g=; b=wPSCXcv9YG9qQIkju3mRlWRZ/ywjDlirGqDsIqlrn
	54s372wBXaLj98+riJE6KyY8pGg2/nV15xGxIOlQLUwPu+NUutc6yImtzp6n/T/j
	w3MPeqSvkA9JKcjJ23c+LOpfaSsZz3vWxz3bmsU4sLT0TduffwUQ4K5KerrIB1+J
	j4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B67662B229;
	Fri, 24 May 2024 15:47:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D55F02B227;
	Fri, 24 May 2024 15:47:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 10/12] clone: drop the protections where hooks aren't run
Date: Fri, 24 May 2024 12:47:13 -0700
Message-ID: <20240524194715.695916-11-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-246-gb9cfe4845c
In-Reply-To: <20240524194715.695916-1-gitster@pobox.com>
References: <20240524194715.695916-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 79E4127E-1A06-11EF-B92A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As part of the security bug-fix releases v2.39.4, ..., v2.45.1, I
introduced logic to safeguard `git clone` from running hooks that were
installed _during_ the clone operation.

The rationale was that Git's CVE-2024-32002, CVE-2021-21300,
CVE-2019-1354, CVE-2019-1353, CVE-2019-1352, and CVE-2019-1349 should
have been low-severity vulnerabilities but were elevated to
critical/high severity by the attack vector that allows a weakness where
files inside `.git/` can be inadvertently written during a `git clone`
to escalate to a Remote Code Execution attack by virtue of installing a
malicious `post-checkout` hook that Git will then run at the end of the
operation without giving the user a chance to see what code is executed.

Unfortunately, Git LFS uses a similar strategy to install its own
`post-checkout` hook during a `git clone`; In fact, Git LFS is
installing four separate hooks while running the `smudge` filter.

While this pattern is probably in want of being improved by introducing
better support in Git for Git LFS and other tools wishing to register
hooks to be run at various stages of Git's commands, let's undo the
clone protections to unbreak Git LFS-enabled clones.

This reverts commit 8db1e8743c0 (clone: prevent hooks from running
during a clone, 2024-03-28).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c  | 12 +-----------
 hook.c           | 34 --------------------------------
 t/t5601-clone.sh | 51 ------------------------------------------------
 3 files changed, 1 insertion(+), 96 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index e7721f5c22..9ec500d427 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -937,8 +937,6 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	int err =3D 0, complete_refs_before_fetch =3D 1;
 	int submodule_progress;
 	int filter_submodules =3D 0;
-	const char *template_dir;
-	char *template_dir_dup =3D NULL;
=20
 	struct transport_ls_refs_options transport_ls_refs_options =3D
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -958,13 +956,6 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
=20
-	xsetenv("GIT_CLONE_PROTECTION_ACTIVE", "true", 0 /* allow user override=
 */);
-	template_dir =3D get_template_dir(option_template);
-	if (*template_dir && !is_absolute_path(template_dir))
-		template_dir =3D template_dir_dup =3D
-			absolute_pathdup(template_dir);
-	xsetenv("GIT_CLONE_TEMPLATE_DIR", template_dir, 1);
-
 	if (option_depth || option_since || option_not.nr)
 		deepen =3D 1;
 	if (option_single_branch =3D=3D -1)
@@ -1112,7 +1103,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		}
 	}
=20
-	init_db(git_dir, real_git_dir, template_dir, GIT_HASH_UNKNOWN, NULL,
+	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
 		INIT_DB_QUIET);
=20
 	if (real_git_dir) {
@@ -1430,7 +1421,6 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	free(unborn_head);
 	free(dir);
 	free(path);
-	free(template_dir_dup);
 	UNLEAK(repo);
 	junk_mode =3D JUNK_LEAVE_ALL;
=20
diff --git a/hook.c b/hook.c
index fc974cee1d..22b274b60b 100644
--- a/hook.c
+++ b/hook.c
@@ -3,32 +3,6 @@
 #include "run-command.h"
 #include "config.h"
=20
-static int identical_to_template_hook(const char *name, const char *path=
)
-{
-	const char *env =3D getenv("GIT_CLONE_TEMPLATE_DIR");
-	const char *template_dir =3D get_template_dir(env && *env ? env : NULL)=
;
-	struct strbuf template_path =3D STRBUF_INIT;
-	int found_template_hook, ret;
-
-	strbuf_addf(&template_path, "%s/hooks/%s", template_dir, name);
-	found_template_hook =3D access(template_path.buf, X_OK) >=3D 0;
-#ifdef STRIP_EXTENSION
-	if (!found_template_hook) {
-		strbuf_addstr(&template_path, STRIP_EXTENSION);
-		found_template_hook =3D access(template_path.buf, X_OK) >=3D 0;
-	}
-#endif
-	if (!found_template_hook) {
-		strbuf_release(&template_path);
-		return 0;
-	}
-
-	ret =3D do_files_match(template_path.buf, path);
-
-	strbuf_release(&template_path);
-	return ret;
-}
-
 const char *find_hook(const char *name)
 {
 	static struct strbuf path =3D STRBUF_INIT;
@@ -64,14 +38,6 @@ const char *find_hook(const char *name)
 		}
 		return NULL;
 	}
-	if (!git_hooks_path && git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0) &=
&
-	    !identical_to_template_hook(name, path.buf))
-		die(_("active `%s` hook found during `git clone`:\n\t%s\n"
-		      "For security reasons, this is disallowed by default.\n"
-		      "If this is intentional and the hook should actually "
-		      "be run, please\nrun the command again with "
-		      "`GIT_CLONE_PROTECTION_ACTIVE=3Dfalse`"),
-		    name, path.buf);
 	return path.buf;
 }
=20
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 20deca0231..fd02984330 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -771,57 +771,6 @@ test_expect_success 'batch missing blob request does=
 not inadvertently try to fe
 	git clone --filter=3Dblob:limit=3D0 "file://$(pwd)/server" client
 '
=20
-test_expect_success 'clone with init.templatedir runs hooks' '
-	git init tmpl/hooks &&
-	write_script tmpl/hooks/post-checkout <<-EOF &&
-	echo HOOK-RUN >&2
-	echo I was here >hook.run
-	EOF
-	git -C tmpl/hooks add . &&
-	test_tick &&
-	git -C tmpl/hooks commit -m post-checkout &&
-
-	test_when_finished "git config --global --unset init.templateDir || :" =
&&
-	test_when_finished "git config --unset init.templateDir || :" &&
-	(
-		sane_unset GIT_TEMPLATE_DIR &&
-		NO_SET_GIT_TEMPLATE_DIR=3Dt &&
-		export NO_SET_GIT_TEMPLATE_DIR &&
-
-		git -c core.hooksPath=3D"$(pwd)/tmpl/hooks" \
-			clone tmpl/hooks hook-run-hookspath 2>err &&
-		! grep "active .* hook found" err &&
-		test_path_is_file hook-run-hookspath/hook.run &&
-
-		git -c init.templateDir=3D"$(pwd)/tmpl" \
-			clone tmpl/hooks hook-run-config 2>err &&
-		! grep "active .* hook found" err &&
-		test_path_is_file hook-run-config/hook.run &&
-
-		git clone --template=3Dtmpl tmpl/hooks hook-run-option 2>err &&
-		! grep "active .* hook found" err &&
-		test_path_is_file hook-run-option/hook.run &&
-
-		git config --global init.templateDir "$(pwd)/tmpl" &&
-		git clone tmpl/hooks hook-run-global-config 2>err &&
-		git config --global --unset init.templateDir &&
-		! grep "active .* hook found" err &&
-		test_path_is_file hook-run-global-config/hook.run &&
-
-		# clone ignores local `init.templateDir`; need to create
-		# a new repository because we deleted `.git/` in the
-		# `setup` test case above
-		git init local-clone &&
-		cd local-clone &&
-
-		git config init.templateDir "$(pwd)/../tmpl" &&
-		git clone ../tmpl/hooks hook-run-local-config 2>err &&
-		git config --unset init.templateDir &&
-		! grep "active .* hook found" err &&
-		test_path_is_missing hook-run-local-config/hook.run
-	)
-'
-
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
=20
--=20
2.45.1-246-gb9cfe4845c

