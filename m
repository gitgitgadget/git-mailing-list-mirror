Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FEF2201A4
	for <e@80x24.org>; Sat, 13 May 2017 09:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbdEMJFD (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 05:05:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:50760 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbdEMJFD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 05:05:03 -0400
Received: (qmail 28201 invoked by uid 109); 13 May 2017 09:05:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 09:05:00 +0000
Received: (qmail 30586 invoked by uid 111); 13 May 2017 09:05:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 05:05:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 May 2017 05:04:58 -0400
Date:   Sat, 13 May 2017 05:04:58 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v7 04/10] convert: move packet_write_line() into pkt-line
 as packet_writel()
Message-ID: <20170513090457.s6gmqjdyrj4osmck@sigill.intra.peff.net>
References: <20170505152802.6724-1-benpeart@microsoft.com>
 <20170505152802.6724-5-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170505152802.6724-5-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2017 at 11:27:56AM -0400, Ben Peart wrote:

> +int packet_writel(int fd, const char *line, ...);

This isn't a new problem, but I noticed that this function should
probably get annotated to describe its interface.

Junio, can you pick up the patch below on top of Ben's series (or I'd be
fine if it were squashed into this patch)?

-- >8 --
Subject: [PATCH] pkt-line: annotate packet_writel with LAST_ARG_MUST_BE_NULL

packet_writel() takes a variable-sized list and reads to
the first NULL. Let's let the compiler know so that it can
help us catch mistakes in the callers.

This should have been annotated similarly when it was a
static function, but it's doubly important now that the
function is available to the whole code-base.

Signed-off-by: Jeff King <peff@peff.net>
---
 pkt-line.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pkt-line.h b/pkt-line.h
index b2965869a..450183b64 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,6 +25,7 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+LAST_ARG_MUST_BE_NULL
 int packet_writel(int fd, const char *line, ...);
 int write_packetized_from_fd(int fd_in, int fd_out);
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
-- 
2.13.0.452.g0afc8e12b

