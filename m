From: Sascha Cunz <sascha-ml@babbelbox.org>
Subject: Re: upload-pack is slow with lots of refs
Date: Thu, 04 Oct 2012 23:52:13 +0200
Message-ID: <7939878.c2fCDAx1ds@blacky>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com> <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com> <20121003201316.GA4484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:43:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtjn-00033L-U5
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab2JDVwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 17:52:09 -0400
Received: from babbelbox.org ([83.133.105.186]:43908 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592Ab2JDVwH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 17:52:07 -0400
Received: (qmail 13401 invoked from network); 4 Oct 2012 21:52:43 -0000
Received: from p54aecf98.dip.t-dialin.net (HELO blacky.localnet) (sascha@babbelbox.org@84.174.207.152)
  by babbelbox.org with ESMTPA; 4 Oct 2012 21:52:43 -0000
User-Agent: KMail/4.9.2 (Linux/3.5.3-gentoo; KDE/4.9.2; x86_64; ; )
In-Reply-To: <20121003201316.GA4484@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207020>

Am Mittwoch, 3. Oktober 2012, 16:13:16 schrieb Jeff King:
> On Wed, Oct 03, 2012 at 12:41:38PM -0700, Shawn O. Pearce wrote:
> > > Out of curiosity, how are you thinking about triggering such a new
> > > behavior in a backwards-compatible way? Invoke git-upload-pack2, and
> > > fall back to reconnecting to start git-upload-pack if it fails?
> > 
> > Basically, yes. New clients connect for git-upload-pack2. Over git://
> > the remote peer will just close the TCP socket with no messages. The
> > client can fallback to git-upload-pack and try again. Over SSH a
> > similar thing will happen in the sense there is no data output from
> > the remote side, so the client can try again. This has the downside of
> > authentication twice over SSH, which may prompt for a password twice.
> > But the user can get out of this by setting remote.NAME.uploadpack =
> > git-upload-pack and thus force the Git client to use the current
> > protocol if they have a new client and must continue to work over SSH
> > with an old server, and don't use an ssh-agent.
> 
> It's a shame that we have to reestablish the TCP or ssh connection to do
> the retry. The password thing is annoying, but also it just wastes a
> round-trip. It means we'd probably want to default the v2 probe to off
> (and let the user turn it on for a specific remote) until v2 is much
> more common than v1. Otherwise everyone pays the price.

Would it be possible to use this workflow:

- Every client connects per default to v1

- If server is capable of v2, it sends a flag along with the usual response
  (A v1 server will obviously not send that flag)

- If client is also capable of v2 and gets the flag, it enables v2 for
  just that remote (probably unless the user said, "i never want to")

- Next time the client connects to that remote it will use v2.

I'm not sure, if this is possible, since I think to remember that I have read 
in the Documentation folder something along the line: Capabilities announced 
from the server mean "I want you to use exactly these flags".

Sascha
