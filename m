From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] push: introduce REJECT_FETCH_FIRST and
 REJECT_NEEDS_FORCE
Date: Wed, 23 Jan 2013 01:56:40 -0500
Message-ID: <20130123065640.GB10306@sigill.intra.peff.net>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358836230-9197-1-git-send-email-gitster@pobox.com>
 <1358836230-9197-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Rorvick <chris@rorvick.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:57:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxuGf-0006eO-2T
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045Ab3AWG4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 01:56:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44658 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab3AWG4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:56:43 -0500
Received: (qmail 1646 invoked by uid 107); 23 Jan 2013 06:58:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jan 2013 01:58:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2013 01:56:40 -0500
Content-Disposition: inline
In-Reply-To: <1358836230-9197-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214293>

On Mon, Jan 21, 2013 at 10:30:29PM -0800, Junio C Hamano wrote:

> When we push to update an existing ref, if:
> 
>  * we do not have the object at the tip of the remote; or
>  * the object at the tip of the remote is not a commit; or
>  * the object we are pushing is not a commit,
> 
> there is no point suggesting to fetch, integrate and push again.
> 
> If we do not have the current object at the tip of the remote, we
> should tell the user to fetch first and evaluate the situation
> before deciding what to do next.

Should we? I know that it is more correct to do so, because we do not
even know for sure that the remote object is a commit, and fetching
_might_ lead to us saying "hey, this is not something that can be
fast-forwarded".

But by far the common case will be that it _is_ a commit, and the right
thing is going to be to pull. Adding in the extra steps makes the
workflow longer and more complicated, and most of the time doesn't
matter. For example, imagine that Alice is working on "master", and when
she goes to push, she finds that Bob has already pushed his work. With
the current code, she sees:

  $ git push
  To ...
   ! [rejected]        HEAD -> master (non-fast-forward)
  error: failed to push some refs to '...'
  hint: Updates were rejected because the tip of your current branch is behind
  hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
  hint: before pushing again.

and she presumably pulls, and all is well with the follow-up push.

With your patch, she sees:

  $ git push
  To ...
   ! [rejected]        HEAD -> master (fetch first)
  error: failed to push some refs to '...'
  hint: Updates were rejected; you need to fetch the destination reference
  hint: to decide what to do.

  $ git fetch
  ...

  $ git push
  To ...
   ! [rejected]        HEAD -> master (non-fast-forward)
  error: failed to push some refs to '...'
  hint: Updates were rejected because the tip of your current branch is behind
  hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
  hint: before pushing again.
  hint: See the 'Note about fast-forwards' in 'git push --help' for details.

which is technically more correct (it's possible that in the second
step, she would find that Bob pushed a tree or something). But in the
common case that it is a commit, we've needlessly added two extra steps
(a fetch and another failed push), both of which involve network access
(so they are slow, and may involve Alice having to type her credentials).

Is the extra hassle in the common case worth it for the off chance that
we might give a more accurate message? Should the "fetch first" message
be some hybrid that covers both cases accurately, but still points the
user towards "git pull" (which will fail anyway if the remote ref is not
a commit)?

-Peff
