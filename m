From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] hooks: Add ability to specify where the hook directory is
Date: Fri, 22 Apr 2016 23:33:17 +0000
Message-ID: <1461367997-28745-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 01:33:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atkaE-0003hE-Kf
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 01:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbcDVXdy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 19:33:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35279 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbcDVXdx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 19:33:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id e201so7555981wme.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3g6ePyAmq00OCWBtqIRZOgSLnSpMeaJT+06kRsrPFrY=;
        b=RkkDJ9vZfcNipcT9vgcaxKazX+Y3FuQ6dLfjaM5iwYS2h8eeTlwpjemrBeylJtMvXX
         s9t468RNfjvXBHrSIvV4TyzStNYaEhsh1mZSSGXhda5N/Yv4o0bgNMn/3/LAR+ecwAaL
         qVhoZFjI3kv0N8jY+fCsWgLUdb05mZCIcK7hJqevgjyi1zZt+j3zUN2LLouapLp9W5gO
         RFdalyl6f1Kx5x/BiiDObGOBLvi0N14OAMNIuqJFqAwlGw1UxNkNoX+obS2lZGnHat0a
         SEkQeiz3g/jKE77dVfA4ol9quFlULkKqvnwDLMn1uoBp+j9rkOf+yuBppFm4brs0aiqK
         /gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3g6ePyAmq00OCWBtqIRZOgSLnSpMeaJT+06kRsrPFrY=;
        b=K5NqotTy9Cq81NX9UpAvsRmRORoDIB96jnJGbz52YWHQ0fckL4g58FV2EGnZyD+D7G
         z4FNsrR+gBe0CYmM09SUmMXiKz31c/YzTCFcVeq8H1NwLJq158JH+q7R+CewZRJYw9Xu
         wqNjZMeaw3T45ZynYvA+ozqNxDv2MhVNN3W6eAAvNy3YqWujjfdlNKYLRIdfMqsh5dE5
         KdzO7BtHKTEn+bYSfJoKyvc4lf8bE9Bw8baPBAQsQWvRJKdE+QQ5+h79MU5ZTUvsOm75
         /JeQG3hQ7jzcJFuXsTkLqeVCAAtT4hlr9XPAzU0T9axbId0DOc0FR/DoObMdh6RFfaeQ
         44Qg==
X-Gm-Message-State: AOPr4FVt1iWDBwUYEVI6/Ek8f0t5XmjvmSpKP3QjOJrIpq49jVxKDQv/6jXv52GhtKeU8w==
X-Received: by 10.194.112.6 with SMTP id im6mr22807014wjb.16.1461368031230;
        Fri, 22 Apr 2016 16:33:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id wa1sm10297464wjc.45.2016.04.22.16.33.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Apr 2016 16:33:50 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292290>

