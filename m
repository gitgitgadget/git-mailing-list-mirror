From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] update-index: allow overwriting existing submodule
	index entries
Date: Tue, 12 Jun 2012 22:33:19 +0200
Message-ID: <20120612203316.GA17053@book.hvoigt.net>
References: <CAOkDyE9q1n=oLoEXXxurDjNM0B2+cZ9eoeGE57F9hEQUjK0hZg@mail.gmail.com> <20120609142658.GB16268@book.hvoigt.net> <7v3961ao1q.fsf@alter.siamese.dyndns.org> <4FD661C3.7000105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 12 22:33:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeXmK-0000mu-0K
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 22:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab2FLUdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 16:33:24 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:49244 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab2FLUdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 16:33:23 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1SeXmB-00060A-IM; Tue, 12 Jun 2012 22:33:19 +0200
Content-Disposition: inline
In-Reply-To: <4FD661C3.7000105@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199850>

Hi,

On Mon, Jun 11, 2012 at 11:23:15PM +0200, Jens Lehmann wrote:
> Am 11.06.2012 17:03, schrieb Junio C Hamano:
> > Heiko Voigt <hvoigt@hvoigt.net> writes:
> > 
> >> In commit e01105 Linus introduced gitlinks to update-index. He explains
> >> that he thinks it is not the right thing to replace a gitlink with
> >> something else.
> >>
> >> That commit is from the very first beginnings of submodule support.
> >> Since then we have gotten a lot closer to being able to remove a
> >> submodule without losing its history. This check prevents such a use
> >> case, so I think this assumption has changed.
> > 
> > Yeah, I think we should remove it if only to make it consistent with
> > "add" (if anything, the Porcelain level "add" should be the one that
> > is more strict and the plumbing level should be able to let you
> > shoot in the foot, not the other way around), but we need to make
> > sure "closer to" becomes reality. Can we remove and the resurrect
> > automatically when checking out a branch with a submodule when you
> > are on a branch with a directory and vice versa?
> 
> Even while I suspect most of the time a submodule <=> directory
> transition will occur (moving directory content into a submodule
> or vice versa; and then there will be no replacement of a gitlink
> with something else as only the files inside the directory will be
> recorded) there is no reason why submodule <=> file or submodule
> <=> link transitions shouldn't work just fine. So yes, we can ;-)
> (See the recursive_submodule_checkout branch in my GitHub repo for
> current state of affairs, even though not all transitions work yet
> some do just fine)

This is what works currently with submodule update in master:

file => submodule
symlink => submodule
directory => submodule
	These are the simplest cases. It currently works fine with
	submodule update. The checkout will remove the files of the
	directory and submodule update will just populate the submodule
	if it needs to.


submodule => file
submodule => symlink
submodule => directory
	These ones are the trickier ones.
	A checkout would currently not touch the submodule. It will be
	left in place. I have just tried it and in case the same files
	exist checkout will stop with an error. If there are no
	overlapping files it will happily checkout the files.  Now
	status displays the files contained in the submodule as
	untracked.

	This behavior could use some improvement. *)

	So if we were to implement submodule removal with submodule
	update the first problem here is when transitioning from a
	submodule to files we first should skip checking out files from
	that path.

	Then when using submodule update we need to detect whether a
	paths situation was brought to you by a checkout. Remember if
	the files are skipped by checkout the submodule is still in place.
	Comparing the working copy with whats in the database looks
	as if the user has replaced the directory/file with a submodule.

	To cleanup the situation with submodule update we could just do
	some security checks**) and in case they are successful remove
	the submodule and checkout the files.

	One real problem I see here is when displaying status if some
	files checkout has been skipped. Now you will potentially
	(directory case) see a lot of files looking as if they were
	deleted.

*) I also found that replacing a submodule with a directory using git
add does not work directly. The directory and it files will simply be
ignored by add.

**) Check that the .git is a gitfile that points outside of the
submodules directory. Check that there are no untracked changes in the
submodule.

The current plan to solve the submodule => file(s) transition is to
extend checkout with a --recurse-submodules option and then let it do
the above transition during checkout.

But unless we are going to have recursive checkout for populated
submodules always on (no config) we need to be able to deal with the
non-recursive outdated submodules situation.

Here a quick idea of what we could do:

We could mark a path as transitioned from submodule (similar to the
assume unchanged bit) if files were skipped due to removal of a
submodule and have submodule update clear that flag. That way we could
teach diff, status and so on to only show one entry for a submodule to
be removed and replaced with something else.

Thinking further: We could actually prevent adding such an out-of-date
submodule as a safeguard. Which in fact was something which happened by
mistake to some of our users. The story is that when you see a *changed*
submodule in a merge conflict it can be easily mistaken for needing
resolution and added to the merge. Most times this rewinds your
submodule to some old state

If we agree on how to handle the submodule => file(s) cases I think the
implementation in the submodule script possibly requires less work than
the fully fledged recursive checkout and could also be used for gaining
some experience with such transitions.

So the first step would be to extend submodule update to support the
removal of submodules. The next step is then that we finish the fully
automatic recursive submodule checkout.

What do you think of such a two step plan?

Cheers Heiko
