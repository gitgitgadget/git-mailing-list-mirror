Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6974D1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750907AbdEBQBQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:01:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:64764 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbdEBQBP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:01:15 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNq8p-1d8cNb2XyV-007TOX; Tue, 02
 May 2017 18:01:08 +0200
Date:   Tue, 2 May 2017 18:01:07 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 03/25] winansi: avoid buffer overrun
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <8b3b6c1071503df2d3e04162ef7fb5f5ff56b177.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QG8aksgVKs3OcpstEv/c4GzCYeU+0WnX5wfP943+Jgwdow05V4D
 +ycCIb4aXUF4m0gDHaIYe/paiO+9hDHK3FrrUGy2d/yXh1vai9VmhNTL2a5gwfy5pI1WQeC
 gIrLeb2py2PTL5uMjZBr2b3VfSSaHt0Ni0e4EcpIGIyEg+g6Y1Pa2G527hmzm6kqgw/2HqP
 gxIXV/0Jrt2OAyFll6oDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yFJsBELTZrY=:pSJx8FIipUM6QMWlR9FSl7
 TvQc4iA9BjYxiVNzfE7i1vOb53hTKcpqIeaVZ7qsfFvHt6eNKanhgxE2SMJKqCPwJUJSXvGIY
 le6VNtu2UZdpPxA67OBiP6a9S9NWg291JrLnL/FLGYliDjdAFMPzJ0BDPqyliru5zifcqY71O
 MSXwMsl60GC0pCVf9oFtMJkvwihXk6EzCEUovU+HnXuiIGnqLQoaxs6mC64SjH79wbOiNdu1Z
 KwR9NsnngqlB6uYHmOgz8Y1qN5xT+Z85ST5mQJOLwJHJA0oS1unTCkf4iM1pDGwjnrXvdC+3K
 g/+Gz21DZlmBkaiIjD35/NljJPpbz0Y1ELfIt5atiGddZOom5DNU69KlQ7iXb3TkjzEd5Wgsd
 qiYncqRIG4KzsByrPbWaL3UETyFbfPvqlRkd5ooHqGKmMcdWqg62lc1TANTSIWSLhYhqg3Z8V
 EZAIc0jqJ+S+dVbPfNUT+afrLUXECUBInXxYWRc/uqvtvtZJbJmRVkmoRlzbLAgM7pMRqlMXZ
 TdEeVHIOAMU5vGYcQ5iQjx0BfVqv7WjXfr54JYM6PH/sTazZZlSGNOnUmBT8gF/RuKLSjOUQu
 Z1+NGxvrsnlkf5pox7ogw7xublDJm/dw9AVmX+D6hl0EDWhydj+CE6oMR8+aJRMbyJhbveL26
 qHQGL3TzcFa97DohjRwStksxsso+bMbOxk1I9lj9mLU9GzLBmvMPL7p86JCaYDoOapd5Nn3go
 OOugYobIFDMQLX//ahs/+TX/0TCf/jKQczQUgjpuYAodo4qKiBzp0Peys6Vdxd+XEbdOdac+F
 qnuSwni
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we could not convert the UTF-8 sequence into Unicode for writing to
the Console, we should not try to write an insanely-long sequence of
invalid wide characters (mistaking the negative return value for an
unsigned length).

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index fd6910746c8..861b79d8c31 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -135,6 +135,11 @@ static void write_console(unsigned char *str, size_t len)
 
 	/* convert utf-8 to utf-16 */
 	int wlen = xutftowcsn(wbuf, (char*) str, ARRAY_SIZE(wbuf), len);
+	if (wlen < 0) {
+		wchar_t *err = L"[invalid]";
+		WriteConsoleW(console, err, wcslen(err), &dummy, NULL);
+		return;
+	}
 
 	/* write directly to console */
 	WriteConsoleW(console, wbuf, wlen, &dummy, NULL);
-- 
2.12.2.windows.2.800.gede8f145e06


