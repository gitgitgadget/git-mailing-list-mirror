Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD7720281
	for <e@80x24.org>; Wed, 27 Sep 2017 06:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbdI0GRj (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:17:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:51624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750739AbdI0GRi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:17:38 -0400
Received: (qmail 25959 invoked by uid 109); 27 Sep 2017 06:17:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 06:17:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11650 invoked by uid 111); 27 Sep 2017 06:18:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:18:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:17:36 -0400
Date:   Wed, 27 Sep 2017 02:17:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] validate_headref: use get_oid_hex for detached HEADs
Message-ID: <20170927061736.reeavh5r3tyqovbc@sigill.intra.peff.net>
References: <20170927061644.gwlhxaiairiy2njp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927061644.gwlhxaiairiy2njp@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a candidate HEAD isn't a symref, we check that it
contains a viable sha1. But in a post-sha1 world, we should
be checking whether it has any plausible object-id.

We can do that by switching to get_oid_hex().

Note that both before and after this patch, we only check
for a plausible object id at the start of the file, and then
call that good enough.  We ignore any content _after_ the
hex, so a string like:

  0123456789012345678901234567890123456789 foo

is accepted. Though we do put extra bytes like this into
some pseudorefs (e.g., FETCH_HEAD), we don't typically do so
with HEAD. We could tighten this up by using parse_oid_hex(),
like:

  if (!parse_oid_hex(buffer, &oid, &end) &&
      *end++ == '\n' && *end == '\0')
          return 0;

But we're probably better to remain on the loose side. We're
just checking here for a plausible-looking repository
directory, so heuristics are acceptable (if we really want
to be meticulous, we should use the actual ref code to parse
HEAD).

Signed-off-by: Jeff King <peff@peff.net>
---
 path.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index 2ef3a86613..5aa9244eb2 100644
--- a/path.c
+++ b/path.c
@@ -639,7 +639,7 @@ int validate_headref(const char *path)
 	struct stat st;
 	char buffer[256];
 	const char *refname;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int fd;
 	ssize_t len;
 
@@ -680,7 +680,7 @@ int validate_headref(const char *path)
 	/*
 	 * Is this a detached HEAD?
 	 */
-	if (!get_sha1_hex(buffer, sha1))
+	if (!get_oid_hex(buffer, &oid))
 		return 0;
 
 	return -1;
-- 
2.14.2.988.g01c8b37dde
