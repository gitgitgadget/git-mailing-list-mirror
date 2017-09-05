Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02A0208E4
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbdIEMOY (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:57132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751129AbdIEMOV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:21 -0400
Received: (qmail 31258 invoked by uid 109); 5 Sep 2017 12:14:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12191 invoked by uid 111); 5 Sep 2017 12:14:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:14:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:19 -0400
Date:   Tue, 5 Sep 2017 08:14:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/20] setup_temporary_shallow: move tempfile struct into
 function
Message-ID: <20170905121419.kghzrffwgvuvrwaf@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The setup_temporary_shallow() function creates a temporary
file, but we never access the tempfile struct outside of the
function. This is OK, since it means we'll just clean up the
tempfile on exit.  But we can simplify the code a bit by
moving the global tempfile struct to the only function in
which it's used.

Note that it must remain "static" due to tempfile.c's
requirement that tempfile storage never goes away until
program exit.

Signed-off-by: Jeff King <peff@peff.net>
---
 shallow.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/shallow.c b/shallow.c
index 29194b475a..c7fd68ace0 100644
--- a/shallow.c
+++ b/shallow.c
@@ -286,22 +286,21 @@ int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 	return write_shallow_commits_1(out, use_pack_protocol, extra, 0);
 }
 
-static struct tempfile temporary_shallow;
-
 const char *setup_temporary_shallow(const struct oid_array *extra)
 {
+	static struct tempfile temp;
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
 	if (write_shallow_commits(&sb, 0, extra)) {
-		fd = xmks_tempfile(&temporary_shallow, git_path("shallow_XXXXXX"));
+		fd = xmks_tempfile(&temp, git_path("shallow_XXXXXX"));
 
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  get_tempfile_path(&temporary_shallow));
-		close_tempfile(&temporary_shallow);
+				  get_tempfile_path(&temp));
+		close_tempfile(&temp);
 		strbuf_release(&sb);
-		return get_tempfile_path(&temporary_shallow);
+		return get_tempfile_path(&temp);
 	}
 	/*
 	 * is_repository_shallow() sees empty string as "no shallow
-- 
2.14.1.721.gc5bc1565f1

