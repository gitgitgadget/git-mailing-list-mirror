Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8D31F461
	for <e@80x24.org>; Mon, 13 May 2019 18:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfEMSPV (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 14:15:21 -0400
Received: from outmail148095.authsmtp.com ([62.13.148.95]:29787 "EHLO
        outmail148095.authsmtp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbfEMSPU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 14:15:20 -0400
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 May 2019 14:15:19 EDT
Received: from punt24.authsmtp.com (punt24.authsmtp.com [62.13.128.105])
        by punt16.authsmtp.com. (8.15.2/8.15.2) with ESMTP id x4DHx8ws000429
        for <git@vger.kernel.org>; Mon, 13 May 2019 18:59:08 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
Received: from mail-c233.authsmtp.com (mail-c233.authsmtp.com [62.13.128.233])
        by punt24.authsmtp.com. (8.15.2/8.15.2) with ESMTP id x4DHx8Cu039951;
        Mon, 13 May 2019 18:59:08 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
Received: from rool-work.lan ([37.152.216.162])
        (authenticated bits=128)
        by mail.authsmtp.com (8.15.2/8.15.2) with ESMTPSA id x4DHx7ar017625
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 13 May 2019 18:59:07 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
Received: from rool-work.lan (localhost [127.0.0.1])
        by rool-work.lan (8.15.2/8.15.2/Debian-3) with ESMTP id x4DHx6AI126125;
        Mon, 13 May 2019 18:59:06 +0100
Received: (from bavison@localhost)
        by rool-work.lan (8.15.2/8.15.2/Submit) id x4DHx6c5126124;
        Mon, 13 May 2019 18:59:06 +0100
X-Authentication-Warning: rool-work.lan: bavison set sender to bavison@riscosopen.org using -f
From:   Ben Avison <bavison@riscosopen.org>
To:     git@vger.kernel.org
Cc:     Ben Avison <bavison@riscosopen.org>
Subject: [PATCH] clone: add `--remote-submodules` flag
Date:   Mon, 13 May 2019 18:59:03 +0100
Message-Id: <20190513175903.126079-1-bavison@riscosopen.org>
X-Mailer: git-send-email 2.21.0.896.g6a6c0f10a7.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Server-Quench: cda5717b-75a8-11e9-a01e-84349711df28
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd1YggXA1ZfRRob ESQCJDVBUg4iPRpU DBlFKhFVNl8UURhQ KkJXbgASJgRHAnRQ SnkJW1VdQFx5U2Z8 YQpWIwZafEtLXRto UU5XQ1RQCwdtHh1P ThpqKlF1JkdGeXl2 Z0MsX3FbW0A0JhIs R0lVEj8bYmIxYH0e URVRalJUcVZXdhtG bll4VXJZN2cPKBEA NjMYHwV5NjFYLikH CggBIRoaBAMREzs7 Wx1HBiglGEoJWiE+ NBRuJFoVEy4u
X-Authentic-SMTP: 61633632303230.1021:706
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using `git clone --recurse-submodules` there was previously no way to
pass a `--remote` switch to the implicit `git submodule update` command for
any use case where you want the submodules to be checked out on their
remote-tracking branch rather than with the SHA-1 recorded in the superproject.

This patch rectifies this situation. It actually passes `--no-fetch` to
`git submodule update` as well on the grounds they the submodule has only just
been cloned, so fetching from the remote again only serves to slow things down.

Signed-off-by: Ben Avison <bavison@riscosopen.org>
---
 Documentation/git-clone.txt        |  9 ++++-
 builtin/clone.c                    |  8 +++++
 t/t5617-clone-submodules-remote.sh | 54 ++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100755 t/t5617-clone-submodules-remote.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index a0f14b51f2..5fc97f14de 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
-	  [--jobs <n>] [--] <repository> [<directory>]
+	  [--[no-]remote-submodules] [--jobs <n>] [--] <repository>
+	  [<directory>]
 
 DESCRIPTION
 -----------
@@ -260,6 +261,12 @@ or `--mirror` is given)
 --[no-]shallow-submodules::
 	All submodules which are cloned will be shallow with a depth of 1.
 
+--[no-]remote-submodules::
+	All submodules which are cloned will use the status of the submodule’s
+	remote-tracking branch to update the submodule, rather than the
+	superproject’s recorded SHA-1. Equivalent to passing `--remote` to
+	`git submodule update`.
+
 --separate-git-dir=<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
diff --git a/builtin/clone.c b/builtin/clone.c
index 31a47d190a..9e5752ee41 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -67,6 +67,7 @@ static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
 static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
+static int option_remote_submodules;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -145,6 +146,8 @@ static struct option builtin_clone_options[] = {
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
+		    N_("any cloned submodules will use their remote-tracking branch")),
 	OPT_END()
 };
 
@@ -792,6 +795,11 @@ static int checkout(int submodule_progress)
 		if (option_verbosity < 0)
 			argv_array_push(&args, "--quiet");
 
+		if (option_remote_submodules == 1) {
+			argv_array_push(&args, "--remote");
+			argv_array_push(&args, "--no-fetch");
+		}
+
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
new file mode 100755
index 0000000000..3ba9a55341
--- /dev/null
+++ b/t/t5617-clone-submodules-remote.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='Test cloning repos with submodules using remote-tracking branches'
+
+. ./test-lib.sh
+
+pwd=$(pwd)
+
+test_expect_success 'setup' '
+	git checkout -b master &&
+	test_commit commit1 &&
+	mkdir sub &&
+	(
+		cd sub &&
+		git init &&
+		test_commit subcommit1 &&
+		git tag sub_when_added_to_super
+	) &&
+	git submodule add "file://$pwd/sub" sub &&
+	git commit -m "add submodule" &&
+	(
+		cd sub &&
+		test_commit subcommit2
+	)
+'
+
+test_expect_success 'clone with --no-remote-submodules' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --no-remote-submodules "file://$pwd/." super_clone &&
+	(
+		cd super_clone/sub &&
+		git diff --exit-code sub_when_added_to_super
+	)
+'
+
+test_expect_success 'clone with --remote-submodules' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --remote-submodules "file://$pwd/." super_clone &&
+	(
+		cd super_clone/sub &&
+		git diff --exit-code remotes/origin/master
+	)
+'
+
+test_expect_success 'check the default is --no-remote-submodules' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --no-remote-submodules "file://$pwd/." super_clone &&
+	(
+		cd super_clone/sub &&
+		git diff --exit-code sub_when_added_to_super
+	)
+'
+
+test_done
-- 
2.21.0.896.g6a6c0f10a7.dirty

