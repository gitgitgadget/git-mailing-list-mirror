Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D841E20248
	for <e@80x24.org>; Thu, 18 Apr 2019 21:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbfDRVRE (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 17:17:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:34404 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731565AbfDRVRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 17:17:04 -0400
Received: (qmail 5556 invoked by uid 109); 18 Apr 2019 21:17:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Apr 2019 21:17:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4651 invoked by uid 111); 18 Apr 2019 21:17:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Apr 2019 17:17:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2019 17:17:02 -0400
Date:   Thu, 18 Apr 2019 17:17:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 1/3] untracked-cache: be defensive about missing NULs in index
Message-ID: <20190418211701.GA18520@sigill.intra.peff.net>
References: <20190418211408.GA18011@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418211408.GA18011@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The on-disk format for the untracked-cache extension contains
NUL-terminated filenames. We parse these from the mmap'd file using
string functions like strlen(). This works fine in the normal case, but
if we see a malformed or corrupted index, we might read off the end of
our mmap.

Instead, let's use memchr() to find the trailing NUL within the bytes we
know are available, and return an error if it's missing.

Note that we can further simplify by folding another range check into
our conditional. After we find the end of the string, we set "next" to
the byte after the string and treat it as an error if there are no such
bytes left. That saves us from having to do a range check at the
beginning of each subsequent string (and works because there is always
data after each string). We can do both range checks together by
checking "!eos" (we didn't find a NUL) and "eos == end" (it was on the
last available byte, meaning there's nothing after). This replaces the
existing "next > end" checks.

Note also that the decode_varint() calls have a similar problem (we
don't even pass them "end"; they just keep parsing). These are probably
OK in practice since varints have a finite length (we stop parsing when
we'd overflow a uintmax_t), so the worst case is that we'd overflow into
reading the trailing bytes of the index.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index f5293a6536..7b0513c476 100644
--- a/dir.c
+++ b/dir.c
@@ -2733,6 +2733,7 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 {
 	struct untracked_cache_dir ud, *untracked;
 	const unsigned char *next, *data = rd->data, *end = rd->end;
+	const unsigned char *eos;
 	unsigned int value;
 	int i, len;
 
@@ -2756,21 +2757,24 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	ALLOC_ARRAY(ud.dirs, ud.dirs_nr);
 	data = next;
 
-	len = strlen((const char *)data);
-	next = data + len + 1;
-	if (next > rd->end)
+	eos = memchr(data, '\0', end - data);
+	if (!eos || eos == end)
 		return -1;
+	len = eos - data;
+	next = eos + 1;
+
 	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), len, 1));
 	memcpy(untracked, &ud, sizeof(ud));
 	memcpy(untracked->name, data, len + 1);
 	data = next;
 
 	for (i = 0; i < untracked->untracked_nr; i++) {
-		len = strlen((const char *)data);
-		next = data + len + 1;
-		if (next > rd->end)
+		eos = memchr(data, '\0', end - data);
+		if (!eos || eos == end)
 			return -1;
-		untracked->untracked[i] = xstrdup((const char*)data);
+		len = eos - data;
+		next = eos + 1;
+		untracked->untracked[i] = xmemdupz(data, len);
 		data = next;
 	}
 
-- 
2.21.0.1092.g8b0302e9c4

