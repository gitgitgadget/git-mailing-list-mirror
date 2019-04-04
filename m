Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915BA20248
	for <e@80x24.org>; Thu,  4 Apr 2019 23:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfDDX2o (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 19:28:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:47434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727039AbfDDX2o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 19:28:44 -0400
Received: (qmail 1501 invoked by uid 109); 4 Apr 2019 23:28:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 23:28:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20477 invoked by uid 111); 4 Apr 2019 23:29:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 19:29:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 19:28:42 -0400
Date:   Thu, 4 Apr 2019 19:28:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/12] server-info: use strbuf to read old info/packs file
Message-ID: <20190404232842.GH21839@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404232104.GA27770@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This old code uses fgets with a fixed-size buffer. Let's use a strbuf
instead, so we don't have to wonder if "1000" is big enough, or what
happens if we see a long line.

This also lets us drop our custom code to trim the newline.

Probably nobody actually cares about the 1000-char limit (after all, the
lines generally only say "P pack-[0-9a-f]{40}.pack"), so this is mostly
just about cleanup/readability.

Signed-off-by: Jeff King <peff@peff.net>
---
 server-info.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/server-info.c b/server-info.c
index ba44cece7f..d4115fecbb 100644
--- a/server-info.c
+++ b/server-info.c
@@ -131,40 +131,38 @@ static int parse_pack_def(const char *packname, int old_cnt)
 static int read_pack_info_file(const char *infofile)
 {
 	FILE *fp;
-	char line[1000];
+	struct strbuf line = STRBUF_INIT;
 	int old_cnt = 0;
 	int stale = 1;
 
 	fp = fopen_or_warn(infofile, "r");
 	if (!fp)
 		return 1; /* nonexistent is not an error. */
 
-	while (fgets(line, sizeof(line), fp)) {
+	while (strbuf_getline(&line, fp) != EOF) {
 		const char *arg;
-		int len = strlen(line);
-		if (len && line[len-1] == '\n')
-			line[--len] = 0;
 
-		if (!len)
+		if (!line.len)
 			continue;
 
-		if (skip_prefix(line, "P ", &arg)) {
+		if (skip_prefix(line.buf, "P ", &arg)) {
 			/* P name */
 			if (parse_pack_def(arg, old_cnt++))
 				goto out_stale;
-		} else if (line[0] == 'D') {
+		} else if (line.buf[0] == 'D') {
 			/* we used to emit D but that was misguided. */
 			goto out_stale;
-		} else if (line[0] == 'T') {
+		} else if (line.buf[0] == 'T') {
 			/* we used to emit T but nobody uses it. */
 			goto out_stale;
 		} else {
-			error("unrecognized: %s", line);
+			error("unrecognized: %s", line.buf);
 		}
 	}
 	stale = 0;
 
  out_stale:
+	strbuf_release(&line);
 	fclose(fp);
 	return stale;
 }
-- 
2.21.0.714.gd1be1d035b

