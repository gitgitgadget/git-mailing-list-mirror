Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39AE202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 20:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966253AbdIYU3v (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 16:29:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:49606 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966239AbdIYU3u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 16:29:50 -0400
Received: (qmail 2440 invoked by uid 109); 25 Sep 2017 20:29:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 20:29:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28527 invoked by uid 111); 25 Sep 2017 20:30:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 16:30:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 16:29:48 -0400
Date:   Mon, 25 Sep 2017 16:29:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/7] get-tar-commit-id: prefer "!=" for read_in_full() error
 check
Message-ID: <20170925202947.u6onp66ztliyxjcj@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Comparing the result of read_in_full() using less-than is
potentially dangerous, as discussed in 561598cfcf
(read_pack_header: handle signed/unsigned comparison in read
result, 2017-09-13).

The instance in get-tar-commit-id is OK, because the
HEADERSIZE macro expands to a signed integer. But if it were
switched to an unsigned type like:

  size_t HEADERSIZE = ...;

this would be a bug. Let's use the more robust "!="
construct.

We can also drop the useless "n" variable while we're at it.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/get-tar-commit-id.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 6d9a79f9b3..259ad40339 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -20,14 +20,12 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	struct ustar_header *header = (struct ustar_header *)buffer;
 	char *content = buffer + RECORDSIZE;
 	const char *comment;
-	ssize_t n;
 
 	if (argc != 1)
 		usage(builtin_get_tar_commit_id_usage);
 
-	n = read_in_full(0, buffer, HEADERSIZE);
-	if (n < HEADERSIZE)
-		die("git get-tar-commit-id: read error");
+	if (read_in_full(0, buffer, HEADERSIZE) != HEADERSIZE)
+		die_errno("git get-tar-commit-id: read error");
 	if (header->typeflag[0] != 'g')
 		return 1;
 	if (!skip_prefix(content, "52 comment=", &comment))
-- 
2.14.1.1148.ga2561536a1

