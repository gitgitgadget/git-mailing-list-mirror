Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEA6C3F68F
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 10:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFB420828
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 10:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLZKm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 05:42:26 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54800 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfLZKm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 05:42:26 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5BB981F46D;
        Thu, 26 Dec 2019 10:42:21 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] packfile: replace lseek+read with pread
Date:   Thu, 26 Dec 2019 10:42:20 +0000
Message-Id: <20191226104220.27325-3-e@80x24.org>
In-Reply-To: <20191226104220.27325-1-e@80x24.org>
References: <20191226104220.27325-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have pread emulation for portability, so there's
there's no reason to make two syscalls where one suffices.

Furthermore, readers of the packfile will be using mmap
(or pread to emulate mmap), anyways, so the file description
offset does not matter in this case.

Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 1821cb7a3d..7e7c04e4d8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -576,9 +576,8 @@ static int open_packed_git_1(struct packed_git *p)
 			     " while index indicates %"PRIu32" objects",
 			     p->pack_name, ntohl(hdr.hdr_entries),
 			     p->num_objects);
-	if (lseek(p->pack_fd, p->pack_size - hashsz, SEEK_SET) == -1)
-		return error("end of packfile %s is unavailable", p->pack_name);
-	read_result = read_in_full(p->pack_fd, hash, hashsz);
+	read_result = pread_in_full(p->pack_fd, hash, hashsz,
+					p->pack_size - hashsz);
 	if (read_result < 0)
 		return error_errno("error reading from %s", p->pack_name);
 	if (read_result != hashsz)
