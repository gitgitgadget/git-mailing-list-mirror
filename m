From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT] [PATCH RFC v1 0/5] Add (static) ignore functionality to
	EGit
Date: Sun, 5 Apr 2009 14:02:48 -0700
Message-ID: <20090405210248.GA23604@spearce.org>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:04:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZVu-0002Ov-6L
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758225AbZDEVCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757154AbZDEVCu
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:02:50 -0400
Received: from george.spearce.org ([209.20.77.23]:42462 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbZDEVCu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:02:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2619738211; Sun,  5 Apr 2009 21:02:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cover.1238102327.git.ferry.huberts@pelagic.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115708>

Ferry Huberts <ferry.huberts@pelagic.nl> wrote:
> This is the first - early - code that adds ignore functionality to EGit.
> Currently it reads in all ignore patterns upon workspace startup into an
> ignore cache. From this cache the ignore state of a resource is evaluated
> in the same fashion as git does.
> 
> The code does not yet react to changes in ignore files but I'm planning to add
> that soon and I can share a lot of code for that.
> 
> I send this code to receive feedback and to give you insight into what I'm
> doing with it. I'm new both to EGit programming and Eclipse programming so
> there might be things that could be done more elegantly :-)

Ok, I finally got a chance to review this series.


We really want as much of the Git specific logic as we can in JGit
under the BSD license.  This has already been raised elsewhere in
this thread.

JGit and EGit are holding the line on Java 5 support; that means
that String.isEmpty() must be spelled as String.length() == 0
(isEmpty was added in Java 6).

Style nit: Don't put /* Constructors */, /* Methods */ or
  / * Public Methods */ comments in code, e.g.
  IgnoreProjectCache l.52-54 or GitIgnoreData l.58-61.

Style nit: Don't assign fields to their default values.

  E.g. Exclude.java l.25,33,42,.. these are being set to the
  same value that the JRE sets the field to if the field is not
  explicitly initialized.  We find it much easier to read code when
  the defaults are assumed.

Style nit: Don't use "this." to refer to members.

  Your IDE should highlight field references differently than
  parameters, and a parameter should never shadow a field name,
  thus "this." is unnecessary and makes the code much more verbose
  to read.  E.g. see Exclude.java 's constructor on l.87-108; I can't
  see the forest (the code) due to all the trees (this.) appearing.

IgnoreFileOutside: Ugh, our own implementation of IFile ?

  I'm worried about the long-term stability of the IFile API.
  Is it really frozen enough that we can implement it ourselves?
  Of course, this may be moot if much of the code was moved back
  to JGit.

IgnoreRepositoryCache: Why not put this into RepositoryMapping?

  Instead of caching it inside a static HashMap of GitIgnoreData,
  wouldn't it be better to put it into RepositoryMapping?
  The TrackOperation for example already has the RepositoryMapping
  handle in scope, saving a few lookup operations, and avoiding
  needing to manage this new additional static HashMap against leaks.


I kind of wanted to tie exclude processing (and attribute processing)
into a TreeWalk, so that we can do an n-way merge against trees and
working directories by tossing all of their AbstractTreeIterators
into a single walk, possibly apply a path filter, and let the walk
handle the per-directory ignore rules as it goes.

Most of your code seems to be built around the Eclipse IResource
model, and the idea that it gets called for a single file path
at a time, which may make it less efficient when we put it into a
TreeWalk and apply the notion of entering and exiting a subdirectory.


OK, that's about all I have for now.  Its reasonable, but still an
early series.
 
-- 
Shawn.
