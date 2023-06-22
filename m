Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAA3EB64DC
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 19:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjFVTvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 15:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFVTve (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 15:51:34 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5021FF1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 12:51:31 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 67EDC5B412;
        Thu, 22 Jun 2023 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687463490;
        bh=zf58TXRlm/XdDzdBNW6nqgkp/SxJfkspEHC/B5v56p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MGPShhsJRrwgBwUH3dtTxxomjc46y73mhL0www1QQ43RzCaQx/mcxCqo3rNpCa2WU
         UGfG7H7adVKZrTdgY0MBG5DfIOILCwvK2wo+9x/ETuah4zNYeMpC4Owii2c9d6NJfz
         B0ytPJv8kggr1i9K4WYhbe0TCWT2SzsF+KtagUSnfbY9BVuhsF3ZSEAt07VovIp7qo
         utbkrX5LkxxDmOprnO8KtBqK0r+HxytL0BVORkWInzVcJrACW6Q8080iNi2iOLE+ty
         E3tQrwpyUJUILahB/P3L03BdzKJw+ISs6+0d3k2mDKCIMfLHCa0u52K6Dr47p94Vfn
         v0Eqt1oMZLmOnDs5GJfciXaRxQyPMNi5gAnnVD8jxDpY3cSrAQSxT3Ou9i1/x2Vrkj
         q4Zgw0iUkE/pCjzyELnXMv+b+5OW4+SLxhW8bkIv/nGBlQZ6VDMXhlfuldwvtnkKGY
         qmXB4Pdt+eo8HS1poPmxCfEcuZA8FcqoKJUs2g7o+SO5qTx1C02
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: [PATCH 2/3] var: add attributes files locations
Date:   Thu, 22 Jun 2023 19:50:58 +0000
Message-ID: <20230622195059.320593-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230622195059.320593-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

Currently, there are some programs which would like to read and parse
the gitattributes files at the global or system levels.  However, it's
not always obvious where these files live, especially for the system
file, which may have been hard-coded at compile time or computed
dynamically based on the runtime prefix.

It's not reasonable to expect all callers of Git to intuitively know
where the Git distributor or user has configured these locations to
be, so add some entries to allow us to determine their location.  Honor
the GIT_ATTR_NOSYSTEM environment variable if one is specified.  Expose
the accessor functions in a way that we can reuse them from within the
var code.

In order to make our paths consistent on Windows and also use the same
form as paths use in "git rev-parse", let's normalize the path before we
return it.  This results in Windows-style paths that use slashes, which
is convenient for making our tests function in a consistent way across
platforms.  Note that this requires that some of our values be freed, so
let's add a flag about whether the value needs to be freed and use it
accordingly.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 Documentation/git-var.txt |  6 ++++++
 attr.c                    |  6 +++---
 attr.h                    |  4 ++++
 builtin/var.c             | 45 ++++++++++++++++++++++++++++++++-------
 t/t0007-git-var.sh        | 20 +++++++++++++++++
 5 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index f0f647e14a..dfbe5cb52b 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -74,6 +74,12 @@ GIT_DEFAULT_BRANCH::
 GIT_SHELL_PATH::
     The path of the binary providing the POSIX shell for commands which use the shell.
 
+GIT_ATTR_SYSTEM::
+    The path to the system linkgit:gitattributes[5] file, if one is enabled.
+
+GIT_ATTR_GLOBAL::
+    The path to the global (per-user) linkgit:gitattributes[5] file.
+
 SEE ALSO
 --------
 linkgit:git-commit-tree[1]
diff --git a/attr.c b/attr.c
index d45d34058d..822d214053 100644
--- a/attr.c
+++ b/attr.c
@@ -870,7 +870,7 @@ static struct attr_stack *read_attr(struct index_state *istate,
 	return res;
 }
 
-static const char *git_etc_gitattributes(void)
+const char *git_etc_gitattributes(void)
 {
 	static const char *system_wide;
 	if (!system_wide)
@@ -878,7 +878,7 @@ static const char *git_etc_gitattributes(void)
 	return system_wide;
 }
 
-static const char *get_home_gitattributes(void)
+const char *get_home_gitattributes(void)
 {
 	if (!git_attributes_file)
 		git_attributes_file = xdg_config_home("attributes");
@@ -886,7 +886,7 @@ static const char *get_home_gitattributes(void)
 	return git_attributes_file;
 }
 
-static int git_attr_system(void)
+int git_attr_system(void)
 {
 	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
 }
diff --git a/attr.h b/attr.h
index 676bd17ce2..05a2e4c622 100644
--- a/attr.h
+++ b/attr.h
@@ -227,4 +227,8 @@ void git_attr_set_direction(enum git_attr_direction new_direction);
 
 void attr_start(void);
 
+const char *git_etc_gitattributes(void);
+const char *get_home_gitattributes(void);
+int git_attr_system(void);
+
 #endif /* ATTR_H */
diff --git a/builtin/var.c b/builtin/var.c
index f97178eed1..b9e2f23697 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -4,6 +4,7 @@
  * Copyright (C) Eric Biederman, 2005
  */
 #include "builtin.h"
+#include "attr.h"
 #include "config.h"
 #include "editor.h"
 #include "ident.h"
@@ -41,18 +42,41 @@ static const char *shell_path(int flag)
 	return SHELL_PATH;
 }
 
