Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5094EB64D9
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 19:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFZTBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 15:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjFZTBC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 15:01:02 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB6A10FD
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 12:00:56 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9B5F95B41E;
        Mon, 26 Jun 2023 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687806051;
        bh=/6BQBmcTjpBjFlHB1wD7rRpRv2H2jGxwZ4m5Alck5zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mJ0C+OHgxHvy6MYJbqNgUcCfaEU587ljy4SLdggstA/AXbkhJ/5CwXuSE3htVNtLU
         UF/0oBLS2aNy1Q9f7k3Z4re+SBq7XA2r7qdfaf8Co3qBHiZHAC8agSWHyPAO2lqafb
         fSMCGz4BcXDy0NWQ29YgMPad1LuD28tgcrW57PN+tsyQkkouXfmoxmZcKfK8njaIMQ
         P+aYprl13RhaILzzkqImkV097Xq+sqIxmQKDGGVTA0PzCqDFxZREReEOc20KGqtA0C
         X6AhE2J0Zy1eQQ8+d55ENVj899+roqDhZJBGxEtnPukepgVjyx8z6r4Z4JYqwF1abL
         R89gLU+9bQs/eUXqiFOE4sL+7tNNlA0tRR5KqNrOhZpBrLQuTYxxym1eFzitX8oIC/
         PngjYiwJcPiONWSx5o19FTAijKtRpBreXqfy+SjmQRlxMrPWxqsBFB6oxfb7slJevy
         CYZzQbhqH300WaWWOzM3JUw+GJgiDO/pbkH6D9N4mHX+h+GDnbj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 6/7] var: add attributes files locations
Date:   Mon, 26 Jun 2023 19:00:07 +0000
Message-ID: <20230626190008.644769-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230626190008.644769-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230626190008.644769-1-sandals@crustytoothpaste.net>
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
 builtin/var.c             | 29 +++++++++++++++++++++++++++++
 t/t0007-git-var.sh        | 20 ++++++++++++++++++++
 3 files changed, 55 insertions(+)

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
diff --git a/builtin/var.c b/builtin/var.c
index ce6a2231ca..7cec05a49a 100644
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
@@ -51,6 +52,26 @@ static char *shell_path(int flag)
 	return xstrdup(SHELL_PATH);
 }
 
+static char *git_attr_val_system(int flag)
+{
+	if (git_attr_system_is_enabled()) {
+		char *file = xstrdup(git_attr_system_file());
+		normalize_path_copy(file, file);
+		return file;
+	}
+	return NULL;
+}
+
+static char *git_attr_val_global(int flag)
+{
+	char *file = xstrdup(git_attr_global_file());
+	if (file) {
+		normalize_path_copy(file, file);
+		return file;
+	}
+	return NULL;
+}
+
 struct git_var {
 	const char *name;
 	char *(*read)(int);
@@ -84,6 +105,14 @@ static struct git_var git_vars[] = {
 		.name = "GIT_SHELL_PATH",
 		.read = shell_path,
 	},
+	{
+		.name = "GIT_ATTR_SYSTEM",
+		.read = git_attr_val_system,
+	},
+	{
+		.name = "GIT_ATTR_GLOBAL",
+		.read = git_attr_val_global,
+	},
 	{
 		.name = "",
 		.read = NULL,
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index e35f07afcb..374d9f49e9 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -162,6 +162,26 @@ test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
 	esac
 '
 
+test_expect_success 'GIT_ATTR_SYSTEM produces expected output' '
+	test_must_fail env GIT_ATTR_NOSYSTEM=1 git var GIT_ATTR_SYSTEM &&
+	(
+		sane_unset GIT_ATTR_NOSYSTEM &&
+		systempath=$(git var GIT_ATTR_SYSTEM) &&
+		test "$systempath" != ""
+	)
+'
+
+test_expect_success 'GIT_ATTR_GLOBAL points to the correct location' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	globalpath=$(XDG_CONFIG_HOME="$TRASHDIR/.config" git var GIT_ATTR_GLOBAL) &&
+	test "$globalpath" = "$TRASHDIR/.config/git/attributes" &&
+	(
+		sane_unset XDG_CONFIG_HOME &&
+		globalpath=$(HOME="$TRASHDIR" git var GIT_ATTR_GLOBAL) &&
+		test "$globalpath" = "$TRASHDIR/.config/git/attributes"
+	)
+'
+
 # For git var -l, we check only a representative variable;
 # testing the whole output would make our test too brittle with
 # respect to unrelated changes in the test suite's environment.
