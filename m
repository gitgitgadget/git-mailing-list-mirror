From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 16:06:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511301514500.25300@iabervon.org>
References: <20051128234256.1508.qmail@science.horizon.com>
 <7vhd9wngn6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511301235390.25300@iabervon.org>
 <7vsltdsxzb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 22:07:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhZ9b-0001bJ-O3
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 22:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVK3VGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 16:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVK3VGK
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 16:06:10 -0500
Received: from iabervon.org ([66.92.72.58]:30222 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750739AbVK3VGI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 16:06:08 -0500
Received: (qmail 30800 invoked by uid 1000); 30 Nov 2005 16:06:39 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Nov 2005 16:06:39 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsltdsxzb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13016>

On Wed, 30 Nov 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Mon, 28 Nov 2005, Junio C Hamano wrote:
> >
> >> *1* It is a shame that the most comprehensive definition of
> >> 3-way read-tree semantics is in t/t1000-read-tree-m-3way.sh test
> >> script.
> >
> > Isn't Documentation/technical/trivial-merge.txt more comprehensive?
> 
> It describes the multi-base extention while the old one was done
> before the multi-base, so content-wise it may be more up to date.
> 
> One thing I have most trouble with is that it is not obvious if
> the table is covering all the cases.  You have to read from top
> to bottom and consider the first match as its fate [*1*]. 

I actually had that problem with the original tables; there isn't a 
canonical order in which to list a table of all of the possible matches 
and non-matches between items so as to be complete.

Perhaps it ought to list, on each line, which previous cases would match, 
so that you could see that case 2 is really the conditions of 2 minus the 
conditions for 2ALT, which is "all of the ancestors are empty, the head 
has a directory/file conflict, and remote exists."

It can't fall off the table, because 1, 2, 3, 4, 6, 7, 9, and 11 cover all 
of the possibilities with respect to inputs being empty, and do not care 
about matching between the inputs.

> I was about to write "with no match resulting in no merge", but it is
> not even obvious if there are cases that would fall off at the
> end from the table by just looking at it.  Even worse, if we add
> "no match results in no merge" at the end, by definition it
> covers all the cases, but it is not obvious what those fall-off
> cases are (IOW, what kinds of conflict they are and why they are
> not handled).
> 
> Another thing, perhaps more important, is taht it does not seem
> to talk about index and up-to-dateness requirements much; it
> says something about what happens when "no merge" result is
> taken, but it is not clear about other cases.  The table in
> t1000 test marks the case with "must match X" when index and
> tree X must agree at the path, and with "must match X and be
> up-to-date" when in addition the file in the working tree must
> match what is recorded in the index at the path (i.e. the former
> can have local modification in the working tree as long as index
> entry and tree match).

But that is redundant information. I was actually confused by that part of 
the table for a long time, because it was not clear that it followed a 
couple of simple rules (which I give above the table), and weren't 
actually chosen on a case-by-case basis.

The implementation I did is actually much easier to verify, because it 
doesn't go into each case for the index requirements, but checks the 
actual rules: the index must match either the head or (if there is one) 
the merge result, and the index must not be dirty if there is a "no merge" 
result. Therefore, you can't lose any work in the index (either you didn't 
have any, or you did the same thing), and you can't lose any work in the 
working tree (either you didn't have any, or we're not going to use the 
working tree).

Last time we discussed it ("Multi-ancestor read-tree notes"), you said:

  I like the second sentence in three-way merge description.  That
  is a very easy-to-understand description of what the index
  requirements are.

> This is vital in making sure that read-tree 3-way merge does not
> lose information from the working tree.  I am sure your updated
> *code* is doing the right thing, but the documentation is not
> clear about it.  E.g. case 3ALT in the table says "take our
> branch if the path does not exist in one or more of common
> ancestors and the other branch does not have it" without saying
> anything about index nor up-to-dateness requirements. 

"If the index exists, it is an error for it not to match either the
 head or (if the merge is trivial) the result."

"A result of "no merge" is an error if the index is not empty and not
 up-to-date."

So the index is permitted to not exist (you missed this case), but if it 
exists, it must match HEAD (or, well, HEAD, which is the result). The 
index need not be up-to-date (since the result is not "no merge"), so the 
working tree doesn't matter.

> > Probably the tables in various other places should be replaced with 
> > references to this document.
> 
> I agree 100% that having them scattered all over is bad and the
> trivial-merge.txt is the logical place to consolidate them, but
> I do not think simply removing others and pointing at
> trivial-merge.txt without updating it is good enough.

Certainly, your complaints about the table should be addressed first. I 
think I'd addressed all your complaints from last time, but at that point, 
we got sidetracked into a discussion of the details of case #16.

	-Daniel
*This .sig left intentionally blank*
