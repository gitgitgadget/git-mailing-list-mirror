Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3841FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 05:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750977AbdJSFZA (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 01:25:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:57266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750777AbdJSFY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 01:24:59 -0400
Received: (qmail 1897 invoked by uid 109); 19 Oct 2017 05:25:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 05:25:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6218 invoked by uid 111); 19 Oct 2017 05:25:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 01:25:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 01:24:57 -0400
Date:   Thu, 19 Oct 2017 01:24:57 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, orgads@gmail.com
Subject: Re: [PATCH] diff.c: increment buffer pointer in all code path
Message-ID: <20171019052457.gqenoshgyjcw53tb@sigill.intra.peff.net>
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
 <20171012233322.31203-1-sbeller@google.com>
 <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
 <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net>
 <20171019050459.p2cx63yrxfwq4ta3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019050459.p2cx63yrxfwq4ta3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 01:04:59AM -0400, Jeff King wrote:

> So. That leaves me with:
> 
>   - I'm unclear on whether next_byte() is meant to return that trailing
>     NUL or not. I don't think it causes any bugs, but it certainly
>     confused me for a function to take a cp/endp pair of pointers, and
>     then dereference endp. It might be worth either fixing or clarifying
>     with a comment.
> 
>   - Those loops to eat trailing whitespace are doing nothing. I'm not
>     sure if that all works out because next_byte() eats whitespaces or
>     not (I think not, because it doesn't eat whitespace for the
>     IGNORE_WHITESPACE_AT_EOL case). But I'm not quite sure what a test
>     would look like.

I had trouble constructing a test at first, but I think my test lines
just weren't long enough to trigger the movement heuristics. If I switch
to something besides seq, I can do:

  # any input that has reasonably sized lines
  look e | head -50 >file
  git add file
  
  perl -i -ne '
    # pick up lines 20-25 to move to line 40, and
    # add some trailing whitespace to them
    if ($. >= 20 && $. <= 25) {
      s/$/     /;
      $hold .= $_;
    } else {
      print $hold if ($. == 40);
      print;
    }
  ' file

  git diff --color-moved --ignore-space-at-eol

I think that _should_ show the block as moved, but it doesn't. But if I
apply this patch:

diff --git a/diff.c b/diff.c
index 93dccd1817..375d9cf447 100644
--- a/diff.c
+++ b/diff.c
@@ -743,8 +743,8 @@ static int moved_entry_cmp(const struct diff_options *diffopt,
 			   const struct moved_entry *b,
 			   const void *keydata)
 {
-	const char *ap = a->es->line, *ae = a->es->line + a->es->len;
-	const char *bp = b->es->line, *be = b->es->line + b->es->len;
+	const char *ap = a->es->line, *ae = a->es->line + a->es->len - 1;
+	const char *bp = b->es->line, *be = b->es->line + b->es->len - 1;
 
 	if (!(diffopt->xdl_opts & XDF_WHITESPACE_FLAGS))
 		return a->es->len != b->es->len  || memcmp(ap, bp, a->es->len);
@@ -771,7 +771,7 @@ static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_opti
 {
 	if (o->xdl_opts & XDF_WHITESPACE_FLAGS) {
 		static struct strbuf sb = STRBUF_INIT;
-		const char *ap = es->line, *ae = es->line + es->len;
+		const char *ap = es->line, *ae = es->line + es->len - 1;
 		int c;
 
 		strbuf_reset(&sb);

it does. It just adjusts our "end pointer" to point to the last valid
character in the string (rather than one past), which seems to be the
convention that those loops (and next_byte) expect.

-Peff
