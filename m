From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Mon, 8 Dec 2008 14:41:37 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812081223140.19665@iabervon.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>  <7voczz4cfb.fsf@gitster.siamese.dyndns.org>  <alpine.LNX.1.00.0811281938250.19665@iabervon.org>  <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>  <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>
  <alpine.LNX.1.00.0811301509070.19665@iabervon.org>  <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>  <alpine.LNX.1.00.0812061238260.19665@iabervon.org>  <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com> 
 <alpine.LNX.1.00.0812071455020.19665@iabervon.org> <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 20:43:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9m0R-0006cm-Hh
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 20:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYLHTlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 14:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbYLHTlk
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 14:41:40 -0500
Received: from iabervon.org ([66.92.72.58]:44787 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbYLHTlj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 14:41:39 -0500
Received: (qmail 27703 invoked by uid 1000); 8 Dec 2008 19:41:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Dec 2008 19:41:37 -0000
In-Reply-To: <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102577>

On Mon, 8 Dec 2008, Nguyen Thai Ngoc Duy wrote:

> On 12/8/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >  > This was discussed since the beginning of this feature. I recall that
> >  > the index reflects worktree, and because we mark CE_NO_CHECKOUT on
> >  > file basis, it's best to save the information there, not separately.
> >  > We do save high level information to form the checkout area (sparse
> >  > patterns) in the last half, but basically you should be able to live
> >  > without that.
> >
> >
> > We need to mark in the index the information that reflects the worktree.
> >
> >  If, however, we take CE_VALID to be the flag for "ignore the worktree
> >  entirely at this path; act as it if contains what the index contains" (and
> >  use this to cause that aspect of no-checkout), and we then entirely ignore
> >  the worktree, including not caring whether there are files there or not
> >  (except, of course, that in the transition from caring to not caring for
> >  no-checkout, we make the worktree empty, while in the case for
> >  "stat-is-expensive", we bring it into agreement with the index), then
> >  there is no additional information that needs to be conveyed in the index.
> 
> That's not enough. CE_VALID is "ignore the worktree files" while
> CE_NO_CHECKOUT is stricter: "those files does (or should) not exist".
> The difference is
> 
>  - for "git grep", we ignore path with CE_NO_CHECKOUT (while using
> cache version for CE_VALID)

Is this sufficient? I'd expect "git grep" to ignore paths that are outside 
the checked-out region, even when searching an arbitrary tree, and even 
when those files aren't in the index at all (i.e., the current commit 
doesn't have them). That is, I'd expect core.defaultsparse or the 
equivalent to limit the paths, normally giving this effect.

>  - porcelain-level support to widen/narrow checkout area will need
> CE_NO_CHECKOUT, not CE_VALID

This isn't a meaningful difference between CE_NO_CHECKOUT and CE_VALID if 
there aren't any other differences.

> >  > >  unless it's ever important to remember whether an entry is CE_VALID due to
> >  > >  having been outside the checkout when the index was written, even though
> >  > >  the checkout area now includes it. I don't have a good intuition as to
> >  > >  what ought to happen if the user manually changes what's specified for
> >  > >  checkout without actually updating the index and working tree.
> >  >
> >  > So if a user changes worktree without updating index, they will have
> >  > the same results as they do now: files are shown as modified if they
> >  > don't have CE_NO_CHECKOUT set. If those files do, they are considered
> >  > 'orphaned' or staled and are recommended to be removed/updated to
> >  > avoid unexpected consequences (not availble this this first half
> >  > series because that belongs to "git status").
> >
> >
> > I was actually thinking that there would be a file for "this is what the
> >  user wants to have checked out" (as opposed to the index, which must
> >  contain "this is what is checked out"), and the porcelain would instruct
> >  the plumbing as to what to do with the worktree (that the plumbing with
> >  then ignore, due to the index bit) based on this information.
> >
> >  The index obviously can't contain the user's full instructions for what
> >  should be checked out, because the user will want to say "I don't care
> >  about anything in Documentation/" and have this apply to
> >  Documentation/some-file-not-in-the-index, so that if this file is in the
> >  worktree, the user gets a warning.
> >
> >  I think you're doing this with core.defaultsparse, although you seem to
> >  allow the index to diverge from this easily.
> 
> Yes they can.
> 
> >
> >  The question, then, is what happens when the index and core.defaultsparse
> >  disagree, either because the porcelain supports causing it or because the
> >  user has simply editting the config file or used plumbing to modify the
> >  index. That is, (1) we have index entries that say that the worktree is
> >  ignored, and the rules don't say they're outside the sparse checkout; do
> >  we care whether we expect the worktree to be empty or match the index?
> >  And, (2) we have index entries that say we do care about them, but the
> >  rules say they're outside the sparse checkout; what happens with these?
> 
> The rule is CE_NO_CHECKOUT is king. core.defaultsparse only helps
> setting CE_NO_CHECKOUT on new entries when they enter the index.

This seems like a really bad idea to me. If you ask for a file that's 
outside your default area to be checked out, and then you switch branches 
and switch back, the file may or may not disappear (depending on whether 
the branch you switched to temporarily had it or not). Likewise, if you 
remove files, and then switch branches and back, the files may or may not 
reappear.

Of course, commands need to look at the index to determine what we've 
actually done with the worktree and index, but I think there should be 
some other location that is responsible for keeping track of what the user 
has asked for.

	-Daniel
*This .sig left intentionally blank*