Change the hardcoded lookup for .git/hooks/* to optionally lookup in
$(git config core.hooksDirectory)/* instead if that config key is set.

This is essentially a more intrusive version of the git-init ability to
specify hooks on init time via init templates.

The difference between that facility and this feature is that this can
be set up after the fact via e.g. ~/.gitconfig or /etc/gitconfig to
apply for all your personal repositories, or all repositories on the
system.

I plan on using this on a centralized Git server where users can create
arbitrary repositories under /gitroot, but I'd like to manage all the
hooks that should be run centrally via a unified dispatch mechanism.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/config.txt          | 10 ++++++++++
 Documentation/githooks.txt        |  5 ++++-
 cache.h                           |  1 +
 config.c                          |  3 +++
 environment.c                     |  1 +
 run-command.c                     |  5 ++++-
 t/t1350-config-hooks-directory.sh | 35 +++++++++++++++++++++++++++++++=
++++
 7 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100755 t/t1350-config-hooks-directory.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..2faf3c0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -618,6 +618,16 @@ core.attributesFile::
 	$XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME is either not
 	set or empty, $HOME/.config/git/attributes is used instead.
=20
+core.hooksDirectory::
+	By default Git will look for your hooks in the '$GIT_DIR/hooks'
+	directory. Set this to different absolute directory name,
+	e.g. '/etc/git/hooks', and Git will try to find your hooks that
+	directory, e.g. '/etc/git/hooks/pre-receive' instead of in
+	'$GIT_DIR/hooks'.
++
+This is useful in cases where you'd like to centrally configure your
+Git hooks instead of configuring them on a per-repository basis.
+
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
 	messages by launching an editor uses the value of this
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a2f59b1..e1fe66d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -13,13 +13,16 @@ $GIT_DIR/hooks/*
 DESCRIPTION
 -----------
=20
-Hooks are little scripts you can place in `$GIT_DIR/hooks`
+Hooks are little scripts you can place in the `hooks`
 directory to trigger action at certain points.  When
 'git init' is run, a handful of example hooks are copied into the
 `hooks` directory of the new repository, but by default they are
 all disabled.  To enable a hook, rename it by removing its `.sample`
 suffix.
=20
+By default the hooks directory is `$GIT_DIR/hooks`, but that can be
+changed via the `core.hooksDirectory` (see linkgit:git-config[1]).
+
 NOTE: It is also a requirement for a given hook to be executable.
 However - in a freshly initialized repository - the `.sample` files ar=
e
 executable by default.
diff --git a/cache.h b/cache.h
index 2711048..85ad594 100644
--- a/cache.h
+++ b/cache.h
@@ -654,6 +654,7 @@ extern int warn_on_object_refname_ambiguity;
 extern const char *apply_default_whitespace;
 extern const char *apply_default_ignorewhitespace;
 extern const char *git_attributes_file;
+extern const char *git_hooks_directory;
 extern int zlib_compression_level;
 extern int core_compression_level;
 extern int core_compression_seen;
diff --git a/config.c b/config.c
index 10b5c95..543de4e 100644
--- a/config.c
+++ b/config.c
@@ -717,6 +717,9 @@ static int git_default_core_config(const char *var,=
 const char *value)
 	if (!strcmp(var, "core.attributesfile"))
 		return git_config_pathname(&git_attributes_file, var, value);
=20
+	if (!strcmp(var, "core.hooksdirectory"))
+		return git_config_pathname(&git_hooks_directory, var, value);
+
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg =3D git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 57acb2f..ffb5dec 100644
--- a/environment.c
+++ b/environment.c
@@ -31,6 +31,7 @@ const char *git_log_output_encoding;
 const char *apply_default_whitespace;
 const char *apply_default_ignorewhitespace;
 const char *git_attributes_file;
+const char *git_hooks_directory;
 int zlib_compression_level =3D Z_BEST_SPEED;
 int core_compression_level;
 int core_compression_seen;
diff --git a/run-command.c b/run-command.c
index 8c7115a..ae8e470 100644
--- a/run-command.c
+++ b/run-command.c
@@ -815,7 +815,10 @@ const char *find_hook(const char *name)
 	static struct strbuf path =3D STRBUF_INIT;
=20
 	strbuf_reset(&path);
-	strbuf_git_path(&path, "hooks/%s", name);
+	if (git_hooks_directory)
+		strbuf_addf(&path, "%s/%s", git_hooks_directory, name);
+	else
+		strbuf_git_path(&path, "hooks/%s", name);
 	if (access(path.buf, X_OK) < 0)
 		return NULL;
 	return path.buf;
diff --git a/t/t1350-config-hooks-directory.sh b/t/t1350-config-hooks-d=
irectory.sh
new file mode 100755
index 0000000..556c1d3
--- /dev/null
+++ b/t/t1350-config-hooks-directory.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description=3D'Test the core.hooksDirectory configuration variabl=
e'
+
+. ./test-lib.sh
+
+test_expect_success 'set up a pre-commit hook in core.hooksDirectory' =
'
+	mkdir -p .git/custom-hooks .git/hooks &&
+	cat >.git/custom-hooks/pre-commit <<EOF &&
+#!$SHELL_PATH
+printf "%s" "." >>.git/PRE-COMMIT-HOOK-WAS-CALLED
+EOF
+	cat >.git/hooks/pre-commit <<EOF &&
+	chmod +x .git/hooks/pre-commit
+#!$SHELL_PATH
+printf "%s" "SHOULD NOT BE CALLED" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
+EOF
+	chmod +x .git/custom-hooks/pre-commit
+'
+
+test_expect_success 'Check that various forms of specifying core.hooks=
Directory work' '
+	test_commit no_custom_hook &&
+	git config core.hooksDirectory .git/custom-hooks &&
+	test_commit have_custom_hook &&
+	git config core.hooksDirectory .git/custom-hooks/ &&
+	test_commit have_custom_hook_trailing_slash &&
+	git config core.hooksDirectory "$PWD/.git/custom-hooks" &&
+	test_commit have_custom_hook_abs_path &&
+	git config core.hooksDirectory "$PWD/.git/custom-hooks/" &&
+	test_commit have_custom_hook_abs_path_trailing_slash &&
+    printf "%s" "...." >.git/PRE-COMMIT-HOOK-WAS-CALLED.expect &&
+    test_cmp .git/PRE-COMMIT-HOOK-WAS-CALLED.expect .git/PRE-COMMIT-HO=
OK-WAS-CALLED
+'
+
+test_done
--=20
2.1.3
