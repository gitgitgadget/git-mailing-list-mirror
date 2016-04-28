From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Thu, 28 Apr 2016 17:20:11 -0400
Message-ID: <20160428212011.GC12268@sigill.intra.peff.net>
References: <20160428134953.GB25364@sigill.intra.peff.net>
 <CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
 <20160428153902.GF31063@sigill.intra.peff.net>
 <CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
 <20160428165031.GA31421@sigill.intra.peff.net>
 <xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
 <20160428191038.GA10574@sigill.intra.peff.net>
 <xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
 <20160428210026.GA12268@sigill.intra.peff.net>
 <CAGZ79kZF4UeNuwBoA-Vw0OFHin4=8GTWPK-GT+5fsEuCFe7Now@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:20:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avtME-0005av-0N
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 23:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbcD1VUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 17:20:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:58788 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753728AbcD1VUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 17:20:15 -0400
Received: (qmail 16527 invoked by uid 102); 28 Apr 2016 21:20:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 17:20:14 -0400
Received: (qmail 14846 invoked by uid 107); 28 Apr 2016 21:20:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 17:20:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 17:20:11 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZF4UeNuwBoA-Vw0OFHin4=8GTWPK-GT+5fsEuCFe7Now@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292957>

On Thu, Apr 28, 2016 at 02:08:43PM -0700, Stefan Beller wrote:

> >   1. Ones where we _know_ that the config is nonsense to pass along,
> >      _and_ where a user might conceivably make use of the
> >      just-the-top-level version of it (core.worktree
> >      comes to mind, though of course they are probably better served by
> >      "--work-tree" in such a case).
> 
> My gut reaction to this:
> In this specific case I would rather error out, as you never want to have
> core.worktree to point at the same dir for all of the repo and submodules.

But then you're erroring out on a case that currently works today (we
apply core.worktree to the root repo, and ignore it for the others),
which I think is worth avoiding.

> Thinking about it further, I am not so sure any more.
> (What if you have multiple submodules tracking the same project
> and you want to see each submodule version with the one worktree you point to?
> Highly unlikely edge case, but it voids the /never/ assumption of my
> gut reaction)

I think this falls in my "nonsense" category. Especially when there are
other ways to handle it (e.g., by asking "git submodule foreach" to look
at each directory).

> I view the whitelist more like an "emergency knob to turn, because the
> developers did it wrong and I want it now". the general case should be
> covered by a mechanism we provide?

I think the emergency knob is "visit each submodule individually if you
have want to do something clever in each one" (or "ask git not to
recurse into submodules" for the opposite effect). The use cases I have
seen discussed are:

  1. Convenience. People expect to set some global-ish config like
     credential.helper, and have it applied uniformly.

  2. Inserting config into awkward parts of the call chain. E.g., I
     think Lars is mostly interested in speeding up clones where the
     submodules have a lot of slow clean/smudge filters. So he wants to
     disable "filter.*" _just_ for the clone, but there's no easy way to
     intercept the clone step of each submodule, stop, and the run the
     individual checkout with "git -c filter.foo.smudge=". I'm sure
     there's probably a way to hack it with plumbing, but it fails in
     "convenience".

-Peff
