Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65FF2027C
	for <e@80x24.org>; Wed, 31 May 2017 04:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbdEaE1t (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 00:27:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:60365 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbdEaE1t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 00:27:49 -0400
Received: (qmail 13290 invoked by uid 109); 31 May 2017 04:27:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 04:27:49 +0000
Received: (qmail 1268 invoked by uid 111); 31 May 2017 04:28:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 00:28:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 00:27:47 -0400
Date:   Wed, 31 May 2017 00:27:47 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: [PATCH] remote: drop free_refspecs() function
Message-ID: <20170531042747.7k2yfd7eml6ep5cd@sigill.intra.peff.net>
References: <20170515230727.hw75whugf25asuor@sigill.intra.peff.net>
 <20170526100403.19270-1-szeder.dev@gmail.com>
 <20170526133024.g5rztiv3lea37n72@sigill.intra.peff.net>
 <xmqq8tlfdmpg.fsf@gitster.mtv.corp.google.com>
 <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 09:11:28AM +0200, SZEDER Gábor wrote:

> I also dropped Peff's two patches that were included in v3, because:
> 
>  - his last patch doesn't apply anymore, because the variable it frees
>    properly doesn't exist anymore, and
>  - with that patch gone his second patch is not tangled up with this
>    topic, so I think it should go on its own branch.

Makes sense on both counts. Here's that stand-alone patch for reference,
which can go onto its own topic.

-- >8 --
Subject: [PATCH] remote: drop free_refspecs() function

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
index fdc52d802..2e39bf930 100644
--- a/remote.c
+++ b/remote.c
@@ -477,26 +477,6 @@ static void read_config(void)
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
@@ -610,7 +590,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		 * since it is only possible to reach this point from within
 		 * the for loop above.
 		 */
-		free_refspecs(rs, i+1);
+		free_refspec(i+1, rs);
 		return NULL;
 	}
 	die("Invalid refspec '%s'", refspec[i]);
@@ -621,7 +601,7 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
 	struct refspec *refspec;
 
 	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
-	free_refspecs(refspec, 1);
+	free_refspec(1, refspec);
 	return !!refspec;
 }
 
@@ -638,6 +618,10 @@ struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
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
2.13.0.676.ge5a8f17ed

