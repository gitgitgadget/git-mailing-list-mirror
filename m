From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Tue, 25 Aug 2009 08:14:24 -0700
Message-ID: <20090825151424.GJ1033@spearce.org>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home> <alpine.LFD.2.00.0908232320410.6044@xanadu.home> <7vocq5q0j7.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908240144530.28290@iabervon.org> <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0908242001250.6044@xanadu.home> <20090825021223.GE1033@spearce.org> <7vab1osc2m.fsf@alter.siamese.dyndns.org> <20090825061248.GG1033@spearce.org> <7vy6p8pfm1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 17:14:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfxjG-0005nf-No
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 17:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbZHYPOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 11:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755089AbZHYPOX
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 11:14:23 -0400
Received: from george.spearce.org ([209.20.77.23]:45731 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057AbZHYPOW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 11:14:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6683B381FD; Tue, 25 Aug 2009 15:14:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vy6p8pfm1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127026>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > The client knows the *name* of the ref, but not the SHA-1 the ref is
> > currently valued at.  Thus when the client knows it wants a certain
> > ref by name, it needs to send a "want " line to the server that would
> > give it whatever that ref currently points at.  Unfortunately since we
> > have not obtained that value yet, we are stuck.
> 
> That could be something you can fix in the out-of-band procedure Gerrit
> uses (you let the client learn both name and value offline, and then the
> client uses that value on "want" line).

Well, we're trying to reduce out-of-band things with Gerrit.

Its bad enough that Gerrit doesn't use git am and git send-email
to slug around changes for discussion.  As it is we're an island
among the git world, *despite* the fact that Gerrit speaks the git
protocol natively and you can push directly to it, avoiding the
send-email SMTP nonsense many folks run into.
 
> However, even if we limit the discussion to Gerrit, you would need an
> updated client that can be called with the out-of-band information
> (i.e. "we know that changes/88/4488/2 points at X, so use X when
> requesting") when talking with such an updated server.

Yes, exactly.  Existing clients wouldn't send an arbitrary want
request, even if the server had a whitelist of objects it would
allow to be requested.

One reason why Gerrit publishes pending changes with ref names is to
make it easier for any user to obtain the proposed change locally.
Its hard to beat `git fetch URL blah`, that's even easier than
"save to mbox, git am mbox".
 
> So I think that expand-refs is a much nicer general solution than just
> "server side is configured to hide but still allow certain refs", and
> client updates cannot be avoided.

Yes, I agree.  Given 20/20 hindsight, its the way the protocol
should have been implemented:

  C: 0014expand refs/heads/*
  C: 0013expand refs/tags/*
  C: 0000

  S: ...refs/heads/master
  S: ...refs/heads/next
  S: ...refs/tags/v1.0
  S: 0000

This would have permitted clients doing `git pull URL for-linus` to say:

  C: 0011expand for-linus
  C: 0000

  S: ...refs/heads/for-linus
  S: ...refs/remotes/k26/for-linus
  S: 0000

and thus significantly narrow the scope of what they are shown when
they connect for a given ref.

> > The problem with this is servers which are sending this expand-refs
> > tag have hidden certain namespaces from older clients.  Those names
> > can't be seen by older git clients, unless the user does an upgrade.
> 
> I do not think "generally hidden, but if you need to know you are allowed
> to peek" is much of a problem.  You do not do that for regular refs, only
> for "on-demand-as-needed" type things.  If we are going to make extensive
> use of notes on commits to give richer annotations, I suspect notes
> hierarchy could be hidden by default in a similar way.

After sleeping on it, I'm OK with hiding some refs from older clients.

Sometimes things evolve, and you should just update your software
to keep up with them.  If you really want the "hidden refs" that
Gerrit advertises, you should install a newer client.

We could consider supporting a legacy option through upload-pack,
such as:

  git fetch --upload-pack='git-upload-pack --expand refs/changes/' URL

which tells the remote side to additionally expand those refs during
the initial advertisement.  Then users have an escape hatch if:

* They know the remote is new enough to hide refs;
* They suspect the remote is hiding refs;
* They received an out-of-band notification telling this;
* They have an older client which doesn't support expanding refs;
* They cannot upgrade said client yet;

I'm thinking about writing an RFC patch for this today for git.git.
I think the expand refs feature neatly solves a number of problems
for me in Gerrit.  But I'm really hoping its not the only set of
repositories that would benefit from such a feature, because if so,
its not worth the headache of the protocol change.

-- 
Shawn.