+static const char *git_attr_val_system(int flag)
+{
+	if (git_attr_system()) {
+		char *file = xstrdup(git_etc_gitattributes());
+		normalize_path_copy(file, file);
+		return file;
+	}
+	return NULL;
+}
+
+static const char *git_attr_val_global(int flag)
+{
+	char *file = xstrdup(get_home_gitattributes());
+	if (file) {
+		normalize_path_copy(file, file);
+		return file;
+	}
+	return NULL;
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
+	int free;
 };
 static struct git_var git_vars[] = {
-	{ "GIT_COMMITTER_IDENT", git_committer_info },
-	{ "GIT_AUTHOR_IDENT",   git_author_info },
-	{ "GIT_EDITOR", editor },
-	{ "GIT_SEQUENCE_EDITOR", sequence_editor },
-	{ "GIT_PAGER", pager },
-	{ "GIT_DEFAULT_BRANCH", default_branch },
-	{ "GIT_SHELL_PATH", shell_path },
+	{ "GIT_COMMITTER_IDENT", git_committer_info, 0 },
+	{ "GIT_AUTHOR_IDENT",   git_author_info, 0 },
+	{ "GIT_EDITOR", editor, 0 },
+	{ "GIT_SEQUENCE_EDITOR", sequence_editor, 0 },
+	{ "GIT_PAGER", pager, 0 },
+	{ "GIT_DEFAULT_BRANCH", default_branch, 0 },
+	{ "GIT_SHELL_PATH", shell_path, 0 },
+	{ "GIT_ATTR_SYSTEM", git_attr_val_system, 1 },
+	{ "GIT_ATTR_GLOBAL", git_attr_val_global, 1 },
 	{ "", NULL },
 };
 
@@ -62,8 +86,11 @@ static void list_vars(void)
 	const char *val;
 
 	for (ptr = git_vars; ptr->read; ptr++)
-		if ((val = ptr->read(0)))
+		if ((val = ptr->read(0))) {
 			printf("%s=%s\n", ptr->name, val);
+			if (ptr->free)
+				free((void *)val);
+		}
 }
 
 static const struct git_var *get_git_var(const char *var)
@@ -110,6 +137,8 @@ int cmd_var(int argc, const char **argv, const char *prefix UNUSED)
 		return 1;
 
 	printf("%s\n", val);
+	if (git_var->free)
+		free((void *)val);
 
 	return 0;
 }
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 270bd4e512..6a2cc94abb 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -159,6 +159,26 @@ test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
 	grep "sh\$" shell
 '
 
+test_expect_success 'GIT_ATTR_SYSTEM points to the correct location' '
+	test_must_fail env GIT_ATTR_NOSYSTEM=1 git var GIT_ATTR_SYSTEM &&
+	(
+		sane_unset GIT_ATTR_NOSYSTEM &&
+		git var GIT_ATTR_SYSTEM >path &&
+		test "$(cat path)" != ""
+	)
+'
+
+test_expect_success 'GIT_ATTR_GLOBAL points to the correct location' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	XDG_CONFIG_HOME="$TRASHDIR/.config" git var GIT_ATTR_GLOBAL >path &&
+	test "$(cat path)" = "$TRASHDIR/.config/git/attributes" &&
+	(
+		sane_unset XDG_CONFIG_HOME &&
+		HOME="$TRASHDIR" git var GIT_ATTR_GLOBAL >path &&
+		test "$(cat path)" = "$TRASHDIR/.config/git/attributes"
+	)
+'
+
 # For git var -l, we check only a representative variable;
 # testing the whole output would make our test too brittle with
 # respect to unrelated changes in the test suite's environment.
