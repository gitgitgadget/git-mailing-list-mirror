From: Jeff King <peff@peff.net>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 14:05:08 -0500
Message-ID: <20101111190508.GA3038@sigill.intra.peff.net>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
 <20101111103742.GA16422@burratino>
 <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
 <20101111173253.GC16972@burratino>
 <alpine.LNX.2.00.1011111241360.14365@iabervon.org>
 <20101111184829.GG16972@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Carl Worth <cworth@cworth.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 20:05:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGcSU-0002d1-Qz
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 20:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162Ab0KKTFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 14:05:12 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43864 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab0KKTFL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 14:05:11 -0500
Received: (qmail 30479 invoked by uid 111); 11 Nov 2010 19:05:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 11 Nov 2010 19:05:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Nov 2010 14:05:08 -0500
Content-Disposition: inline
In-Reply-To: <20101111184829.GG16972@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161293>

On Thu, Nov 11, 2010 at 12:48:29PM -0600, Jonathan Nieder wrote:

> So why does git clone keep running after the first remove_junk() call?
> It seems that the signal is initially set up (by Python's popen()?) as
> SIG_IGN.  I guess "git clone" should explicitly override that to be
> SIG_DFL?

I was tracing this earlier today, too, and got sidetracked. But I got to
the same confusing point: why doesn't it die after cleaning up? It looks
like we inherit SIG_IGN for SIGPIPE from the parent python process.

I don't think it makes sense for git-clone to do this itself. If we are
going to say "SIGPIPE should default to SIG_DFL on startup" then we
should do it as the very first thing in the git wrapper, not just for
git-clone. That gives each git program a known starting point of
behavior.

But I wonder if we should perhaps just be ignoring SIGPIPE in this
instance instead.  There isn't a real error here; we just ended up not
being able to write some useless progress report to stdout. There's no
reason to fail.

Note that we probably don't want to ignore SIGPIPE for all of git; many
of the output-producing programs rely on it for early termination when
the user closes the pager. But for clone, it makes sense.

> Here's a proof of concept.  It is not very good because it overrides
> any previously set sigchain handlers (in case the "git" wrappers
> start to use one) and because using SIG_DFL as a sigchain_fun feels
> like violating an abstraction.
> [...]
> +	sigchain_push_common(SIG_DFL);

I don't think your patch is the right solution, but FWIW, sigchain was
explicitly intended to be able to take SIG_DFL and SIG_IGN. Probably
sigchain_fun should be removed and we should just use sighandler_t
explicitly (I think in initial versions they were not the same thing,
and I realized the error of my ways, but the sigchain_fun typedef hung
around anyway).

-Peff
