From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer at any
 time
Date: Tue, 1 Dec 2009 18:59:02 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912011852030.5582@cone.home.martin.st>
References: <25718488.post@talk.nabble.com> <20091127234110.7b7e9993.rctay89@gmail.com> <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st> <alpine.DEB.2.00.0912011236360.5582@cone.home.martin.st> <20091201161428.GC21299@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:59:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFW4y-0006IS-DR
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbZLAQ7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbZLAQ7k
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:59:40 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:55527 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753973AbZLAQ7j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:59:39 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi1.inet.fi (8.5.014)
        id 4B03EE3D00916B98; Tue, 1 Dec 2009 18:59:43 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <20091201161428.GC21299@spearce.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134229>

On Tue, 1 Dec 2009, Shawn O. Pearce wrote:

> In the case of git-receive-pack requests, we might be uploading an
> entire project to an empty repository on the remote side.  This could
> be 8 GiB worth of data if the project was something huge like KDE.
> We can't assume that we should malloc 8 GiB of memory to buffer
> the payload.

True, fair enough. This was mostly a proof of concept of how this could be 
implemented, but with these comments for you, it's clear that this isn't a 
feasible solution at all. There's no acute need for it either.

> The *correct* way to support an arbitrary rewind is to modify the
> outgoing channel from remote-curl to its protocol engine (client.in
> within the rpc_service method) to somehow request the protocol engine
> (aka git-send-pack or git-fetch-pack) to stop and regenerate the
> current request.

That's a good idea!

> Another approach would be to modify http-backend (and the protocol)
> to support an "auth ping" request prior to spooling out the entire
> payload if its more than an http.postBuffer size.  Basically we
> do what the "Expect: 100-continue" protocol is supposed to do,
> but in the application layer rather than the HTTP/1.1 layer, so
> our CGI actually gets invoked.

That's also quite a good idea, especially if it would be done in a way so 
that it's certain that the same curl session will be reused, instead of 
getting a potentially new curl session when using get_active_slot().

> This unfortunately still relies on the underlying libcurl to not
> discard the authentication data after that initial "auth ping".
> But to be honest, I think that is a reasonable expectation.  The
> #@!*@!* library should be able to generate two requests back-to-back
> to the same URL without needing to rewind the 2nd request.

Yeah, as long as the same curl session is preserved, this should be no 
problem.

// Martin
