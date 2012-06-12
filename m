From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] update-index: allow overwriting existing submodule index
 entries
Date: Tue, 12 Jun 2012 23:18:05 +0200
Message-ID: <4FD7B20D.9080803@web.de>
References: <CAOkDyE9q1n=oLoEXXxurDjNM0B2+cZ9eoeGE57F9hEQUjK0hZg@mail.gmail.com> <20120609142658.GB16268@book.hvoigt.net> <7v3961ao1q.fsf@alter.siamese.dyndns.org> <4FD661C3.7000105@web.de> <20120612203316.GA17053@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 23:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeYTn-0005TR-5X
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 23:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339Ab2FLVSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 17:18:18 -0400
Received: from mout.web.de ([212.227.17.12]:58090 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153Ab2FLVSR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 17:18:17 -0400
Received: from [192.168.178.48] ([79.193.95.43]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LxOQ2-1Rth9t15Wk-0177xv; Tue, 12 Jun 2012 23:18:14
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <20120612203316.GA17053@book.hvoigt.net>
X-Provags-ID: V02:K0:NjhwELCVJhtRb+Xs3UsjZkieIwyf9SdjX0DD9b946dw
 rcTvSe+juQGnq0gAPFcXR9t+t9ZJHN9HZYJEpHQvJ6tFXYEFRI
 Vadr0kTC1QCKE3HHh+8U/oEeHKun+GVLOMcmz3pUnHpX75hZPN
 4zkko9AFRxbFNlbkQ17RYVGBDd27GS127ew7cpAhkADNQzS96f
 U9xU9mjNZSh37ptLASIJw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199862>

Am 12.06.2012 22:33, schrieb Heiko Voigt:
> Here a quick idea of what we could do:
> 
> We could mark a path as transitioned from submodule (similar to the
> assume unchanged bit) if files were skipped due to removal of a
> submodule and have submodule update clear that flag. That way we could
> teach diff, status and so on to only show one entry for a submodule to
> be removed and replaced with something else.
> 
> Thinking further: We could actually prevent adding such an out-of-date
> submodule as a safeguard. Which in fact was something which happened by
> mistake to some of our users. The story is that when you see a *changed*
> submodule in a merge conflict it can be easily mistaken for needing
> resolution and added to the merge. Most times this rewinds your
> submodule to some old state
> 
> If we agree on how to handle the submodule => file(s) cases I think the
> implementation in the submodule script possibly requires less work than
> the fully fledged recursive checkout and could also be used for gaining
> some experience with such transitions.
> 
> So the first step would be to extend submodule update to support the
> removal of submodules. The next step is then that we finish the fully
> automatic recursive submodule checkout.
> 
> What do you think of such a two step plan?

Hmm, I suspect the real problem here is that "git submodule update" is
run *after* the actual checkout, merge, reset or whatever. So if for
example you want to replace a submodule with a plain directory containing
the same files the submodule update would not only have to remove the now
obsolete submodule but also has to remember to check out all files in the
former submodule directory again. IMO this should be part of the initial
unpack_trees(), not done in a later script. Imagine a submodule having
local modifications which would be overwritten by the checkout, then the
later submodule update would have to fail (when used without -f) to
protect the users changes. The only sane thing to do would be to not allow
such a checkout in the first place (when the user chose to automatically
update submodules that is) but abort just like we do for changes to
regular files right now telling the user to save his changes.

And I suspect you would have to teach at least status and diff to give
meaningful output in that "submodule should be removed and replaced with
something else but submodule update hasn't run yet" case, and apart from
the change to add you mentioned above some other commands might need
safeguards too.

So me thinks we should skip step one and implement recursive checkout
right away. Adding much more complexity to the submodule script for an
intermediate solution doesn't sound like a good idea to me.
