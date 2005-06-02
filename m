From: Tony Lindgren <tony@atomide.com>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Thu, 2 Jun 2005 00:32:05 -0700
Message-ID: <20050602073205.GA31482@muru.com>
References: <Pine.LNX.4.58.0506011951150.1876@ppc970.osdl.org> <Pine.LNX.4.21.0506020223570.30848-100000@iabervon.org> <20050602071453.GA16616@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Nicolas Pitre <nico@cam.org>, Tony Lindgren <tony@atomide.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 09:32:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdkAU-0004Wq-7G
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 09:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVFBHds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 03:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVFBHds
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 03:33:48 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:34740 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261333AbVFBHc2
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 03:32:28 -0400
Received: from pimout5-ext.prodigy.net (pimout5-int.prodigy.net [207.115.4.21])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j527WO2G027774
	for <git@vger.kernel.org>; Thu, 2 Jun 2005 03:32:27 -0400
X-ORBL: [67.117.73.34]
Received: from torttu.muru.com (adsl-67-117-73-34.dsl.sntc01.pacbell.net [67.117.73.34])
	by pimout5-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j527WBdI184934;
	Thu, 2 Jun 2005 03:32:15 -0400
Received: by torttu.muru.com (Postfix, from userid 1000)
	id B7A1EBF459; Thu,  2 Jun 2005 00:32:06 -0700 (PDT)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050602071453.GA16616@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 02, 2005 at 09:14:53AM +0200, Matthias Urlichs wrote:
> Hi,
> 
> Daniel Barkalow:
> > If the lock is only to protect against someone else modifying HEAD after
> > we've checked that it is our starting point and before we modify it,
> > there's no reason not to hold the lock while pushing; it wouldn't block
> > anything other than someone doing a quick push in the middle of our long
> > one, and thereby causing us to dump a lot of useless objects on the
> > server (which will become obsolete as we will need to do the merge and
> > push a different version).
> > 
> The objects we push aren't going to be obsolete. The server needs them
> anyway, because our HEAD refers to them.

I don't think locking for the duration of the push really is a problem.
It is unlikely that there would be so many people pushing that it would
cause inconvenience... Of course it would be nice to optimize it if
possible.

> What if the connection dies in the middle of a push? You then sit there
> waiting for it, and the lock, to time out. OTOH, an atomic cmpxchg on
> the server can't block and can't timeout.
> 
> > you want to have the
> > client watch for the resolution of the other transfer one way or the
> > other, since you're in the current state precisely because you lost on
> > getting the lock and now definitely need the next version.
> > 
> I disagree. Given that you need to wait for the upload to finish anyway
> (whether you know it or not ;-) it makes sense to spend the time
> actually uploading -- upload speed is frequently lower than download
> for individuals.

I would assume the biggest problem for most people is how they can push
through a firewall. From that point of view it would make sense to do
the push as a cgi script rather than something over ssh. And with a
cgi script you can of course optimize the locking and use tmp files
before renaming which are a bit hard to do with rsync.

Tony
