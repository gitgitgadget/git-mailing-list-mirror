Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE58EC83F29
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 07:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbjHaHTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbjHaHTt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 03:19:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4901A6
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 00:19:46 -0700 (PDT)
Received: (qmail 21398 invoked by uid 109); 31 Aug 2023 07:19:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 07:19:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3528 invoked by uid 111); 31 Aug 2023 07:19:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 03:19:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 03:19:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 7/8] interpret-trailers: mark unused "unset" parameters in
 option callbacks
Message-ID: <20230831071945.GE3197751@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831070935.GA3197495@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few parse-option callbacks that do not look at their "unset"
parameters, but also do not set PARSE_OPT_NONEG. At first glance this
seems like a bug, as we'd ignore "--no-if-exists", etc.

But they do work fine, because when "unset" is true, then "arg" is NULL.
And all three functions pass "arg" on to helper functions which do the
right thing with the NULL.

Note that this shortcut would not be correct if any callback used
PARSE_OPT_NOARG (in which case "arg" would be NULL but "unset" would be
false). But none of these do.

So the code is fine as-is. But we'll want to mark the unused "unset"
parameters to quiet -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/interpret-trailers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 6aadce6a1e..a5f9adf6b9 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -24,19 +24,19 @@ static enum trailer_if_exists if_exists;
 static enum trailer_if_missing if_missing;
 
 static int option_parse_where(const struct option *opt,
-			      const char *arg, int unset)
+			      const char *arg, int unset UNUSED)
 {
 	return trailer_set_where(opt->value, arg);
 }
 
 static int option_parse_if_exists(const struct option *opt,
-				  const char *arg, int unset)
+				  const char *arg, int unset UNUSED)
 {
 	return trailer_set_if_exists(opt->value, arg);
 }
 
 static int option_parse_if_missing(const struct option *opt,
-				   const char *arg, int unset)
+				   const char *arg, int unset UNUSED)
 {
 	return trailer_set_if_missing(opt->value, arg);
 }
-- 
2.42.0.561.gaa987ecc69

