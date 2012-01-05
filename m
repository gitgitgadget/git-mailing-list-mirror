From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Wed, 4 Jan 2012 21:55:59 -0500
Message-ID: <20120105025559.GB7326@sigill.intra.peff.net>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
 <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
 <20120105000713.GA24220@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Jan 05 03:56:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RidUu-0007lA-Be
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 03:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069Ab2AEC4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 21:56:03 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58020
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014Ab2AEC4C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 21:56:02 -0500
Received: (qmail 22359 invoked by uid 107); 5 Jan 2012 03:02:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Jan 2012 22:02:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jan 2012 21:55:59 -0500
Content-Disposition: inline
In-Reply-To: <20120105000713.GA24220@ecki.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187963>

On Thu, Jan 05, 2012 at 01:07:13AM +0100, Clemens Buchacher wrote:

> On Wed, Jan 04, 2012 at 05:26:49PM -0500, Jeff King wrote:
> > 
> > Or is the problem the git wrapper itself, which doesn't kill its
> > subprocess when it dies (which IMHO is a bug which we might want to
> > fix)? In that case, couldn't we just use --pid-file to save the actual
> > daemon pid, and then kill using that?
> 
> Or like this. Doesn't work with multiple children. I have yet to
> check if we have those anywhere.

It so happens that I have just the patch you need. I've been meaning to
go over it again and submit it:

  run-command: optionally kill children on exit
  https://github.com/peff/git/commit/5523d7ebf2a0386c9c61d7bfbc21375041df4989

The original use case was to help with this:

  https://github.com/peff/git/commit/79bf3f232f89c3e2f5284a3b7b71a667be8825d1

> > As a side note, it looks like we just start the daemon with "git daemon
> > &". Doesn't that create a race condition with the tests which
> > immediately try to access it (i.e., the first test may run before the
> > daemon actually opens the socket)?
> 
> That's correct. How would I fix that? Try connecting and sleep in a
> loop until ready or timeout? Will look into that.

Your choices are basically busy-waiting, or convincing the daemon to
send a signal when it's ready to serve. I like the latter, but it does
mean adding a small amount of code to git-daemon.

-Peff
