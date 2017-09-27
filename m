Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2B120281
	for <e@80x24.org>; Wed, 27 Sep 2017 06:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750961AbdI0GR3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:17:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:51614 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750858AbdI0GR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:17:29 -0400
Received: (qmail 25951 invoked by uid 109); 27 Sep 2017 06:17:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 06:17:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11621 invoked by uid 111); 27 Sep 2017 06:18:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:18:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:17:26 -0400
Date:   Wed, 27 Sep 2017 02:17:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] validate_headref: use skip_prefix for symref parsing
Message-ID: <20170927061726.gat3ykqx4fdstzq6@sigill.intra.peff.net>
References: <20170927061644.gwlhxaiairiy2njp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927061644.gwlhxaiairiy2njp@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the previous commit guarantees that our symref buffer
is NUL-terminated, we can just use skip_prefix() and friends
to parse it. This is shorter and saves us having to deal
with magic numbers and keeping the "len" counter up to date.

While we're at it, let's name the rather obscure "buf" to
"refname", since that is the thing we are parsing with it.

Signed-off-by: Jeff King <peff@peff.net>
---
 path.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/path.c b/path.c
index 3e4d7505ef..2ef3a86613 100644
--- a/path.c
+++ b/path.c
@@ -637,7 +637,8 @@ void strbuf_git_common_path(struct strbuf *sb,
 int validate_headref(const char *path)
 {
 	struct stat st;
-	char *buf, buffer[256];
+	char buffer[256];
+	const char *refname;
 	unsigned char sha1[20];
 	int fd;
 	ssize_t len;
@@ -669,14 +670,10 @@ int validate_headref(const char *path)
 	/*
 	 * Is it a symbolic ref?
 	 */
-	if (len < 4)
-		return -1;
-	if (!memcmp("ref:", buffer, 4)) {
-		buf = buffer + 4;
-		len -= 4;
-		while (len && isspace(*buf))
-			buf++, len--;
-		if (len >= 5 && !memcmp("refs/", buf, 5))
+	if (skip_prefix(buffer, "ref:", &refname)) {
+		while (isspace(*refname))
+			refname++;
+		if (starts_with(refname, "refs/"))
 			return 0;
 	}
 
-- 
2.14.2.988.g01c8b37dde

