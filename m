From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Contribute a fairly paranoid update hook
Date: Fri, 20 Apr 2007 23:39:20 -0400
Message-ID: <20070421033920.GC17480@spearce.org>
References: <20070420060847.GA8255@spearce.org> <7vmz131fzz.fsf@assigned-by-dhcp.cox.net> <20070420145923.GB17480@spearce.org> <f0bk15$c8m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 05:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf6Rf-0004F6-Fi
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 05:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbXDUDj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 23:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbXDUDj0
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 23:39:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34571 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbXDUDjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 23:39:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hf6RL-0005wV-BM; Fri, 20 Apr 2007 23:39:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9640E20FBAE; Fri, 20 Apr 2007 23:39:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <f0bk15$c8m$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45149>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
> 
> > I also recently hacked some semi-useful features into gitweb.cgi.
...
> If I can ask: what features? 

I added a "pending" action and link in the top navigation bar.
This page shows all of the topic branches that:

 - match a particular prefix string
   (e.g. "heads/test/pending/");
 - has commits not reachable through refs matching another prefix
   (e.g. "heads/test/approved/")
 - has commits not reachable through another specific ref
   (e.g. "heads/test/current").

These branches are sorted by name and show under their title a
shortlog of the "new commits" that aren't reachable by the latter
two sets of refs.

Sometimes branches fully contain another; these are identified under
both branches.  When this happens commits are only shown under one
of the two listings.

Here's a rough ASCII approximation of the pending page:

  fix1:

    Also bundled within:
    
      * set-of-fixes

    Shawn Pearce      don't be stupid, delete temp files

  fix2:

    Also bundled within:

      * set-of-fixes

    Shawn Pearce      don't leak printer handles

  set-of-fixes:

    Includes topics:

      * fix1:
      * fix2:

    Stewie Griffin    Merge 'tiny-fix1'
    Stewie Griffin    Merge 'tiny-fix2'
    Glenn Quagmire    Improve performance by sucking less

Each topic branch also has an "approve" link, which uses an "approve"
action to copy the branch (err, create a new branch with update-ref)
into the "heads/test/approved/" namespace.  This causes them to
fall out of the "pending" page when it reloads.

The approved page shows topics matching the "heads/test/approved/"
page, but that have commits not in "heads/test/current".  It looks
exactly like the pending page above, but has an "unapprove" link
to delete the ref from the "heads/test/approved/" directory.

Why?

Managers and testers want to choose the topic branches they will be
including into the next release, and they don't make that decision
until just before they ask the build manager to start creating
the build.  This gitweb interface lets them see the topics that
are ready for building, and make their selections.

The build manager can then sweep the entire "heads/test/approved/"
directory and merge everything not already merged into the current
branch.  Of course if a merge fails, or a compile fails, the build
manager stops and throws the mess back at the development team.

Bad merges or build failures happen less often than you might expect,
as we do have fairly good isolation between our topic branches.
During some periods of the year we don't think twice about using the
octopus driver to merge topics, and will merge 30+ topics at a clip
in just a minute or two, because they are all unrelated and isolated
changes that management has asked to go into a single release.

Most of the above code is actually fairly well isolated in
gitweb.cgi.  It turns out it was quite easy to add what I needed,
and to reuse a lot of the existing code.  I'll probably be able to
clean it up well enough to submit a patch.  Might take a few weeks.

-- 
Shawn.
