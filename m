Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B71FC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 20:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B84D60EE9
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 20:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhKCUTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 16:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCUTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 16:19:45 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C358C061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 13:17:08 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1635970626; bh=d1bBF49GELn8Vc4xDd4aPTMwkYLteXjRGTTXETrojus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUTJjlKIH7y5F5JvAqDAm+3hK7W6P5Z3DhFda3hiA3KvkzCNRzz4cPIRtaQu9MetL
         xYkn2N1krkvVC1JvLzOPZZ+d4+GQeKtCpDGiXQYwJ7ajzO2UJVAYOEa+1GNcsB9I6A
         35EWbJEhJlNJ4pS+3liOM4AVh64oj6sliP1l77J0=
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4] var: add GIT_DEFAULT_BRANCH variable
Date:   Wed,  3 Nov 2021 21:17:02 +0100
Message-Id: <20211103201702.117771-1-thomas@t-8ch.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <CAPig+cR0PL-XtfC8v4-u1Taq6yOLO=2HSHsNBnzvzLCyM-whZA@mail.gmail.com>
References: <CAPig+cR0PL-XtfC8v4-u1Taq6yOLO=2HSHsNBnzvzLCyM-whZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the logical variable GIT_DEFAULT_BRANCH which represents the
the default branch name that will be used by "git init".

Currently this variable is equivalent to
    git config init.defaultbranch || 'master'

This however will break if at one point the default branch is changed as
indicated by `default_branch_name_advice` in `refs.c`.

By providing this command ahead of time users of git can make their
code forward-compatible.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---

Changes from v1 ( https://lore.kernel.org/git/20211030140112.834650-1-thomas@t-8ch.de/ ):
* Replaced the custom subcommand with an internal variable
* Cleaned up the tests

Changes from v2 ( https://lore.kernel.org/git/20211102164434.1005707-1-thomas@t-8ch.de/ ):
* Removed superfluous error handling
* Switched to better fitting function
* Reworded commit message to be more consistent with the rest of git

Changes from v3 ( https://lore.kernel.org/git/20211103185331.599463-1-thomas@t-8ch.de/ ):
* Future-proof test by testing against the actual name of a new repository

 Documentation/git-var.txt |  3 +++
 builtin/var.c             |  7 +++++++
 t/t0007-git-var.sh        | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+)

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
index 6c6f46b4ae..491db27429 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -5,6 +5,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "refs.h"
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
@@ -27,6 +28,11 @@ static const char *pager(int flag)
 	return pgm;
 }
 
+static const char *default_branch(int flag)
+{
+	return git_default_branch_name(1);
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -36,6 +42,7 @@ static struct git_var git_vars[] = {
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
 	{ "GIT_EDITOR", editor },
 	{ "GIT_PAGER", pager },
+	{ "GIT_DEFAULT_BRANCH", default_branch },
 	{ "", NULL },
 };
 
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 53af92d571..e56f4b9ac5 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -27,6 +27,26 @@ test_expect_success !FAIL_PREREQS,!AUTOIDENT 'requested identities are strict' '
 	)
 '
 
+test_expect_success 'get GIT_DEFAULT_BRANCH without configuration' '
+	(
+		sane_unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
+		git init defbranch &&
+		git -C defbranch symbolic-ref --short HEAD >expect &&
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

