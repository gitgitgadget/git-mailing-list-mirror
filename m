Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C853CC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1F72067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zaQGXT9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgG2XPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41170 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728009AbgG2XPc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D75DE6101F;
        Wed, 29 Jul 2020 23:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064499;
        bh=HI9WMtbfHbrUeociuYI9oW7Ak33yBxHycter0tfuUXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zaQGXT9GxD4aUFoLzyyvUumCb+iit0Hco6gsnK+W09WEOs5ZX15zwfRTe10NJRiSl
         5vmabErk0K0TwptdFP1KblnJZy/++V4saVpBNq15t44U2hBqJZfbZQpMtf9AK0VOAy
         xKOtWNVR79isOsIl9ZfTjXytR2m9dp9+gXKYja6bGBK1CTyRbIpDeuqVT4SHoAapPO
         StFRC80B7HXUfUXqBn4rUFkNG17OrJC0PyuYWQojcgNv0+pKjDVryk2og3aOg7XiG/
         vTZlB9Y/Wl8gyE/Kp6ZGmGMWWwFMJ6teNgs3xSEJOOIz32AO/MvdYXau3aVvGX/TuH
         8bTJ4XfqON122LQGTNPUIfAvf+LSsHSv0KQwFgDjgJ+X6VSgagjOc8Z6LnJiYLawaX
         FuEnPsL7tsARVkqmzsTf6EdJX28vbOyzz8iSlNuZGJIGIrWZj2JfTCgg4cONZnGSSz
         a0B6A2S2pTetNPiEyY23CtuDmCE+WeknJyKkJueFClq9OuCvU9b
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 29/39] http-fetch: set up git directory before parsing pack hashes
Date:   Wed, 29 Jul 2020 23:14:18 +0000
Message-Id: <20200729231428.3658647-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
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

Since we still want to allow the invocation of -h to print the help when
we're not in a repository, gracefully handle us being outside of one and
produce an error after argument parsing has finished.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-fetch.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/http-fetch.c b/http-fetch.c
index 1df376e745..c4ccc5fea9 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -84,8 +84,11 @@ int cmd_main(int argc, const char **argv)
 	int get_verbosely = 0;
 	int get_recover = 0;
 	int packfile = 0;
+	int nongit;
 	struct object_id packfile_hash;
 
+	setup_git_directory_gently(&nongit);
+
 	while (arg < argc && argv[arg][0] == '-') {
 		const char *p;
 
@@ -115,7 +118,8 @@ int cmd_main(int argc, const char **argv)
 	if (argc != arg + 2 - (commits_on_stdin || packfile))
 		usage(http_fetch_usage);
 
-	setup_git_directory();
+	if (nongit)
+		die(_("not a git repository"));
 
 	git_config(git_default_config, NULL);
 
