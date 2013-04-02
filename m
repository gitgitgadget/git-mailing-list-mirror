From: Jeff King <peff@peff.net>
Subject: Re: git https transport and wrong password
Date: Tue, 2 Apr 2013 16:05:51 -0400
Message-ID: <20130402200551.GA535@sigill.intra.peff.net>
References: <20130402155440.GT30514@lakka.kapsi.fi>
 <20130402192845.GC17784@sigill.intra.peff.net>
 <20130402194751.GV30514@lakka.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Mikko Rapeli <mikko.rapeli@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:06:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7TM-0006ka-E6
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610Ab3DBUF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:05:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52604 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761114Ab3DBUFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:05:55 -0400
Received: (qmail 13974 invoked by uid 107); 2 Apr 2013 20:07:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 16:07:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 16:05:51 -0400
Content-Disposition: inline
In-Reply-To: <20130402194751.GV30514@lakka.kapsi.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219874>

On Tue, Apr 02, 2013 at 10:47:51PM +0300, Mikko Rapeli wrote:

> Don't know anything about curl but maybe git could parse the url for a
> username and prompt for the password before the first 401 failure roundtrip
> that's now in place. I guess most of this logic is in http.c.

We used to do that but stopped, as curl might also be able to retrieve
the password from .netrc; the extra prompt was an annoyance to users
in this situation.

Now that we have the credential subsystem, I would recommend dropping
usernames from all git-over-http URLs, and either:

  1. Using a credential helper that supports secure long-term storage
     (osxkeychain, wincred, etc).

  2. Specifying the username to the credential subsystem explicitly, by
     putting something like:

       [credential "https://yourhost/"]
              username = yourusername

     in your git config.

Obviously (1) is nicer, but you may have corporate policies against
storing credentials. Or you may have a complicated single sign-on
procedure, where the password changes. In that case, I would still say
it is worth writing a custom helper script that can feed the temporary
credential to git.

-Peff
