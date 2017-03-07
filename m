Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5307D1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 13:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755360AbdCGNm7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 08:42:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:39711 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752390AbdCGNmm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 08:42:42 -0500
Received: (qmail 19748 invoked by uid 109); 7 Mar 2017 13:36:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 13:36:00 +0000
Received: (qmail 25611 invoked by uid 111); 7 Mar 2017 13:36:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 08:36:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Mar 2017 08:35:57 -0500
Date:   Tue, 7 Mar 2017 08:35:57 -0500
From:   Jeff King <peff@peff.net>
To:     Horst Schirmeier <horst@schirmeier.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/6] send-pack: extract parsing of "unpack" response
Message-ID: <20170307133557.xoqv6kigxzakgysi@sigill.intra.peff.net>
References: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After sending the pack, we call receive_status() which gets
both the "unpack" line and the ref status. Let's break these
into two functions so we can call the first part
independently.

Signed-off-by: Jeff King <peff@peff.net>
---
 send-pack.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6195b43e9..12e229e44 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -130,22 +130,27 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 	return 0;
 }
 
-static int receive_status(int in, struct ref *refs)
+static int receive_unpack_status(int in)
 {
-	struct ref *hint;
-	int ret = 0;
-	char *line = packet_read_line(in, NULL);
+	const char *line = packet_read_line(in, NULL);
 	if (!starts_with(line, "unpack "))
 		return error("did not receive remote status");
-	if (strcmp(line, "unpack ok")) {
-		error("unpack failed: %s", line + 7);
-		ret = -1;
-	}
+	if (strcmp(line, "unpack ok"))
+		return error("unpack failed: %s", line + 7);
+	return 0;
+}
+
+static int receive_status(int in, struct ref *refs)
+{
+	struct ref *hint;
+	int ret;
+
 	hint = NULL;
+	ret = receive_unpack_status(in);
 	while (1) {
 		char *refname;
 		char *msg;
-		line = packet_read_line(in, NULL);
+		char *line = packet_read_line(in, NULL);
 		if (!line)
 			break;
 		if (!starts_with(line, "ok ") && !starts_with(line, "ng ")) {
-- 
2.12.0.429.gde83c8049

