Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0D5C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7248D2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="C6fpyAfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390668AbgEYUAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390580AbgEYUA1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 163EE60D0E;
        Mon, 25 May 2020 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436794;
        bh=KCNvkesVvwvNQy/hd5h5tkTw+MplM9cz3ZpWZNGYF3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=C6fpyAfYo8ypPvUBDGqQLlQKHZCOzhM8rSXJdR3IquXigmMScC0B8SGWAVkLRHvk+
         0dEyGMREsMkFA5WVS0OCzzOdbgvK9q+QwVr5ssxfKAYaDYsKCAHuViW4HpgFjUuHiW
         jwIZkR4NdBbF+pdpY32tbwBTGrOHtVpodVgk+DntSApoO3fSbczIHd/FuF7BjpxlFQ
         ZSIhP8xfy0DUAOV7mYsZqSX7jlGQ5cswEhDO9BNKNzkFekPfVeHFfhDJz+IgFGO6/O
         25GmXAHAHerHGx2eGi6hFnVVz3zO8lG2t3FVN71ZsHBatDEymN9ZPFlNAogDLZHBEf
         Ic6mWnSVtdHIYZ4h7uJ14w4OZarVdsBRiPY2RCyS7ug9uXzQz8KJ/SrkObd5ixwLDO
         xubx/GNAL21Ato/f9cIvw5r0i3nPAadjqz7axkLhrRKsC3z9v7EEc+4Vx7iF4GjyRZ
         zydi7b3iQOGvpkyAdUsADM+2TVb6uOkVWbmGqSDCM9YPPJ3rZ/b
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 26/44] builtin/show-index: provide options to determine hash algo
Date:   Mon, 25 May 2020 19:59:12 +0000
Message-Id: <20200525195930.309665-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

show-index is capable of reading any possible index file whether or not
the index is inside a repository.  However, because our index files lack
metadata about the hash algorithm in use, it's not possible to
autodetect the algorithm that a particular index file is using.

In order to allow us to read index files of any algorithm, let's set up
the .git directory gently so that we default to the algorithm for the
current repository, and add an --object-format option to allow users to
override this setting and continue to run show-index outside of a
repository altogether.  Let's also document this new option so that
people can find it and use it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-show-index.txt | 11 ++++++++++-
 builtin/show-index.c             | 29 ++++++++++++++++++++++++-----
 git.c                            |  2 +-
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index 424e4ba84c..39b1d8eaa1 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -9,7 +9,7 @@ git-show-index - Show packed archive index
 SYNOPSIS
 --------
 [verse]
-'git show-index'
+'git show-index' [--object-format=<hash-algorithm>]
 
 
 DESCRIPTION
@@ -36,6 +36,15 @@ Note that you can get more information on a packfile by calling
 linkgit:git-verify-pack[1]. However, as this command considers only the
 index file itself, it's both faster and more flexible.
 
+OPTIONS
+-------
+
+--object-format=<hash-algorithm>::
+	Specify the given object format (hash algorithm) for the index file.  The
+	valid values are 'sha1' and (if enabled) 'sha256'.  The default is the
+	algorithm for the current repository (set by `extensions.objectFormat`), or
+	'sha1' if no value is set or outside a repository..
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 0826f6a5a2..8106b03a6b 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -1,9 +1,12 @@
 #include "builtin.h"
 #include "cache.h"
 #include "pack.h"
+#include "parse-options.h"
 
-static const char show_index_usage[] =
-"git show-index";
+static const char *const show_index_usage[] = {
+	"git show-index [--object-format=<hash-algorithm>]",
+	NULL
+};
 
 int cmd_show_index(int argc, const char **argv, const char *prefix)
 {
@@ -11,10 +14,26 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 	unsigned nr;
 	unsigned int version;
 	static unsigned int top_index[256];
-	const unsigned hashsz = the_hash_algo->rawsz;
+	unsigned hashsz;
+	const char *hash_name = NULL;
+	int hash_algo;
+	const struct option show_index_options[] = {
+		OPT_STRING(0, "object-format", &hash_name, N_("hash-algorithm"),
+			   N_("specify the hash algorithm to use")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, show_index_options, show_index_usage, 0);
+
+	if (hash_name) {
+		hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo == GIT_HASH_UNKNOWN)
+			die(_("Unknown hash algorithm"));
+		repo_set_hash_algo(the_repository, hash_algo);
+	}
+
+	hashsz = the_hash_algo->rawsz;
 
-	if (argc != 1)
-		usage(show_index_usage);
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
 		die("unable to read header");
 	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
diff --git a/git.c b/git.c
index a2d337eed7..2f021b97f3 100644
--- a/git.c
+++ b/git.c
@@ -574,7 +574,7 @@ static struct cmd_struct commands[] = {
 	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 	{ "show", cmd_show, RUN_SETUP },
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
-	{ "show-index", cmd_show_index },
+	{ "show-index", cmd_show_index, RUN_SETUP_GENTLY },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "sparse-checkout", cmd_sparse_checkout, RUN_SETUP | NEED_WORK_TREE },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
