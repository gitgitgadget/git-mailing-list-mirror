From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn failure when symlink added in svn
Date: Mon, 30 Apr 2007 08:43:59 -0700
Message-ID: <20070430154359.GD1800@untitled>
References: <alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org> <loom.20070428T144858-521@post.gmane.org> <7virbgjthr.fsf@assigned-by-dhcp.cox.net> <m2odl8fjv1.fsf@ziti.fhcrc.org> <7v7irwjql6.fsf@assigned-by-dhcp.cox.net> <m2k5vwfbf6.fsf@ziti.fhcrc.org> <7vwszwi0h2.fsf@assigned-by-dhcp.cox.net> <m2irbfqlze.fsf@ziti.local> <20070429182649.GD12375@untitled> <m24pmxrkgt.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 17:44:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiY31-0006sE-WB
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 17:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423431AbXD3PoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 11:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423433AbXD3PoK
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 11:44:10 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35767 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423431AbXD3PoI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 11:44:08 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 42E347DC0A0;
	Mon, 30 Apr 2007 08:44:06 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 30 Apr 2007 08:43:59 -0700
Content-Disposition: inline
In-Reply-To: <m24pmxrkgt.fsf@ziti.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45870>

Seth Falcon <sethfalcon@gmail.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Seth Falcon <sethfalcon@gmail.com> wrote:
> >> Eric: is there any way to undo some of the svn revs that have been
> >> retrieved using git-svn fetch and then refetch them? 
> 
> > Assuming you're not using something crazy like noMetadata, you can just
> > use update-ref on the remote heads to the last known good revisions and
> > remove the associated .rev_db files.
> >
> > Otherwise you'll have to delete entries from the .rev_db files, the
> > format is one line per-revision, the revision is the line number of the
> > file.
> 
> Hmm, not sure I understood.  Here's what I tried:
> 
> I'm tracking two branches via git-svn.  For each, I used git log
> remotes/<branch> to find a revision that I expect to be ok and noted
> the sha1.  Then I did: 
> 
>     git-update-ref remotes/git-svn a27b11c1

You may need to specify "refs/": "refs/remotes/git-svn".
Is there a .git/remotes/git-svn ref file now?

> and similar, but with different sha1 for the other branch.  Next I
> removed the .rev_db* files (there was one for each svn branch) and
> tried doing git-svn fetch.  This seemed to rebuild the .rev_db, but
> eventually I ended up with:
> 
> Done rebuilding .git/svn/git-svn/.rev_db.00db46b3-68df-0310-9c12-caf00c1e9a41
>         M       src/<somepath>
>         M       src/<another>
> Incomplete data: Delta source ended unexpectedly at /Users/seth/scm/bin/git-svn line 2982
> 
> And if I rerun git svn fetch, I get:
> 
> Index mismatch: 9c07a6009029e4a1d834ff126f705c4db3c4bce7 != 67dc53678f759c52a93a281f13fadb08799f86b2
> rereading 0f12c8c092600c8a3337ec35d153d3a76ce2329d
>         M       src/<somepath>
>         M       src/<another>
> Incomplete data: Delta source ended unexpectedly at /Users/seth/scm/bin/git-svn line 2982
> 
> 
> [where <somepath> and <another> are the same in both cases]
> 
> Did I miss a step or misunderstand how to undo?  What's strange is
> that if I do git show 0f12c8c, I see a patch that is looks like it came
> from a fetch using the my broken version of git-svn -- do I need to
> clear out objects before refetching?

I might have left some steps (I've been all over the place lately :/).
You probably need to do all that and also need to edit
.git/svn/.metadata and set the {branches,tags}-maxRev fields to the last
known good revisions if you use globs.

Also you can try removing the index files inside .git/svn (but they
*should* be auto-checked and rebuilt (as they were in the second
"git-svn fetch" run you did...

-- 
Eric Wong
