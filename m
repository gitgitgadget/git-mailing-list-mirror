Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1432A2023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbcGHJQ6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:16:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:41888 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753018AbcGHJQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:16:56 -0400
Received: (qmail 5364 invoked by uid 102); 8 Jul 2016 09:16:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:16:58 -0400
Received: (qmail 11983 invoked by uid 107); 8 Jul 2016 09:17:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:17:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:16:53 -0400
Date:	Fri, 8 Jul 2016 05:16:53 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/8] branch: use write_file_buf instead of write_file
Message-ID: <20160708091653.GA17072@sigill.intra.peff.net>
References: <577EB546.1090007@web.de>
 <20160707203157.GA11804@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607080834340.6426@virtualbox>
 <20160708065650.GA10664@sigill.intra.peff.net>
 <20160708090400.GA26594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708090400.GA26594@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If we already have a strbuf, then using write_file_buf is a
little nicer to read (no wondering whether "%s" will eat
your NULs), and it's more efficient (no extra formatting
step).

We don't care about the newline magic of write_file(), as we
have our own multi-line content.

Signed-off-by: Jeff King <peff@peff.net>
---
Almost forgot this one. I had originally converted to write_file_buf
directly, but later reshuffled the patches to make the refactoring more
clear.

 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 15232c4..1d41251 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -618,7 +618,7 @@ static int edit_branch_description(const char *branch_name)
 		    "  %s\n"
 		    "Lines starting with '%c' will be stripped.\n",
 		    branch_name, comment_line_char);
-	write_file(git_path(edit_description), "%s", buf.buf);
+	write_file_buf(git_path(edit_description), buf.buf, buf.len);
 	strbuf_reset(&buf);
 	if (launch_editor(git_path(edit_description), &buf, NULL)) {
 		strbuf_release(&buf);
-- 
2.9.0.393.g704e522

