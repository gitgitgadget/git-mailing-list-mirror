Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF1CD1FAA8
	for <e@80x24.org>; Mon, 15 May 2017 07:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759570AbdEOHtu (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 03:49:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:51728 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757697AbdEOHtd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 03:49:33 -0400
Received: (qmail 11293 invoked by uid 109); 15 May 2017 07:49:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 07:49:28 +0000
Received: (qmail 14465 invoked by uid 111); 15 May 2017 07:50:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 03:50:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 03:49:26 -0400
Date:   Mon, 15 May 2017 03:49:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] remote: drop free_refspecs() function
Message-ID: <20170515074926.q3rubolg6qtjz7dz@sigill.intra.peff.net>
References: <20170515074617.wsdzogshc4ilnlsb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170515074617.wsdzogshc4ilnlsb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have free_refspec(), a public function which does
the same thing as the static free_refspecs(). Let's just
keep one.  There are two minor differences between the
functions:

  1. free_refspecs() is a noop when the refspec argument is
     NULL. This probably doesn't matter in practice.  The
     nr_refspec parameter would presumably be 0 in that
     case, skipping the loop. And free(NULL) is explicitly
     OK. But it doesn't hurt for us to port this extra
     safety to free_refspec(), as one of the callers passes
     a funny "i+1" count.

  2. The order of arguments is reversed between the two
     functions. This patch uses the already-public order of
     free_refspec(), as it matches the argument order on the
     parsing side.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/remote.c b/remote.c
index ad6c5424e..7918e0dac 100644
--- a/remote.c
+++ b/remote.c
@@ -473,26 +473,6 @@ static void read_config(void)
 	alias_all_urls();
 }
 
-/*
- * This function frees a refspec array.
- * Warning: code paths should be checked to ensure that the src
- *          and dst pointers are always freeable pointers as well
- *          as the refspec pointer itself.
- */
-static void free_refspecs(struct refspec *refspec, int nr_refspec)
-{
-	int i;
-
-	if (!refspec)
-		return;
-
-	for (i = 0; i < nr_refspec; i++) {
-		free(refspec[i].src);
-		free(refspec[i].dst);
-	}
-	free(refspec);
-}
-
 static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
 {
 	int i;
@@ -606,7 +586,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		 * since it is only possible to reach this point from within
 		 * the for loop above.
 		 */
-		free_refspecs(rs, i+1);
+		free_refspec(i+1, rs);
 		return NULL;
 	}
 	die("Invalid refspec '%s'", refspec[i]);
@@ -617,7 +597,7 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
 	struct refspec *refspec;
 
 	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
-	free_refspecs(refspec, 1);
+	free_refspec(1, refspec);
 	return !!refspec;
 }
 
@@ -634,6 +614,10 @@ static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 void free_refspec(int nr_refspec, struct refspec *refspec)
 {
 	int i;
+
+	if (!refspec)
+		return;
+
 	for (i = 0; i < nr_refspec; i++) {
 		free(refspec[i].src);
 		free(refspec[i].dst);
-- 
2.13.0.458.g025404205

