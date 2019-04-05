Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3483A20248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfDESNM (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:13:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:48730 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728683AbfDESNM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:13:12 -0400
Received: (qmail 11329 invoked by uid 109); 5 Apr 2019 18:13:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:13:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28335 invoked by uid 111); 5 Apr 2019 18:13:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:13:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:13:10 -0400
Date:   Fri, 5 Apr 2019 14:13:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 08/13] server-info: fix blind pointer arithmetic
Message-ID: <20190405181310.GH32243@sigill.intra.peff.net>
References: <20190405180306.GA21113@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405180306.GA21113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're writing out a new objects/info/packs file, we read back the
old one to try to keep the ordering the same. When we see a line
starting with "P", we expect "P pack-1234..." and blindly jump to "line
+ 2" to parse the pack name. If we saw a line with _just_ "P" and
nothing else, we'd jump past the end of the buffer and start reading
arbitrary memory.

This shouldn't be a big attack vector, as the files are local to the
repository and written by us, but it's clearly worth fixing (we do read
remote copies of the file for dumb-http fetches, but using a totally
different parser!).

Let's instead use skip_prefix() here, which avoids pointer arithmetic
altogether. Note that this converts our switch statement to an if/else
chain, making it slightly more verbose. But it will also make it easier
to do a few follow-on cleanups.

Signed-off-by: Jeff King <peff@peff.net>
---
 server-info.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/server-info.c b/server-info.c
index e2b2d6a27a..b61a6be4c2 100644
--- a/server-info.c
+++ b/server-info.c
@@ -112,9 +112,9 @@ static struct pack_info *find_pack_by_name(const char *name)
 /* Returns non-zero when we detect that the info in the
  * old file is useless.
  */
-static int parse_pack_def(const char *line, int old_cnt)
+static int parse_pack_def(const char *packname, int old_cnt)
 {
-	struct pack_info *i = find_pack_by_name(line + 2);
+	struct pack_info *i = find_pack_by_name(packname);
 	if (i) {
 		i->old_num = old_cnt;
 		return 0;
@@ -139,24 +139,26 @@ static int read_pack_info_file(const char *infofile)
 		return 1; /* nonexistent is not an error. */
 
 	while (fgets(line, sizeof(line), fp)) {
+		const char *arg;
 		int len = strlen(line);
 		if (len && line[len-1] == '\n')
 			line[--len] = 0;
 
 		if (!len)
 			continue;
 
-		switch (line[0]) {
-		case 'P': /* P name */
-			if (parse_pack_def(line, old_cnt++))
+		if (skip_prefix(line, "P ", &arg)) {
+			/* P name */
+			if (parse_pack_def(arg, old_cnt++))
 				goto out_stale;
-			break;
-		case 'D': /* we used to emit D but that was misguided. */
-		case 'T': /* we used to emit T but nobody uses it. */
+		} else if (line[0] == 'D') {
+			/* we used to emit D but that was misguided. */
 			goto out_stale;
-		default:
+		} else if (line[0] == 'T') {
+			/* we used to emit T but nobody uses it. */
+			goto out_stale;
+		} else {
 			error("unrecognized: %s", line);
-			break;
 		}
 	}
 	fclose(fp);
-- 
2.21.0.729.g7d31bf3764

