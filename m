Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D892021E
	for <e@80x24.org>; Fri, 19 May 2017 12:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdESMvn (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:51:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:54809 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbdESMvm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:51:42 -0400
Received: (qmail 2461 invoked by uid 109); 19 May 2017 12:51:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:51:41 +0000
Received: (qmail 27743 invoked by uid 111); 19 May 2017 12:52:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:52:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:51:40 -0400
Date:   Fri, 19 May 2017 08:51:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 04/15] handle_revision_arg: hoist ".." check out of range
 parsing
Message-ID: <20170519125139.rrrlwpptqsvigus3@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 003c84f6d (specifying ranges: we did not mean to make
".." an empty set, 2011-05-02), we treat the argument ".."
specially. We detect it by noticing that both sides of the
range are empty, and that this is a non-symmetric two-dot
range.

While correct, this makes the code overly complicated. We
can just detect ".." up front before we try to do further
parsing. This avoids having to de-munge the NUL from dotdot,
and lets us eliminate an extra const array (which we needed
only to do direct pointer comparisons).

It also removes the one code path from the range-parsing
conditional that requires us to return -1. That will make it
simpler to pull the dotdot parsing out into its own
function.

Signed-off-by: Jeff King <peff@peff.net>
---
There's a similar call in rev-parse which could maybe take the same
cleanup. I didn't bother with it because my main goal was removing an
obstacle to factoring out the dotdot parsing (though in an ideal world,
rev-parse would actually use the same dotdot parsing code; I've no idea
how complicated that would be).

 revision.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/revision.c b/revision.c
index 9c683874d..dec06ff8b 100644
--- a/revision.c
+++ b/revision.c
@@ -1443,6 +1443,14 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 
 	flags = flags & UNINTERESTING ? flags | BOTTOM : flags & ~BOTTOM;
 
+	if (!cant_be_filename && !strcmp(arg, "..")) {
+		/*
+		 * Just ".."?  That is not a range but the
+		 * pathspec for the parent directory.
+		 */
+		return -1;
+	}
+
 	dotdot = strstr(arg, "..");
 	if (dotdot) {
 		unsigned char from_sha1[20];
@@ -1450,27 +1458,15 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		const char *this = arg;
 		int symmetric = *next == '.';
 		unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
-		static const char head_by_default[] = "HEAD";
 		unsigned int a_flags;
 
 		*dotdot = 0;
 		next += symmetric;
 
 		if (!*next)
-			next = head_by_default;
+			next = "HEAD";
 		if (dotdot == arg)
-			this = head_by_default;
-		if (this == head_by_default && next == head_by_default &&
-		    !symmetric) {
-			/*
-			 * Just ".."?  That is not a range but the
-			 * pathspec for the parent directory.
-			 */
-			if (!cant_be_filename) {
-				*dotdot = '.';
-				return -1;
-			}
-		}
+			this = "HEAD";
 		if (!get_sha1_committish(this, from_sha1) &&
 		    !get_sha1_committish(next, sha1)) {
 			struct object *a_obj, *b_obj;
-- 
2.13.0.219.g63f6bc368

