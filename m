From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: git https transport and wrong password
Date: Tue, 2 Apr 2013 22:47:51 +0300
Message-ID: <20130402194751.GV30514@lakka.kapsi.fi>
References: <20130402155440.GT30514@lakka.kapsi.fi>
 <20130402192845.GC17784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:48:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7Bu-0003J2-LN
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413Ab3DBTry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:47:54 -0400
Received: from mail.kapsi.fi ([217.30.184.167]:43978 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932401Ab3DBTrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:47:53 -0400
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UN7BP-0003Y5-HH; Tue, 02 Apr 2013 22:47:51 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UN7BP-0007g5-F6; Tue, 02 Apr 2013 22:47:51 +0300
Content-Disposition: inline
In-Reply-To: <20130402192845.GC17784@sigill.intra.peff.net>
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mikko.rapeli@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219865>

On Tue, Apr 02, 2013 at 03:28:45PM -0400, Jeff King wrote:
> We get redirected somewhere where we provide the (presumably wrong)
> credential again. I do not think that is git's fault; the server asked
> us to make the extra request. Is that part of the lockout procedure? If
> it is not, it seems odd that the server would issue a redirect for a
> bogus auth (shouldn't it just keep giving us 401?).

I think it is supposed to be a catch all failure mode without any
authentication but is just wrong/buggy. I'll try to debug these by
issuing curl commands step by step.

> I do not know what is going on with the redirection there, but I have a
> hunch on the extra auth round-trip.  What does your remote URL look
> like? Does it have your username (e.g., https://user@host/project.git)?

Yes, that's the giturl format I have.

> I have noticed that if curl sees such a URL, it attempts to do a
> password-less authentication itself, before even handing control back to
> git. So my above sequence would become:
> 
>   1. git feeds URL to curl, who makes request
>   2. we get a 401
>   3. curl says "Oh, I have a username; let me try that" and re-requests
>   4. we get another 401, because we need a password
>   5. curl says "that didn't work" and hands control back to git
>   6. git requests a password from the user and gives it to curl
>   7. curl retries with the password, but it's wrong, so that results in
>      a 401, too
> 
> At the end of it, we've now made _two_ failed requests for user X,
> rather than one. I don't know if there's a way to tell curl not to try
> the extra user-only round-trip. But you can strip the username out of
> your URL to avoid it.

It did seem like there was just one GET and 401 return before password
was promptet. I'll tripple check that.

Played around with command line curl a bit and at least it did the right
thing with a URL without username -- failed with 401 after single try --
and with URL without username but username provided -u 'username' which
succeeded or failed on single try based on password.

Don't know anything about curl but maybe git could parse the url for a
username and prompt for the password before the first 401 failure roundtrip
that's now in place. I guess most of this logic is in http.c.

-Mikko
