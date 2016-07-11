Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88FB1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 16:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934117AbcGKQnV (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 12:43:21 -0400
Received: from imap.thunk.org ([74.207.234.97]:46104 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbcGKQnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 12:43:20 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=eEivHcC9aWK8cEFmQ5dcgyn/ZXjyyWwBJ7du7slBVCA=;
	b=KQcAcz0lO7lJxEarwwulCy6mREJEBGxvp9adkdBoWhwO7Q6Lunwe/QfjFS0f/GCJwC/SxWWanu4tuUIQQ8lEzBjxA7JbhaG+RVGjg1SofOIUFkMbDcQsxeW9et8q6MFgzZCCofgdAKSmUlMoKvMBkf25Ct0CbVHL3DxWJLIK0ys=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84_2)
	(envelope-from <tytso@thunk.org>)
	id 1bMeIg-0007Xn-4g; Mon, 11 Jul 2016 16:43:18 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 6648E828F74; Mon, 11 Jul 2016 12:43:17 -0400 (EDT)
Date:	Mon, 11 Jul 2016 12:43:17 -0400
From:	Theodore Ts'o <tytso@mit.edu>
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] pretty: add format specifiers: %gr, %gt, %gI, gi
Message-ID: <20160711164317.GB3890@thunk.org>
References: <20160710055402.32684-1-tytso@mit.edu>
 <20160710061644.GA19640@sigill.intra.peff.net>
 <20160710142622.GE26097@thunk.org>
 <20160711050201.GA18031@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160711050201.GA18031@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 01:02:02AM -0400, Jeff King wrote:
> Yeah, I'd have hoped for %gd, as well. One thing I think we should move
> towards in the long run is giving more readable names to our
> placeholders for git-log, the way for-each-ref and cat-file do (but
> keeping the existing ones for compatibility and as a shorthand).
> 
> So ideally the answer in the long run is:
> 
>   %(reflog-ref)@{%(reflog-index)}
> 
> or possibly:
> 
>   %(reflog:index)
> 
> for the whole thing. Or something like that. I haven't thought that hard
> about the exact syntax.

Yes, FWIW, I agree that long term, using % followed by one or two
characters is just a mess, and using some kind of human-readable
format is going to make a lot of sense.  I can imagine a few places
where I might still want to type --format=%at in some kind of ad-hoc
shell command, but in most places, if you're using a complex --format
specifier, it's going either in a shell script or in a .gitconfig
file, where being verbose is probably more of an advantage than a
disadvantage.

>   1. It's half-implemented. Why can we do format X, but not format Y
>      (for that matter, why can you do %ct, but there is no --date format
>      that matches it?). That sort of non-orthogonality ends up
>      frustrating for users and makes git look creaky and poorly thought
>      out.

Git *is* creaky and not thought-out in advance; that's just the nature
of how most successful open source projects grow; might as well be
proud of it.  :-)   As Greg K-H has said: "We believe in evolution, and
not intelligent design."  :-)

> > ... although I doubt whether git would ever want to do the equivalent of:
> > 
> > gcloud compute images list  --format='table[box,title=Images](name:sort=1,family)'
> > 
> > which will print something like this:
> 
> That's neat, though I think I'd really prefer just making it easy to get
> the data out of git in a structured way, and then applying some cool
> json-formatting script to it. Surely "turn this json into a table" is a
> thing that could be solved once for everybody (I don't work with it
> enough to know, but maybe "jq" can do that already).

Oh, agreed.  I used that as over-the-top example of something we
probably wouldn't want to put in the git core.  jq can't, but I'm sure
there must be some JSON tool out there which can.

> But let's get back to reality for a moment. Here are some patches that
> address the issues you brought up above.
> 
>   [1/5]: doc/rev-list-options: clarify "commit@{Nth}" for "-g" option
>   [2/5]: doc/rev-list-options: explain "-g" output formats
>   [3/5]: doc/pretty-formats: describe index/time formats for %gd
>   [4/5]: date: document and test "raw-local" mode
>   [5/5]: date: add "unix" format
> 
> The next step is either:
> 
>   - add specific reflog-time-formats, as your patch does
> 
>   - add a generic reflog-date placeholder, so you can do:
> 
>       git log --date=unix --format='%gT'
> 
>     or whatever. That still doesn't give you multiple date types in a
>     single invocation, though. It's probably not much code to do so, but
>     designing the syntax and supporting existing placeholders would be
>     some work.
> 
> I'm on the fence, so I'll let you decide how you want to proceed. I can
> live with "%gr" and "%gt", as they are at least symmetric with their
> author/committer counterparts.

I'm on the fence myself.  I can live with either, since either way the
long message command line will be going in .gitconfig.  I have a
slight preference for %gr and %gt, as %gT isn't orthogonal with
%ad/%cd, but I could be easily pursuaded otherwise.

Does anyone else have a strong opinion?

						- Ted
