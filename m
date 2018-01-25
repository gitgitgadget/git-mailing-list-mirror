Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 159E11F404
	for <e@80x24.org>; Thu, 25 Jan 2018 19:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeAYTI1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 14:08:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:57578 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750994AbeAYTI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 14:08:26 -0500
Received: (qmail 15189 invoked by uid 109); 25 Jan 2018 19:08:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Jan 2018 19:08:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6417 invoked by uid 111); 25 Jan 2018 19:09:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Jan 2018 14:09:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jan 2018 14:08:24 -0500
Date:   Thu, 25 Jan 2018 14:08:24 -0500
From:   Jeff King <peff@peff.net>
To:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/6] t/lib-git-daemon: record daemon log
Message-ID: <20180125190824.GA26309@sigill.intra.peff.net>
References: <20180125005447.GA26661@sigill.intra.peff.net>
 <20180125005511.GB26850@sigill.intra.peff.net>
 <38b41541-5758-d013-3d64-314eec7e31ed@lucaswerkmeister.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38b41541-5758-d013-3d64-314eec7e31ed@lucaswerkmeister.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 12:56:47PM +0100, Lucas Werkmeister wrote:

> > Let's dump the log into a file, as well, so that future
> > tests can check the log. There are two subtleties worth
> > calling out here:
> > 
> >   - we replace "cat" with a subshell loop around "read" to
> >     ensure that there's no buffering (so that tests can be
> >     sure that after a request has been served, the matching
> >     log entries will have made it to the file)
> 
> POSIX specifies the -u option for that behavior, can’t you use that?
> (GNU coreutils’ cat ignores it, since writing without delay is
> apparently its default behavior already.)

Actually, this glosses over one other detail, which is that we'd also
need to replace "cat" with "tee" to keep output going to descriptor 4.
That's not strictly necessary (it's just for debugging output), so we
could drop that. But the shell loop seemed easy enough.

> >  	{
> >  		read line <&7
> > +		echo "$line"
> >  		echo >&4 "$line"
> > -		cat <&7 >&4 &
> > -	} 7<git_daemon_output &&
> > +		(
> > +			while read line <&7
> > +			do
> > +				echo "$line"
> > +				echo >&4 "$line"
> > +			done
> > +		) &
> > +	} 7<git_daemon_output >>"$TRASH_DIRECTORY/daemon.log" &&
> >  
> >  	# Check expected output
> >  	if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
> > 
> 
> read without -r clobbers backslashes, and echo may interpret escape
> sequences. To faithfully reproduce the output, it would be better to use
> read -r and printf '%s\n' "$line", I think. (However, it looks like the
> existing code already uses read+echo, so I guess you could also keep
> that pattern in this change and then fix it in a later one.)

Yeah. I doubt it matters much, since this is just inside our tests, and
we control the input. But it doesn't hurt to do it in the more robust
way. I'll re-roll this patch.

-Peff
