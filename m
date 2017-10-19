Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3731D1FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 05:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbdJSFmt (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 01:42:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:57318 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751558AbdJSFms (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 01:42:48 -0400
Received: (qmail 2559 invoked by uid 109); 19 Oct 2017 05:42:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 05:42:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6470 invoked by uid 111); 19 Oct 2017 05:42:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 01:42:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 01:42:46 -0400
Date:   Thu, 19 Oct 2017 01:42:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        orgads@gmail.com
Subject: Re: [PATCH] diff.c: increment buffer pointer in all code path
Message-ID: <20171019054246.jii62lq2druohbpo@sigill.intra.peff.net>
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
 <20171012233322.31203-1-sbeller@google.com>
 <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
 <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net>
 <20171019050459.p2cx63yrxfwq4ta3@sigill.intra.peff.net>
 <20171019052457.gqenoshgyjcw53tb@sigill.intra.peff.net>
 <xmqqzi8niu1r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzi8niu1r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 02:30:08PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > it does. It just adjusts our "end pointer" to point to the last valid
> > character in the string (rather than one past), which seems to be the
> > convention that those loops (and next_byte) expect.
> 
> Yeah I am not sure if I like this comparison at the beginning of the
> function:
> 
>         static int next_byte(const char **cp, const char **endp,
>                              const struct diff_options *diffopt)
>         {
>                 int retval;
> 
>                 if (*cp > *endp)
>                         return -1;
> 
> but it says endp _is_ part of valid input, contrary to my intuition.

Actually, I think even this function is confused about its convention.
In the line you quote, we clearly treat *endp as part of the input. But
later we do:

  while (*cp < *endp && isspace(**cp))
	  (*cp)++;

meaning that we'd fail to soak up whitespace at *endp. That wouldn't be
so bad if not for the other bug which fails to eat whitespace at endp in
the first place. :)

So I think the right fix is this:

diff --git a/diff.c b/diff.c
index 6fd288420b..09081a207c 100644
--- a/diff.c
+++ b/diff.c
@@ -712,7 +712,7 @@ static int next_byte(const char **cp, const char **endp,
 {
 	int retval;
 
-	if (*cp > *endp)
+	if (*cp >= *endp)
 		return -1;
 
 	if (isspace(**cp)) {
@@ -729,7 +729,12 @@ static int next_byte(const char **cp, const char **endp,
 		if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE)) {
 			while (*cp < *endp && isspace(**cp))
 				(*cp)++;
-			/* return the first non-ws character via the usual below */
+			/*
+			 * return the first non-ws character via the usual
+			 * below, unless we ate all of the bytes
+			 */
+			if (*cp >= *endp)
+				return -1;
 		}
 	}
 
@@ -750,9 +755,9 @@ static int moved_entry_cmp(const struct diff_options *diffopt,
 		return a->es->len != b->es->len  || memcmp(ap, bp, a->es->len);
 
 	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_AT_EOL)) {
-		while (ae > ap && isspace(*ae))
+		while (ae > ap && isspace(ae[-1]))
 			ae--;
-		while (be > bp && isspace(*be))
+		while (be > bp && isspace(be[-1]))
 			be--;
 	}
 
@@ -775,7 +780,7 @@ static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_opti
 		int c;
 
 		strbuf_reset(&sb);
-		while (ae > ap && isspace(*ae))
+		while (ae > ap && isspace(ae[-1]))
 			ae--;
 		while ((c = next_byte(&ap, &ae, o)) > 0)
 			strbuf_addch(&sb, c);

It's late here, so I'll wait for comments from Stefan and then try to
wrap it up with a commit message and test tomorrow.

-Peff
