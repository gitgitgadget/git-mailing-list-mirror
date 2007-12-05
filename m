From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: .git/svn disk usage
Date: Wed, 5 Dec 2007 00:54:52 -0800
Message-ID: <20071205085451.GA347@soma>
References: <65dd6fd50712022217l5f807f31pf3f00d82c3dccf5c@mail.gmail.com> <loom.20071203T182924-435@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Voit <david.voit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 09:55:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izq2E-000401-GH
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 09:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbXLEIyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 03:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbXLEIyy
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 03:54:54 -0500
Received: from hand.yhbt.net ([66.150.188.102]:46775 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbXLEIyx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 03:54:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A8AB17DC025;
	Wed,  5 Dec 2007 00:54:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20071203T182924-435@post.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67126>

David Voit <david.voit@gmail.com> wrote:
> Ollie Wild <aaw <at> google.com> writes:
> 
> > 
> > Hi,
> > 
> > I've been using git-svn to mirror the gcc repository at
> > svn://gcc.gnu.org/svn/gcc.  Recently, I noticed that my .git directory
> > is consuming 11GB of disk space.  Digging further, I discovered that
> > 9.8GB of this is attributable to the .git/svn directory (which
> > includes 200 branches and 2,588 tags).  Given that my .git/objects
> > directory is 652MB, it seems that it ought to be possible to store
> > this information in a more compact form.
> > 
> > I'm curious if other developers have run into this issue.  If so, are
> > there any proposals / plans for improving the storage of git-svn
> > metadata?
> > 
> > Thanks,
> > Ollie
> > 
> 
> Hi all,
> 
> I've seen the same effect, so i tried to reduce the size of the revdb and made a
> new format:
> First, in the bin files the sha1 are stored as hexvalues not as ascii, this
> reduces the a single sha1 from 41 bytes to 20.
> Second, only save the non-zero commits, thats what the idx are used for.
> A idx file has three 32bit integers per entry.
> The first integer represents the first zero svn revision, the second the last
> zero revision and the last integer is the position of the next non-zero revision
> in the bin.
> 
> Example:
> Revision 0-373006 are zero revision and 373007 is the first actualy used revision
> and 373008-373623 are again zero revisions
> the idx has the following content:
> 0 373006 0
> 373007 373007 1
> 
> and the bin only saves
> 59037b8043268c9ca0d87ba86519ed0b5358c8a1
> eef3f7e25993a46e3c4242aa502d93e909b08c57

I'd very much like rev_db to be smaller, but I find the idea of the data
relying on a separate index too fragile and difficult to recover
from if corruption occurs (mainly for --no-metadata users).

The rev_db is simply a lookup for mapping SVN revision numbers to
git commit SHA1s.

I have an idea for a more compact .rev_db format:

  All records are 24 bytes:
    4 bytes for a 32-bit integer representing the SVN revision
    20 bytes for the git commit SHA1

  rev_db is an append-only format, so the 32-bit integer will be
  monotonically increasing over time, which allows:

  Lookups by revision number done via binary search:

  Which means empty revisions never need to be entered anymore.

Of course there needs to be a migration strategy for existing
repositories (mainly the ones using --no-metadata), too.

Users not using --no-metadata (nor the option for svk metadata) can just
remove their .rev_db* files and git-svn will automatically recreate them
as needed.

> The format currently used produce a 373624*41bytes large file.
> 
> Used on a git-svn clone here, i get:
> The results are:
> old:
> 1,1G    hadoop (1004M   svn/)
> new:
> 47M     hadoop (5,9M    svn/)

Very nice reduction!

> Here a example sourcecode to test this idea:
> 
> I try to integrate this in git-svn this week.
> 
> NOTE: I'm not a perl hacker, so use at your own risk.
> 
> Bye David
> ps.: I'm not a member of this list please reply directly to me.

If you don't have time, I'll try to implement my ideas sometime this
week or weekend (assuming I have time, too).

-- 
Eric Wong
