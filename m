Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC03E1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 23:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeAVXIW (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 18:08:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:53770 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751031AbeAVXIW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 18:08:22 -0500
Received: (qmail 8848 invoked by uid 109); 22 Jan 2018 23:08:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Jan 2018 23:08:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11940 invoked by uid 111); 22 Jan 2018 23:08:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Jan 2018 18:08:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jan 2018 18:08:20 -0500
Date:   Mon, 22 Jan 2018 18:08:20 -0500
From:   Jeff King <peff@peff.net>
To:     felipe@felipegasper.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fix comma splices
Message-ID: <20180122230819.GB21604@sigill.intra.peff.net>
References: <5a656638.LthG4qGgtrvPcSKz%felipe@felipegasper.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a656638.LthG4qGgtrvPcSKz%felipe@felipegasper.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 21, 2018 at 10:19:04PM -0600, felipe@felipegasper.com wrote:

> Subject: [PATCH] Fix comma splices in remote.c
> [...]
> @@ -2123,9 +2123,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
>  				_("  (use \"git push\" to publish your local commits)\n"));
>  	} else if (!ours) {
>  		strbuf_addf(sb,
> -			Q_("Your branch is behind '%s' by %d commit, "
> +			Q_("Your branch is behind '%s' by %d commit "
>  			       "and can be fast-forwarded.\n",
> -			   "Your branch is behind '%s' by %d commits, "
> +			   "Your branch is behind '%s' by %d commits "
>  			       "and can be fast-forwarded.\n",

Yes, the original violates the usual English rules for commas, which say
that the dependent clause joined with a conjunction should not have a
comma.

(To be pedantic, these aren't comma splices. A comma splice joins two
independent clauses with a comma and _without_ a conjunction).

This kind of comma _can_ actually be considered correct if it makes the
sentence more clear, or to indicate a more extreme contrast. I tend to
agree with you, though, that it does not help clarity here at all.

> @@ -2134,11 +2134,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
>  				_("  (use \"git pull\" to update your local branch)\n"));
>  	} else {
>  		strbuf_addf(sb,
> -			Q_("Your branch and '%s' have diverged,\n"
> -			       "and have %d and %d different commit each, "
> +			Q_("Your branch and '%s' have diverged.\n"
> +			       "They have %d and %d different commit each, "
>  			       "respectively.\n",

This one is the same case as above, but you solved it differently. I
agree that the result reads more clearly than the original. And more
clearly than:

  Your branch and '%s' have diverged and have %d and %d different
  commits each, respectively.

The first hunk could use the same "start a new sentence" trick, but it's
pretty clear as a single sentence.  So I think your patch is doing the
right thing, my pedantic explanations notwithstanding. ;)

Reading this did make me wonder two things, though:

  1. Do we really need the newline after "diverged"? Especially with the
     comma, it makes the result look funnily wrapped (unless you have an
     extremely long upstream branch name).

     OTOH, if we switch it to a period as your patch does, I think the
     line break looks much more natural.

  2. Is this Q_() here actually helping? It triggers on "ours + theirs"
     being greater than 1. So the "singular" case could only come up if
     you had "0" in one of the cases.  But:

       ...and have 0 and 1 different commit each...

     makes no sense to me in English. It would still be "commits". I
     could accept:

       ...and have 1 commit each...

     for the case where it's 1/1. But we would use "1 and 1 different
     commits each" (which is correct, albeit slightly clunkier).

     In fact, I don't think the singular case here can _ever_ trigger,
     because this is the "else" block we get to when we know that
     neither is zero. So I think the singular half of this Q_() could
     just go away.

     Like:

diff --git a/remote.c b/remote.c
index 4c84ba88dc..52672ac658 100644
--- a/remote.c
+++ b/remote.c
@@ -2096,13 +2096,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
 		strbuf_addf(sb,
-			Q_("Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commit each, "
-			       "respectively.\n",
-			   "Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commits each, "
-			       "respectively.\n",
-			   ours + theirs),
+			_("Your branch and '%s' have diverged,\n"
+			  "and have %d and %d different commits each, "
+			  "respectively.\n"),
 			base, ours, theirs);
 		if (advice_status_hints)
 			strbuf_addstr(sb,

(if I were doing such a series, I'd probably do that first as a
preparatory step, and then do grammatical fix on top).

-Peff
