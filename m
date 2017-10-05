Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9DD2036C
	for <e@80x24.org>; Thu,  5 Oct 2017 05:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdJEF7z (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 01:59:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:33060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751116AbdJEF7y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 01:59:54 -0400
Received: (qmail 7497 invoked by uid 109); 5 Oct 2017 05:59:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 05:59:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24406 invoked by uid 111); 5 Oct 2017 05:59:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 01:59:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 01:59:52 -0400
Date:   Thu, 5 Oct 2017 01:59:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] sha1_loose_object_info: handle errors from unpack_sha1_rest
Message-ID: <20171005055952.t5ef7hyolyevoj3d@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a caller of sha1_object_info_extended() sets the
"contentp" field in object_info, we call unpack_sha1_rest()
but do not check whether it signaled an error.

This causes two problems:

  1. We pass back NULL to the caller via the contentp field,
     but the function returns "0" for success. A caller
     might reasonably expect after a successful return that
     it can access contentp without a NULL check and
     segfault.

     As it happens, this is impossible to trigger in the
     current code. There is exactly one caller which uses
     contentp, read_object(). And the only thing it does
     after a successful call is to return the content
     pointer to its caller, using NULL as a sentinel for
     errors. So in effect it converts the success code from
     sha1_object_info_extended() back into an error!

     But this is still worth addressing avoid problems for
     future users of "contentp".

  2. Callers of unpack_sha1_rest() are expected to close the
     zlib stream themselves on error. Which means that we're
     leaking the stream.

The problem in (1) comes from from c84a1f3ed4 (sha1_file:
refactor read_object, 2017-06-21), which added the contentp
field.  Before that, we called unpack_sha1_rest() via
unpack_sha1_file(), which directly used the NULL to signal
an error.

But note that the leak in (2) is actually older than that.
The original unpack_sha1_file() directly returned the result
of unpack_sha1_rest() to its caller, when it should have
been closing the zlib stream itself on error.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 09ad64ce55..10c3a0083d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1124,10 +1124,14 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 
-	if (status >= 0 && oi->contentp)
+	if (status >= 0 && oi->contentp) {
 		*oi->contentp = unpack_sha1_rest(&stream, hdr,
 						 *oi->sizep, sha1);
-	else
+		if (!*oi->contentp) {
+			git_inflate_end(&stream);
+			status = -1;
+		}
+	} else
 		git_inflate_end(&stream);
 
 	munmap(map, mapsize);
-- 
2.14.2.1117.g65a3442612
