Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC94E1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 04:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbeCTEWs (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 00:22:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:35416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750768AbeCTEWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 00:22:47 -0400
Received: (qmail 29634 invoked by uid 109); 20 Mar 2018 04:22:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 04:22:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28912 invoked by uid 111); 20 Mar 2018 04:23:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 00:23:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 00:22:45 -0400
Date:   Tue, 20 Mar 2018 00:22:45 -0400
From:   Jeff King <peff@peff.net>
To:     CB Bailey <charles@hashpling.org>
Cc:     Michele Locati <michele@locati.it>, git@vger.kernel.org,
        Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCH] filter-branch: use printf instead of echo -e
Message-ID: <20180320042245.GA13302@sigill.intra.peff.net>
References: <20180319144905.11564-1-michele@locati.it>
 <20180319153945.kchupu43cpcbg25n@hashpling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180319153945.kchupu43cpcbg25n@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 03:39:46PM +0000, CB Bailey wrote:

> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > index 1b7e4b2cd..21d84eff3 100755
> > --- a/git-filter-branch.sh
> > +++ b/git-filter-branch.sh
> > @@ -627,7 +627,7 @@ then
> >  				print H "$_:$f\n" or die;
> >  			}
> >  			close(H) or die;' || die "Unable to save state")
> > -	state_tree=$(/bin/echo -e "100644 blob $state_blob\tfilter.map" | git mktree)
> > +	state_tree=$(printf '100644 blob %s\tfilter.map\n' "$state_blob" | git mktree)
> >  	if test -n "$state_commit"
> >  	then
> >  		state_commit=$(/bin/echo "Sync" | git commit-tree "$state_tree" -p "$state_commit")
> 
> I think the change from 'echo -e' to printf is good because of the
> better portability reason that you cite.
> 
> Looking at the change, I am now curious as to why '/bin/echo' is used.
> Testing on a Mac, bash's built in 'echo' recognizes '-e' whereas
> '/bin/echo' does not. This is just an observation, I still prefer the
> move to 'printf' that you suggest.

Right. Moving them to just "echo -e" would work on systems where /bin/sh
is bash, but not elsewhere (e.g., Debian systems with "dash" whose
built-in echo doesn't understand "-e").

So my guess as to why /bin/echo was used is that on Linux systems it's
_more_ predictable and portable, because you know you're always going to
get the GNU coreutils version, which knows "-e". Even if you're using a
non-bash shell.

But on non-Linux systems, who knows what system "echo" you'll get. :)

Author cc'd in case there's something more interesting going on.

-Peff
