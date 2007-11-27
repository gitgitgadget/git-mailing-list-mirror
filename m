From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:48:04 -0500
Message-ID: <20071127014804.GJ14735@spearce.org>
References: <200711252248.27904.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 02:48:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwpYq-00069b-SF
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 02:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbXK0BsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 20:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbXK0BsJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 20:48:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43268 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbXK0BsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 20:48:08 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IwpYJ-0003kX-Mm; Mon, 26 Nov 2007 20:47:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B785920FBAE; Mon, 26 Nov 2007 20:48:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200711252248.27904.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66155>

Jakub Narebski <jnareb@gmail.com> wrote:
> If you would write git from scratch now, from the beginning, without 
> concerns for backwards compatibility, what would you change, or what 
> would you want to have changed?

- Sort tree entries by name, *not* by name+type

  This has got to be my biggest gripe with Git.  I think Linus really
  screwed the pooch with this.  We've talked it over a few times
  on the list and he and I have just agreed to disagree on this.

  Ask any database person and they'll tell you how wrong the
  current tree ordering is.  Or they are nuts and don't get
  the concept of data integrity.

  Linus' excuse is that the current ordering makes working with
  the flat index faster as its just one index file.  That doesn't
  mean that the flat index file can't contain tree information.
  Like it does in say that new fangled cache-tree extension.  :-)

  This particular "design decision" has brought all sorts of bugs
  into the system, like the D/F merge conflict issues, and even one
  from Linus himself when he first introduced the submodule support.
  Lets not even talk about ugly that made things in jgit.


- Loose objects storage is difficult to work with

  The standard loose object format of DEFLATE("$type $size\0$data")
  makes it harder to work with as you need to inflate at least
  part of the object just to see what the hell it is or how big
  its final output buffer needs to be.

  It also makes it very hard to stream into a packfile if you have
  determined its not worth creating a delta for the object (or no
  suitable delta base is available).

  The new (now deprecated) loose object format that was based on
  the packfile header format simplified this and made it much
  easier to work with.


- No proper libgit

  Already been stated but we don't have a great library and we
  don't have a good way to build one right now either.  A lot of
  our internal code assumes die() will abort the process.  That's a
  very bad assumption to be making inside of a library.


- Binary packed-refs representation

  I probably wouldn't have done an ASCII based packed-refs file,
  or heck, even loose refs.  I probably would have just gone with
  a binary file that we wholesale rewrite every time there is any
  sort of ref update.

  We already do this with the index.  So every time we update a
  file path we are rewriting the entire index.  And we update
  file paths a heck of a lot more often than we update branch
  heads.  Or tags.

  But tools like for-each-ref get invoked heavily, and fast access
  to the ref database is important to overall performance.


- No GIT_OBJECT_DIRECTORY vs. GIT_DIR distinction

  This is causing problems with $GIT_DIR/objects/info/alternates
  and then try to repack repositories.  Not having the ref space of
  the alternates and/or borrowers considered during repacking can
  cause all sorts of fun breakage that may be hard to recover from.
  Plus it means you have to do funny "refs/forkee" hacks just to
  avoid pushing unnecessary objects over the wire when the other
  end is borrowing objects.

  I probably would have had the object directory unified with its
  ref database, so that they cannot be accessed individually.


All of the above is written with 20/20 hindsight and all that.

Looking back (and knowing myself well) I think the only item I
would have gotten right if I had written Git from scratch is the
first one above (the tree entry ordering).  I probably would have
done something equally "as bad" as what we have today for all of
the others...

-- 
Shawn.
