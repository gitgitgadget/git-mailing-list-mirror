Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B372023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244AbcGHJI7 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:08:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:41853 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754057AbcGHJI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:08:57 -0400
Received: (qmail 4945 invoked by uid 102); 8 Jul 2016 09:08:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:08:58 -0400
Received: (qmail 11834 invoked by uid 107); 8 Jul 2016 09:09:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:09:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:08:54 -0400
Date:	Fri, 8 Jul 2016 05:08:54 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/8] branch: use non-gentle write_file for branch description
Message-ID: <20160708090854.GC10152@sigill.intra.peff.net>
References: <20160708090400.GA26594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708090400.GA26594@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We use write_file_gently() to do this job currently.
However, if we see an error, we simply complain via
error_errno() and then end up exiting with an error code.

By switching to the non-gentle form, the function will die
for us, with a better error. It is more specific about which
syscall caused the error, and that mentions the
actual filename we're trying to write.

Our exit code for the error case does switch from "1" to
"128", but that's OK; it wasn't a meaningful documented code
(and in fact it was odd that it was a different exit code
than most other error conditions).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ecde53..15232c4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -618,10 +618,7 @@ static int edit_branch_description(const char *branch_name)
 		    "  %s\n"
 		    "Lines starting with '%c' will be stripped.\n",
 		    branch_name, comment_line_char);
-	if (write_file_gently(git_path(edit_description), "%s", buf.buf)) {
-		strbuf_release(&buf);
-		return error_errno(_("could not write branch description template"));
-	}
+	write_file(git_path(edit_description), "%s", buf.buf);
 	strbuf_reset(&buf);
 	if (launch_editor(git_path(edit_description), &buf, NULL)) {
 		strbuf_release(&buf);
-- 
2.9.0.393.g704e522

