Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7969B1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 07:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeH3LIf (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:08:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:33522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726169AbeH3LIf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:08:35 -0400
Received: (qmail 11624 invoked by uid 109); 30 Aug 2018 07:07:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 07:07:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24230 invoked by uid 111); 30 Aug 2018 07:08:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 03:08:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 03:07:52 -0400
Date:   Thu, 30 Aug 2018 03:07:52 -0400
From:   Jeff King <peff@peff.net>
To:     Jann Horn <jannh@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 1/5] test-delta: read input into a heap buffer
Message-ID: <20180830070751.GA15420@sigill.intra.peff.net>
References: <20180830070548.GA15081@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830070548.GA15081@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently read the input to test-delta by mmap()-ing it.
However, memory-checking tools like valgrind and ASan are
less able to detect reads/writes past the end of an mmap'd
buffer, because the OS is likely to give us extra bytes to
pad out the final page size. So instead, let's read into a
heap buffer.

As a bonus, this also makes it possible to write tests with
empty bases, as mmap() will complain about a zero-length
map.

This is based on a patch by Jann Horn <jannh@google.com>
which actually aligned the data at the end of a page, and
followed it with another page marked with mprotect(). That
would detect problems even without a tool like ASan, but it
was significantly more complex and may have introduced
portability problems. By comparison, this approach pushes
the complexity onto existing memory-checking tools.

Note that this could be done even more simply by using
strbuf_read_file(), but that would defeat the purpose:
strbufs generally overallocate (and at the very least
include a trailing NUL which we do not care about), which
would defeat most memory checkers.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-delta.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 34c7259248..e749a49c88 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -34,8 +34,8 @@ int cmd__delta(int argc, const char **argv)
 		return 1;
 	}
 	from_size = st.st_size;
-	from_buf = mmap(NULL, from_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (from_buf == MAP_FAILED) {
+	from_buf = xmalloc(from_size);
+	if (read_in_full(fd, from_buf, from_size) < 0) {
 		perror(argv[2]);
 		close(fd);
 		return 1;
@@ -48,8 +48,8 @@ int cmd__delta(int argc, const char **argv)
 		return 1;
 	}
 	data_size = st.st_size;
-	data_buf = mmap(NULL, data_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (data_buf == MAP_FAILED) {
+	data_buf = xmalloc(data_size);
+	if (read_in_full(fd, data_buf, data_size) < 0) {
 		perror(argv[3]);
 		close(fd);
 		return 1;
-- 
2.19.0.rc1.539.g3876d0831e

