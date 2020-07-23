Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13942C433FE
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD68820684
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="n2a68FRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbgGWBKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387577AbgGWBKD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:03 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 636E461016
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466602;
        bh=/X+wx4cEA1CTt7F4mr6dLCr9FnNmF24HxacG5rvkHf4=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=n2a68FRWvlXMnfL0S4npuDsHt5FP5Ceg5rUEnnopyuyPpZw5W6aSsXfn70+U0G5e4
         bdLQJTPx3h4B8EFkmQe/sOQHIX5XzcdHEA+su0eQurDBtqKUjP20stwKuDOUrTj+2d
         0j5eNqCMzMMM5UQ3hXTJMgNQmRmTm1qIi0Tw4vbJdVrbdSmzCPXguB4ESZqUDjM/bO
         lpquNcnUQx/l0evgIG7WQAOuWFdCyC4po0mO3zcTkAObEA78QpYMJiAGjkW5EZn21v
         /KFub5QZ4AqgjqrupoCFUYH+B8ct3I+ViJPDUIbx/mvVuWQCjfgD+evHPWHoBlfvos
         NVjHlglvljR7ca0KYNutazrBgNE4/cwxQHDKmd2eWQ4lEUoHldcZCb0Z2LKhUiz308
         NPc+9ca1GudQsxBrPBEdDKREFbDWLUsFm72GdMwkvr0gprwI60qm3IUT1EyiEfaGkQ
         3EYrjoyzqCSEhsBIY71l1Be4Indve0ve2HAuBwcFbzfzF34Z26n
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 29/39] http-fetch: set up git directory before parsing pack hashes
Date:   Thu, 23 Jul 2020 01:09:33 +0000
Message-Id: <20200723010943.2329634-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In dd4b732df7 ("upload-pack: send part of packfile response as uri",
2020-06-10), the git http-fetch code learned how to take  ac --packfile
option.  This option takes an argument, which is the name of a packfile
hash, and parses it using parse_oid_hex.  It does so before calling
setup_git_directory.

However, in a SHA-256 repository this fails to work, since we have not
set the hash algorithm in use and parse_oid_hex fails as a consequence.
To ensure that we can parse packfile hashes of the right length, let's
set up the git directory before we start parsing arguments.
---
 http-fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 1df376e745..8db7eb669f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -86,6 +86,8 @@ int cmd_main(int argc, const char **argv)
 	int packfile = 0;
 	struct object_id packfile_hash;
 
+	setup_git_directory();
+
 	while (arg < argc && argv[arg][0] == '-') {
 		const char *p;
 
@@ -115,8 +117,6 @@ int cmd_main(int argc, const char **argv)
 	if (argc != arg + 2 - (commits_on_stdin || packfile))
 		usage(http_fetch_usage);
 
-	setup_git_directory();
-
 	git_config(git_default_config, NULL);
 
 	if (packfile) {
