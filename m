Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5755FC35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9B0206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="slRAd04V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBVUS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:26 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39078 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727039AbgBVUSK (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:10 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B8E486079C
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402689;
        bh=+CbaV4vB0OjC329reZOD72Q9e0X81Dv91pSFssPPsGI=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=slRAd04ViOj5VHJ6v3yRWa1tdKwtlvwo0OVO71ds3YlyUh485SSA8gI7o15XgST3b
         P1rcOVisbh5e1p4UkkUQvtwLw8YExe911VZ3YDBL2RD1qhMTuMEoBVJdGV8PMngYRF
         tqX/DGMf8+kjc+Brc0JLnzeTpYbsKO2wKJpWRQ2zjNC4/TZ8WAX/13Bkcdeqtaz5wl
         okyris45tomHb2FUR6yplkn6ZDkocQar07vFSKmbe3TrEfLOssOYwyUr02Syfh+X3r
         aiv9HXtZCL2e740P9FaY1PqaKwRwShNUtLdXiO/W23s+0ro1GA1TKHr5Esb9aIqyDk
         G+bI5K+Q499vBhtXEeZfRFChrMalz4sEV3oqu55O78GpCRz9BkY0gPVMquKFoesp2G
         sOwv08XZ0PZsJnJLfpFsYVIRn2iA5TP5QOCYnpnHvB54hnnI2C3kG4mwkmiwpwsVkj
         x3//6sXRXzdrhgzsWfKCppX1gECXMoQmwlM/0GeEF6UYwQR73pE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 16/24] worktree: allow repository version 1
Date:   Sat, 22 Feb 2020 20:17:41 +0000
Message-Id: <20200222201749.937983-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git supports both repository versions 0 and 1.  These formats are
identical except for the presence of extensions.  When using an
extension, such as for a different hash algorithm, a check for only
version 0 causes the check to fail.  Instead, call
verify_repository_format to verify that we have an appropriate version
and no unknown extensions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 worktree.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/worktree.c b/worktree.c
index 5b4793caa3..d1d23aadb4 100644
--- a/worktree.c
+++ b/worktree.c
@@ -449,7 +449,7 @@ const struct worktree *find_shared_symref(const char *symref,
 int submodule_uses_worktrees(const char *path)
 {
 	char *submodule_gitdir;
-	struct strbuf sb = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT, err = STRBUF_INIT;
 	DIR *dir;
 	struct dirent *d;
 	int ret = 0;
@@ -463,18 +463,16 @@ int submodule_uses_worktrees(const char *path)
 	get_common_dir_noenv(&sb, submodule_gitdir);
 	free(submodule_gitdir);
 
-	/*
-	 * The check below is only known to be good for repository format
-	 * version 0 at the time of writing this code.
-	 */
 	strbuf_addstr(&sb, "/config");
 	read_repository_format(&format, sb.buf);
-	if (format.version != 0) {
+	if (verify_repository_format(&format, &err)) {
+		strbuf_release(&err);
 		strbuf_release(&sb);
 		clear_repository_format(&format);
 		return 1;
 	}
 	clear_repository_format(&format);
+	strbuf_release(&err);
 
 	/* Replace config by worktrees. */
 	strbuf_setlen(&sb, sb.len - strlen("config"));
