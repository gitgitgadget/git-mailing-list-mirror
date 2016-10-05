Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BCED1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 14:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbcJEO3d (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 10:29:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:52757 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbcJEO3c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 10:29:32 -0400
Received: (qmail 23044 invoked by uid 109); 5 Oct 2016 14:29:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 14:29:31 +0000
Received: (qmail 17545 invoked by uid 111); 5 Oct 2016 14:29:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 10:29:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Oct 2016 10:29:29 -0400
Date:   Wed, 5 Oct 2016 10:29:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] clone: detect errors in normalize_path_copy
Message-ID: <20161005142929.l7fy3jxkme4iwunc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are copying the alternates from the source
repository, if we find a relative path that is too deep for
the source (e.g., "../../../objects" from "/repo.git/objects"),
then normalize_path_copy will report an error and leave
trash in the buffer, which we will add to our new alternates
file. Instead, let's detect the error, print a warning, and
skip copying that alternate.

There's no need to die. The relative path is probably just
broken cruft in the source repo. If it turns out to have
been important for accessing some objects, we rely on other
parts of the clone to detect that, just as they would with a
missing object in the source repo itself (though note that
clones with "-s" are inherently local, which may do fewer
object-quality checks in the first place).

Signed-off-by: Jeff King <peff@peff.net>
---
Noticed by coverity; the recent alternates cleanups mean that all of the
other calls to normalize_path_copy() are now checked, so it realized
this one was an oddball and probably an error (I actually looked for
others with `grep` when doing that series, but somehow missed this one;
hooray for static analysis). The fix is independent of that series.

 builtin/clone.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index fb75f7e..6cf3b54 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -345,8 +345,11 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 			continue;
 		}
 		abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
-		normalize_path_copy(abs_path, abs_path);
-		add_to_alternates_file(abs_path);
+		if (!normalize_path_copy(abs_path, abs_path))
+			add_to_alternates_file(abs_path);
+		else
+			warning("skipping invalid relative alternate: %s/%s",
+				src_repo, line.buf);
 		free(abs_path);
 	}
 	strbuf_release(&line);
-- 
2.10.1.506.g904834d
