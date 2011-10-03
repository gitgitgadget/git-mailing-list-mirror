From: Jeff King <peff@peff.net>
Subject: Re: Branches & directories
Date: Sun, 2 Oct 2011 23:07:23 -0400
Message-ID: <20111003030723.GA24523@sigill.intra.peff.net>
References: <CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
 <CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
 <CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
 <CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
 <CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
 <CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
 <CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
 <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
 <4E889813.8070205@gmail.com>
 <CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 05:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAYsR-0002uS-HR
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 05:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953Ab1JCDH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 23:07:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51352
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580Ab1JCDHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 23:07:25 -0400
Received: (qmail 22871 invoked by uid 107); 3 Oct 2011 03:12:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 02 Oct 2011 23:12:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Oct 2011 23:07:23 -0400
Content-Disposition: inline
In-Reply-To: <CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182617>

On Sun, Oct 02, 2011 at 04:40:14PM -0700, Hilco Wijbenga wrote:

> That's however not the scenario that I'm talking about. I'm talking about doing
> 
> git checkout branch
> git checkout master
> 
> or
> 
> git stash
> git stash pop
> 
> In both cases all files (or at least all affected files, in case of
> git stash) get the current time as their timestamp instead of the
> timestamp they had before. This is forcing (completely unnecessary)
> rebuilds. *Nothing* has changed but I have to do a complete rebuild
> (well, I suppose I could "touch" all build artifacts and such but I'm
> sure you get the idea).
> 
> I understand *why* it's happening (it's simply reusing the existing
> Git functionality) but in the scenarios above nothing has really
> changed, I should be able to pick up from where I left off, shouldn't
> I?

No. There are cases where that will fool timestamp-based tools. The
problem is that the build products are not tracked by git, and so they
are not changed when you switch branches. But the timestamps of build
products and branches are compared.

So let's imagine you have two branches, with two different versions of
foo.c, both of which use "make" to build them into foo.o. Their
timestamps are from an hour ago and two hours ago. And that git restores
those old timestamps. You do:

  git checkout master
  make

Now foo.c is one hour old (from master). But foo.o is only a few seconds
old (it was just created by make. Now you do:

  git checkout branch
  make

Now foo.c is two hours old (from branch). But foo.o is still new, so
make doesn't rebuild it, which is an error.

Or did you really mean your example literally, as in you run two
checkouts back to back, without running anything in between, and the
second checkout restores the state before the first one. In that case,
yes, it would be correct to keep the old timestamps. But this is an
optimization that can only apply in a few very specific cases. And
moreoever, how can git know when it is OK to apply that optimization? It
has no idea what commands you might have run since the last time we were
at "master".

-Peff
