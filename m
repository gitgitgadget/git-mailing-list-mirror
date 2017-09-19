Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DD52047F
	for <e@80x24.org>; Tue, 19 Sep 2017 19:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdISTlO (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:41:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:43904 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751074AbdISTlM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:41:12 -0400
Received: (qmail 11288 invoked by uid 109); 19 Sep 2017 19:41:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 19:41:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7265 invoked by uid 111); 19 Sep 2017 19:41:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 15:41:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Sep 2017 15:41:10 -0400
Date:   Tue, 19 Sep 2017 15:41:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/2] read_info_alternates: warn on non-trivial errors
Message-ID: <20170919194110.ngmgrlph3ffadvoj@sigill.intra.peff.net>
References: <20170919194044.3prgaxd4sqandy75@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919194044.3prgaxd4sqandy75@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we fail to open $GIT_DIR/info/alternates, we silently
assume there are no alternates. This is the right thing to
do for ENOENT, but not for other errors.

A hard error is probably overkill here. If we fail to read
an alternates file then either we'll complete our operation
anyway, or we'll fail to find some needed object. Either
way, a warning is good idea. And we already have a helper
function to handle this pattern; let's just call
warn_on_fopen_error().

Note that technically the errno from strbuf_read_file()
might be from a read() error, not open(). But since read()
would never return ENOENT or ENOTDIR, and since it produces
a generic "unable to access" error, it's suitable for
handling errors from either.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sha1_file.c b/sha1_file.c
index b682b7ec06..1477ea7b50 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -432,6 +432,7 @@ static void read_info_alternates(const char * relative_base, int depth)
 
 	path = xstrfmt("%s/info/alternates", relative_base);
 	if (strbuf_read_file(&buf, path, 1024) < 0) {
+		warn_on_fopen_errors(path);
 		free(path);
 		return;
 	}
-- 
2.14.1.1014.g252e627ae0
