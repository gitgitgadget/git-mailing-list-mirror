Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AF0EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjF0QUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjF0QTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:19:31 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54503A92
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:19:26 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D95395B421;
        Tue, 27 Jun 2023 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687882752;
        bh=zVEtx15NzQHH6OnvqjJcMdT9jfhx9YoFI7ht1UrdpUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=v/x8xrKjnrGoUkB7+mV/BsaQ6PjNlweJWbWGN1/77qJ3Zl/1tCTt0VtutaJmcEzfG
         5jF2zxsf0jULSocUV9U9KLCr5SuaUTweTmfzJHAkbTwkfRxQEBM+7J0QflddfgTTBH
         i184JGaLnls+PrvSiZ9YFv1EbSf1bUJ4KKaE1S7EM8mmrGa2gznWunH8+xOXVQbCN/
         egDaXluO9j6elWfuD3THXfs/Plfzi2JyvYMvJtMVMIUJWhaveD9pHXmy7D2G8/O9A4
         CXY4sCEpkQlTf8FN3NbCrxLp+ptZXliSPv76AIV7wuKQtcumnY+NikzVuY9DmH+UGs
         zMAOYPiNuGE+9a+gVGeZ6FLNMWji6PI76ZkNE4F0QsWtd48WBrTN2K9aY5GrKlRJWV
         WwPfqHcABpvaCrveXt9IGB+wEkxztQUXCMpg8/COi0VRMLhl9t/D+Lligicp4Hlc2F
         03Pyeixl4aa+AEIMDjzpNUNGIduQxDvhRff9xpFSrdkJ7lyFvdf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 7/8] var: add attributes files locations
Date:   Tue, 27 Jun 2023 16:19:01 +0000
Message-ID: <20230627161902.754472-8-sandals@crustytoothpaste.net>
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
index d6f9f495c9..79f7bdf55f 100644
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
@@ -51,6 +52,26 @@ static char *shell_path(int ident_flag UNUSED)
 	return xstrdup(SHELL_PATH);
 }
 
+static char *git_attr_val_system(int ident_flag UNUSED)
+{
+	if (git_attr_system_is_enabled()) {
+		char *file = xstrdup(git_attr_system_file());
+		normalize_path_copy(file, file);
+		return file;
+	}
+	return NULL;
+}
+
+static char *git_attr_val_global(int ident_flag UNUSED)
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
