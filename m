Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EE7C43461
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58D2207FC
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="roRV/FHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgG1Xfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40852 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbgG1XfK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:10 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 10E006101F;
        Tue, 28 Jul 2020 23:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979308;
        bh=soY+aqv9+MMtSZaxyqR9FTYs7U+WRbISFa4di6Cc3Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=roRV/FHYQlufEo7XymUFTjtBx5LXuidOvrMGDeoUu9mYGvL4ifMgmDmpomxiSOp+2
         /BKUVu2yG9iUDSzPG0NFfh9ORJ4Fi7O7mI0fC2oZ5KbitnHle7E4nG28FDWIdwMLqr
         q9rImbDjWL1fcIuG0nMpE8FJ7lo+Zyb7QCXClsjnC9lrIVKpYmWqq4+poPVCzfzwcY
         2tb9EjR5eQC1rTmibb9RWipf70E6n0c5uSzsI2efSj9W9E2v+SDaY65CQ/RLcDon6w
         2SvEzrXztG+BS20NqH85IyXhpRhM7syB9dWCFI/f+UzMpkb4hANftcD5a9aTGz8HFU
         PwT3gAmte7Tf1SsIYgmBMfmXJlP/FnsLq1vCdCxy+NuEGOpeOh/WLFdLVCMCv54Hci
         NjrqB9pu7uyDhqKVwVoUDzaYGxqFTNDVr1OAGS9a64nM/vuhreIwfo2+3T5C7CQiXj
         8KFnFWtMLwD/wbI5I9PYNPx5IEKSgs1esISy19ZygNai4ByEjQt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 29/39] http-fetch: set up git directory before parsing pack hashes
Date:   Tue, 28 Jul 2020 23:34:36 +0000
Message-Id: <20200728233446.3066485-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
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

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 1df376e745..65050dee2b 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -86,6 +86,8 @@ int cmd_main(int argc, const char **argv)
 	int packfile = 0;
 	struct object_id packfile_hash;
 
+	setup_git_directory_gently(NULL);
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
