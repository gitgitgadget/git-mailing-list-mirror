From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] receive-pack: send pack-processing stderr over
 sideband
Date: Fri, 21 Sep 2012 13:05:39 -0400
Message-ID: <20120921170539.GA19707@sigill.intra.peff.net>
References: <20120921053057.GA9768@sigill.intra.peff.net>
 <20120921053455.GB9863@sigill.intra.peff.net>
 <7v7grn8gnv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:05:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF6fn-0001cQ-AL
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 19:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab2IURFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 13:05:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53461 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280Ab2IURFl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 13:05:41 -0400
Received: (qmail 3704 invoked by uid 107); 21 Sep 2012 17:06:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 13:06:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 13:05:39 -0400
Content-Disposition: inline
In-Reply-To: <7v7grn8gnv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206135>

On Fri, Sep 21, 2012 at 09:49:40AM -0700, Junio C Hamano wrote:

> >   2. No matter what the cause, we are probably better off
> >      showing the errors to the client. If the client and the
> >      server admin are not the same entity, it is probably
> >      much easier for the client to cut-and-paste the errors
> >      they see than for the admin to try to dig them out of a
> >      log and correlate them with a particular session.
> 
> I agree with the "probably" above (and also with points 1 and 3),
> but it at the same time feel a bit iffy.  The server side would lose
> log entries to check when the operator observes higher error rate
> and starts suspecting something recently broke, and the lost clue
> cannot be recovered without contacting the pushers, no?

Yeah, that is true, although that is already the case with ssh pushes.
Conversely, it also means that servers using the ssh transport have lost
the option of redirecting the server-side stderr (e.g., with a wrapper
around git-receive-pack) to a log if they were already doing so.

However, this does make things more consistent with upload-pack, which
connects the stderr of pack-objects to sideband (which it must to handle
progress). Furthermore, many of the messages from receive-pack are
handled by rp_error, which sends to the sideband. So if you were
monitoring your git purely by trying to capture stderr, you were already
only getting a fraction of the real data.

If a server side really did want to capture the error output, I think
the right way to do it would be:

  1. Modify send_sideband to send a copy of all band-2 data to stderr.

  2. Redirect stderr from all processes to a log processor (it's
     tempting to just send it somewhere besides stderr in (1) above, but
     you may also get clients which do not claim to support sidebands,
     in which case we will just spew to stderr).

  3. Do immediate culling on the output before storage, because some of
     what you get will be junk like progress reports (and they all come
     down the same fd, since it is typically stderr from a subprocess).

So I think this patch is not really making anything _worse_ if somebody
wanted to do that. It just moves the messages from being caught by step
(2) to being caught by step (1). But you have to do both either way.

-Peff
