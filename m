From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 02:54:20 -0400
Message-ID: <20130908065420.GI14019@sigill.intra.peff.net>
References: <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <20130904092527.GB22348@sigill.intra.peff.net>
 <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908044329.GA15087@sigill.intra.peff.net>
 <CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
 <20130908052107.GA15610@sigill.intra.peff.net>
 <CAMP44s3U2rJsqTj4cAOpY1ntum53bEy2cP5XRNaMu5vwnYVoww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 08:54:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIYtN-0004x1-2x
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 08:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab3IHGyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 02:54:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:43058 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473Ab3IHGyY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 02:54:24 -0400
Received: (qmail 6211 invoked by uid 102); 8 Sep 2013 06:54:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 01:54:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 02:54:20 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3U2rJsqTj4cAOpY1ntum53bEy2cP5XRNaMu5vwnYVoww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234194>

On Sun, Sep 08, 2013 at 01:17:42AM -0500, Felipe Contreras wrote:

> > I think it's fine to tell them to do "git pull --merge". What I'd worry
> > more about is somebody who is suddenly presented with the choice between
> > "--rebase" and "--merge" and doesn't know which to choose. We've created a
> > cognitive load on the user, and even more load if they choose --rebase
> > and don't quite understand what it means.
> 
> If that happens they will go back to the guy that told them to run
> those commands.

I think "the guy" may be git itself. For example, here is a possible
session with jc/pull-training-wheel:

  $ git push
  To ...
   ! [rejected]        master -> master (non-fast-forward)
  error: failed to push some refs to '...'
  hint: Updates were rejected because the tip of your current branch is behind
  hint: its remote counterpart. Integrate the remote changes (e.g.
  hint: 'git pull ...') before pushing again.
  hint: See the 'Note about fast-forwards' in 'git push --help' for details.

  $ git pull
  The pull does not fast-forward; please specify
  if you want to merge or rebase.

  Use either

      git pull --rebase
      git pull --merge

  You can also use 'git config pull.rebase true' (if you want --rebase) or
  'git config pull.rebase false' (if you want --merge) to set this once for
  this project and forget about it.

The user is pointed at "pull" from "push", and then gets presented with
the "merge or rebase" choice. It may be that the advice you can find by
googling "merge vs rebase" is enough to then help the person along
(and/or we may need to improve the manpages in that respect).

I am genuinely curious what people in favor of this feature would want
to say in the documentation to a user encountering this choice for the
first time. In my experience, rebasing introduces more complications,
specifically:

  1. the merge is "backwards" with respect to ours/theirs

  2. you may end up with difficult conflict resolution due to repeated
     changes over the same section of code. E.g., you write some buggy
     code and then fix it, but upstream has changed the same area.
     Rebasing involves first resolving your buggy version with the
     upstream code, and then resolving the fix on top of the previous
     resolution.

  3. rewriting of commits found in other branches, which then need
     rebased on top of the branch you just rebased

  4. a previously bug-free commit can show a bug after the rebase if
     other parts of the project changed (whereas with a merge, the bug
     would be attributable to the merge)

I know those are all balanced by some advantages of rebasing, but I also
think they are things that can be troublesome for a user who does not
fully grok the rebase process. I'm just wondering if we should mention
both, but steer people towards merging as the safer alternative (you
might have ugly history, but you are less likely to create a mess with
duplicate commits or badly-resolved conflicts).

> Fortunately there probably are very few of these users.

Maybe. I am not sure how one would measure.

If you are interested, I can ask the opinion of some of the GitHub
trainers. They see a lot of new users and have a sense of what kinds of
confusion come up most frequently, what kinds of workflows they tend to
see, etc. Their experience may be biased towards corporate-ish users,
though, because those are the people who pay for training.

> > The current warning message in jc/pull-training-wheel is quite neutral
> > between the two options. Perhaps we should lean more towards merging?
> 
> I don't like that message. I would like this for the deprecation period:
> 
> "The pull was not fast-forward, in the future you would have to choose
> a merge or a rebase, merging automatically for now. Read 'man git
> pull' for more help."
> 
> Then when obsolete:
> 
> The pull was not fast-forward, please either merge or rebase.

A deprecation message helps people who are making the transition from an
older behavior to a newer one. It cannot help new users who start with a
git version after the deprecation period.

> "Any more babysitting with essay long messages is counter-productive
> to the vast majority of Git users."

I think that is what we have advice.* for.

-Peff
