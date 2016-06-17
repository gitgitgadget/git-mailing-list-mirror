Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 558F720179
	for <e@80x24.org>; Fri, 17 Jun 2016 15:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbcFQPgn (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 11:36:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:56183 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755687AbcFQPgl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 11:36:41 -0400
Received: (qmail 20246 invoked by uid 102); 17 Jun 2016 15:36:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 11:36:40 -0400
Received: (qmail 26300 invoked by uid 107); 17 Jun 2016 15:36:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 11:36:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 11:36:38 -0400
Date:	Fri, 17 Jun 2016 11:36:38 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, jacob.keller@gmail.com, mhagger@alum.mit.edu
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring
 blank lines
Message-ID: <20160617153637.GA9314@sigill.intra.peff.net>
References: <20160616174620.1011-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160616174620.1011-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 10:46:20AM -0700, Stefan Beller wrote:

> The compaction heuristic for diffs was deemed quite good, but in 5580b27
> we have an example demonstrates a common case, that fails with the existing
> heuristic. That is why we disabled the heuristic in the v2.9.0 release.
> 
> With this patch a diff looks like:
> 
>          def bar
>                  do_bar_stuff()
> 
>                  common_ending()
>          end
> 
> +        def bal
> +                do_bal_stuff()
> +
> +                common_ending()
> +        end
> +
>          def baz
>                  do_baz_stuff()
> 
>                  common_ending()
>          end
> 
> whereas before we had:
> 
>   WIP (TODO: ask peff to provide an example that actually triggers, I seem to be
>        unable to write one, though I thought the above was one)

Did you want something that triggers the "bad" case with the existing
compaction heuristic?

I gave one in:

  http://article.gmane.org/gmane.comp.version-control.git/296947

I think the difference is that in my example, the diff (before
compaction) has the blank line at the top (because we are adding a new
entry at the bottom), whereas in yours, the blank line is at the bottom.

This patch does make my "bad" case look better. Unfortunately, it
re-breaks another case:

	cat >file.rb <<\EOF
	##
	# This is the foo function.
	def foo
	  foo stuff
	end

	##
	# This is the bar function.
	def bar
	  bar stuff
	end

	##
	# This is the baz function.
	def baz
	  baz stuff
	end
	EOF

	git init
	git add file.rb
	sed -i 7,12d file.rb
	git diff

That goes back to the original, pre-compaction-heuristic diff:

	diff --git a/file.rb b/file.rb
	index 0b31fb6..ee25d63 100644
	--- a/file.rb
	+++ b/file.rb
	@@ -5,12 +5,6 @@ def foo
	 end
	 
	 ##
	-# This is the bar function.
	-def bar
	-  bar stuff
	-end
	-
	-##
	 # This is the baz function.
	 def baz
	   baz stuff

-Peff
