Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484DF1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 13:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754182AbdCGNsP (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 08:48:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:39724 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752898AbdCGNsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 08:48:14 -0500
Received: (qmail 20026 invoked by uid 109); 7 Mar 2017 13:39:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 13:39:51 +0000
Received: (qmail 25636 invoked by uid 111); 7 Mar 2017 13:39:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 08:39:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Mar 2017 08:39:48 -0500
Date:   Tue, 7 Mar 2017 08:39:48 -0500
From:   Jeff King <peff@peff.net>
To:     Horst Schirmeier <horst@schirmeier.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 6/6] send-pack: report signal death of pack-objects
Message-ID: <20170307133948.x3w6nufae7tbgeka@sigill.intra.peff.net>
References: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If our pack-objects sub-process dies of a signal, then it
likely didn't have a chance to write anything useful to
stderr. The user may be left scratching their head why the
push failed. Let's detect this situation and write something
to stderr.

Signed-off-by: Jeff King <peff@peff.net>
---
We could drop the SIGPIPE special-case, but I think it's just noise
after the unpack-status fix in the previous commit.

 send-pack.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/send-pack.c b/send-pack.c
index e15232739..d2d2a49a0 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -72,6 +72,7 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 	struct child_process po = CHILD_PROCESS_INIT;
 	FILE *po_in;
 	int i;
+	int rc;
 
 	i = 4;
 	if (args->use_thin_pack)
@@ -125,8 +126,20 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 		po.out = -1;
 	}
 
-	if (finish_command(&po))
+	rc = finish_command(&po);
+	if (rc) {
+		/*
+		 * For a normal non-zero exit, we assume pack-objects wrote
+		 * something useful to stderr. For death by signal, though,
+		 * we should mention it to the user. The exception is SIGPIPE
+		 * (141), because that's a normal occurence if the remote end
+		 * hangs up (and we'll report that by trying to read the unpack
+		 * status).
+		 */
+		if (rc > 128 && rc != 141)
+			error("pack-objects died of signal %d", rc - 128);
 		return -1;
+	}
 	return 0;
 }
 
-- 
2.12.0.429.gde83c8049
