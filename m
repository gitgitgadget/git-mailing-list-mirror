Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74EE4202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 23:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbdJSXXj (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 19:23:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:58494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750736AbdJSXXj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 19:23:39 -0400
Received: (qmail 9309 invoked by uid 109); 19 Oct 2017 23:23:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 23:23:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13528 invoked by uid 111); 19 Oct 2017 23:23:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 19:23:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 19:23:37 -0400
Date:   Thu, 19 Oct 2017 19:23:37 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/3] t5615: avoid re-using descriptor 4
Message-ID: <20171019232337.zfd7occtjboem7f4@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
 <20171019210730.sgm4g4tmor2dgjv7@sigill.intra.peff.net>
 <CAGZ79kYTmUnM+fcf222-cvwB3Fg4+J_xy28E7A3AYryx4qDf_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYTmUnM+fcf222-cvwB3Fg4+J_xy28E7A3AYryx4qDf_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 02:46:33PM -0700, Stefan Beller wrote:

> > I also considered trying to bump the "set -x" output descriptor to "9".
> > That just moves the problem around, but presumably scripts are less
> > likely to go that high. :)
> >
> > It would also be possible to pick something insanely high, like "999".
> > Many shells choke on descriptors higher than 9, but since the issue is
> > related to BASH_XTRACEFD, we could make it a bash-only thing. I don't
> > know if it's worth the trouble. I hate leaving a subtle "don't use
> > descriptor 4 in a subshell or your script will break" hand-grenade like
> > this lying around, but we do seem to have only one instance of it over
> > the whole test suite.
> 
> I would imagine that a higher fd for BASH_XTRACEFD
> would be less explosive than requiring the tests to skip
> the low number 4. (It is not *that* low. In e.g. git-submodule.sh
> we make use of 3 in cmd_foreach, not needing more.)

So one trick is that we can't just set it to a higher number. We have to
also open and manage that descriptor. It might be enough to do:

  if test -n "$BASH_VERSION"
  then
	exec 999>&4
	BASH_XTRACEFD=999
  fi

but since we fiddle with descriptors on a per-test basis, I'm not sure
if that's it or not. I think for convincing output to go to it, it
probably is. We tend to point things _at_ descriptor 4, not point
descriptor 4 elsewhere. But the fix in patch 1 is an exception, where we
try to suppress the "set +x" output. For that we have to redirect 999,
too (which is hard because ">&999" is syntactically invalid in other
shells, so we have to follow a separate code path for bash or get into
evals).

Or start playing games with unsetting BASH_XTRACEFD (which closes 999,
and then we re-open 999>&4 and reset XTRACEFD).

I think it might be workable, but I'm worried we're opening a can of
worms. Or continuing to dig into the can of worms from the original
BASH_XTRACEFD, if you prefer. :)

-Peff
