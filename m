Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0891208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 08:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbdHQIlO (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 04:41:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:41468 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751687AbdHQIlM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 04:41:12 -0400
Received: (qmail 2111 invoked by uid 109); 17 Aug 2017 08:41:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 08:41:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25308 invoked by uid 111); 17 Aug 2017 08:41:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 04:41:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Aug 2017 04:41:09 -0400
Date:   Thu, 17 Aug 2017 04:41:09 -0400
From:   Jeff King <peff@peff.net>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git add -p breaks after split on change at the top of the file
Message-ID: <20170817084109.ba7g2hnymtwqeclw@sigill.intra.peff.net>
References: <20170816202442.aumzwa443spqgyul@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170816202442.aumzwa443spqgyul@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Junio, as this gets deep into git-apply innards]

On Wed, Aug 16, 2017 at 10:25:04PM +0200, Simon Ruderich wrote:

>     $ git add -p
>     diff --git a/file b/file
>     index 587be6b..74a69a0 100644
>     --- a/file
>     +++ b/file
>     @@ -1 +1,4 @@
>     +a
>     +b
>      x
>     +c
>     Stage this hunk [y,n,q,a,d,/,s,e,?]? <-- press s
>     Split into 2 hunks.
>     @@ -1 +1,3 @@
>     +a
>     +b
>      x
>     Stage this hunk [y,n,q,a,d,/,j,J,g,e,?]? <-- press e
> 
>     Now delete the line "+a" in your editor and save.
> 
>     error: patch failed: file:1
>     error: file: patch does not apply
> 
> I expected git add -p to stage this change without error. It
> works fine without splitting the hunk (by deleting the first and
> last + line in the diff).

Interesting case. The problem isn't in add--interactive itself (I don't
think), but in git-apply. This is the diff we end up feeding to "git
apply --cached --check --recount --allow-overlap" to see if it applies:

  diff --git a/file b/file
  index 587be6b..74a69a0 100644
  --- a/file
  +++ b/file
  @@ -1 +1,3 @@
  +b
   x
  @@ -1 +3,2 @@
   x
  +c

The first hunk (that we edited) applies fine. But the second one does
not. Its hunk header says that it starts at line "1", so we expect to
find it at the beginning of the file. But of course it _isn't_ at the
beginning of the file anymore, because the first hunk added a line
before there.

So this diff is somewhat bogus; it has two hunks which start at the same
spot. But I think that's exactly the sort of thing that
"--allow-overlap" should handle. Doing this makes your case work for me:

diff --git a/apply.c b/apply.c
index 41ee63e1db..606db58218 100644
--- a/apply.c
+++ b/apply.c
@@ -2966,8 +2966,9 @@ static int apply_one_fragment(struct apply_state *state,
 	 * In other words, a hunk that is (frag->oldpos <= 1) with or
 	 * without leading context must match at the beginning.
 	 */
-	match_beginning = (!frag->oldpos ||
-			   (frag->oldpos == 1 && !state->unidiff_zero));
+	match_beginning = (nth_fragment == 1 &&
+			   (!frag->oldpos ||
+			    (frag->oldpos == 1 && !state->unidiff_zero)));
 
 	/*
 	 * A hunk without trailing lines must match at the end.


But I'm not quite sure if that's right. The rest of the overlap code
seems to mark patched lines with a flag. Meaning that instead of giving
up and saying "well, this is the second line so we can't ever try
matching the beginning", we should be redefining "beginning" in that
case to allow 0 or more PATCHED lines starting from the beginning of the
file.

-Peff
