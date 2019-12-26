Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBDEC2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 10:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD912080D
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 10:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfLZKmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 05:42:23 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54764 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfLZKmX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 05:42:23 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 28D0E1F466;
        Thu, 26 Dec 2019 10:42:21 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] packfile: remove redundant fcntl F_GETFD/F_SETFD
Date:   Thu, 26 Dec 2019 10:42:19 +0000
Message-Id: <20191226104220.27325-2-e@80x24.org>
In-Reply-To: <20191226104220.27325-1-e@80x24.org>
References: <20191226104220.27325-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git_open sets close-on-exec since cd66ada06588f797
("sha1_file: open window into packfiles with O_CLOEXEC").
There's no reason to keep using fcntl to set the close-on-exec
flag, anymore.

Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/packfile.c b/packfile.c
index f0dc63e92f..1821cb7a3d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -510,7 +510,6 @@ static int open_packed_git_1(struct packed_git *p)
 	struct pack_header hdr;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	unsigned char *idx_hash;
-	long fd_flag;
 	ssize_t read_result;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
@@ -554,16 +553,6 @@ static int open_packed_git_1(struct packed_git *p)
 	} else if (p->pack_size != st.st_size)
 		return error("packfile %s size changed", p->pack_name);
 
-	/* We leave these file descriptors open with sliding mmap;
-	 * there is no point keeping them open across exec(), though.
-	 */
-	fd_flag = fcntl(p->pack_fd, F_GETFD, 0);
-	if (fd_flag < 0)
-		return error("cannot determine file descriptor flags");
-	fd_flag |= FD_CLOEXEC;
-	if (fcntl(p->pack_fd, F_SETFD, fd_flag) == -1)
-		return error("cannot set FD_CLOEXEC");
-
 	/* Verify we recognize this pack file format. */
 	read_result = read_in_full(p->pack_fd, &hdr, sizeof(hdr));
 	if (read_result < 0)
