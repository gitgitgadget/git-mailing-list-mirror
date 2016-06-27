Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4935A1FF40
	for <e@80x24.org>; Mon, 27 Jun 2016 03:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbcF0D4g (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 23:56:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45680 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbcF0D4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 23:56:36 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99B231FF40;
	Mon, 27 Jun 2016 03:56:35 +0000 (UTC)
Date:	Mon, 27 Jun 2016 03:56:35 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCHv2 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
Message-ID: <20160627035635.GA5478@dcvr.yhbt.net>
References: <20160626232112.721-1-e@80x24.org>
 <20160626232112.721-2-e@80x24.org>
 <20160626235129.GC21668@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160626235129.GC21668@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Sun, Jun 26, 2016 at 11:21:11PM +0000, Eric Wong wrote:
> 
> > We should continue to loop after EAGAIN/EWOULDBLOCK as the
> > intent of xread is to read as much as possible until an
> > EOF or real error occurs.
> 
> BTW, a minor nit here. xread() does _not_ read as much as possible until
> EOF. It tries until it gets a real error or at least one byte.
> 
> I know you inherited this mistaken text from 1079c4be0b, but we should
> probably not repeat it.

Good catch, here's v2 of PATCH 1/2 reworded:

----------8<----------
Subject: [PATCH] xread: retry after poll on EAGAIN/EWOULDBLOCK

We should continue to loop after EAGAIN/EWOULDBLOCK as the
intent of xread is to try until there is available data,
EOF, or an unrecoverable error.

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
-- 
EW
