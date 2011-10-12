From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] remote: support --all for the prune-subcommand
Date: Wed, 12 Oct 2011 17:36:18 -0400
Message-ID: <20111012213618.GA4315@sigill.intra.peff.net>
References: <1317644168-5808-1-git-send-email-kusmabite@gmail.com>
 <20111004070006.GA6824@sigill.intra.peff.net>
 <CABPQNSZrfxhyA3em8TN2=d7pAHopZMgRg47baKnDT9h14=rxkA@mail.gmail.com>
 <20111004071332.GA7308@sigill.intra.peff.net>
 <CABPQNSZ-ELfFuxmKMqXCQaAgMZMRsZG3S5wWJLsjkYVvK6aGug@mail.gmail.com>
 <CABPQNSb7NYTac5uWSegK9rmYz1n0yt1GJWHKUtLg1k_OYHdDNg@mail.gmail.com>
 <20111004075608.GC7308@sigill.intra.peff.net>
 <CABPQNSb7WACrr=7FsR8YVMC1-q3i0zRhQtXiV8VshfCJn3qgEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 23:36:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE6TS-0000Oz-Eu
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 23:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334Ab1JLVgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 17:36:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58902
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754307Ab1JLVgU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 17:36:20 -0400
Received: (qmail 18176 invoked by uid 107); 12 Oct 2011 21:36:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 17:36:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 17:36:18 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSb7WACrr=7FsR8YVMC1-q3i0zRhQtXiV8VshfCJn3qgEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183416>

On Tue, Oct 04, 2011 at 10:22:35AM +0200, Erik Faye-Lund wrote:

> > I think the original rationale was that we didn't want fetch to be
> > "lossy". That is, if I were using upstream's "foo" branch as part o=
f my
> > work (to diff against, or whatever), then doing a "git fetch" to up=
date
> > should not suddenly make it hard to do my work. And not just hard a=
s in
> > "I notice that it's gone and I adapt my workflow". But that you no
> > longer have _any_ record of where upstream's "foo" branch used to p=
oint,
> > so even doing something like:
> >
> > =C2=A0git rebase --onto new-foo foo my-topic
> >
> > is impossible.
>=20
> Following that logic, a user cannot _ever_ safely prune a remote if h=
e
> wants to work on some of the branches. Doing something like "git
> remote foo -n" to check if the branch would get pruned before doing a
> proper prune is prone to a race-condition; the branch could be delete=
d
> on the remote between the dry-run and the actual pruning.

Right. And that's why we don't prune by default. In practice, it tends
to be safe if you pick a reasonable time to prune, and the upstream is
reasonable about their branches. But turning it on all the time takes
away the "pick a reasonable time".

> Besides, the owner of the repo can just as easily have deleted the
> branch and created a new one with the same name, causing the contents
> of the branch to be lost. This happens all the time with
> "for-upstream"-kind of branches, no?

They can do that, but on the local side, you will just see a jump in
history. But because we didn't _delete_ the ref on the local side, you
will retain your reflog.

IOW, the reflog can save us from anything the upstream will do. And
that's what makes deletion so special: we delete the local reflog.

> > The right solution, IMHO, is that ref deletion should actually keep=
 the
> > reflog around in a graveyard of some sort. Entries would expire
> > naturally over time, as they do in regular reflogs. And then it bec=
omes
> > a lot safer to prune on every fetch, because you still have 90 days=
 look
> > at the reflog.
> >
> Fixing the reflog to expire for ref deletion rather than completely
> deleting it sounds like a good move, indeed.

This is on my long-term todo list, but if somebody gets around to it
before me, I won't be upset. :)

> While we're on the subject, an additional argument to change "git
> fetch" to always prune is that it's much much easier for user to grok
> "last known state of <remote>'s branches" than "the union of all the
> branches that were ever pulled from <remote>, unless --prune was
> specified". But that's not a technical one, and surely there's issues
> to resolve with the proposal before going in that direction.

Agreed. Really, everything argument points towards auto-prune except th=
e
reflog-safety thing. I think once that is fixed, turning on pruning by
default becomes a no-brainer.

-Peff
