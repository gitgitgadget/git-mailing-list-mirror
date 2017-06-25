Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E7220831
	for <e@80x24.org>; Sun, 25 Jun 2017 14:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbdFYOKG (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 10:10:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:52338 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750748AbdFYOKF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 10:10:05 -0400
Received: (qmail 14636 invoked by uid 109); 25 Jun 2017 14:09:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 25 Jun 2017 14:09:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28054 invoked by uid 111); 25 Jun 2017 14:10:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 25 Jun 2017 10:10:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jun 2017 10:09:57 -0400
Date:   Sun, 25 Jun 2017 10:09:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: NULL dereference in ab/wildmatch
Message-ID: <20170625140957.kjkctkaesm6il5u2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 25, 2017 at 02:50:10AM -0700, scan-admin@coverity.com wrote:

> 
> ** CID 1413016:  Null pointer dereferences  (FORWARD_NULL)
> /config.c: 213 in include_by_gitdir()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 1413016:  Null pointer dereferences  (FORWARD_NULL)
> /config.c: 213 in include_by_gitdir()
> 207     {
> 208     	struct strbuf text = STRBUF_INIT;
> 209     	struct strbuf pattern = STRBUF_INIT;
> 210     	int ret = 0, prefix;
> 211     	const char *git_dir;
> 212     	int already_tried_absolute = 0;
> >>>     CID 1413016:  Null pointer dereferences  (FORWARD_NULL)
> >>>     Assigning: "code" = "NULL".
> 213     	struct wildmatch_compiled *code = NULL;
> 214     
> 215     	if (opts->git_dir)
> 216     		git_dir = opts->git_dir;
> 217     	else
> 218     		goto done;

I think this comes the "goto done" at the bottom of the context. After
that label, we call wildmatch_free() unconditionally. Probably it just
needs:

diff --git a/config.c b/config.c
index 515f8518e2..cfee92ebbf 100644
--- a/config.c
+++ b/config.c
@@ -260,7 +260,8 @@ static int include_by_gitdir(const struct config_options *opts,
 done:
 	strbuf_release(&pattern);
 	strbuf_release(&text);
-	wildmatch_free(code);
+	if (code)
+		wildmatch_free(code);
 	return ret;
 }
 

though arguably wildmatch_free() should be taught to handle NULL.

-Peff
