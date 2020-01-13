Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF0EC33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87457207FF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MrpPyZ9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAMMsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:16 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37778 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728885AbgAMMsE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:04 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 02B69607F9
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919683;
        bh=+CbaV4vB0OjC329reZOD72Q9e0X81Dv91pSFssPPsGI=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=MrpPyZ9BFxonesndBJvRX1f9pS8O09QCoenlGRfgDAF/mrSFUKhCTZvGhPOl8lwFM
         wnotk4cjznGz72SRcgD8iWY/nUOqLKHro/wnGz55B5mOjGUyO/+ho9BD3ZZ1QAjl6t
         SR9flA2O01JVSPjMVzjdTMwmIlYkZa78qo+oVu8hyW9ychDzZReT0qRWvsOUCNCrt7
         JNI8Z9EdmyOsmLu+W2m1evfP2EN23dfctdvenNIu4kG7hTISy3VbZuImw/+U/8mWr7
         A4SHuKr4jM9n8SuRacUErX/YufkIeKny1pl9t+TOOc10sQqVA4PSrHIRWt4q4JZL6D
         hhyogF3OxkjBKT4rJl4M/+uToXQY6iJzUr0cO5x8OIm4hTPxKz5d08at1+hSgZedJO
         +gqBe3coJfselC4NkSqBltBshDNmMBG6hZhxuHIeCRax16wQs6GGiKOZwan82smWPJ
         wqes+pHnQ/dGmQtGOGg9/1id85hRbaopyiJZpuU3tUv3NHVymSR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 14/22] worktree: allow repository version 1
Date:   Mon, 13 Jan 2020 12:47:21 +0000
Message-Id: <20200113124729.3684846-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
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
