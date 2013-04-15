From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 14:43:47 -0400
Message-ID: <20130415184347.GA21170@sigill.intra.peff.net>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
 <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <516C21CF.5080705@xiplink.com>
 <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
 <CALkWK0n0y6OPJvYjNeEbUx_CC58vHRRLCsmJtws+RKyv3wRTwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, marcnarc@xiplink.com,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:44:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URoNj-0001AW-03
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934002Ab3DOSny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:43:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46851 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933000Ab3DOSnx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 14:43:53 -0400
Received: (qmail 27032 invoked by uid 107); 15 Apr 2013 18:45:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 14:45:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 14:43:47 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0n0y6OPJvYjNeEbUx_CC58vHRRLCsmJtws+RKyv3wRTwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221285>

On Mon, Apr 15, 2013 at 11:30:40PM +0530, Ramkumar Ramachandra wrote:

> Junio C Hamano wrote:
> > My
> > understanding is that this "config" is about making that option
> > easier to use when you _know_ any new repository you create with
> > "git clone" or "git init" inside your (toplevel super)project's
> > working tree will become its submodule, as it is more convenient to
> > have their $GIT_DIR inside the .git/modules/$name of the
> > superproject.
> 
> Right.  But I'm still worried about .git/modules/$name.  Can you
> explain why it's a better idea than having a dedicated ~/bare?

I do not have too much deep knowledge of submodules, nor have I been
following this thread very closely, but I have not seen how ~/bare would
handle per-submodule information?

That is, let us imagine I do:

  git clone $PROJECT one && cd one && git submodule update foo
  git clone $PROJECT two && cd two && git submodule update foo

The current scheme would put the cloned modules into
one/.git/modules/foo and two/.git/modules/foo, respectively. Let us
imagine instead that the first one writes to ~/modules/$URL (assuming
some sane mapping of the URL into the filesystem), and the second one
says "A-ha, I already have ~/modules/$URL, so I can skip cloning it".

But that is not the end of the story. If I do:

  cd one/foo &&
  hack hack hack &&
  git commit -m foo &&
  cd .. &&
  git commit -m 'updated submodule'

you would not want to see a dirty, updated submodule in project "two".
You did not touch "two/foo" nor advance its HEAD at all.

So there is some information that is per-clone (the objects, the remote
tips), but there is some information that is per-submodule (where our
local branches are, the index, the worktree). I can see why it is
advantageous to share the per-clone information between similar clones
(because it avoids disk space and network transfer). But I do not think
you can escape having some form of per-submodule repo, even if it is a
thin git-new-workdir-ish repo that points back to a parent repo for the
clone.

Is there some part of your proposal that I am missing? It seems like you
would still need one/.git/modules/foo for this "thin" repo.

And once we separate out those concerns, I also do not see why sharing
per-clone information needs to be related to submodules at all. If I do:

  git clone $URL one &&
  git clone $URL two

those can potentially be shared in the same way as two submodule repos
that happen to point to the same $URL. It would make sense to me to
improve such a shared-object setup independently, and then build the
shared-submodule storage on top of that.

And by the way, I am actually not sure that such a shared-object setup
is a good idea, but only that _if_ you are going to do it with
submodules, you might as well do it for all repos. In theory, it is not
that hard to have a big per-user object-only repository (either for all
repos, or for related ones). But we can do that already with "git clone
-s", and people do not generally bother, because the maintenance is very
tricky (especially dealing with reachability and pruning).

I am open to the argument that solving it in a specific case
(submodules) lets us make assumptions that simplify the problem from the
general case, but I do not offhand see how it would be any easier in
this case.
