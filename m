Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682E320229
	for <e@80x24.org>; Sat, 22 Oct 2016 04:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbcJVE7l (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 00:59:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:32794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbcJVE7l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 00:59:41 -0400
Received: (qmail 12695 invoked by uid 109); 22 Oct 2016 04:59:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 04:59:40 +0000
Received: (qmail 9437 invoked by uid 111); 22 Oct 2016 05:00:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 01:00:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Oct 2016 00:59:38 -0400
Date:   Sat, 22 Oct 2016 00:59:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] daemon: detect and reject too-long paths
Message-ID: <20161022045938.h3xa3yapzlg427vy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are checking the path via path_ok(), we use some
fixed PATH_MAX buffers. We write into them via snprintf(),
so there's no possibility of overflow, but it does mean we
may silently truncate the path, leading to potentially
confusing errors when the partial path does not exist.

We're better off to reject the path explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
Another option would be to switch to strbufs here. That potentially
introduces cases where a client can convince us to just keep allocating
memory, but I don't think so in practice; the paths and interpolated
data items all have to come in 64K pkt-lines, which places a hard
limit. This is a much more minimal change, though, and I don't hear
anybody complaining about the inability to use large paths.

 daemon.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 425aad0507..ff0fa583b0 100644
--- a/daemon.c
+++ b/daemon.c
@@ -160,6 +160,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 {
 	static char rpath[PATH_MAX];
 	static char interp_path[PATH_MAX];
+	size_t rlen;
 	const char *path;
 	const char *dir;
 
@@ -187,8 +188,12 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 			namlen = slash - dir;
 			restlen -= namlen;
 			loginfo("userpath <%s>, request <%s>, namlen %d, restlen %d, slash <%s>", user_path, dir, namlen, restlen, slash);
-			snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
-				 namlen, dir, user_path, restlen, slash);
+			rlen = snprintf(rpath, sizeof(rpath), "%.*s/%s%.*s",
+					namlen, dir, user_path, restlen, slash);
+			if (rlen >= sizeof(rpath)) {
+				logerror("user-path too large: %s", rpath);
+				return NULL;
+			}
 			dir = rpath;
 		}
 	}
@@ -207,7 +212,15 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 
 		strbuf_expand(&expanded_path, interpolated_path,
 			      expand_path, &context);
-		strlcpy(interp_path, expanded_path.buf, PATH_MAX);
+
+		rlen = strlcpy(interp_path, expanded_path.buf,
+			       sizeof(interp_path));
+		if (rlen >= sizeof(interp_path)) {
+			logerror("interpolated path too large: %s",
+				 interp_path);
+			return NULL;
+		}
+
 		strbuf_release(&expanded_path);
 		loginfo("Interpolated dir '%s'", interp_path);
 
@@ -219,7 +232,11 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 			logerror("'%s': Non-absolute path denied (base-path active)", dir);
 			return NULL;
 		}
-		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
+		rlen = snprintf(rpath, sizeof(rpath), "%s%s", base_path, dir);
+		if (rlen >= sizeof(rpath)) {
+			logerror("base-path too large: %s", rpath);
+			return NULL;
+		}
 		dir = rpath;
 	}
 
-- 
2.10.1.776.ge0e381e
