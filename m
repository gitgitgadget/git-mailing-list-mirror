Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5DD1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 20:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbdBHU7e (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:59:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:51774 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751217AbdBHU7e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:59:34 -0500
Received: (qmail 28368 invoked by uid 109); 8 Feb 2017 20:52:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:52:53 +0000
Received: (qmail 5623 invoked by uid 111); 8 Feb 2017 20:52:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:52:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 15:52:50 -0500
Date:   Wed, 8 Feb 2017 15:52:50 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/11] for_each_alternate_ref: stop trimming trailing
 slashes
Message-ID: <20170208205250.kon3zogep7prmui6@sigill.intra.peff.net>
References: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
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
 transport.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/transport.c b/transport.c
index 9ce0ee96b..6fba9e95b 100644
--- a/transport.c
+++ b/transport.c
@@ -1226,8 +1226,6 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 		return 0;
 	len = strlen(other);
 
-	while (other[len-1] == '/')
-		other[--len] = '\0';
 	if (len < 8 || memcmp(other + len - 8, "/objects", 8))
 		goto out;
 	/* Is this a git repository with refs? */
-- 
2.12.0.rc0.371.ga6cf8653b

