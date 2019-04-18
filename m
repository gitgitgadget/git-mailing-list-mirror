Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA43920305
	for <e@80x24.org>; Thu, 18 Apr 2019 21:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfDRVSh (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 17:18:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:34436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728531AbfDRVSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 17:18:37 -0400
Received: (qmail 5630 invoked by uid 109); 18 Apr 2019 21:18:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Apr 2019 21:18:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4701 invoked by uid 111); 18 Apr 2019 21:19:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Apr 2019 17:19:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2019 17:18:35 -0400
Date:   Thu, 18 Apr 2019 17:18:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 3/3] untracked-cache: simplify parsing by dropping "len"
Message-ID: <20190418211835.GC18520@sigill.intra.peff.net>
References: <20190418211408.GA18011@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418211408.GA18011@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code which parses untracked-cache extensions from disk keeps a "len"
variable, which is the size of the string we are parsing. But since we
now have an "end of string" variable, we can just use that to get the
length when we need it. This eliminates the need to keep "len" up to
date (and removes the possibility of any errors where "len" and "eos"
get out of sync).

As a bonus, it means we are not storing a string length in an "int",
which is a potential source of overflows (though in this case it seems
fairly unlikely for that to cause any memory problems).

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index 17865f44df..60438b2cdc 100644
--- a/dir.c
+++ b/dir.c
@@ -2735,7 +2735,7 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	const unsigned char *data = rd->data, *end = rd->end;
 	const unsigned char *eos;
 	unsigned int value;
-	int i, len;
+	int i;
 
 	memset(&ud, 0, sizeof(ud));
 
@@ -2756,28 +2756,25 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	eos = memchr(data, '\0', end - data);
 	if (!eos || eos == end)
 		return -1;
-	len = eos - data;
 
-	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), len, 1));
+	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), eos - data, 1));
 	memcpy(untracked, &ud, sizeof(ud));
-	memcpy(untracked->name, data, len + 1);
+	memcpy(untracked->name, data, eos - data + 1);
 	data = eos + 1;
 
 	for (i = 0; i < untracked->untracked_nr; i++) {
 		eos = memchr(data, '\0', end - data);
 		if (!eos || eos == end)
 			return -1;
-		len = eos - data;
-		untracked->untracked[i] = xmemdupz(data, len);
+		untracked->untracked[i] = xmemdupz(data, eos - data);
 		data = eos + 1;
 	}
 
 	rd->ucd[rd->index++] = untracked;
 	rd->data = data;
 
 	for (i = 0; i < untracked->dirs_nr; i++) {
-		len = read_one_dir(untracked->dirs + i, rd);
-		if (len < 0)
+		if (read_one_dir(untracked->dirs + i, rd) < 0)
 			return -1;
 	}
 	return 0;
-- 
2.21.0.1092.g8b0302e9c4
