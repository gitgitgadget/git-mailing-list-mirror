Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97AE2082F
	for <e@80x24.org>; Sat, 15 Jul 2017 18:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdGOSzl (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 14:55:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41914 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdGOSzk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 14:55:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3587A2082F;
        Sat, 15 Jul 2017 18:55:40 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] set FD_CLOEXEC properly when O_CLOEXEC is not supported
Date:   Sat, 15 Jul 2017 18:55:40 +0000
Message-Id: <20170715185540.6778-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FD_CLOEXEC only applies to the file descriptor, so it needs to be
manipuluated via F_GETFD/F_SETFD.  F_GETFL/F_SETFL are for file
description flags.

Verified via strace with o_cloexec set to zero.

Signed-off-by: Eric Wong <e@80x24.org>
---
 sha1_file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index fca165f13c..b60ae15f70 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1684,14 +1684,14 @@ int git_open_cloexec(const char *name, int flags)
 		fd = open(name, flags | o_cloexec);
 	}
 
-#if defined(F_GETFL) && defined(F_SETFL) && defined(FD_CLOEXEC)
+#if defined(F_GETFD) && defined(F_SETFD) && defined(FD_CLOEXEC)
 	{
 		static int fd_cloexec = FD_CLOEXEC;
 
 		if (!o_cloexec && 0 <= fd && fd_cloexec) {
 			/* Opened w/o O_CLOEXEC?  try with fcntl(2) to add it */
-			int flags = fcntl(fd, F_GETFL);
-			if (fcntl(fd, F_SETFL, flags | fd_cloexec))
+			int flags = fcntl(fd, F_GETFD);
+			if (fcntl(fd, F_SETFD, flags | fd_cloexec))
 				fd_cloexec = 0;
 		}
 	}
-- 
EW

