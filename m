From: Stephen Bash <bash@genarts.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 21:42:56 -0400 (EDT)
Message-ID: <8043579.526738.1287452576766.JavaMail.root@mail.hq.genarts.com>
References: <20101018051702.GD22376@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 03:43:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P81EZ-0002Cb-Ms
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 03:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab0JSBnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 21:43:06 -0400
Received: from hq.genarts.com ([173.9.65.1]:51321 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753610Ab0JSBnF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 21:43:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id E1D221E2635D;
	Mon, 18 Oct 2010 21:43:03 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TGdhKE5rNGz3; Mon, 18 Oct 2010 21:42:56 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id CF0721E26351;
	Mon, 18 Oct 2010 21:42:56 -0400 (EDT)
In-Reply-To: <20101018051702.GD22376@kytes>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159301>

----- Original Message -----
> From: "Ramkumar Ramachandra" <artagnon@gmail.com>
> To: "Stephen Bash" <bash@genarts.com>
> Sent: Monday, October 18, 2010 1:17:05 AM
> Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
> 
> [sorry about the delayed reply; was ill]

No problem!  It's taken me more than 12 hours to actually compose a response (literally, I hit "Reply All" over 12 hours ago!), I don't think I can complain :)
 
> Stephen Bash writes:
> > Converting to Git using svn-fe
> > ------------------------------
> > I was
> > pointed to David Barr's svn-dump-fast-export tool:
> >    http://github.com/barrbrain/svn-dump-fast-export
> 
> So you used the version that supports dumpfile v2 that's merged into
> git.git `master`.

Yes, thanks for the clarification.
 
> > Extracting SVN's History
> > ------------------------
> > First we want to understand SVN's branching/tagging history. Modify
> > buildSVNTree.pl as necessary, then run
> >    perl buildSVNTree.pl > svnBranches.txt
> 
> > ...
>
> Unnecessary

I'm going to collapse all these comments because I think we're coming at this from different angles.  I agree, discovering the copies in git is "easy" (albeit an n^2 operation), and git will correctly identify file content.  But when I was asked to preserve the SVN history, I decided to extract a DAG from SVN and migrate that DAG to Git.  Thus the history itself is preserved (sans merges), not just the contents of the files.  This is the purpose of buildSVNTree.  I can elaborate further if requested.

> > There's also some logic in buildSVNTree to determine if a branch/tag
> > is deleted in the SVN head. That information is used by
> > hideFromGit.
> 
> It'll be in the revision history in Git anyway- it doesn't require
> special handling.

See below.

> > Ah, I should probably mention: svn-fe can produce "empty"
> > commits, and filterBranch does nothing to remove them. By "empty" I
> > mean there will be a commit object without any content changes. So
> > creating a branch/tag in SVN creates a commit, but doesn't change
> > content. That commit will be part of the new Git history.
> > Similarly, filterBranch will create git tags from svn tags, but they
> > point to one of these "empty" commits rather than the branch they
> > are tagged from. It's not very git-ish, but it seems to work...
> 
> Oh, I didn't realize that fast-import allows the creation of empty
> commits. We should probably fix this?

To be precise: svn-fe creates commits where
  git diff-tree treeA treeB
is empty with treeA being the tree object of /trunk/project and treeB being the tree of /branches/foo/project.  This version of my tools does not squash these commits, a future version probably will (this may cause problems with two-way communication?).

> > filterBranch is probably the longest step of the process; there's a
> > lot of filtering going on. It will be very verbose on STDOUT, so I
> > recommend tee'ing to a file or a terminal with infinite scroll back.
> > It also involves a lot of disk hits (somewhat reduced if $tempdir is
> > a RAM disk), and potentially a lot of space (it will create a git
> > repo for every branch/tag in your subversion history). For our
> > repository this step took about 1.5-2 hours IIRC.
> 
> Wow, this really brute-force.

Yes it is.  If I get around to writing a new version, I'll at least advance to a single pass using commit-tree.  Beyond that I'm probably into the fast-import code, which I'll happily leave to the rest of you :)

> > Note that SVN rev to Git commit can be one to many!
>
> Unless there's a one-to-one mapping between Git revisions and SVN
> revisions, a two-way bridge will become very difficult to build. Can
> you think of any scenarios where a one-to-one mapping doesn't make
> sense?

I have 32 SVN revs in my history that touch multiple Git commit objects.  The simplest example is
  svn mv svn://svnrepo/branches/badBranchName svn://svnrepo/branches/goodBranchName
which creates a single SVN commit that touches two branches (badBranchName will have all it's contents deleted, goodBranchName will have an "empty commit" as described above).  The more devious version is the SVN rev where a developer checked out / (yes, I'm not kidding) and proceeded to modify a single file on all branches in one commit.  In our case, that one SVN rev touches 23 git commit objects.  And while the latter is somewhat a corner case, the former is common and probably needs to be dealt with appropriately (it's kind of a stupid operation in Git-land, so maybe it can just be squashed).
 
> Grafts and filter-branch. db-svn-filter-root does this more elegantly.

I found a 'db-svn-filter-root' branch, but it was not entirely obvious to me what code I should be looking at...
 
> > Hiding 'Deleted' Branches
> > -------------------------
> 
> Hm. You didn't include the history of deleted branches in the main
> repository. Why? 

The commit objects are still there, I simply moved the refs to refs/hidden/{heads,tags}.  Because my goal was to maintain the full SVN history I needed to somehow protect the objects from garbage collection.  At the time I didn't know about "git merge -s ours", so this strategy achieved my goal of protecting the objects.  In this case, the refs are not cloned, but are fetch-able, so I found it to be a reasonable solution.

> Does it make sense to provide the user an option to
> exclude some (deleted) branches in the SVN history? It'll make the
> two-way mapping extremely difficult.

I think there are cases where a user could say "I don't care about dead development branches".  In my current system, all branches, even those that do not contribute back to the trunk are saved in the hidden namespace.  But I could see users that don't care about some or all extraneous branches and would be happy to not convert them or to let them be garbage collected.
 
> Thanks for the interesting and insightful read :)

I'm glad it's stimulating conversation.  I'm beginning to wonder if there might be competing design goals for one-way vs. two-way compatibility...  Performance is one place where opinions probably greatly differ (I didn't mind taking an extra 30 minutes to mirror my SVN repo because it probably saved more than that in communication overhead later in the process, but that mirror operation is very taxing on your timeline); my exhaustive search of all SVN copies is another (I wanted to be *extremely* certain I knew about all the misplaced branches/tags, but it's inefficient for a casual developer who just wants to interact with an SVN server).  It's all just food for thought, and I'm happy to carry on the conversation from my different point-of-view :)

Thanks,
Stephen
