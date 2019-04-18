Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D24F20248
	for <e@80x24.org>; Thu, 18 Apr 2019 21:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbfDRVRl (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 17:17:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:34416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728531AbfDRVRk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 17:17:40 -0400
Received: (qmail 5585 invoked by uid 109); 18 Apr 2019 21:17:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Apr 2019 21:17:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4671 invoked by uid 111); 18 Apr 2019 21:18:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Apr 2019 17:18:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2019 17:17:38 -0400
Date:   Thu, 18 Apr 2019 17:17:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 2/3] untracked-cache: simplify parsing by dropping "next"
Message-ID: <20190418211738.GB18520@sigill.intra.peff.net>
References: <20190418211408.GA18011@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418211408.GA18011@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we parse an on-disk untracked cache, we have two pointers, "data"
and "next". As we parse, we point "next" to the end of an element, and
then later update "data" to match.

But we actually don't need two pointers. Each parsing step can just
update "data" directly from other variables we hold (and we don't have
to worry about bailing in an intermediate state, since any parsing
failure causes us to immediately discard "data" and return).

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/dir.c b/dir.c
index 7b0513c476..17865f44df 100644
--- a/dir.c
+++ b/dir.c
@@ -2732,50 +2732,44 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 			struct read_data *rd)
 {
 	struct untracked_cache_dir ud, *untracked;
-	const unsigned char *next, *data = rd->data, *end = rd->end;
+	const unsigned char *data = rd->data, *end = rd->end;
 	const unsigned char *eos;
 	unsigned int value;
 	int i, len;
 
 	memset(&ud, 0, sizeof(ud));
 
-	next = data;
-	value = decode_varint(&next);
-	if (next > end)
+	value = decode_varint(&data);
+	if (data > end)
 		return -1;
 	ud.recurse	   = 1;
 	ud.untracked_alloc = value;
 	ud.untracked_nr	   = value;
 	if (ud.untracked_nr)
 		ALLOC_ARRAY(ud.untracked, ud.untracked_nr);
-	data = next;
 
-	next = data;
-	ud.dirs_alloc = ud.dirs_nr = decode_varint(&next);
-	if (next > end)
+	ud.dirs_alloc = ud.dirs_nr = decode_varint(&data);
+	if (data > end)
 		return -1;
 	ALLOC_ARRAY(ud.dirs, ud.dirs_nr);
-	data = next;
 
 	eos = memchr(data, '\0', end - data);
 	if (!eos || eos == end)
 		return -1;
 	len = eos - data;
-	next = eos + 1;
 
 	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), len, 1));
 	memcpy(untracked, &ud, sizeof(ud));
 	memcpy(untracked->name, data, len + 1);
-	data = next;
+	data = eos + 1;
 
 	for (i = 0; i < untracked->untracked_nr; i++) {
 		eos = memchr(data, '\0', end - data);
 		if (!eos || eos == end)
 			return -1;
 		len = eos - data;
-		next = eos + 1;
 		untracked->untracked[i] = xmemdupz(data, len);
-		data = next;
+		data = eos + 1;
 	}
 
 	rd->ucd[rd->index++] = untracked;
-- 
2.21.0.1092.g8b0302e9c4

