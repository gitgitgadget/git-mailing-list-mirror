Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796D0C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 15:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4146C608FE
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 15:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbhD1Poy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:44:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:38232 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241197AbhD1PnT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 11:43:19 -0400
Received: (qmail 8932 invoked by uid 109); 28 Apr 2021 15:42:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Apr 2021 15:42:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 698 invoked by uid 111); 28 Apr 2021 15:42:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Apr 2021 11:42:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Apr 2021 11:42:30 -0400
From:   Jeff King <peff@peff.net>
To:     David Emett <dave@sp4m.net>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 1/2] pack-bitmap: clean up include_check after use
Message-ID: <YImCZpLA0TjAkU9/@coredump.intra.peff.net>
References: <YImCNXC5DUvy5gT8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YImCNXC5DUvy5gT8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a bitmap walk has to traverse (to fill in non-bitmapped objects),
we use rev_info's include_check mechanism to let us stop the traversal
early. But after setting the function and its data parameter, we never
clean it up. This means that if the rev_info is used for a subsequent
traversal without bitmaps, it will unexpectedly call into our
include_check function (worse, it will do so pointing to a now-defunct
stack variable in include_check_data, likely resulting in a segfault).

There's no code which does this now, but it's an accident waiting to
happen. Let's clean up after ourselves in the bitmap code.

Reported-by: David Emett <dave@sp4m.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3ed15431cd..f2b59fbf48 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -631,6 +631,9 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		traverse_commit_list_filtered(filter, revs,
 					      show_commit, show_object,
 					      &show_data, NULL);
+
+		revs->include_check = NULL;
+		revs->include_check_data = NULL;
 	}
 
 	return base;
-- 
2.31.1.791.g8400859cdc

