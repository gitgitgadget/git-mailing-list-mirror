From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Thu, 11 Dec 2008 21:40:47 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812112045120.19665@iabervon.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com> <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com> <alpine.LNX.1.00.0811301509070.19665@iabervon.org>
 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com> <alpine.LNX.1.00.0812061238260.19665@iabervon.org> <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com> <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
 <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com> <alpine.LNX.1.00.0812081223140.19665@iabervon.org> <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com> <alpine.LNX.1.00.0812111520490.19665@iabervon.org>
 <7vy6ym9nm8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:42:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAxyh-0003k0-1D
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757169AbYLLCkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757195AbYLLCkt
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:40:49 -0500
Received: from iabervon.org ([66.92.72.58]:33967 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757089AbYLLCkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:40:49 -0500
Received: (qmail 30889 invoked by uid 1000); 12 Dec 2008 02:40:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Dec 2008 02:40:47 -0000
In-Reply-To: <7vy6ym9nm8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102864>

On Thu, 11 Dec 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> That's the point. CE_VALID does not define checkout area while
> >> CE_NO_CHECKOUT does.  If an entry is CE_VALID, it is still in checkout
> >> area. But if it is CE_NO_CHECKOUT, "git grep" should ignore that path.
> >> core.defaultsparse has nothing to do here.
> >
> > My point is that the index cannot tell git grep whether it should search a 
> > path if the path isn't in the index.
> 
> Let's step back a bit.  I think "git grep" that stays silent outside of
> the checkout area when used to grep in the work tree or in the index is a
> mistake.
> 
> The problem "sparse checkout" attempts to address is not this:
> 
>     I ran "git init && git add ." in /usr/src by mistake.  There is no
>     reason for coreutils that is in /usr/src/coreutils and gnucash that is
>     in /usr/src/gnucash to share the same development history nor their
>     should be any ordering between commits in these two independent
>     projects.  I should have done N separate "init & add" independently at
>     one level deeper in the directory hierarchy, but I am too lazy to
>     filter branch the resulting mess now.
> 
> At least, it should not be that, at least to me.
> 
> "Sparse" is "I am not going to modify the files in these areas, and I know
> they do not need to be present for my purposes (e.g. build), so I do not
> need copies in the work tree."  It still works on the whole tree structure
> recorded in the commit, but gives you a way to work inside a sparsely
> populated work tree, iow, without checking everything out.

There's the meta question of: "Do people who have declared that they 
aren't going to modify or build with some files want their searches to 
tell them about those files?"

Say I'm the "tr" guy, and I care about the build system, library code, and 
"tr.c", and I run "make tr"; my sparse checkout doesn't include "head.c", 
and I totally ignore all the other stuff that's in coreutils. Maybe I want 
"git grep" to exclude the other stuff.

I don't really have a firm position on whether "git grep" should ignore 
"head.c" or not, but I think it should be consistent between "git grep" 
and "git grep origin/next", and I think that, if origin/next has a new 
"foot.c" that isn't in the current branch to by marked as NO_CHECKOUT, it 
should be skipped if "tail.c" (which is in my current branch) is skipped.

> So "git grep -e frotz Documentation/", whether you only check out
> Documentation or the whole tree, should grep only in Documentation area,
> and "git grep -e frotz" should grep in the whole tree, even if you happen
> to have a sparse checkout.  By definition, a sparse checkout has no
> modifications outside the checkout area, so whenever grep wants to look
> for strings outside the checkout area it should pretend as if the same
> content as what the index records is in the work tree.  This is consistent
> with the way how "git diff" in a sparsely checked out work tree should
> behave.

"git diff" is an ambiguous model for "git grep". It equally describes 
the behavior of "git diff" to say that it treats files outside the 
checkout area as matching the index or to say that it never lists files 
outside the checkout area. On the other hand, there is the question of 
whether "git diff branch1 branch2" shows differences that are outside the 
checkout area, and whether "git log" shows commits that only change things 
outside the checkout area, and "git grep" should match the behavior of 
these.

	-Daniel
*This .sig left intentionally blank*
