From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 16:28:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com> 
 <20070824062106.GV27913@spearce.org>  <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
  <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 01:29:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOib5-0006xJ-PD
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 01:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbXHXX3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 19:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbXHXX3o
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 19:29:44 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55228 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750911AbXHXX3n (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 19:29:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7ONSx5k002667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Aug 2007 16:29:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7ONSwU8020251;
	Fri, 24 Aug 2007 16:28:58 -0700
In-Reply-To: <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
X-Spam-Status: No, hits=-2.75 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56613>



On Fri, 24 Aug 2007, Jon Smirl wrote:
> 
> We're going something wrong in git-daemon.

Nope.

Or rather, it's mostly by design.

> I can clone the tree in five minutes using the http protocol. Using the 
> git protocol would take 24hrs if I let it finish.

The http side doesn't actually do any global verification, the way 
git-daemon does. So to it, everything is just temporary buffers, and you 
don't need any memory at all, really.

git-daemon will create a packfile. That means that it has to generate the 
*global* object reachability, and will then optimize the object packing 
etc etc. That's a minimum of something like 48 bytes per object for just 
the object chains, and the kernel has a *lot* of objects (over half a 
million).

In addition to the object chains yourself, the native protocol will also 
obviously have to actually *look* at and parse all the tree and commit 
objects while it does all this, so while it doesn't necessarily keep all 
of those in memory all the time, it will need to access them, and if you 
don't have enough memory to cache them, that will add its own set of IO.

So I haven't checked exactly how much memory you really want to have to 
serve big projects, but with some handwavy guesstimate, if you actually 
want to do a good job I'd guess that you really want to have at least as 
much memory as the size of largest project you are serving, and probably 
add at least 10-20% on top of that.

So for the kernel, at a guess, you'd probably want to have at least 256MB 
of RAM to do a half-way good job. 512MB is likely nicer and allows you to 
actually cache the stuff over multiple accesses.

But I haven't actually tested. Maybe it might be bearable at 128M.

			Linus
