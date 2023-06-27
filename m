Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90102EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjF0QUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjF0QTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:19:31 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53223A91
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:19:26 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E9D335B422;
        Tue, 27 Jun 2023 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687882752;
        bh=QhDSYmbpxGfNX7prl/mR5WibJ1Ihc5pBj8noNTgtZYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FzkA7znwn7O4zqdqKwckS0EH/5CjKUI1qafHBQPfeoKr7661NI0CWuX1mOBJT5QrL
         WXMzvIt2kP52POEm0GyDvsB9knbil/cmV/dzCbc4VBd482ceqKuALVYS/30znV7LaH
         h2YYL+n/7OKgnFQXl1T8DVkXKfZs7vTHD6fe9XaRyX3kzbrX3w+WKl/5Fznsu8slgr
         6ufbpodAae5zmKu8B5Qc9eg4Dq/+LWKgWYtedX7HwkJVJp0Xx5jeQKkz5/iqWIUMRh
         DQEcfKIu+/d2CnCcwcmihGZ4FOpFUdku8tSHHOYvbofgpyqJSM8WrbVgtN+B5fPlID
         UPNUPSUUe8cyoClSThTtafPwPtC/2O1pqOPJ4CDe8wY3b0maNxfUbJSWu+3o4ZyvrR
         wPj5aOmkUM/uDONWiCNe6Gr1g88XarG2XYIYuFl4Ls86fxqRNqBTW+K0f1aFbwmTCp
         OlJlHCeoj8Js+Q8AuvSVc5CNcNR4LhUIWeaBQpQsgKM++GzEyWv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 8/8] var: add config file locations
Date:   Tue, 27 Jun 2023 16:19:02 +0000
Message-ID: <20230627161902.754472-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230627161902.754472-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230627161902.754472-1-sandals@crustytoothpaste.net>
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
 Documentation/git-var.txt | 14 +++++++++
 builtin/var.c             | 57 +++++++++++++++++++++++++++++++++-
 t/t0007-git-var.sh        | 65 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)

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
index 79f7bdf55f..ef45710a20 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -72,9 +72,45 @@ static char *git_attr_val_global(int ident_flag UNUSED)
 	return NULL;
 }
 
+static char *git_config_val_system(int ident_flag UNUSED)
+{
+	if (git_config_system()) {
+		char *file = git_system_config();
+		normalize_path_copy(file, file);
+		return file;
+	}
+	return NULL;
+}
+
+static char *git_config_val_global(int ident_flag UNUSED)
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
 	char *(*read)(int);
+	int multivalued;
 };
 static struct git_var git_vars[] = {
 	{
@@ -113,6 +149,15 @@ static struct git_var git_vars[] = {
 		.name = "GIT_ATTR_GLOBAL",
 		.read = git_attr_val_global,
 	},
+	{
+		.name = "GIT_CONFIG_SYSTEM",
+		.read = git_config_val_system,
+	},
+	{
+		.name = "GIT_CONFIG_GLOBAL",
+		.read = git_config_val_global,
+		.multivalued = 1,
+	},
 	{
 		.name = "",
 		.read = NULL,
@@ -126,7 +171,17 @@ static void list_vars(void)
 
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
 			free(val);
 		}
 }
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 374d9f49e9..8cb597f99c 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -182,6 +182,49 @@ test_expect_success 'GIT_ATTR_GLOBAL points to the correct location' '
 	)
 '
 
+test_expect_success 'GIT_CONFIG_SYSTEM points to the correct location' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	test_must_fail env GIT_CONFIG_NOSYSTEM=1 git var GIT_CONFIG_SYSTEM &&
+	(
+		sane_unset GIT_CONFIG_NOSYSTEM &&
+		systempath=$(git var GIT_CONFIG_SYSTEM) &&
+		test "$systempath" != "" &&
+		systempath=$(GIT_CONFIG_SYSTEM=/dev/null git var GIT_CONFIG_SYSTEM) &&
+		if test_have_prereq MINGW
+		then
+			test "$systempath" = "nul"
+		else
+			test "$systempath" = "/dev/null"
+		fi &&
+		systempath=$(GIT_CONFIG_SYSTEM="$TRASHDIR/gitconfig" git var GIT_CONFIG_SYSTEM) &&
+		test "$systempath" = "$TRASHDIR/gitconfig"
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
+		globalpath=$(GIT_CONFIG_GLOBAL=/dev/null git var GIT_CONFIG_GLOBAL) &&
+		if test_have_prereq MINGW
+		then
+			test "$globalpath" = "nul"
+		else
+			test "$globalpath" = "/dev/null"
+		fi &&
+		globalpath=$(GIT_CONFIG_GLOBAL="$TRASHDIR/gitconfig" git var GIT_CONFIG_GLOBAL) &&
+		test "$globalpath" = "$TRASHDIR/gitconfig"
+	)
+'
+
 # For git var -l, we check only a representative variable;
 # testing the whole output would make our test too brittle with
 # respect to unrelated changes in the test suite's environment.
@@ -199,6 +242,28 @@ test_expect_success 'git var -l lists config' '
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
+		sed -n -e "/^GIT_EDITOR/,\$p" var | head -n 3 >actual &&
+		test_cmp expected actual
+	)
+'
+
 test_expect_success 'listing and asking for variables are exclusive' '
 	test_must_fail git var -l GIT_COMMITTER_IDENT
 '
