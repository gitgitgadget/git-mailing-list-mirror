Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D30C001B0
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 19:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjFVTvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 15:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFVTvd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 15:51:33 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7811FED
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 12:51:31 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 787555B415;
        Thu, 22 Jun 2023 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687463490;
        bh=ltsGQj7nNggI1iT06O39TcGI5pEsBobKBm/io0V2Wvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=e9gOPOj2K25IzcV/1lJEAgAwszAJI5GDNuzX1GZPuBRpas2z24kOxftrXNzrPAcxk
         vTgCdNdKT/FzAlIwH/7DYNtwfrgxtzUo2sKu07mJfUuwgHSqKf1KljR/YwySEk+m/+
         plznwEXeF33VAoIFNUYc0IJa3NzoPPa58InWRXeuig7V7L2u+igGRyv1zHPGSYQWlC
         xqVtoKEbQKATjtKL2hCdE609UH6iurxnfHj72cnbICn6RAwoDTKmNomA2ur9qerlXH
         0LSjuI2HVC1xi9Qy7eD95sh+ezn5YnMGa5jF3EuZMNn86DY2432oCwI8aEV9FfrviX
         4oLlaOGS4SS0imQO633POIF7AxEqtBr9qWsoXbOVoV0fERuGBxrK2KGcCYOos+qzF7
         ktl4OSBKHytazrtOiXlEAqOkgD7A3zmHlE8rzel7WJkeu47NcT9QWF4VzKFyd+IZIg
         JYfIUErgGKXL5KIZ6k3ikmeMCZMLDWl3Q3At9CTD/SdT0IJXyj+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: [PATCH 3/3] var: add config file locations
Date:   Thu, 22 Jun 2023 19:50:59 +0000
Message-ID: <20230622195059.320593-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230622195059.320593-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

Much like with attributes files, sometimes programs would like to know
the location of configuration files at the global or system levels.
However, it isn't always clear where these may live, especially for the
system file, which may have been hard-coded at compile time or computed
dynamically based on the runtime prefix.

Since other parties cannot intuitively know how Git was compiled and
where it looks for these files, help them by providing variables that
can be queried.  Because we have multiple paths for global config
values, print them in order from highest to lowest priority, and be sure
to split on newlines so that "git var -l" produces two entries for the
global value.

However, be careful not to split all values on newlines, since our
editor values could well contain such characters, and we don't want to
split them in such a case.

Note in the documentation that some values may contain multiple paths
and that callers should be prepared for that fact.  This helps people
write code that will continue to work in the event we allow multiple
items elsewhere in the future.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 Documentation/git-var.txt | 14 ++++++++
 builtin/var.c             | 68 +++++++++++++++++++++++++++++++++------
 t/t0007-git-var.sh        | 66 +++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index dfbe5cb52b..c38fb3968b 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -80,6 +80,20 @@ GIT_ATTR_SYSTEM::
 GIT_ATTR_GLOBAL::
     The path to the global (per-user) linkgit:gitattributes[5] file.
 
+GIT_CONFIG_SYSTEM::
+    The path to the system configuration file, if one is enabled.
+
+GIT_CONFIG_GLOBAL::
+    The path to the global (per-user) configuration files, if any.
+
+Most path values contain only one value. However, some can contain multiple
+values, which are separated by newlines, and are listed in order from highest to
+lowest priority.  Callers should be prepared for any such path value to contain
+multiple items.
+
+Note that paths are printed even if they do not exist, but not if they are
+disabled by other environment variables.
+
 SEE ALSO
 --------
 linkgit:git-commit-tree[1]
diff --git a/builtin/var.c b/builtin/var.c
index b9e2f23697..8a47b74777 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -62,21 +62,59 @@ static const char *git_attr_val_global(int flag)
 	return NULL;
 }
 
+static const char *git_config_val_system(int flag)
+{
+	if (git_config_system()) {
+		char *file = git_system_config();
+		normalize_path_copy(file, file);
+		return file;
+	}
+	return NULL;
+}
+
+static const char *git_config_val_global(int flag)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *user, *xdg;
+	size_t unused;
+
+	git_global_config(&user, &xdg);
+	if (xdg && *xdg) {
+		normalize_path_copy(xdg, xdg);
+		strbuf_addf(&buf, "%s\n", xdg);
+	}
+	if (user && *user) {
+		normalize_path_copy(user, user);
+		strbuf_addf(&buf, "%s\n", user);
+	}
+	free(xdg);
+	free(user);
+	strbuf_trim_trailing_newline(&buf);
+	if (buf.len == 0) {
+		strbuf_release(&buf);
+		return NULL;
+	}
+	return strbuf_detach(&buf, &unused);
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
+	int multivalued;
 	int free;
 };
 static struct git_var git_vars[] = {
-	{ "GIT_COMMITTER_IDENT", git_committer_info, 0 },
-	{ "GIT_AUTHOR_IDENT",   git_author_info, 0 },
-	{ "GIT_EDITOR", editor, 0 },
-	{ "GIT_SEQUENCE_EDITOR", sequence_editor, 0 },
-	{ "GIT_PAGER", pager, 0 },
-	{ "GIT_DEFAULT_BRANCH", default_branch, 0 },
-	{ "GIT_SHELL_PATH", shell_path, 0 },
-	{ "GIT_ATTR_SYSTEM", git_attr_val_system, 1 },
-	{ "GIT_ATTR_GLOBAL", git_attr_val_global, 1 },
+	{ "GIT_COMMITTER_IDENT", git_committer_info, 0, 0 },
+	{ "GIT_AUTHOR_IDENT",   git_author_info, 0, 0 },
+	{ "GIT_EDITOR", editor, 0, 0 },
+	{ "GIT_SEQUENCE_EDITOR", sequence_editor, 0, 0 },
+	{ "GIT_PAGER", pager, 0, 0 },
+	{ "GIT_DEFAULT_BRANCH", default_branch, 0, 9 },
+	{ "GIT_SHELL_PATH", shell_path, 0, 0 },
+	{ "GIT_ATTR_SYSTEM", git_attr_val_system, 0, 1 },
+	{ "GIT_ATTR_GLOBAL", git_attr_val_global, 0, 1 },
+	{ "GIT_CONFIG_SYSTEM", git_config_val_system, 0, 1 },
+	{ "GIT_CONFIG_GLOBAL", git_config_val_global, 1, 1 },
 	{ "", NULL },
 };
 
