From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 20:52:52 -0500
Message-ID: <20070122015252.GA26934@coredump.intra.peff.net>
References: <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net> <20070119034404.GA17521@spearce.org> <20070119104935.GA5189@moooo.ath.cx> <7vfya6hll3.fsf@assigned-by-dhcp.cox.net> <20070120111832.GA30368@moooo.ath.cx> <7vlkjw50nl.fsf@assigned-by-dhcp.cox.net> <20070121103724.GA23256@moooo.ath.cx> <7vejpo39zg.fsf@assigned-by-dhcp.cox.net> <20070121220114.GA24729@coredump.intra.peff.net> <45B415B1.30407@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 02:53:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8oMj-0004fy-ON
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 02:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbXAVBwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 20:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbXAVBwy
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 20:52:54 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4837 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751868AbXAVBwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 20:52:54 -0500
Received: (qmail 21588 invoked from network); 21 Jan 2007 20:53:13 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 21 Jan 2007 20:53:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Jan 2007 20:52:52 -0500
To: Steven Grimm <koreth@midwinter.com>
Content-Disposition: inline
In-Reply-To: <45B415B1.30407@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37383>

On Sun, Jan 21, 2007 at 05:38:57PM -0800, Steven Grimm wrote:

> >before B). However, that doesn't make sense for the commit operation, in
> >which you add blobs (with git-add), and then eventually construct a
> >tree.
> >  
> 
> Shouldn't the repository be locked against operations like prune while a 
> commit is in progress anyway? That seems like it's pretty prudent and 
> reasonable to me -- doing otherwise is just asking for a zillion little 
> race conditions. Prune should be a rare enough operation that having it 
> abort (or better, block) while a commit is going on wouldn't be a big 
> problem, I'd think.

I was a bit loose with my phrase 'commit operation'. What I really mean
is:

$ git add file   ;# (1)
$ hack hack hack ;# (2)
$ git commit     ;# (3)

After step (1), you have a blob in your db. If you already had that
blob, then you have the old blob. You don't get the updated tree and
commit until step (3). Step (2) can be hours or days. Do you really want
to lock the repository that long?

Potentially we could 'touch' the blob in step (1) to update its
timestamp. But if we update timestamps for things like commit, then that
might mean 'touch'ing tens of thousands of objects for a commit which
_should_ only require making a few objects.

-Peff
