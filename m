Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4BCC2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3EE720753
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g//Vdc4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbgEMAzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38112 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgEMAyv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 57C5360CFF;
        Wed, 13 May 2020 00:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331289;
        bh=FIDfPhqmGD6F3kAFqrdeqRinJc9gYjcu7fAYule9rDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=g//Vdc4SFCIM/FT7JuB4UDxM3d32YbCB4LhAFBO+7IHmnxmXudNB5NHdhMM7CT8Q3
         Nr/yvHG/p34CEv9lVdSlzZjZ4aqe5W3yAVkdMcXmxS3ruerrstEEnZ5VmmHP8i4qdZ
         UpDO/l1rM/G09NDbTmrBQzkKoOYLyglU4eLUwTNEU5QyhlXTpJfhuKGXHScE43jBQ6
         JU0r0iQQ0K6YFYe5rQPl/dE+P5IQlDgqV2UZBgSXe6E62L1ltCpmFKpUmqd8b2q05Y
         MRSgvz1Pm1828WMvfnzd5b4PvcFoEkTPxlZMa0JcToS9tOKni42jeAnkWt2Mr5Ww1w
         1sGuF7dNro5KiA+DNtMo0J99gu8eOpyVkPl/2RY4zPaXF2Gv9BynEjVdFl2BcRaXoO
         T7Ne5uT2qXQisz9Ol/biYef5xVKb87wDU+RRHb3wYCkY51/OLfTxhDMMic/N5BRdPb
         nyMYulxLNhg3IteFwtyLi51PgnjFh471UjdLLlizholtqCyKfYx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 27/44] builtin/show-index: provide options to determine hash algo
Date:   Wed, 13 May 2020 00:54:07 +0000
Message-Id: <20200513005424.81369-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible to use a variety of index formats with show-index, and we
need a way to indicate the hash algorithm which is in use for a
particular index we'd like to show.  Default to using the value for the
repository we're in by calling setup_git_directory_gently, and allow
overriding it by using a --hash argument.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-index.c | 29 ++++++++++++++++++++++++-----
 git.c                |  2 +-
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 0826f6a5a2..ebfa2e9abd 100644
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
+	"git show-index [--hash=HASH]",
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
+		OPT_STRING(0, "hash", &hash_name, N_("hash"),
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
index 2e4efb4ff0..e53e8159a2 100644
--- a/git.c
+++ b/git.c
@@ -573,7 +573,7 @@ static struct cmd_struct commands[] = {
 	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 	{ "show", cmd_show, RUN_SETUP },
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
-	{ "show-index", cmd_show_index },
+	{ "show-index", cmd_show_index, RUN_SETUP_GENTLY },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "sparse-checkout", cmd_sparse_checkout, RUN_SETUP | NEED_WORK_TREE },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
