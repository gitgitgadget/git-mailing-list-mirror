Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738C6C433F4
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5271E2080D
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tKfHKF8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbgGWBKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40488 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387600AbgGWBKD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:03 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BD8FC61012
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466602;
        bh=rRMHiNx1BObyJZy0Sl4dkfBzRMv2sX2yJcxoAHcDbZ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=tKfHKF8rfmRtw00mpjrBel0UqWl2rwp3B6iDZttPk0n9Ux5bTv60l3HX4mhHqRZbl
         R4khkk+SMWVafVdCnkj7oM2ndMz6R/pJOdzMLHY1ufAdATFrqSxqbLJuK7GUzZAFqW
         WSnTePjYw1lWHrY634K0L5U6etVv8kzx53Oimbg5sSc6aqvlmgMH8PDn+Ldcu0orS/
         pv2c/1T3AxP5x0+beAE9GwCh3gnOyI3rLN6JVFEvoD6TYuKMbDLS3apXJg6JtdjAlP
         yYFd6a5LTvu1/BSAbOxZrOOQqvw7ypTdKgJoRvV5MGXSypYUGI1+A5anTSrGP/UcLP
         Mt0FTUNtQoVweFWD7PhanziknqCsn9DLR2+4PPMwb+2dCPaCMMc/X5HXHj9lHAnY4k
         o2J8sQihS7dbLxp+v9eKoaCbjF9RA5426NK9oUidiq1QTsnIioX/dSJuNRwwCJpGg/
         54gQA254UardmG/Bc0YfJyn2/SAA056ujkd2Yunj50GMgAH6l2i
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 30/39] builtin/verify-pack: implement an --object-format option
Date:   Thu, 23 Jul 2020 01:09:34 +0000
Message-Id: <20200723010943.2329634-31-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recently added test in t5702 started using git verify-pack outside of
a repository.  While this poses no problems with SHA-1, with SHA-256 we
implicitly rely on the setup of the repository to initialize our hash
algorithm settings.

Since we're not in a repository here, we need to provide git verify-pack
help to set things up properly.  git index-pack already knows an
--object-format option, so let's accept one as well and pass it down to
our git index-pack invocation.  Since this argument is optional, let's
dynamically determine the proper location to insert it into the array.
Finally, let's make t5702 pass the proper argument on down to its git
verify-pack caller.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/verify-pack.c  | 25 +++++++++++++++++--------
 t/t5702-protocol-v2.sh |  2 +-
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index c2a1a5c504..c4090102a9 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -7,21 +7,27 @@
 #define VERIFY_PACK_VERBOSE 01
 #define VERIFY_PACK_STAT_ONLY 02
 
-static int verify_one_pack(const char *path, unsigned int flags)
+static int verify_one_pack(const char *path, unsigned int flags, const char *hash_algo)
 {
 	struct child_process index_pack = CHILD_PROCESS_INIT;
-	const char *argv[] = {"index-pack", NULL, NULL, NULL };
-	struct strbuf arg = STRBUF_INIT;
+	const char *argv[] = {"index-pack", NULL, NULL, NULL, NULL };
+	struct strbuf arg = STRBUF_INIT, hash_arg = STRBUF_INIT;
 	int verbose = flags & VERIFY_PACK_VERBOSE;
 	int stat_only = flags & VERIFY_PACK_STAT_ONLY;
 	int err;
+	int argno = 1;
 
 	if (stat_only)
-		argv[1] = "--verify-stat-only";
+		argv[argno++] = "--verify-stat-only";
 	else if (verbose)
-		argv[1] = "--verify-stat";
+		argv[argno++] = "--verify-stat";
 	else
-		argv[1] = "--verify";
+		argv[argno++] = "--verify";
+
+	if (hash_algo) {
+		strbuf_addf(&hash_arg, "--object-format=%s", hash_algo);
+		argv[argno++] = hash_arg.buf;
+	}
 
 	/*
 	 * In addition to "foo.pack" we accept "foo.idx" and "foo";
@@ -31,7 +37,7 @@ static int verify_one_pack(const char *path, unsigned int flags)
 	if (strbuf_strip_suffix(&arg, ".idx") ||
 	    !ends_with(arg.buf, ".pack"))
 		strbuf_addstr(&arg, ".pack");
-	argv[2] = arg.buf;
+	argv[argno++] = arg.buf;
 
 	index_pack.argv = argv;
 	index_pack.git_cmd = 1;
@@ -60,12 +66,15 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 {
 	int err = 0;
 	unsigned int flags = 0;
+	const char *object_format = NULL;
 	int i;
 	const struct option verify_pack_options[] = {
 		OPT_BIT('v', "verbose", &flags, N_("verbose"),
 			VERIFY_PACK_VERBOSE),
 		OPT_BIT('s', "stat-only", &flags, N_("show statistics only"),
 			VERIFY_PACK_STAT_ONLY),
+		OPT_STRING(0, "object-format", &object_format, N_("hash"),
+			   N_("specify the hash algorithm to use")),
 		OPT_END()
 	};
 
@@ -75,7 +84,7 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 	if (argc < 1)
 		usage_with_options(verify_pack_usage, verify_pack_options);
 	for (i = 0; i < argc; i++) {
-		if (verify_one_pack(argv[i], flags))
+		if (verify_one_pack(argv[i], flags, object_format))
 			err = 1;
 	}
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 1b54c35b01..7fc22171e7 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -829,7 +829,7 @@ test_expect_success 'part of packfile response provided as URI' '
 	# Ensure that my-blob and other-blob are in separate packfiles.
 	for idx in http_child/.git/objects/pack/*.idx
 	do
-		git verify-pack --verbose $idx >out &&
+		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
 		{
 			grep "^[0-9a-f]\{16,\} " out || :
 		} >out.objectlist &&
