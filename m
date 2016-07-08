Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7922023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbcGHJZ1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:25:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:41902 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754093AbcGHJZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:25:26 -0400
Received: (qmail 5733 invoked by uid 102); 8 Jul 2016 09:25:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:25:27 -0400
Received: (qmail 12045 invoked by uid 107); 8 Jul 2016 09:25:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:25:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:25:23 -0400
Date:	Fri, 8 Jul 2016 05:25:23 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] walker: let walker_say take arbitrary formats
Message-ID: <20160708092522.GA18263@sigill.intra.peff.net>
References: <20160708092510.GB17072@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708092510.GB17072@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We take a printf-style format and a single "char *"
parameter, and the format must therefore have at most one
"%s" in it. Besides being error-prone (and tickling
-Wformat-nonliteral), this is unnecessarily restrictive. We
can just provide the usual varargs interface.

Signed-off-by: Jeff King <peff@peff.net>
---
 walker.c | 10 +++++++---
 walker.h |  3 ++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/walker.c b/walker.c
index d95b007..2c86e40 100644
--- a/walker.c
+++ b/walker.c
@@ -9,10 +9,14 @@
 
 static unsigned char current_commit_sha1[20];
 
-void walker_say(struct walker *walker, const char *fmt, const char *hex)
+void walker_say(struct walker *walker, const char *fmt, ...)
 {
-	if (walker->get_verbosely)
-		fprintf(stderr, fmt, hex);
+	if (walker->get_verbosely) {
+		va_list ap;
+		va_start(ap, fmt);
+		vfprintf(stderr, fmt, ap);
+		va_end(ap);
+	}
 }
 
 static void report_missing(const struct object *obj)
diff --git a/walker.h b/walker.h
index 95e5765..a869013 100644
--- a/walker.h
+++ b/walker.h
@@ -19,7 +19,8 @@ struct walker {
 };
 
 /* Report what we got under get_verbosely */
-void walker_say(struct walker *walker, const char *, const char *);
+__attribute__((format (printf, 2, 3)))
+void walker_say(struct walker *walker, const char *fmt, ...);
 
 /* Load pull targets from stdin */
 int walker_targets_stdin(char ***target, const char ***write_ref);
-- 
2.9.0.393.g704e522

