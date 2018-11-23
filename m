Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672131F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 11:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405348AbeKWWBI (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 17:01:08 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:17414 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403798AbeKWWBH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 17:01:07 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id Q9SMg52vNwhzSQ9SVg6d2J; Fri, 23 Nov 2018 11:17:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542971836;
        bh=t6wU0boC7ClCNA7+n6LOGDKGiaUZMrt/atn0odNJ3cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=UPqrSVp9A5l46MK1DhD+CmBgFG06Hq09TgKn6pJrIo61evANgDkCxMxP9wQnuUR9p
         4mUSoh7nAqRfqXP759HFUTavbb/I6q7UhnaLolQBTnvF6mMhXwAaaKWin2NXhQi8bj
         lqFDB0R3vq+r4cX7gFdtz253XSvDsBiqKG5O6v2A=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=y_CGkvlsz7gVS21YNtIA:9
 a=lscoNs9zkJFjLRpE:21 a=Zz04NpX7QAiYgEuK:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 7/9] diff --color-moved-ws: optimize allow-indentation-change
Date:   Fri, 23 Nov 2018 11:16:56 +0000
Message-Id: <20181123111658.30342-8-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123111658.30342-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181123111658.30342-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD2OUQI8mOdIL/FtT3wDKWInQkyalcUDJe3osrTN8QUBZPvEaCzi0FCNSkBNQmUBPEH0zUMXwJRRKkq2fi+a6t7TgdUf2kECWog5HecGSOstWDX+CJKW
 04/jvXC+0ik+M9rWC9O6RZJvFX2ptx/lYxj0gk1qVWsgQNVhgyTdP1RUUmf2aRheC+RAlygLKFgEuXTK0ZWNwEB6cS5LtH7X12fpAwEpJUGv6rfkdYycbwzE
 z5shRedDKRKbTM38v6DnnPTCMwGck+AJ1KdFHjhqn54QuvuZ+IvJRD4YFg6HyW1j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When running

  git diff --color-moved-ws=allow-indentation-change v2.18.0 v2.19.0

cmp_in_block_with_wsd() is called 694908327 times. Of those 42.7%
return after comparing a and b. By comparing the lengths first we can
return early in all but 0.03% of those cases without dereferencing the
string pointers. The comparison between a and c fails in 6.8% of
calls, by comparing the lengths first we reject all the failing calls
without dereferencing the string pointers.

This reduces the time to run the command above by by 42% from 14.6s to
8.5s. This is still much slower than the normal --color-moved which
takes ~0.6-0.7s to run but is a significant improvement.

The next commits will replace the current implementation with one that
works with mixed tabs and spaces in the indentation. I think it is
worth optimizing the current implementation first to enable a fair
comparison between the two implementations.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 8c08dd68df..c378ce3daf 100644
--- a/diff.c
+++ b/diff.c
@@ -829,20 +829,23 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 				 int n)
 {
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
-	int al = cur->es->len, cl = l->len;
+	int al = cur->es->len, bl = match->es->len, cl = l->len;
 	const char *a = cur->es->line,
 		   *b = match->es->line,
 		   *c = l->line;
-
+	const char *orig_a = a;
 	int wslen;
 
 	/*
-	 * We need to check if 'cur' is equal to 'match'.
-	 * As those are from the same (+/-) side, we do not need to adjust for
-	 * indent changes. However these were found using fuzzy matching
-	 * so we do have to check if they are equal.
+	 * We need to check if 'cur' is equal to 'match'.  As those
+	 * are from the same (+/-) side, we do not need to adjust for
+	 * indent changes. However these were found using fuzzy
+	 * matching so we do have to check if they are equal. Here we
+	 * just check the lengths. We delay calling memcmp() to check
+	 * the contents until later as if the length comparison for a
+	 * and c fails we can avoid the call all together.
 	 */
-	if (strcmp(a, b))
+	if (al != bl)
 		return 1;
 
 	if (!pmb->wsd.string)
@@ -870,7 +873,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 		al -= wslen;
 	}
 
-	if (al != cl || memcmp(a, c, al))
+	if (al != cl || memcmp(orig_a, b, bl) || memcmp(a, c, al))
 		return 1;
 
 	return 0;
-- 
2.19.1.1690.g258b440b18

