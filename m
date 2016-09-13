Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40984207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbcIMDXc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:23:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:42276 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754012AbcIMDXa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:23:30 -0400
Received: (qmail 20239 invoked by uid 109); 13 Sep 2016 03:23:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:23:30 +0000
Received: (qmail 18439 invoked by uid 111); 13 Sep 2016 03:23:40 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:23:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:23:27 -0700
Date:   Mon, 12 Sep 2016 20:23:27 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 04/16] diff: skip implicit no-index check when given
 --no-index
Message-ID: <20160913032327.d4v5s4h3wfy4vj3y@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can invoke no-index mode in two ways: by an explicit
request from the user, or implicitly by noticing that we
have two paths, and at least one is outside the repository.

If the user already told us --no-index, there is no need for
us to do the implicit test at all.  However, we currently
do, and downgrade our "explicit" to DIFF_NO_INDEX_IMPLICIT.

This doesn't have any user-visible behavior, though it's not
immediately obvious why. We only trigger the implicit check
when we have exactly two non-option arguments. And the only
code that cares about implicit versus explicit is an error
message that we show when we _don't_ have two non-option
arguments.

However, it's worth fixing anyway. Besides being slightly
more efficient, it makes the code easier to follow, which
will help when we modify it in future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index b7a9405..a31643c 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -301,20 +301,21 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	if (!no_index)
+	if (!no_index) {
 		prefix = setup_git_directory_gently(&nongit);
 
-	/*
-	 * Treat git diff with at least one path outside of the
-	 * repo the same as if the command would have been executed
-	 * outside of a git repository.  In this case it behaves
-	 * the same way as "git diff --no-index <a> <b>", which acts
-	 * as a colourful "diff" replacement.
-	 */
-	if (nongit || ((argc == i + 2) &&
-		       (!path_inside_repo(prefix, argv[i]) ||
-			!path_inside_repo(prefix, argv[i + 1]))))
-		no_index = DIFF_NO_INDEX_IMPLICIT;
+		/*
+		 * Treat git diff with at least one path outside of the
+		 * repo the same as if the command would have been executed
+		 * outside of a git repository.  In this case it behaves
+		 * the same way as "git diff --no-index <a> <b>", which acts
+		 * as a colourful "diff" replacement.
+		 */
+		if (nongit || ((argc == i + 2) &&
+			       (!path_inside_repo(prefix, argv[i]) ||
+				!path_inside_repo(prefix, argv[i + 1]))))
+			no_index = DIFF_NO_INDEX_IMPLICIT;
+	}
 
 	if (!no_index)
 		gitmodules_config();
-- 
2.10.0.230.g6f8d04b

