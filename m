From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Wed, 4 Jan 2012 17:26:49 -0500
Message-ID: <20120104222649.GA14727@sigill.intra.peff.net>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
 <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 23:26:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiZIO-0007Rg-TW
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 23:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174Ab2ADW0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 17:26:52 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57928
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757099Ab2ADW0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 17:26:51 -0500
Received: (qmail 20017 invoked by uid 107); 4 Jan 2012 22:33:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Jan 2012 17:33:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jan 2012 17:26:49 -0500
Content-Disposition: inline
In-Reply-To: <7vaa63p11t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187951>

On Wed, Jan 04, 2012 at 02:15:10PM -0800, Junio C Hamano wrote:

> >> Do you really need to kill the children but not the daemon?
> >
> > If I kill just the parent "git daemon" command, then the actual
> > git-daemon (started by run_command) will be left behind.
> 
> Sounds like we would be better off with a new "--foreground" option other
> daemon-ish projects seem to have?

Isn't that usually for "don't background yourself"? AFAIK, git-daemon
stays in the foreground and only forks to handle each connection. So
can't we just kill the main process, and any running cruft will
eventually die as connections are closed?

Or is the problem the git wrapper itself, which doesn't kill its
subprocess when it dies (which IMHO is a bug which we might want to
fix)? In that case, couldn't we just use --pid-file to save the actual
daemon pid, and then kill using that?

As a side note, it looks like we just start the daemon with "git daemon
&". Doesn't that create a race condition with the tests which
immediately try to access it (i.e., the first test may run before the
daemon actually opens the socket)?

-Peff
