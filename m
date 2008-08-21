From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Call Me Gitless
Date: Thu, 21 Aug 2008 09:58:52 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808210928010.19665@iabervon.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7viqtukbec.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Trans <transfire@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 16:01:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWAhj-00028c-1o
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 15:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbYHUN6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 09:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbYHUN6y
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 09:58:54 -0400
Received: from iabervon.org ([66.92.72.58]:50975 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbYHUN6y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 09:58:54 -0400
Received: (qmail 5330 invoked by uid 1000); 21 Aug 2008 13:58:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Aug 2008 13:58:52 -0000
In-Reply-To: <7viqtukbec.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93149>

On Thu, 21 Aug 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Mon, 18 Aug 2008, Junio C Hamano wrote:
> > ...
> >>     If we had a configuration for "index-free" people, that changes the
> >>     semantics of "git add" to register object name of an empty blob when a
> >>     new path is added, makes "git add" for existing blobs a no-op, but
> >>     keeps "git commit -a" and "git commit <paths>" to operate as they
> >>     currently do, then people with such configuration could:
> >> 
> >> 	$ >new-file
> >>         $ git add new-file
> >>         $ edit old-file
> >>         $ edit new-file
> >>         $ git diff
> >> 
> >>     to always see what's the difference from the HEAD is with "git diff",
> >>     and any of these three:
> >> 
> >> 	$ git commit -a
> >>         $ git commit old-file
> >>         $ git commit old-file new-file
> >> 
> >>     would work as expected by them.  We still need to support the three
> >>     diff variants for normal git people, but people who do not use index
> >>     do not have to know the two variants ("git diff" vs "git diff HEAD");
> >>     such a change could be argued as a "UI improvement" [*1*].
> >
> > I think that having the possibility of adding an empty blob (or maybe a 
> > magical "nothing currently here but git-ls-files includes it") would be 
> > preferrable to a no-index mode.
> 
> I am not sure if you are really saying something different from what I am
> saying.  We'll see after this three patch series.  The first one is an
> unrelated bugfix (but the bug won't trigger with existing callers -- only
> triggered with the added codepath).

I see this primarily as something you can use if you're worried about 
leaving files out of commits. When you create the file, you can use "git 
add -N" to make sure that it won't get overlooked when you're adding 
things. If you weren't using the index for anything important, you could 
just use a normal add, but that would get confusing if you're adding 
completed changes as well as some half-written version of any file that 
happens to be new. That is, it'll let you cause "git diff" to report the 
contents as unstaged changes in your working tree, rather than not 
reporting it (either because it's not tracked at all, or because the 
changes are now staged). Then you can decide to stage them.

(The thing that I'd ideally like to have different is for:

$ echo "content" > new-name
$ git add -N new-name
$ git commit

Say:

# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#          added:   new-name
#
no changes added to commit (use "git add" and/or "git commit -a")

rather than committing the empty blob. But that's tricky to implement 
and keep from breaking other stuff and really minor; and the 
documentation doesn't exclude that being what happens with -N)

	-Daniel
*This .sig left intentionally blank*
