From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Sun, 15 Apr 2007 00:31:46 -0400
Message-ID: <20070415043146.GB2229@spearce.org>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <Pine.LNX.4.64.0704141019290.18655@racer.site> <20070415000330.GG3778@curie-int.orbis-terrarum.net> <Pine.LNX.4.63.0704141655390.31807@qynat.qvtvafvgr.pbz> <20070415020139.GB2689@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 06:31:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcwP4-0001VL-IK
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 06:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbXDOEbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 00:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXDOEbv
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 00:31:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49883 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbXDOEbv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 00:31:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HcwOz-0004ez-JZ; Sun, 15 Apr 2007 00:31:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5E1A020FBAE; Sun, 15 Apr 2007 00:31:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070415020139.GB2689@curie-int.orbis-terrarum.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44486>

"Robin H. Johnson" <robbat2@gentoo.org> wrote:
> On Sat, Apr 14, 2007 at 05:02:47PM -0700, David Lang wrote:
> > > - Shallow history checkouts are important to our low-bandwidth
> > >  ebuild-tree developers (people in places with 33.6k modems, because
> > >  the phone lines don't work well enough for 56k), or other high latency
> > >  setups.
> >  note that for people on low-bandwideth lines, makeing too shallow a checkout 
> >  can actually end up costing more over time (they will have to pull full 
> >  revisions since they don't have the earlier versions to just pull a diff 
> >  against)

Mail them a DVD of the Git import, have them load it locally,
and use --reference for all future clones.  With Git its possible
to build fast throwaway trees from any random URL, so long as you
keep at least one repository available locally to act as a reference.

The speed at which a DVD (or small box of CDs) travels through the
various postal systems might very well be faster than 33.6k modem.
:-)
 
> I should have mentioned that we aren't following the kernel model here.
> All of the developers will have git+ssh access to the central tree, to
> push their own changes to it. On a similar tangent, in some subtrees
> (our documentation mainly) we have server-side validation tests before
> the commit is accepted. The 'update' hook documentation suggests that
> ACLs should be possible and implemented via that.

Yes.  I run probably the most paranoid update hook in existance.
If you want a copy let me know, I'll send it to you.  Its a Perl
script that verifies the 'committer ' line matches the UNIX uid (by
doing a table lookup) for every new commit or tag being introduced
to the repository.  It also verifies that the user can update that
branch, create it, delete it, or rewind it.

It sounds like you would need to add some additional rules about
specific paths being modified only by certain people in certain
branches (for the SELinux stuff), and running other validations in
the documentation (whatever that is).

> The tree that goes out to users is NOT git or CVS. What you point to
> here is impossible unless we forced all of the users to migrate to git
> (a truly herculean task if there was ever one).
> It's a tarball or an rsync of an automatically managed CVS checkout.
> (Tarballs go onto the release media, and are also widely used by those
> that sneaker-net their trees to machines for security reasons).
> Alternatively, the users browse the viewcvs, and pull something from the
> Attic. Regardless of where they get the file from, the problem is that
> the file doesn't contain any markers to help the developers merge it
> back again.

Git won't do this for you.  We specifically don't mangle source[*1*].

What you could do is create a program that mangles the files before
delivery.  You would probably want to do something like:

  $Id: 7fbf239:path/to/file$

where 7fbf239 is the earliest commit that introduced that particular
version of path/to/file, even if that is months old.  That would
be most like what CVS would do.  8 char abbreviated commits should
be reasonably stable, and not too long to read or copy and paste.
A format like the above would also be easy to grab and copy into
a Git command line.

If we had a Git library that could access the repository, this would
a pretty easy program to write.  You are basically blaming each path
in the current HEAD commit on the parent, until you cannot blame
anyone else for that path.  You do this blame on the entire tree,
and then output the munged structure (or only the files you want
munged).

Its good we have a GSoC project working on libification!  ;-)

[*1*] Yes, I'm ignoring the nutso crlf support that's now in...  Even
      though I work on Windows, the only true line ending is LF.  ;-)

-- 
Shawn.
