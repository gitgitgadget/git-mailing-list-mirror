Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5331F858
	for <e@80x24.org>; Tue,  2 Aug 2016 10:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbcHBK7k (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 06:59:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:53171 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751341AbcHBK7j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 06:59:39 -0400
Received: (qmail 22934 invoked by uid 102); 2 Aug 2016 10:52:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Aug 2016 06:52:57 -0400
Received: (qmail 23877 invoked by uid 107); 2 Aug 2016 10:53:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Aug 2016 06:53:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Aug 2016 06:52:53 -0400
Date:	Tue, 2 Aug 2016 06:52:53 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] blame: drop strdup of string literal
Message-ID: <20160802105252.jyl5x7eanttw2swj@sigill.intra.peff.net>
References: <20160613053203.GB3950@sigill.intra.peff.net>
 <20160613053928.GC23880@sigill.intra.peff.net>
 <CAPig+cQudTwT6H35YgEvxdK9AAn0BwvUC8bi8-DxGYNh9rb_Lw@mail.gmail.com>
 <20160614050541.GA9909@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160614050541.GA9909@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 14, 2016 at 01:05:41AM -0400, Jeff King wrote:

> On Tue, Jun 14, 2016 at 12:32:15AM -0400, Eric Sunshine wrote:
> 
> > > +       struct string_list range_list = STRING_LIST_INIT_NODUP;
> > 
> > Related to this series, there's an additional "fix" which ought to be
> > made, probably as a separate patch. In particular, in cmd_blame():
> > 
> >     if (lno && !range_list.nr)
> >         string_list_append(&range_list, xstrdup("1"));
> > 
> > which supplies a default range ("line 1 through end of file") if -L
> > was not specified. I used xstrdup() on the literal "1" in 58dbfa2
> > (blame: accept multiple -L ranges, 2013-08-06) to be consistent with
> > parse_opt_string_list() which was unconditionally xstrdup'ing the
> > argument (but no longer does as of patch 1/3 of this series).
> 
> Yeah, I'd agree that this is a minor bug both before and after the
> series due to the leak. Want to roll a patch on top?

Here it is, just to tie up a loose end. I marked you as the author since
the hard part was noticing the issue and explaining the history, which
you already did above.

-- >8 --
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] blame: drop strdup of string literal

This strdup was added as part of 58dbfa2 (blame: accept
multiple -L ranges, 2013-08-06) to be consistent with
parse_opt_string_list(), which appends to the same list.

But as of 7a7a517 (parse_opt_string_list: stop allocating
new strings, 2016-06-13), we should stop using strdup (to
match parse_opt_string_list, and for all the reasons
described in that commit; namely that it does nothing useful
and causes us to leak the memory).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index ab66cde..29bd479 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2805,7 +2805,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	lno = prepare_lines(&sb);
 
 	if (lno && !range_list.nr)
-		string_list_append(&range_list, xstrdup("1"));
+		string_list_append(&range_list, "1");
 
 	anchor = 1;
 	range_set_init(&ranges, range_list.nr);
-- 
2.9.2.670.g42e63de

