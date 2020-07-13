Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69C9C433E2
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97554206D9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k+QY44vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgGMCuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:50:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40760 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728479AbgGMCtn (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:43 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 39E9C60A6E;
        Mon, 13 Jul 2020 02:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608577;
        bh=/X+wx4cEA1CTt7F4mr6dLCr9FnNmF24HxacG5rvkHf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=k+QY44vmTiuTDRm+CnqMC+bOa7xydtg+g0xdyGNPNKEy8xjjTSpbWS10aosirdfnW
         ATWbZALbD6xQd/JXJI6TBSUhdDjJucDe1ZFtcnsYqejnQMUVnTJNMZ0qQns7X9004c
         KlJ/pUj1AM7nhgU0hFHvQxogTrn9ICAFhYG3Zmmq8S4Z/aoLByghxSaMs5VtBouHzv
         WaKyiVoSj29G/nRE7Np8jk5SrvBezCE7nAYPzwtWFPFYjLfa/uIbiFL1cFs9a9SDTl
         4m/NuzKK8F0mfopmdubzGXYDqIADtZqW8Rdi99EHRJRcBsbhygSEJK8DDAY/i1UZ0a
         Giyum82VE2tfR9wxIW52oVJqBwYthHnGJiaRI6CYpsJfuACMU+qd6uNf5FNmFfUNRM
         KMGl+si91L57sgJEgyQWs1T9mSsqvdWww9PYeZRwQfJMxjvIQHRcbMEyuLO2Pgo516
         WDVU5Rrxhn5BonG6mX5w04vdkObY7zWgJsnuHSmwqLzM8+sPfJq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 29/39] http-fetch: set up git directory before parsing pack hashes
Date:   Mon, 13 Jul 2020 02:48:59 +0000
Message-Id: <20200713024909.3714837-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
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
