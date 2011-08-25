From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] gitk: Allow commit editing
Date: Thu, 25 Aug 2011 13:30:19 -0400
Message-ID: <20110825173018.GA519@sigill.intra.peff.net>
References: <87obzlwpx0.fsf@steelpick.2x.cz>
 <1313756753-26498-1-git-send-email-sojka@os.inf.tu-dresden.de>
 <20110825031420.GB3465@sigill.intra.peff.net>
 <87bovdvdhd.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, paulus@samba.org
To: Michal Sojka <sojka@os.inf.tu-dresden.de>
X-From: git-owner@vger.kernel.org Thu Aug 25 19:30:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwdl8-0006sx-E6
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 19:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab1HYRaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 13:30:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42149
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab1HYRaY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 13:30:24 -0400
Received: (qmail 16734 invoked by uid 107); 25 Aug 2011 17:31:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 13:31:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 13:30:19 -0400
Content-Disposition: inline
In-Reply-To: <87bovdvdhd.fsf@steelpick.2x.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180091>

On Thu, Aug 25, 2011 at 03:15:42PM +0200, Michal Sojka wrote:

> I implemented something like you ontlined above (see below). Instead of
> rev-listing HEAD, I use the commit id to be edited. This way I don't
> have to find the commit in the returned list, but I only check whether
> the list is empty or not.

Yeah, that makes sense.  Technically you are also rewriting every commit
_after_ the commit in question, so you want to be sure that those aren't
included elsewhere, too. But by definition, any ref which includes them
must also include the commit in question, so I think your test is
sufficient.

> Additionally, besides skiping HEAD ref, I also skip refs/stash. Rebasing
> before stash should not (I hope) cause any problems and therefore it is
> not necessary to warn the user.

Yes, that makes sense to me, too.

> > Speaking of which, notice that I used HEAD here. What happens with your
> > patch if I do:
> > 
> >   $ git checkout foo
> >   $ gitk bar
> > 
> > and select a commit to edit that is not in "foo"?
> 
> I added a check for this. If this is detected, error message is
> displayed and no edit is possible.

I was going to suggest that we could actually do the rebase on "bar",
but that is probably too much complexity hiding behind the user's back
(not to mention that there are lots of corner cases where figuring out
the right branch is tough, like "gitk <sha1>").

> The other changes in this version are:
> - added --no-autosquash to rebase invocation

Yeah, that is probably a good idea.

> +    # Check whether some other refs contain the commit to be edited
> +    if {[exec git rev-list --stdin $id << $otherrefsneg] eq {}} {
> +	if { [confirm_popup [mc "The commit you are going to edit is contained in another, possibly non-local, ref (e.g. branch or tag).\
> +				It is a bad idea to change a ref that is possibly used by other people. See git-rebase(1) for details.\n\n\
> +				Do you want to continue?"]]} {
> +	    return 1

Minor micro-optimization: this can be "git rev-list -1". You only care
if it produces the one commit, so that's sufficient. Without "-1", git
will keep reporting commits all the way down to the merge base with some
other ref.


Another question I had while thinking about whether or not this whole
idea is sane: what happens with conflicts in later commits that are
caused by your amended changes? Rebase will complain to the terminal,
no? Which the user may or may not even see, depending on how they
started gitk.

-Peff
