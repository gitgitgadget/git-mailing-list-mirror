Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EED82021E
	for <e@80x24.org>; Fri, 19 May 2017 12:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbdESMuK (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:50:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:54800 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750857AbdESMuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:50:09 -0400
Received: (qmail 2311 invoked by uid 109); 19 May 2017 12:50:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:50:08 +0000
Received: (qmail 27719 invoked by uid 111); 19 May 2017 12:50:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:50:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:50:07 -0400
Date:   Fri, 19 May 2017 08:50:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 03/15] handle_revision_arg: stop using "dotdot" as a generic
 pointer
Message-ID: <20170519125006.gbvzr2dqrcycmpx7@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The handle_revision_arg() function has a "dotdot" variable
that it uses to find a ".." or "..." in the argument. If we
don't find one, we look for other marks, like "^!". But we
just keep re-using the "dotdot" variable, which is
confusing.

Let's introduce a separate "mark" variable that can be used
for these other marks. They still reuse the same variable,
but at least the name is no longer actively misleading.

Signed-off-by: Jeff King <peff@peff.net>
---
It may make sense to pull each of these into its own helper. I didn't
really look because they're so small, and because the return semantics
seemed confusing to me. Some of them return, and some of them keep
parsing. Some of them restore the NUL they overwrite, and some do not.

I didn't dig in to see if there are weird corner cases where they
misbehave.

 revision.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/revision.c b/revision.c
index b6031fb35..9c683874d 100644
--- a/revision.c
+++ b/revision.c
@@ -1433,6 +1433,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 {
 	struct object_context oc;
 	char *dotdot;
+	char *mark;
 	struct object *object;
 	unsigned char sha1[20];
 	int local_flags;
@@ -1529,33 +1530,33 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		*dotdot = '.';
 	}
 
-	dotdot = strstr(arg, "^@");
-	if (dotdot && !dotdot[2]) {
-		*dotdot = 0;
+	mark = strstr(arg, "^@");
+	if (mark && !mark[2]) {
+		*mark = 0;
 		if (add_parents_only(revs, arg, flags, 0))
 			return 0;
-		*dotdot = '^';
+		*mark = '^';
 	}
-	dotdot = strstr(arg, "^!");
-	if (dotdot && !dotdot[2]) {
-		*dotdot = 0;
+	mark = strstr(arg, "^!");
+	if (mark && !mark[2]) {
+		*mark = 0;
 		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), 0))
-			*dotdot = '^';
+			*mark = '^';
 	}
-	dotdot = strstr(arg, "^-");
-	if (dotdot) {
+	mark = strstr(arg, "^-");
+	if (mark) {
 		int exclude_parent = 1;
 
-		if (dotdot[2]) {
+		if (mark[2]) {
 			char *end;
-			exclude_parent = strtoul(dotdot + 2, &end, 10);
+			exclude_parent = strtoul(mark + 2, &end, 10);
 			if (*end != '\0' || !exclude_parent)
 				return -1;
 		}
 
-		*dotdot = 0;
+		*mark = 0;
 		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), exclude_parent))
-			*dotdot = '^';
+			*mark = '^';
 	}
 
 	local_flags = 0;
-- 
2.13.0.219.g63f6bc368

