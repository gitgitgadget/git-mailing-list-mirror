Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F852023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbcGHJKN (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:10:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:41864 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754086AbcGHJKL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:10:11 -0400
Received: (qmail 5021 invoked by uid 102); 8 Jul 2016 09:10:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:10:12 -0400
Received: (qmail 11881 invoked by uid 107); 8 Jul 2016 09:10:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:10:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:10:08 -0400
Date:	Fri, 8 Jul 2016 05:10:08 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/8] write_file: use xopen
Message-ID: <20160708091007.GE10152@sigill.intra.peff.net>
References: <20160708090400.GA26594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708090400.GA26594@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This simplifies the code a tiny bit, and provides consistent
error messages with other users of xopen().

While we're here, let's also switch to using O_WRONLY. We
know we're only going to open/write/close the file, so
there's no point in asking for O_RDWR.

Signed-off-by: Jeff King <peff@peff.net>
---
 wrapper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 0349441..7c126b8 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -644,9 +644,7 @@ void write_file(const char *path, const char *fmt, ...)
 {
 	va_list params;
 	struct strbuf sb = STRBUF_INIT;
-	int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
-	if (fd < 0)
-		die_errno(_("could not open %s for writing"), path);
+	int fd = xopen(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 
 	va_start(params, fmt);
 	strbuf_vaddf(&sb, fmt, params);
-- 
2.9.0.393.g704e522

