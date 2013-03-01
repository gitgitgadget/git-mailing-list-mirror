From: Jeff King <peff@peff.net>
Subject: Re: two-way merge corner case bug
Date: Fri, 1 Mar 2013 17:36:12 -0500
Message-ID: <20130301223612.GA862@sigill.intra.peff.net>
References: <7v7glun8kt.fsf@alter.siamese.dyndns.org>
 <20130226201820.GD13830@sigill.intra.peff.net>
 <7vwqtulplp.fsf@alter.siamese.dyndns.org>
 <20130301092201.GA17254@sigill.intra.peff.net>
 <7va9qngisg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 23:36:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBYZE-00072l-Ri
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 23:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab3CAWgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 17:36:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39563 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340Ab3CAWgP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 17:36:15 -0500
Received: (qmail 4600 invoked by uid 107); 1 Mar 2013 22:37:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Mar 2013 17:37:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2013 17:36:12 -0500
Content-Disposition: inline
In-Reply-To: <7va9qngisg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217300>

On Fri, Mar 01, 2013 at 08:57:03AM -0800, Junio C Hamano wrote:

> An initial checkout is *supposed* to happen in an empty working
> tree, so if we code it not to overwrite an existing path in the
> working tree, the user cannot lose possibly precious contents with
> an mistaken initial checkout (they will instead appear as modified
> relative to the index), while in the normal case we will write out
> the contents from the HEAD through the index.  We could attempt "we
> do not have to if the user behaves, but with this we could help
> misbehaving users" if we used twoway merge for an initial checkout.

That matches my thinking. It is probably not worth touching, though,
since it is not causing any problems. I just found it curious that the
exact same (and only, as far as I can see) exception we make for
initial_checkout is the same thing we have to tweak here.

> Having said that, I notice that in the normal codepath (e.g. "git
> clone" without the "--no-checkout" option) we no longer use twoway
> merge for the initial checkout.  Back when "git clone" was a
> scripted Porcelain, I think we used to do a twoway read-tree.  It
> may be that we broke it when "clone" was rewritten in C, but the
> breakage is to the "we do not have to..." thing, so it may not be a
> big deal.

The one-way merge that we use now in clone makes a lot of sense to me.
We do not have a "previous state" we were based on.

> The only case that matters in today's code is "git checkout"
> (without any option or argument) immediately after "git clone -n", I
> think.  The special casing for this initial checkout in twoway merge
> is needed because we go from HEAD to HEAD in that case, and we do
> not want to keep the artificial local removals from the index; we
> start from not even having the $GIT_INDEX_FILE, so without the
> special case all paths appear to have been "rm --cached", which is
> usually not what the user would want to see ;-)

Right. I just wondered if such a checkout should instead be a "reset",
in which case it would fall under the proposed patch. But "git checkout"
never does a twoway_merge with o->reset; instead, it uses a one-way
merge.

Anyway, that is all tangential to the bug at hand.

> > ... My worry would be that somebody is
> > using "--reset" but expecting the removal to be carried through
> > (technically, "--reset" is documented as "-m but discard unmerged
> > entries", but we are not really treating it that way here).
> 
> I've checked all in-tree uses of "read-tree --reset -u".
> 
> Nobody seems to use that combination, either from scripts or from C
> (i.e. when opts.update==1 and opts.merge==1, opts.reset is not set)
> with a twoway merge, other than "git am --abort/--skip".

I can believe it. So do we want to do that fix, then? Did you want to
roll up the two halves of it with a test and write a commit message? I
feel like you could write a much more coherent one than I could on this
subject.

-Peff