@@ -87,7 +125,17 @@ static void list_vars(void)
 
 	for (ptr = git_vars; ptr->read; ptr++)
 		if ((val = ptr->read(0))) {
-			printf("%s=%s\n", ptr->name, val);
+			if (ptr->multivalued && *val) {
+				struct string_list list = STRING_LIST_INIT_DUP;
+				int i;
+
+				string_list_split(&list, val, '\n', -1);
+				for (i = 0; i < list.nr; i++)
+					printf("%s=%s\n", ptr->name, list.items[i].string);
+				string_list_clear(&list, 0);
+			} else {
+				printf("%s=%s\n", ptr->name, val);
+			}
 			if (ptr->free)
 				free((void *)val);
 		}
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 6a2cc94abb..d519c2f441 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -179,6 +179,49 @@ test_expect_success 'GIT_ATTR_GLOBAL points to the correct location' '
 	)
 '
 
+test_expect_success 'GIT_CONFIG_SYSTEM points to the correct location' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	test_must_fail env GIT_CONFIG_NOSYSTEM=1 git var GIT_CONFIG_SYSTEM &&
+	(
+		sane_unset GIT_CONFIG_NOSYSTEM &&
+		git var GIT_CONFIG_SYSTEM >path &&
+		test "$(cat path)" != "" &&
+		GIT_CONFIG_SYSTEM=/dev/null git var GIT_CONFIG_SYSTEM >path &&
+		if test_have_prereq MINGW
+		then
+			test "$(cat path)" = "nul"
+		else
+			test "$(cat path)" = "/dev/null"
+		fi &&
+		GIT_CONFIG_SYSTEM="$TRASHDIR/gitconfig" git var GIT_CONFIG_SYSTEM >path &&
+		test "$(cat path)" = "$TRASHDIR/gitconfig"
+	)
+'
+
+test_expect_success 'GIT_CONFIG_GLOBAL points to the correct location' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" git var GIT_CONFIG_GLOBAL >actual &&
+	echo "$TRASHDIR/foo/git/config" >expected &&
+	echo "$TRASHDIR/.gitconfig" >>expected &&
+	test_cmp expected actual &&
+	(
+		sane_unset XDG_CONFIG_HOME &&
+		HOME="$TRASHDIR" git var GIT_CONFIG_GLOBAL >actual &&
+		echo "$TRASHDIR/.config/git/config" >expected &&
+		echo "$TRASHDIR/.gitconfig" >>expected &&
+		test_cmp expected actual &&
+		GIT_CONFIG_GLOBAL=/dev/null git var GIT_CONFIG_GLOBAL >path &&
+		if test_have_prereq MINGW
+		then
+			test "$(cat path)" = "nul"
+		else
+			test "$(cat path)" = "/dev/null"
+		fi &&
+		GIT_CONFIG_GLOBAL="$TRASHDIR/gitconfig" git var GIT_CONFIG_GLOBAL >path &&
+		test "$(cat path)" = "$TRASHDIR/gitconfig"
+	)
+'
+
 # For git var -l, we check only a representative variable;
 # testing the whole output would make our test too brittle with
 # respect to unrelated changes in the test suite's environment.
@@ -196,6 +239,29 @@ test_expect_success 'git var -l lists config' '
 	test_cmp expect actual.bare
 '
 
+test_expect_success 'git var -l lists multiple global configs' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" git var -l >actual &&
+	grep "^GIT_CONFIG_GLOBAL=" actual >filtered &&
+	echo "GIT_CONFIG_GLOBAL=$TRASHDIR/foo/git/config" >expected &&
+	echo "GIT_CONFIG_GLOBAL=$TRASHDIR/.gitconfig" >>expected &&
+	test_cmp expected filtered
+'
+
+test_expect_success 'git var -l does not split multiline editors' '
+	(
+		GIT_EDITOR="!f() {
+			echo Hello!
+		}; f" &&
+		export GIT_EDITOR &&
+		echo "GIT_EDITOR=$GIT_EDITOR" >expected &&
+		git var -l >var &&
+		cat var &&
+		sed -n -e "/^GIT_EDITOR/,\$p" var | head -n 3 >actual &&
+		test_cmp expected actual
+	)
+'
+
 test_expect_success 'listing and asking for variables are exclusive' '
 	test_must_fail git var -l GIT_COMMITTER_IDENT
 '
