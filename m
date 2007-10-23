From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 08:03:38 -0400
Message-ID: <20071023120338.GG27132@thunk.org>
References: <20071023012140.GC22997@thunk.org> <7vtzoi8voo.fsf@gitster.siamese.dyndns.org> <20071023020044.GA27132@thunk.org> <20071023040522.GX14735@spearce.org> <20071023043321.GC27132@thunk.org> <20071023044657.GC14735@spearce.org> <20071023045632.GD27132@thunk.org> <20071023050726.GD14735@spearce.org> <20071023053003.GE27132@thunk.org> <20071023054238.GE14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 14:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkIUU-0001g5-Rx
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 14:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbXJWMD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 08:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbXJWMD7
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 08:03:59 -0400
Received: from THUNK.ORG ([69.25.196.29]:54954 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbXJWMD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 08:03:58 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IkIe7-0002hi-0G; Tue, 23 Oct 2007 08:14:07 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IkITy-0008J1-Bp; Tue, 23 Oct 2007 08:03:38 -0400
Content-Disposition: inline
In-Reply-To: <20071023054238.GE14735@spearce.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62128>

On Tue, Oct 23, 2007 at 01:42:38AM -0400, Shawn O. Pearce wrote:
> Yes.  But you need the prior value of the branch so you can do
> something easy like:
> 
> 	git checkout yourtopic
> 	git rebase --onto $newtopic $oldtopic
> 
> which means you probably need to look through the logs for not just
> pu but also pu@{1}.  A script to break out the topic branches from
> pu post fetch and store them as proper tracking branches would make
> this easier, but that much.  If you plan ahead you can save that
> $oldtopic point so you can do something like this:
> 
> 	git log pu ; # find $newtopic
> 	git checkout yourtopic
> 	git rebase --onto $newtopic base-yourtopic
> 	git tag -f base-yourtopic $newtopic

Yeah, I had thought about writing a little script that would take my
project's topic branches, and then push them out into the public
repository under topics/ad/extents-testcases or
topics/tt/badblocks-cleanup.  That would make it easy to find the head
of your topic, and once you find that, the base of your-topic isn't
that hard to find, since it would just be the result of "git-rev-list
topic ^master | tail -1".

One of the reasons I was thinking the above is because most of the
patches are coming into my end as emailed patch series, and I end up
tweaking them a lot as I carry them around in the topics branch.  So
if other people want to see what I've done to a branch after I've done
a git rebase --interactive, it's easier if they can get access to the
individual topics branch, so they can extract out the patch series
while it's being tweaked by me (and possibly others).

This is probably because my view of git has been colored by kernel
community practices, where patches are normally perfected and get
rebased a lot (normally in a sub-maintainer or maintainer's tree)
before they get pushed to Linus, and in my mental model a topic branch
represents the maintainer's git tree in the central repository.

The extreme end of this would be the classical BitKeeper model, where
Larry McVoy once argued to me that he didn't like history to *ever* be
rewound/rewritten, since not only did this interfere with other people
trees once they had been pushed, but it causes development history to
be lost, which is always valuable.  (Of course, in the end he did
write "bk fold", which squashes the last N commits into 1, mainly due
to customer pressure.)  The kernel viewpoint is to rebase all the
time, because the history is so huge that we don't *want* to see the
development history of the rough drafts of features before they get
merged into mainline.

> It keeps the history shorter in gitk.  But otherwise it isn't bad.
> Unless you are running into a lot of conflicts every time you rebase
> and its wasting your time.  ;-)

It sounds like what you are saying here is that the git.git tree takes
a viewpoint which is slightly between the extremes of the kernel model
(which does involve resolving rebasing a lot and resolving lots of
conflicts, but heh, that's not Linus's problem, that's been pushed out
to the leafs of the developer community, and besides, it strongly
encourages topics to get merged into the mainline fast), and the
classical Bitkeeper model, which says that philosophical goodness
means you should keep *all* development history once it enters the BK SCM.

With git.git, we are essentially throwing away development history
while it is in 'pu', but once a commit graduates to 'next', we do keep
the development history forever.  The downside to this is that
development 'crud' can build up in next; even if all substantive
commits in 'next' end up graduating to 'master', there will still be
lots of merge commits that will only be in 'next'.   

I have an emotional bias which tends to treat that excess history as
toxic waste to be avoided at all costs, but that's probably because
when you have a git tree as huge as the kernel, life is easier if the
history is kept as clean as possible.  

Which I suppose is easy enough to do in the git.git model; if you
throw away the 'next' branch and then rewind it so it is forked off of
'master' all of that history essentially gets flushed.  The downside
is that people maintaining topics branches which were forked against
the old 'next' will need to do some grotty work to rebase their
patches, so any attempt to rewind next would probably require the
central maintainer to give plenty of notice, and then on the flag day,
save 'next' as 'old-next' before rewinding to allow the other
developers to more easily rebase any private branches they might have.

Hmm, interesting.  A lot of this is quite subtle, or at least the
impacts of different choices in the git workflow really didn't become
obvious to me until I started trying I stepped into the central
maintainer role for a project using git!

							- Ted
