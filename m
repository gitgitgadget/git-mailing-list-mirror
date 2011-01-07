From: Jeff King <peff@peff.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Fri, 7 Jan 2011 16:56:31 -0500
Message-ID: <20110107215631.GA10343@sigill.intra.peff.net>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
 <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
 <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
 <20110107052207.GA23128@sigill.intra.peff.net>
 <20110107053119.GA23177@sigill.intra.peff.net>
 <20110107185218.GA16645@LK-Perkele-VI.localdomain>
 <20110107191719.GA6175@sigill.intra.peff.net>
 <20110107214501.GA29959@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Jan 07 22:57:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbKIw-0007iE-4v
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 22:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170Ab1AGV4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 16:56:37 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38232 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145Ab1AGV4e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 16:56:34 -0500
Received: (qmail 18856 invoked by uid 111); 7 Jan 2011 21:56:33 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 07 Jan 2011 21:56:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jan 2011 16:56:31 -0500
Content-Disposition: inline
In-Reply-To: <20110107214501.GA29959@LK-Perkele-VI.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164769>

On Fri, Jan 07, 2011 at 11:45:01PM +0200, Ilari Liusvaara wrote:

> > I'm not clear in your example what ~/repositories/linux-2.6 is. Is it a
> > repo? In that case, isn't that basically the same as --reference? Or is
> > it a local mirror list?
> 
> Yes, it is a repo. No, it isn't the same as --reference. It is list
> of mirrors to try first before connecting to final repository and can
> be any type of repository URL (local, true smart transport, smart HTTP,
> dumb HTTP, etc...)

OK, I understand what you mean. I was thrown off by your example using a
local repository (in which case you probably would want --reference to
save disk space, unless the burden of alternates management is too
much).

So yeah, I think we are on the same page, except that you were proposing
to pass the mirror directly, and I was proposing passing a mirror file
which would contain a list of mirrors. Yours is much simpler and would
probably be what people want most of the time.

> > If the latter, then yeah, I think it is a good idea. Clients should
> > definitely be able to ignore, override, or add to mirror lists provided
> > by servers. The server can provide hints about useful mirrors, but it is
> > up to the client to decide which methods are useful to it and which
> > mirrors are closest.
> 
> This is essentially adding mirrors to mirror list (modulo that mirrors
> are not assumed to be complete).

I think there should always be an assumption that mirrors are not
necessarily complete. That is necessary for bundle-like mirrors to be
feasible, since updating the bundle for every commit defeats the
purpose.

It would be nice for there to be a way for some mirrors to be marked as
"should be considered complete and authoritative", since we can optimize
out the final check of the master in that case (as well as for future
fetches). But that's a future feature. My plan was to leave space in the
mirror list for arbitrary metadata of that sort.

> > Of course there are some servers who will want to do more than hint
> > (e.g., the gentoo case where they really don't want people cloning from
> > the main machine). For those cases, though, I think it is best to
> > provide the hint and to reject clients who don't follow it (e.g., by
> > barfing on somebody who tries to do a full clone). You have to implement
> > that rejection layer anyway for older clients.
> 
> With option like this, a client could do:
> 
> git clone --use-mirror=http://git.example.org/base/foo git://git.example.org/foo
> 
> To first grab stuff via HTTP (well-packed dumb HTTP is very light on the
> server) and then continue via git:// (now much cheaper because client is
> relatively up to date).

Yes, exactly.

-Peff
