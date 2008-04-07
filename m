From: David Mansfield <david@cobite.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation
	and	broken branch imports
Date: Mon, 07 Apr 2008 13:54:05 -0400
Organization: Cobite
Message-ID: <1207590845.17329.98.camel@gandalf.cobite.com>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
	 <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de>
	 <1207230582.17329.39.camel@gandalf.cobite.com>
	 <47F5FA79.8010604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 07 19:55:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JivYY-00086C-5o
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 19:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYDGRyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 13:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbYDGRyO
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 13:54:14 -0400
Received: from 208.36.103.2.ptr.us.xo.net ([208.36.103.2]:55115 "EHLO
	iris.cobite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751632AbYDGRyN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 13:54:13 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by iris.cobite.com (Postfix) with ESMTP id 06074DFEAE;
	Mon,  7 Apr 2008 13:54:12 -0400 (EDT)
X-Virus-Scanned: amavisd-new at cobite.com
Received: from iris.cobite.com ([127.0.0.1])
	by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xaQ8aBB9PodJ; Mon,  7 Apr 2008 13:54:05 -0400 (EDT)
Received: from [208.222.80.105] (208.36.103.2.ptr.us.xo.net [208.36.103.2])
	by iris.cobite.com (Postfix) with ESMTP id 7A771DFEAD;
	Mon,  7 Apr 2008 13:54:05 -0400 (EDT)
In-Reply-To: <47F5FA79.8010604@alum.mit.edu>
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78982>


On Fri, 2008-04-04 at 11:52 +0200, Michael Haggerty wrote:
> David Mansfield wrote:
> > The main issue with git-cvsimport stems from an unfixable problem.
> > cvsps's design goal is to show commits in chronological order.  Based
> > solely on this data, it's impossible to always reconstruct a branch
> > point (or a tag) since a person could have committed files after someone
> > else's commit, but not done an update then tagged.  
> 
> Just to be more explicit, I think you are talking about a situation like
> this:
> 
> 1. Add file1:1.1 and file2:1.1 to repository.
> 2. User1 modifies file1 and commits file1:1.2.
>    ...some non-negligible amount of time passes...
> 3. User2 modifies file2 and commits file2:1.2.
> 4. User2, without updating file1 to revision 1.2, adds a tag.
> 
> This results in a tag that refers to file1:1.1 and file2:1.2, even
> though those two revisions never appeared in the repository at the same
> time.
> 

More or less, yes.  It gets worse if a user does 'cvs update' in a
directory, or on an individual file.


> > So some files are from before the 'other' user's commit, and some files
> > after.  What can you do?  
> 
> You can do the only thing that is consistent with the CVS
> history--create the tag not from a single source revision but from
> multiple revisions.  Unfortunately, git cannot handle this directly, but
> there is a workaround using a "fixup branch" [1].
> 
> cvs2svn/cvs2git [2] creates a "fixup branch", copies file1:1.1 and
> file2:1.2 onto that branch, then creates the tag from the fixup branch.
>  This ensures that checking the tag out of git gives the same file
> contents as checking the tag out of CVS.  I think that git-cvsimport
> gets this wrong (!?!)
> 
> It is your framing of the problem that is leading to the impossibility.
>  CVS's design does *not* require that a tag or branch is created in a
> single commit, nor that it is created from a single source revision.
> Trying to impose these artificial constraints means that the resulting
> git repository is inconsistent with the CVS repository in quite common
> circumstances.
> 

It's not 'my framing of the problem.'  It's 'the design goal of cvsps is
not compatible with the desire to use the output of cvsps to create a
git repository.'  See the difference?

> > It's not per se a flaw in cvsps, it always wanted to show commits in
> > chronological order, but it is a severe limitation in using cvsps to
> > generate changesets for git.
> 
> cvs2git always creates commits in chronological order too, but its
> output is by design always consistent with the CVS record.
> 

Yes.  That's what cvs2git was designed for.  Look at the name.  In order
to create the 'fixup' branch, you have to make some out of operations,
which is fine if that's what your design goal is.

The design goal of cvsps was always simply to show who did what and in
what chronological order.  However, just with that, it's impossible to
use for the purpose it is currently being used for.

The 'fixup branch' sounds like a really great idea and an elegant
solution.

> > By engineering a direct tool (such as parsecvs, I presume) these
> > obstacles can be overcome by constructing some commits that were never
> > made by the actual users of the cvs repo in order to get it right.
> > 
> > I'm not sure exactly how this is done, because I've never looked at
> > parsecvs.
> 
> cvs2git's design is documented quite extensively, if you are interested
> [3].  Parsecvs, AFAIK, uses a similar approach.
> 

I'm quite happy that there are other tools, and even more happy if they
already fix every bug that git-cvsimport has.

I was simply addressing the bug from the standpoint of: this issue can
be fixed without compromising what cvsps wants to be as a tool.

The place where the fixup branch logic needs to be is in git-cvsimport,
not in cvsps.  Better yet, get rid of git-cvsimport and replace it with
cvs2git if it works better.  

However, if possible, I'd like to fix problems with the
cvsps/git-cvsimport if possible, unless someone can tell me for sure
that it's obsolete and noone uses it.

Thanks,
David
