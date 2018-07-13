Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536001F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 19:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbeGMTzz (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 15:55:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:58834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730149AbeGMTzy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 15:55:54 -0400
Received: (qmail 550 invoked by uid 109); 13 Jul 2018 19:39:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Jul 2018 19:39:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6601 invoked by uid 111); 13 Jul 2018 19:39:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 13 Jul 2018 15:39:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2018 15:39:53 -0400
Date:   Fri, 13 Jul 2018 15:39:53 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: [PATCH 1/2] fsck: split ".gitmodules too large" error from parse
 failure
Message-ID: <20180713193952.GA12162@sigill.intra.peff.net>
References: <20180713193759.GB10354@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180713193759.GB10354@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since ed8b10f631 (fsck: check .gitmodules content,
2018-05-02), we'll report a gitmodulesParse error for two
conditions:

  - a .gitmodules entry is not syntactically valid

  - a .gitmodules entry is larger than core.bigFileThreshold

with the intent that we can detect malicious files and
protect downstream clients. E.g., from the issue in
0383bbb901 (submodule-config: verify submodule names as
paths, 2018-04-30).

But these conditions are actually quite different with
respect to that bug:

 - a syntactically invalid file cannot trigger the problem,
   as the victim would barf before hitting the problematic
   code

 - a too-big .gitmodules _can_ trigger the problem. Even
   though it is obviously silly to have a 500MB .gitmodules
   file, the submodule code will happily parse it if you
   have enough memory.

So it may be reasonable to configure their severity
separately. Let's add a new class for the "too large" case
to allow that.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 87b0e228bd..4129935d86 100644
--- a/fsck.c
+++ b/fsck.c
@@ -63,6 +63,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(GITMODULES_MISSING, ERROR) \
 	FUNC(GITMODULES_BLOB, ERROR) \
 	FUNC(GITMODULES_PARSE, ERROR) \
+	FUNC(GITMODULES_LARGE, ERROR) \
 	FUNC(GITMODULES_NAME, ERROR) \
 	FUNC(GITMODULES_SYMLINK, ERROR) \
 	/* warnings */ \
@@ -1005,7 +1006,7 @@ static int fsck_blob(struct blob *blob, const char *buf,
 		 * that an error.
 		 */
 		return report(options, &blob->object,
-			      FSCK_MSG_GITMODULES_PARSE,
+			      FSCK_MSG_GITMODULES_LARGE,
 			      ".gitmodules too large to parse");
 	}
 
-- 
2.18.0.433.gb9621797ee

