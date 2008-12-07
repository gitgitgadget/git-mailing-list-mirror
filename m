From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Sun, 7 Dec 2008 16:26:21 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>  <20081128192033.GF23984@spearce.org>  <7voczz4cfb.fsf@gitster.siamese.dyndns.org>  <alpine.LNX.1.00.0811281938250.19665@iabervon.org> 
 <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>  <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>  <alpine.LNX.1.00.0811301509070.19665@iabervon.org>  <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com> 
 <alpine.LNX.1.00.0812061238260.19665@iabervon.org> <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 07 22:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9RAS-0005GE-1x
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 22:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbYLGV0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 16:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbYLGV0b
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 16:26:31 -0500
Received: from iabervon.org ([66.92.72.58]:40115 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbYLGV0b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 16:26:31 -0500
Received: (qmail 26980 invoked by uid 1000); 7 Dec 2008 21:26:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Dec 2008 21:26:21 -0000
In-Reply-To: <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102507>

On Sun, 7 Dec 2008, Nguyen Thai Ngoc Duy wrote:

> On 12/7/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >  > There is not much work for CE_NO_CHECKOUT on plumbling level except
> >  > some fixes. The last half of the series, for porcelain level, you will
> >  > see more.
> >
> >
> > For the porcelain level, do we need the difference to be in the index? If
> >  the porcelain knows the sparse checkout area and can instruct the plumbing
> >  appropriately, the information shouldn't need to be stored in the index
> 
> This was discussed since the beginning of this feature. I recall that
> the index reflects worktree, and because we mark CE_NO_CHECKOUT on
> file basis, it's best to save the information there, not separately.
> We do save high level information to form the checkout area (sparse
> patterns) in the last half, but basically you should be able to live
> without that.

We need to mark in the index the information that reflects the worktree.

If, however, we take CE_VALID to be the flag for "ignore the worktree 
entirely at this path; act as it if contains what the index contains" (and 
use this to cause that aspect of no-checkout), and we then entirely ignore 
the worktree, including not caring whether there are files there or not 
(except, of course, that in the transition from caring to not caring for 
no-checkout, we make the worktree empty, while in the case for 
"stat-is-expensive", we bring it into agreement with the index), then 
there is no additional information that needs to be conveyed in the index.

> >  unless it's ever important to remember whether an entry is CE_VALID due to
> >  having been outside the checkout when the index was written, even though
> >  the checkout area now includes it. I don't have a good intuition as to
> >  what ought to happen if the user manually changes what's specified for
> >  checkout without actually updating the index and working tree.
> 
> So if a user changes worktree without updating index, they will have
> the same results as they do now: files are shown as modified if they
> don't have CE_NO_CHECKOUT set. If those files do, they are considered
> 'orphaned' or staled and are recommended to be removed/updated to
> avoid unexpected consequences (not availble this this first half
> series because that belongs to "git status").

I was actually thinking that there would be a file for "this is what the 
user wants to have checked out" (as opposed to the index, which must 
contain "this is what is checked out"), and the porcelain would instruct 
the plumbing as to what to do with the worktree (that the plumbing with 
then ignore, due to the index bit) based on this information.

The index obviously can't contain the user's full instructions for what 
should be checked out, because the user will want to say "I don't care 
about anything in Documentation/" and have this apply to 
Documentation/some-file-not-in-the-index, so that if this file is in the 
worktree, the user gets a warning.

I think you're doing this with core.defaultsparse, although you seem to 
allow the index to diverge from this easily.

The question, then, is what happens when the index and core.defaultsparse 
disagree, either because the porcelain supports causing it or because the 
user has simply editting the config file or used plumbing to modify the 
index. That is, (1) we have index entries that say that the worktree is 
ignored, and the rules don't say they're outside the sparse checkout; do 
we care whether we expect the worktree to be empty or match the index? 
And, (2) we have index entries that say we do care about them, but the 
rules say they're outside the sparse checkout; what happens with these?

Case (1) is where we would need to know, in the index, whether we expect 
the worktree to actually match the index (traditional CE_VALID) or whether 
we expect the worktree to be empty (CE_NO_CHECKOUT), if our behavior 
should actually differ. My vague feeling is that we don't want it to 
differ, and these paths are unexpectional "interesting to the user, but 
the worktree is ignored" until reading a tree into the index again. (But 
note that we will have to check on the worktree when reading into the 
index if this changes the index from "blobA, CE_VALID" to 
"blobA, !CE_VALID", since the worktree could differ in a way that we don't 
want to retain. And I think we want it to be an error to have the worktree 
be something other than blobA or nothing before, but "nothing" is fine and 
we just write it out. (This means that users of CE_VALID who remove files 
behind git's back may lose their removal work; but this is a pretty 
trivial danger).

	-Daniel
*This .sig left intentionally blank*
