From: Jeff King <peff@peff.net>
Subject: Re: Candidates for sequencer?
Date: Mon, 12 Nov 2012 17:16:13 -0500
Message-ID: <20121112221613.GC10531@sigill.intra.peff.net>
References: <CALkWK0n0tTZ3EgzeesOr2B1LjeEUjTnWQh5dDfW28jA1ia0-gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:16:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY2Iy-0001SX-FB
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 23:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab2KLWQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 17:16:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45112 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462Ab2KLWQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 17:16:17 -0500
Received: (qmail 14854 invoked by uid 107); 12 Nov 2012 22:17:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 17:17:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 17:16:13 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0n0tTZ3EgzeesOr2B1LjeEUjTnWQh5dDfW28jA1ia0-gA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209534>

On Tue, Nov 13, 2012 at 03:16:51AM +0530, Ramkumar Ramachandra wrote:

> I'd like to get more commands to call into sequencer.c, so that we can
> (finally) implement a sensible `git continue` and `git abort`.
> Currently, am and rebase come to mind, but they are shell scripts and
> I don't see how we can make them call into sequencer.c.  Is there any
> way to make sequencer.c more useful?  Should we implement a `git
> continue` and `git reset` anyway, lifting code from 83c750ac to check
> the tree state?

I'd love it if ther was a mechanism for interruptible commands to notify
the rest of git that they are in progress. This would not only make
cross-language commands like "rebase" and "am" work easily, but it would
mean that we can automatically support third-party commands that we
don't even know about.

I am already doing something like this for some personal scripts which
do sequences of merges and rebases, and my "git continue" looks like:

  if test -f "$GIT_DIR/continue"; then
    eval "$(cat "$GIT_DIR/continue")"
  elif test -d "$GIT_DIR/rebase-merge"; then
    git rebase --continue
  elif test -d "$GIT_DIR/rebase-apply"; then
    if test -f "$GIT_DIR/rebase-apply/applying"; then
      git am --continue
    else
      git rebase --continue
    fi
  fi
  [... etc ...]

It works pretty well in practice, but I'd have a few suggestions on top:

  1. Even if "am" and "rebase" learn to use $GIT_DIR/continue, we should
     probably continue to support the fallback state-examination in case
     people use mixed versions of git. And clearly the code should be
     shared with what's in wt-status.c.

  2. The "continue" file should probably be called "in-progress", and
     should have more structured data, like the name of the operation.

  3. The list of operations in progress needs to be a stack. If I am
     rebasing and start a cherry pick, what would "git continue" do? It
     probably makes sense to continue the most recently started
     operation first.

  4. Rebase already detects an in-progress rebase. It should probably
     also detect an "am" or "cherry-pick" in progress. But it's not
     commutative; you should be able to start a "cherry-pick" in the
     middle of a "rebase". This is really independent of the storage
     format (we could do it right now if the state logic from wt-status
     is made available in a machine-readable format).

     We _might_ want to put information in the in-progress file that
     helps programs reach that decision. I'm not sure of a sane way of
     doing it, though. You could say "don't rebase while I'm in
     progress", but that depends on the writer knowing the universe of
     all programs that might be run. It might be possible to come up
     with some taxonomy of operations like "a history rewriting
     operation is in progress" which would cause other history rewriting
     operations to choose not to start. But coming up with the right set
     of attributes might be impossible.

-Peff
