From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] git-imap-send: use libcurl for implementation
Date: Sun, 17 Aug 2014 14:42:52 -0400
Message-ID: <20140817184252.GB2200@peff.net>
References: <53EA8C3E.1080500@raz.or.at>
 <20140813015917.GA30756@google.com>
 <20140817083022.GJ23808@peff.net>
 <53F0A66A.9000909@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	434599@bugs.debian.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Sun Aug 17 20:42:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJ5Pu-0004Xy-DF
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 20:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbaHQSmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 14:42:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:53796 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751404AbaHQSmx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 14:42:53 -0400
Received: (qmail 5969 invoked by uid 102); 17 Aug 2014 18:42:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 13:42:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 14:42:52 -0400
Content-Disposition: inline
In-Reply-To: <53F0A66A.9000909@raz.or.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255370>

On Sun, Aug 17, 2014 at 02:56:10PM +0200, Bernhard Reiter wrote:

> > I'm not sure if that would cause problems on Windows,
> > though.
> 
> Apparently socketpair is not available there. Googling "socketpair
> windows" yields, among a lot of other useful resources, the following
> relatively actively maintained ~150 LOC, BSD-3-clause-licensed,
> implementation:
> 
> https://github.com/ncm/selectable-socketpair
> 
> That license is GPL compatible, so should we consider including that
> implementation with git? That's the kind of stuff that goes to
> compat/win32, right?

Thanks for researching. Sticking that in compat/ would be our usual
strategy, yes.

> > I'm not sure I understand this comment. Even if SSL is not in use,
> > wouldn't we be passing a regular pipe to curl, which would break?
> 
> Yeah, we can't do that, and thus would have to keep the handwritten IMAP
> implementation just for the tunnel case (allowing to drop only the
> OpenSSL specific stuff), see my other email:
> http://www.mail-archive.com/git@vger.kernel.org/msg56791.html (the
> relevant part is pretty far down at the bottom).

I'd really love it if we could make this work with tunnels and
eventually get rid of the hand-written imap code entirely. I agree with
Jonathan that we probably need to keep it around a bit for people on
older curl, but dropping it is a good goal in the long run. That code
was forked from the isync project, but mangled enough that we could not
take bug fixes from upstream. As not many people use imap-send, I
suspect it is largely unmaintained and the source of many lurking
bugs[1]. Replacing it with curl's maintained implementation is probably
a good step.

-Peff

[1] That's my somewhat subjective opinion, but I feel like I have seen
    several bugs reported in imap-send that had literally been there for
    years. And having worked on IMAP implementations in a past life, I
    know there are many dark corners of the protocol that vary from
    server to server.
