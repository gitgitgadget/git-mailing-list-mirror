Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0189F1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755865AbdC1Tr0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:47:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:53167 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755801AbdC1Tr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:47:26 -0400
Received: (qmail 11810 invoked by uid 109); 28 Mar 2017 19:46:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:56 +0000
Received: (qmail 7595 invoked by uid 111); 28 Mar 2017 19:47:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:47:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:53 -0400
Date:   Tue, 28 Mar 2017 15:46:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 14/18] combine-diff: replace malloc/snprintf with xstrfmt
Message-ID: <20170328194653.o2qknaynp45ha7yf@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to use the magic "100" when a strbuf can do
it for us.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 59501db99..d3560573a 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -292,9 +292,10 @@ static char *grab_blob(const struct object_id *oid, unsigned int mode,
 	enum object_type type;
 
 	if (S_ISGITLINK(mode)) {
-		blob = xmalloc(100);
-		*size = snprintf(blob, 100,
-				 "Subproject commit %s\n", oid_to_hex(oid));
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "Subproject commit %s\n", oid_to_hex(oid));
+		*size = buf.len;
+		blob = strbuf_detach(&buf, NULL);
 	} else if (is_null_oid(oid)) {
 		/* deleted blob */
 		*size = 0;
-- 
2.12.2.845.g55fcf8b10

