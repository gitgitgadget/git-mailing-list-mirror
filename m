Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB8F20A17
	for <e@80x24.org>; Tue, 24 Jan 2017 00:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdAXAjt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 19:39:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:43552 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751937AbdAXAjr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 19:39:47 -0500
Received: (qmail 9500 invoked by uid 109); 24 Jan 2017 00:39:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 00:39:47 +0000
Received: (qmail 2339 invoked by uid 111); 24 Jan 2017 00:40:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 19:40:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jan 2017 19:39:45 -0500
Date:   Mon, 23 Jan 2017 19:39:45 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/12] for_each_alternate_ref: stop trimming trailing slashes
Message-ID: <20170124003944.hbaftn7zkflm7vu7@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The real_pathdup() function will have removed extra slashes
for us already (on top of the normalize_path() done when we
created the alternate_object_database struct in the first
place).

Incidentally, this also fixes the case where the path is
just "/", which would read off the start of the array.
That doesn't seem possible to trigger in practice, though,
as link_alt_odb_entry() blindly eats trailing slashes,
including a bare "/".

Signed-off-by: Jeff King <peff@peff.net>
---
I think the "/" thing in link_alt_odb_entry() is buggy, and it's an easy
one-liner fix.  But I notice some of the rest of the code isn't ready to
handle "/" (mostly it just duplicates "/" when appending to the path),
so I left it for now (and I doubt anybody cares anyway).

 transport.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/transport.c b/transport.c
index 74d0e45bd..6b4b3ed31 100644
--- a/transport.c
+++ b/transport.c
@@ -1219,8 +1219,6 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 		return 0;
 	len = strlen(other);
 
-	while (other[len-1] == '/')
-		other[--len] = '\0';
 	if (len < 8 || memcmp(other + len - 8, "/objects", 8))
 		goto out;
 	/* Is this a git repository with refs? */
-- 
2.11.0.765.g454d2182f

