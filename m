From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Thu, 11 Dec 2008 15:30:45 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812111520490.19665@iabervon.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>  <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>  <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>  <alpine.LNX.1.00.0811301509070.19665@iabervon.org> 
 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>  <alpine.LNX.1.00.0812061238260.19665@iabervon.org>  <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>  <alpine.LNX.1.00.0812071455020.19665@iabervon.org> 
 <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>  <alpine.LNX.1.00.0812081223140.19665@iabervon.org> <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 21:32:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAsCf-0007QB-LL
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 21:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756937AbYLKUau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 15:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755977AbYLKUau
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 15:30:50 -0500
Received: from iabervon.org ([66.92.72.58]:38214 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757894AbYLKUar (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 15:30:47 -0500
Received: (qmail 13062 invoked by uid 1000); 11 Dec 2008 20:30:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Dec 2008 20:30:45 -0000
In-Reply-To: <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102819>

On Thu, 11 Dec 2008, Nguyen Thai Ngoc Duy wrote:

> On 12/9/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >  >  - for "git grep", we ignore path with CE_NO_CHECKOUT (while using
> >  > cache version for CE_VALID)
> >
> >
> > Is this sufficient? I'd expect "git grep" to ignore paths that are outside
> >  the checked-out region, even when searching an arbitrary tree, and even
> >  when those files aren't in the index at all (i.e., the current commit
> >  doesn't have them). That is, I'd expect core.defaultsparse or the
> >  equivalent to limit the paths, normally giving this effect.
> 
> That's the point. CE_VALID does not define checkout area while
> CE_NO_CHECKOUT does.  If an entry is CE_VALID, it is still in checkout
> area. But if it is CE_NO_CHECKOUT, "git grep" should ignore that path.
> core.defaultsparse has nothing to do here.

My point is that the index cannot tell git grep whether it should search a 
path if the path isn't in the index. If I do a narrow checkout of only 
Documentation/, and I do "git grep foo", I won't see files that aren't in 
Documentation/; if I do "git grep foo origin/next", I think I shouldn't 
see files that aren't in Documentation/, and "new-program.c" isn't in my 
index at all, marked as CE_NO_CHECKOUT or otherwise, so git grep can't 
find out from the index whether that file is outside my area of interest. 
It needs to be able to determine that "only Documentation/ is in the 
checkout area" ignoring the details of the list of files in the working 
directory currently in or out of the area.

> >  > >  The question, then, is what happens when the index and core.defaultsparse
> >  > >  disagree, either because the porcelain supports causing it or because the
> >  > >  user has simply editting the config file or used plumbing to modify the
> >  > >  index. That is, (1) we have index entries that say that the worktree is
> >  > >  ignored, and the rules don't say they're outside the sparse checkout; do
> >  > >  we care whether we expect the worktree to be empty or match the index?
> >  > >  And, (2) we have index entries that say we do care about them, but the
> >  > >  rules say they're outside the sparse checkout; what happens with these?
> >  >
> >  > The rule is CE_NO_CHECKOUT is king. core.defaultsparse only helps
> >  > setting CE_NO_CHECKOUT on new entries when they enter the index.
> >
> >
> > This seems like a really bad idea to me. If you ask for a file that's
> >  outside your default area to be checked out, and then you switch branches
> >  and switch back, the file may or may not disappear (depending on whether
> >  the branch you switched to temporarily had it or not). Likewise, if you
> >  remove files, and then switch branches and back, the files may or may not
> >  reappear.
> 
> Well, if you set core.defaultsparse properly, those files should
> appear/disappear as you wish (and as of now if you define your
> checkout area with "git checkout --{include-,exclude-,}sparse" then
> core.defaultsparse should be updated accordingly). I don't say
> core.defaultsparse is perfect.

Right, so in order to get reasonable behavior, the user must use 
--{include,exclude}-sparse. I think that this should be the *default* 
behavior, and probably the *only porcelain-supported* behavior, because 
otherwise it's confusing.

	-Daniel
*This .sig left intentionally blank*
