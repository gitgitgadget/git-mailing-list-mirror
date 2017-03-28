Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20621FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755030AbdC1TqA (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:46:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:53154 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752637AbdC1TqA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:46:00 -0400
Received: (qmail 11723 invoked by uid 109); 28 Mar 2017 19:45:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:45:54 +0000
Received: (qmail 1961 invoked by uid 111); 28 Mar 2017 19:46:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:46:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:45:52 -0400
Date:   Tue, 28 Mar 2017 15:45:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/18] odb_mkstemp: use git_path_buf
Message-ID: <20170328194551.w2y34j4kc2qd45vy@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since git_path_buf() is smart enough to replace "objects/"
with the correct object path, we can use it instead of
manually assembling the path. That's slightly shorter, and
will clean up any non-canonical bits in the path.

Signed-off-by: Jeff King <peff@peff.net>
---
 environment.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/environment.c b/environment.c
index 88276790d..a9bf5658a 100644
--- a/environment.c
+++ b/environment.c
@@ -282,16 +282,14 @@ int odb_mkstemp(struct strbuf *template, const char *pattern)
 	 * restrictive except to remove write permission.
 	 */
 	int mode = 0444;
-	strbuf_reset(template);
-	strbuf_addf(template, "%s/%s", get_object_directory(), pattern);
+	git_path_buf(template, "objects/%s", pattern);
 	fd = git_mkstemp_mode(template->buf, mode);
 	if (0 <= fd)
 		return fd;
 
 	/* slow path */
 	/* some mkstemp implementations erase template on failure */
-	strbuf_reset(template);
-	strbuf_addf(template, "%s/%s", get_object_directory(), pattern);
+	git_path_buf(template, "objects/%s", pattern);
 	safe_create_leading_directories(template->buf);
 	return xmkstemp_mode(template->buf, mode);
 }
-- 
2.12.2.845.g55fcf8b10

