From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Wed, 4 Jan 2012 21:51:54 -0500
Message-ID: <20120105025154.GA7326@sigill.intra.peff.net>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
 <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
 <m3vcoqevjm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 03:52:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RidQv-0006aT-Cu
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 03:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756477Ab2AECv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 21:51:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58008
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492Ab2AECv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 21:51:56 -0500
Received: (qmail 22302 invoked by uid 107); 5 Jan 2012 02:58:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Jan 2012 21:58:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jan 2012 21:51:54 -0500
Content-Disposition: inline
In-Reply-To: <m3vcoqevjm.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187962>

On Wed, Jan 04, 2012 at 06:24:16PM -0800, Jakub Narebski wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As a side note, it looks like we just start the daemon with "git daemon
> > &". Doesn't that create a race condition with the tests which
> > immediately try to access it (i.e., the first test may run before the
> > daemon actually opens the socket)?
> 
> Hmmm... perhaps the trick that git-instaweb does for "plackup" web
> server would be of use here, waiting for socket to be ready?

It looks like it busy loops, which is kind of ugly.

The credential-cache helper has a similar problem. It wants to kick off
a daemon if one is not already running, and then connect to it. So the
daemon does:

  printf("ok\n");
  fclose(stdout);

when it has set up the socket, and the client does:

  r = read_in_full(daemon.out, buf, sizeof(buf));
  if (r < 0)
          die_errno("unable to read result code from cache daemon");
  if (r != 3 || memcmp(buf, "ok\n", 3))
          die("cache daemon did not start: %.*s", r, buf);
  /* now we can connect over the socket */

We could probably add a "--notify-when-ready" option to git-daemon to
do something similar.

-Peff
