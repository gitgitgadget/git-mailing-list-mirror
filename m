From: Jeff King <peff@peff.net>
Subject: Re: Forcing git to pack objects
Date: Sun, 20 Dec 2015 02:41:07 -0500
Message-ID: <20151220074106.GE30662@sigill.intra.peff.net>
References: <CAOc6etZePL=yvy=fVt9e=RmwdStJy6Kf621icYbYOER-NyMvXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 08:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAYcE-0000vU-Me
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 08:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbbLTHlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 02:41:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:44654 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754102AbbLTHlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 02:41:09 -0500
Received: (qmail 21323 invoked by uid 102); 20 Dec 2015 07:41:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Dec 2015 01:41:09 -0600
Received: (qmail 11255 invoked by uid 107); 20 Dec 2015 07:41:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Dec 2015 02:41:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Dec 2015 02:41:07 -0500
Content-Disposition: inline
In-Reply-To: <CAOc6etZePL=yvy=fVt9e=RmwdStJy6Kf621icYbYOER-NyMvXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282762>

On Fri, Dec 18, 2015 at 07:03:39PM -0600, Edmundo Carmona Antoranz wrote:

> Recently I was running manually a git gc --prune command (wanted to
> shrink my 2.8G .git directory by getting rid of loose objects) and I
> ended up running out of space on my HD. After freaking out a little
> bit (didn't know if the repo would end up in a 'stable' state), I
> ended up freeing up some space and I again have a working repo...
> _but_ I noticed that basically _all_ objects on my repo are laying
> around in directories .git/objects/00 to ff (and taking a whole lot of
> space... like the .git directory is now like 5 GBs). After running git
> gc manually again it ended up taking a lot of time and the objects are
> still there. Also git svn sometimes gcs after fetching and it took to
> run cause of the gc execution (ended up killing it) and the files are
> still there. Is it possible to ask git to put all those objects in
> .pack files? Or did I mess something on my repo?

It sounds like these objects aren't reachable from any of your refs.
That would explain:

 - why they don't get packed; we only pack reachable objects.

   There's no easy way with "git gc" or "git repack" to pack unreachable
   objects. If you drop down to the "git pack-objects" level, you can
   manually convince it to do so.

   I have a patch to add "git repack -k", which packs even unreachable
   objects (we use this at GitHub, since our routine repository
   maintenance never deletes objects). If people are interested, I can
   clean it up and post it to the list.

 - why your repo grew during the gc; packed unreachable objects are
   exploded into loose objects during a gc, so they can age and expire
   on their own (we use filesystem mtimes to determine how old they
   are).

   Git is smart enough not to explode loose objects that it is just
   going to prune in a moment.  But the default expiration time is 2
   weeks, so there's a good chance it would want to keep some of them.

   If you use "git gc --prune=now", that should prune everything
   immediately (and this is safe, as long as you know there are no
   simultaneous users of your local repository).

-Peff
