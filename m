Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4779C0015E
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 19:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjFZTBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 15:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFZTA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 15:00:57 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930C110CC
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 12:00:52 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 61D425B419;
        Mon, 26 Jun 2023 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687806051;
        bh=+XOLxzptZrn6kzkSGVkUsaHIv/gAwdykti5MvVK2Tww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0e9ezZKb25CSiW6mwfNUeK+KS6lHCOhQDY5JIgBueKnh+okx2vK9EQlRldV0RgQOu
         KURAvnzCt3o8ejx/UHGmx9MWlvbT1tPZPwhj/eOzi4D2FQL9pVZbttQRZk6JvRMPKe
         EasXL7wBiTyhmnA86t42S4vBoJJVX5K5Z0sR4UL/lMJEU/+7jnyM0/Z7smHSJtprpt
         O+iobIymGewdZKrhPv9uCqs0nJvZ5xO4JwqyIZKoStGg621W+BYmQ7AsGwUpynO0dm
         Yl8ELCSDPa5naJjbBi1aQMSAzvbVMc6wsS0f4ol9Dxh4v+wLKYdi+B+AsM0hHc55iD
         ECrA6ePt2EVHwLZ+rJkZwm6zmEQzbu0DSA8ostyiB7ycS2Gj/0Kj0OJtUUVcdkpcjX
         tlIBr4NGTXv50mBqttXv07UAqnv+6YHhbIJuaa4wBuYJ9iQIzEFDjCTZuYN1NgRwAK
         us3OE32EY1G3ifShsHYdjwsG6HLvZ+sn5WFU1UEdUSEJg3spx+V
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 2/7] var: add support for listing the shell
Date:   Mon, 26 Jun 2023 19:00:03 +0000
Message-ID: <20230626190008.644769-3-sandals@crustytoothpaste.net>
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

On most Unix systems, finding a suitable shell is easy: one simply uses
"sh" with an appropriate PATH value.  However, in many Windows
environments, the shell is shipped alongside Git, and it may or may not
be in PATH, even if Git is.

In such an environment, it can be very helpful to query Git for the
shell it's using, since other tools may want to use the same shell as
well.  To help them out, let's add a variable, GIT_SHELL_PATH, that
points to the location of the shell.

On Unix, we know our shell must be executable to be functional, so
assume that the distributor has correctly configured their environment,
and use that as a basic test.  On Git for Windows, we know that our
shell will be one of a few fixed values, all of which end in "sh" (such
as "bash").  This seems like it might be a nice test on Unix as well,
since it is customary for all shells to end in "sh", but there probably
exist such systems that don't have such a configuration, so be careful
here not to break them.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 Documentation/git-var.txt |  3 +++
 builtin/var.c             |  6 ++++++
 t/t0007-git-var.sh        | 15 +++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index f40202b8e3..f0f647e14a 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -71,6 +71,9 @@ endif::git-default-pager[]
 GIT_DEFAULT_BRANCH::
     The name of the first branch created in newly initialized repositories.
 
+GIT_SHELL_PATH::
+    The path of the binary providing the POSIX shell for commands which use the shell.
+
 SEE ALSO
 --------
 linkgit:git-commit-tree[1]
diff --git a/builtin/var.c b/builtin/var.c
index 2149998980..f97178eed1 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -36,6 +36,11 @@ static const char *default_branch(int flag)
 	return git_default_branch_name(1);
 }
 
+static const char *shell_path(int flag)
+{
+	return SHELL_PATH;
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -47,6 +52,7 @@ static struct git_var git_vars[] = {
 	{ "GIT_SEQUENCE_EDITOR", sequence_editor },
 	{ "GIT_PAGER", pager },
 	{ "GIT_DEFAULT_BRANCH", default_branch },
+	{ "GIT_SHELL_PATH", shell_path },
 	{ "", NULL },
 };
 
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index eeb8539c1b..e35f07afcb 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -147,6 +147,21 @@ test_expect_success 'get GIT_SEQUENCE_EDITOR with configuration and environment
 	)
 '
 
+test_expect_success POSIXPERM 'GIT_SHELL_PATH points to a valid executable' '
+	shellpath=$(git var GIT_SHELL_PATH) &&
+	test_path_is_executable "$shellpath"
+'
+
+# We know in this environment that our shell will be one of a few fixed values
+# that all end in "sh".
+test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
+	shellpath=$(git var GIT_SHELL_PATH) &&
+	case "$shellpath" in
+	*sh) ;;
+	*) return 1;;
+	esac
+'
+
 # For git var -l, we check only a representative variable;
 # testing the whole output would make our test too brittle with
 # respect to unrelated changes in the test suite's environment.
