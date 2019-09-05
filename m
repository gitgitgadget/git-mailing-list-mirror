Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB401F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbfIEWud (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:50:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:41390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727213AbfIEWud (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:50:33 -0400
Received: (qmail 10298 invoked by uid 109); 5 Sep 2019 22:50:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 22:50:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32425 invoked by uid 111); 5 Sep 2019 22:52:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 18:52:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 18:50:31 -0400
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: [PATCH 1/6] git-am: handle missing "author" when parsing commit
Message-ID: <20190905225031.GA25657@sigill.intra.peff.net>
References: <20190905224859.GA28660@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190905224859.GA28660@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We try to parse the "author" line out of a commit buffer. We handle the
case that split_ident_line() doesn't work, but we don't do any error
checking that we found an "author" line in the first place! This would
cause us to segfault on such a corrupt object.

Let's put in an explicit NULL check (we can just die(), which is what a
bogus split would do, too). As a bonus, this silences a warning when
compiling with gcc 9.2.1 using "-flto -O3", which claims that ident_len
may be uninitialized (it would only be if we had a NULL here).

Reported-by: Stephan Beyer <s-beyer@gmx.net>
Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1aea657a7f..ee7305eaa6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1272,7 +1272,9 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 	buffer = logmsg_reencode(commit, NULL, get_commit_output_encoding());
 
 	ident_line = find_commit_header(buffer, "author", &ident_len);
-
+	if (!ident_line)
+		die(_("missing author line in commit %s"),
+		      oid_to_hex(&commit->object.oid));
 	if (split_ident_line(&id, ident_line, ident_len) < 0)
 		die(_("invalid ident line: %.*s"), (int)ident_len, ident_line);
 
-- 
2.23.0.463.g883b23b1c5

