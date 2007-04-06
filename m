From: Junio C Hamano <junkio@cox.net>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Fri, 06 Apr 2007 14:44:02 -0700
Message-ID: <7vbqi1jhzx.fsf@assigned-by-dhcp.cox.net>
References: <17940.59514.150325.738141@lisa.zopyra.com>
	<20070405134954.GA18402@coredump.intra.peff.net>
	<17941.655.192938.792088@lisa.zopyra.com>
	<20070405204604.GA24779@coredump.intra.peff.net>
	<7vodm2o6yl.fsf@assigned-by-dhcp.cox.net>
	<20070406025255.GA31909@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwEA-0004CO-L3
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 23:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933145AbXDFVoG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 17:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933142AbXDFVoG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 17:44:06 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:46702 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933143AbXDFVoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 17:44:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070406214402.PSTS1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 17:44:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id jxk21W00A1kojtg0000000; Fri, 06 Apr 2007 17:44:03 -0400
In-Reply-To: <20070406025255.GA31909@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Apr 2007 22:52:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43921>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 05, 2007 at 02:18:58PM -0700, Junio C Hamano wrote:
>
>> IIRC "git push" without explicit refspecs push the matching
>> refs, but I am a bit under the weather and feverish, so don't
>> take my word literally but look at git-push manual page please.
>
> Ah, yes you're right. It really doesn't make sense to push
> refs/remotes/* in most cases, since they're just tracking branches, and
> if the destination _does_ have them, then it is unlikely to be in sync
> with you (leading to Bill's problem).  OTOH, you might want to be able
> to push them explicitly if you are doing a strict mirror of a
> repository.
>
> The patch below turns off refs/remotes/ sending for "git-push" and
> "git-push --all", but still allows "git-push origin
> remotes/origin/master". I'm not sure about the semantics; maybe --all
> should imply even remotes?

The behaviour of git-send-pack that pushes all the matching refs
made sense when there was no separate-remotes layout (and there
was no "git push" wrapper).  Back then, the expected use was
really:

 * For integrators who own public repositories, send-pack to
   their public repositories without refspecs updated what they
   already decided to publish in refs/heads and refs/tags.

   Updating refs/tags hierarchy means moving tags which should
   have done with caution (since it changes the general public's
   view of what the version v2.6.12 really is), but no one can
   update tag without first forcing with "git tag -f" in one's
   own repository to begin with, it was not a problem in
   practice.

 * For people who used pull/push with a central repository as
   the CVS-style synchronization point, the central repository,
   being the mother of all participant repositories, was
   supposed to lack the 'origin' branch, and participant
   repositories had 'origin' that tracked 'master' of the
   central repository.  So matching push never needed to worry
   about 'origin', and 'master' of participant was pushed to
   'master' of the central repository, undergoing the usual
   fast-forward checks and all.

   Even here, we had a few trouble reports from people who
   primed their central repository by cloning from somewhere
   (and cloning without --bare) and left the 'origin' branch
   around.  We might have added instruction to our documentation
   that tells people to remove 'origin' branch from their
   central repositories to avoid confusion (but I am too lazy to
   look).

 * For anybody who has more than one private repositories
   (e.g. mothership and notebook) and uses push between them
   when switching repositories to work in, new development might
   have been on a new branch, in which case it needed an
   explicit refspec to send the new branch or tag.  But
   "matching refs" rule was useful for heads most of the time,
   as long as the two repositories were reasonably in sync
   (e.g. after supper you sit on your couch working on notebook,
   and you finish the day by pushing matching refs to your
   mothership to prepare for tomorrow, which you would start on
   your mothership machine).

In all these cases, what we meant by "matching refs" rule is to
update matching branch heads.  Even pushing matching tags is
debatable, as consciously replacing a tag that was already
pushed out with a new one is already a special case, and I would
suspect that replacing a public tag should be done via an
explicit "git send-pack $url tag v2.6.12", even though the
"matching refs" rule would silently update it.

People who built git-send-pack did not use separate remotes
layout (which has not been even invented yet), nor StGIT, so
refs/remotes, refs/bases nor refs/patches were not even on the
radar.  Speaking of StGIT, I do not think it makes sense to sync
only .git/refs/{bases,patches} without sending .git/patches.

> Does this seem like a sane direction to take? It just seems silly to be
> pushing refs/remotes, which 99% of the time should be a purely local
> thing.

So I'd suspect "git push" (not limited to git-send-pack) without
explicit refspecs should only do "matching branch heads" these
days, to keep the original spirit but yet to adjust to today's
reality.  In other words, instead of treating remotes/ specially
(in a negative sense), like your patch does, I think we should
do only "matching refs in heads/" hierarchy.
