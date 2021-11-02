Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16844C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC37960EE9
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhKBQsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:48:10 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:53219 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235069AbhKBQr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 12:47:28 -0400
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1635871488; bh=4SuGzUW9RHIQ6gbAD4vI0JsW/rqx5kfxFdtepat4n+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMUCWKczdWWVXDwuXrTmvqz/viR4fawu6J08YxVDz34U5EPzXL8P409PF9cbS8h9P
         00NePlGZfAKy7B7g+Melrrcez7jkZvM04//KBziREZRJSFqnqS08Ogr77R+aM1RrE1
         SIK71QJq0rEArFfDou/z/+dKbQavJ/ZPWt/01WPg=
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] var: add GIT_DEFAULT_BRANCH variable
Date:   Tue,  2 Nov 2021 17:44:34 +0100
Message-Id: <20211102164434.1005707-1-thomas@t-8ch.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the builtin variable GIT_DEFAULT_BRANCH which represents the
the default branch name that will be used by git-init.

Currently this variable is equivalent to
    git config init.defaultbranch || 'master'

This however will break if at one point the default branch is changed as
indicated by `default_branch_name_advice` in `refs.c`.

By providing this command ahead of time users of git can make their
code forward-compatible.

Co-developed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---

Changes from v1 ( https://lore.kernel.org/git/20211030140112.834650-1-thomas@t-8ch.de/ ):
* Replaced the custom subcommand with an internal variable
* Cleaned up the tests

@Johannes: I replaced BUG() with die() from your example because that seems to be
nicer for user facing messages.

 Documentation/git-var.txt |  3 +++
 builtin/var.c             | 13 +++++++++++++
 t/t0007-git-var.sh        | 19 +++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 6072f936ab..387cc1b914 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -59,6 +59,9 @@ ifdef::git-default-pager[]
     The build you are using chose '{git-default-pager}' as the default.
 endif::git-default-pager[]
 
+GIT_DEFAULT_BRANCH::
+    The name of the first branch created in newly initialized repositories.
+
 SEE ALSO
 --------
 linkgit:git-commit-tree[1]
diff --git a/builtin/var.c b/builtin/var.c
index 6c6f46b4ae..d1d82b6c93 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -5,6 +5,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "refs.h"
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
@@ -27,6 +28,17 @@ static const char *pager(int flag)
 	return pgm;
 }
 
+static const char *default_branch(int flag)
+{
+	const char *name = repo_default_branch_name(the_repository, 1);
+
+	if (!name)
+		die("could not determine the default branch name");
+
+	return name;
+}
+
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -36,6 +48,7 @@ static struct git_var git_vars[] = {
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
 	{ "GIT_EDITOR", editor },
 	{ "GIT_PAGER", pager },
+	{ "GIT_DEFAULT_BRANCH", default_branch },
 	{ "", NULL },
 };
 
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 53af92d571..6b6852e35e 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -27,6 +27,25 @@ test_expect_success !FAIL_PREREQS,!AUTOIDENT 'requested identities are strict' '
 	)
 '
 
+test_expect_success 'get GIT_DEFAULT_BRANCH without configuration' '
+	(
+		sane_unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
+		echo master >expect &&
+		git var GIT_DEFAULT_BRANCH >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_DEFAULT_BRANCH with configuration' '
+	test_config init.defaultbranch foo &&
+	(
+		sane_unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
+		echo foo >expect &&
+		git var GIT_DEFAULT_BRANCH >actual &&
+		test_cmp expect actual
+	)
+'
+
 # For git var -l, we check only a representative variable;
 # testing the whole output would make our test too brittle with
 # respect to unrelated changes in the test suite's environment.

base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49
-- 
2.33.1

