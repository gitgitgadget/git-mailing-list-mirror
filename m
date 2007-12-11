From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 14:26:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712111410370.5349@iabervon.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> 
 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
 <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:27:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Al2-0004mO-KJ
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbXLKT0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbXLKT0t
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:26:49 -0500
Received: from iabervon.org ([66.92.72.58]:44785 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbXLKT0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:26:48 -0500
Received: (qmail 19066 invoked by uid 1000); 11 Dec 2007 19:26:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Dec 2007 19:26:46 -0000
In-Reply-To: <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67914>

On Tue, 11 Dec 2007, Daniel Berlin wrote:

> On 12/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> >
> > On Tue, 11 Dec 2007, Daniel Berlin wrote:
> > >
> > > This seems to be a common problem with git. It seems to use a lot of
> > > memory to perform common operations on the gcc repository (even though
> > > it is faster in some cases than hg).
> >
> > The thing is, git has a very different notion of "common operations" than
> > you do.
> >
> > To git, "git annotate" is just about the *last* thing you ever want to do.
> > It's not a common operation, it's a "last resort" operation. In git, the
> > whole workflow is designed for "git log -p <pathnamepattern>" rather than
> > annotate/blame.
> >
> I understand this, and completely agree with you.
> However, I cannot force GCC people to adopt completely new workflow in
> this regard.
> The changelog's are not useful enough (and we've had huge fights over
> this) to do git log -p and figure out the info we want.
> Looking through thousands of diffs to find the one that happened to
> your line is also pretty annoying.
> Annotate is a major use for gcc developers as a result
> I wish I could fix this silliness, but i can't :)
> 
> > That said, I'll see if I can speed up "git blame" on the gcc repository.
> > It _is_ a fundamentally much more expensive operation than it is for
> > systems that do single-file things.
> 
> SVN had the same problem (the file retrieval was the most expensive op
> on FSFS). One of the things i did to speed it up tremendously was to
> do the annotate from newest to oldest (IE in reverse), and stop
> annotating when we had come up with annotate info for all the lines.
> If you can't speed up file retrieval itself, you can make it need less
> files :)
> In GCC history, it is likely you will be able to cut off at least 30%
> of the time if you do this, because files often have changed entirely
> multiple times.

Unfortunately, we're doing that already. One improvement that is already 
available is that we can do progressive annotate: we can output lines we 
find in the order we find them, such that lines that changed recently 
(which are usually the more interesting ones) get annotated quicker. 
Obviously, you need a GUI-ish thing to do this, because pagers don't like 
having stuff written out of order, but there's a good chance that a user 
annotating fold-const.c will have the info for the interesting lines in a 
few seconds, and go on while git is still trying to find where the boring 
old lines came from.

There's also the possibility of generating caches of commit:file pairs 
you've annotated, which would make generating the annotation for something 
you'd annotated for a recent commit blindingly fast.

	-Daniel
*This .sig left intentionally blank*
