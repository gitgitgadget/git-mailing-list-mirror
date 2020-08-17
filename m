Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF81C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14B72065D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgHQVdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:33:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33554 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgHQVdD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:33:03 -0400
Received: (qmail 6680 invoked by uid 109); 17 Aug 2020 21:33:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 21:33:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22252 invoked by uid 111); 17 Aug 2020 21:33:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 17:33:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 17:33:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/7] clear_pattern_list(): clear embedded hashmaps
Message-ID: <20200817213302.GA1854722@coredump.intra.peff.net>
References: <20200817213228.GA1854603@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817213228.GA1854603@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 96cc8ab531 (sparse-checkout: use hashmaps for cone patterns,
2019-11-21) added some auxiliary hashmaps to the pattern_list struct,
but they're leaked when clear_pattern_list() is called.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dir.c b/dir.c
index fe64be30ed..9411b94e9b 100644
--- a/dir.c
+++ b/dir.c
@@ -916,6 +916,8 @@ void clear_pattern_list(struct pattern_list *pl)
 		free(pl->patterns[i]);
 	free(pl->patterns);
 	free(pl->filebuf);
+	hashmap_free_entries(&pl->recursive_hashmap, struct pattern_entry, ent);
+	hashmap_free_entries(&pl->parent_hashmap, struct pattern_entry, ent);
 
 	memset(pl, 0, sizeof(*pl));
 }
-- 
2.28.0.605.g35fde94f44

