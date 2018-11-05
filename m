Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1741D1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeKEQBW (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:01:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:40402 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728985AbeKEQBV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:01:21 -0500
Received: (qmail 21875 invoked by uid 109); 5 Nov 2018 06:43:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:43:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17211 invoked by uid 111); 5 Nov 2018 06:42:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:42:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:43:12 -0500
Date:   Mon, 5 Nov 2018 01:43:12 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/13] tag: mark "--message" option with NONEG
Message-ID: <20181105064312.GI25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not allow "--no-message" to work now, as the option callback
returns "-1" when it sees a NULL arg. However, that will cause
parse-options to exit(129) without printing anything further, leaving
the user confused about what happened.

Instead, let's explicitly mark it as PARSE_OPT_NONEG, which will give a
useful error message (and print the usual -h output).

In theory this could be used to override an earlier "-m", but it's not
clear how it would interact with other message options (e.g., would it
also clear data read for "-F"?). Since it's already disabled and nobody
is asking for it, let's punt on that and just improve the error message.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index f623632186..6a396a5090 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -390,8 +390,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(N_("Tag creation options")),
 		OPT_BOOL('a', "annotate", &annotate,
 					N_("annotated tag, needs a message")),
-		OPT_CALLBACK('m', "message", &msg, N_("message"),
-			     N_("tag message"), parse_msg_arg),
+		{ OPTION_CALLBACK, 'm', "message", &msg, N_("message"),
+		  N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg },
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
-- 
2.19.1.1505.g9cd28186cf

