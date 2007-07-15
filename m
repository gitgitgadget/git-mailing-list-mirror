From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Questions about git-fast-import for cvs2svn
Date: Sun, 15 Jul 2007 20:51:42 +0200
Message-ID: <F06A5876-BA2A-4172-B2D1-BBCFF92C83EF@zib.de>
References: <469A2B1D.2040107@alum.mit.edu> <20070715120149.3271b736.seanlkml@sympatico.ca>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jul 15 20:51:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA9BP-0005pB-Ku
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 20:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbXGOSu7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 14:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbXGOSu7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 14:50:59 -0400
Received: from mailer.zib.de ([130.73.108.11]:59391 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbXGOSu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 14:50:58 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6FIomQV003526;
	Sun, 15 Jul 2007 20:50:48 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10151.pool.einsundeins.de [77.177.1.81])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6FIofp2027632
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 15 Jul 2007 20:50:45 +0200 (MEST)
In-Reply-To: <20070715120149.3271b736.seanlkml@sympatico.ca>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52577>


On Jul 15, 2007, at 6:01 PM, Sean wrote:

> On Sun, 15 Jul 2007 16:11:41 +0200
> Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> [...]
>
>> 3. I expect we should set 'committer' to the value determined from  
>> CVS
>> and leave 'author' unused.  But I suppose another possibility  
>> would be
>> to set the 'committer' to 'cvs2svn' and the 'author' to the  
>> original CVS
>> author.  Which one makes sense?
>
> Another option is to just allow Git to set author and committer to the
> same value.  As noted in the man page: "If author is omitted then
> fast-import will automatically use the committer's information for
> the author portion of the commit".

I expect that committer and author would both be set to the value
determined from CVS. CVS doesn't differentiate and I think the
most reasonable assumption in many CVS settings is that the one
who committed a change is the original author.


>> 4. It appears that a commit can only have a single 'from', which I
>> suppose means that files can only be added to one branch from a  
>> single
>> source branch/revision in a single commit.  But CVS branches and tags
>> can include files from multiple source branches and/or revisions.   
>> What
>> would be the most git-like way to handle this situation?  Should the
>> branch be created in one commit, then have files from other sources
>> added to it in other commits?  Or should (is this even possible?) all
>> files be added to the branch in a single commit, using multiple  
>> "merge"
>> sources?

This is really a hard question, which I feel unable to answer.
My feeling is that you would not be able to construct a git
history where branches would need multiple 'froms'. git always
tracks the complete state of all files in the project. So
you can only branch all files at once or no file at all.
It's really hard to say how the situation you described can
be handled.

However, I have a related comment.

Well maintained CVS branches shouldn't suffer from this problem. In
our repository we typically set a tag topic-split on the CVS trunk
and create the branch topic-branch from this tag. Note, some time may
pass before we commit the first change to topic-branch. I'd expect that
a CVS to git importer should handle this situation perfectly. I'd expect
that the git tag topic-split would be set to the last commit common
to the git branch representing the CVS trunk and the git branch
representing the CVS topic-branch. git-cvsimport fails to do so if
the timing of the first commit to the CVS topic-branch is wrong.

To be honest, we have messy branches as well that start off in an
uncontrolled way. But I'd care less about them than about the well
maintained branches.

Michael,
what do you think. Would cvs2svn perfectly handle the well-formed
CVS branches I described?

I already would be very happy if the well-formed branches can be
imported to git and any malformed branch would be reported.

Maybe a second step could be to import malformed branches nonetheless,
perhaps in a non-standard way and give a hint what the difficulty was.
A human may have a chance to fix it using git tools, such as
git-filter-branch or similar.


> Git supports the ability to merge from multiple branches at once  
> (known
> as an octopus merge).  So it's possible to start a new branch, drawing
> in files from more than one source branch in a single commit.  As i
> understand it, fast-import allows only a single "from" line for a  
> commit,
> but allows multiple "merge" lines for additional parentage info.
>
> [...]

I'm not sure if merges help to solve the situation described by Michael.
 From my understanding the situation is more like starting a branch and
later 'cherry-picking' commits from various other branches at different
times. Michael describes a situation where a branch would need to start
from multiple commits. I think this is different from merging.

I propose not to create any merge commits during import from CVS to git.
CVS doesn't track merges and therefore I'd expect that the history  
created
in git during import should form a tree (without merges). If you have
a custom way to detect merges for a specific CVS repository (e.g. by  
parsing
CVS commit messages) you can use a grafts file to add them to git later.

	Steffen
