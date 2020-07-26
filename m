Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBB3C433F1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710C920738
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mvtN5EoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGZTy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40746 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbgGZTyz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:55 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 455B86101C;
        Sun, 26 Jul 2020 19:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793294;
        bh=/X+wx4cEA1CTt7F4mr6dLCr9FnNmF24HxacG5rvkHf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mvtN5EoNGzuw5KH20oWYaCWOVLKAqrQ6DG//pBg8LEKvnoNOsBxiPhIQyjlyG/Fw3
         TOJbS9WqodH0sEAR3q9ycUgoIaNiMqLTmJMk5j1ckSzMHGQEiODOBaf/hV54ivmzVx
         QLwbYWQxjTBQ/HxDHKxxRqNupQjW6LF0mKvP+/hNsZfxJy42dWYUaAACKUnPFkteAV
         VJnB+wsb1ZtgPGgn9jusE2SY6vp4F+lekk1wyUm3hBNug6PcvxvBwm6wy3nhk7g1BL
         kcmU8ZuSLRj6x48DYGjD0aF/TDPyN+bhkz8cJdrw8tjIygd+1hzHu6RglYWyTKwght
         JI20MLJ8L4zlrxuwJsaCA33hxqPGc/CcMoesbOeKfM9npm5u5271zZuWWzD6ff7XAm
         90A5ky+FMRLjJMjj8oS72cN9Xw6Bj/d2MkC1EArBtWht85KNCicqaRUyOA026cKr3d
         yH6cWNSVvUl475oQD24VNoJb59IaeEZ29yQ5QrIDtkTufCskMVJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 29/39] http-fetch: set up git directory before parsing pack hashes
Date:   Sun, 26 Jul 2020 19:54:14 +0000
Message-Id: <20200726195424.626969-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
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
