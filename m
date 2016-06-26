Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570BA20179
	for <e@80x24.org>; Sun, 26 Jun 2016 23:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbcFZXVb (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 19:21:31 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58148 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbcFZXV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 19:21:29 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735A42018B;
	Sun, 26 Jun 2016 23:21:25 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
Date:	Sun, 26 Jun 2016 23:21:11 +0000
Message-Id: <20160626232112.721-2-e@80x24.org>
In-Reply-To: <20160626232112.721-1-e@80x24.org>
References: <20160626232112.721-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We should continue to loop after EAGAIN/EWOULDBLOCK as the
intent of xread is to read as much as possible until an
EOF or real error occurs.

Fixes: 1079c4be0b720 ("xread: poll on non blocking fds")

Signed-off-by: Eric Wong <e@80x24.org>
---
 wrapper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/wrapper.c b/wrapper.c
index 5dc4e15..f1155d0 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -255,6 +255,7 @@ ssize_t xread(int fd, void *buf, size_t len)
 				 * call to read(2).
 				 */
 				poll(&pfd, 1, -1);
+				continue;
 			}
 		}
 		return nr;
