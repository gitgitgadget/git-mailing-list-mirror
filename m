From: Jeff King <peff@peff.net>
Subject: Re: Bug? Bad permissions in $PATH breaks Git aliases
Date: Tue, 27 Mar 2012 13:59:33 -0400
Message-ID: <20120327175933.GA1716@sigill.intra.peff.net>
References: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
 <20120327031953.GA17338@sigill.intra.peff.net>
 <7vbonikrj4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:59:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCagJ-00034b-Qv
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 19:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab2C0R7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 13:59:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34373
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754977Ab2C0R7g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 13:59:36 -0400
Received: (qmail 5480 invoked by uid 107); 27 Mar 2012 17:59:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Mar 2012 13:59:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2012 13:59:33 -0400
Content-Disposition: inline
In-Reply-To: <7vbonikrj4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194065>

On Tue, Mar 27, 2012 at 08:11:27AM -0700, Junio C Hamano wrote:

> > I think the general feeling last time this came up was "why not just
> > remove the cruft from your PATH?" But I would personally be OK with
> > option (3) above, and it is probably not that hard to implement.
> 
> http://thread.gmane.org/gmane.comp.version-control.git/171755/focus=171838
> shows that it was almost exactly a year ago; we tried (2) and nobody liked
> it.

I was actually thinking of:

  http://thread.gmane.org/gmane.comp.version-control.git/189077

> I got an impression from the discussion in it that #3 may give confusing
> messages to the end users, but I didn't think the issues through.

The implementation for #3 is straight-forward; I'll post the patches in
a moment. However, it still ends up being confusing, because git ends up
talking about permissions instead of offering its usual help.

Here are a few cases with stock git and no broken entries in PATH:

  (1)
  $ git does-not-exist
  git: 'does-not-exist' is not a git command. See 'git --help'.

  (2)
  $ git cerry-pick
  git: 'cerry-pick' is not a git command. See 'git --help'.

  Did you mean this?
          cherry-pick

  (3)
  $ git config alias.broken does-not-exist
  $ git broken
  Expansion of alias 'broken' failed; 'does-not-exist' is not a git command

  (4)
  $ git config alias.ok '!echo ok'
  $ git ok
  ok

Here are the same cases with a broken entry in PATH:

  $ mkdir foo; chmod 0 foo; PATH=$PWD/foo:$PATH

  (1)
  $ git does-not-exist
  fatal: cannot exec 'git-does-not-exist': Permission denied

  (2)
  $ git cerry-pick
  fatal: cannot exec 'git-cerry-pick': Permission denied

  (3)
  $ git broken
  fatal: cannot exec 'git-broken': Permission denied

  (4)
  $ git ok
  fatal: cannot exec 'git-ok': Permission denied

Case (1) is OK; we report the differing error. But case (2) is worse, as
we don't offer suggestions any more. Cases (3) and (4) are both worse,
because we don't even try to expand the alias (whether it would work or
not).

Here are the same cases with my patches:

  (1)
  $ git does-not-exist
  Failed to run command 'does-not-exist': Permission denied

  (2)
  $ git cerry-pick
  Failed to run command 'cerry-pick': Permission denied

  (3)
  $ git broken
  Expansion of alias 'broken' failed; 'does-not-exist': Permission
  denied

  (4)
  $ git ok
  ok

This is somewhat improved. Case (4) now runs the alias. Case (3) has a
better error message, which is that it tells you it was not "broken"
which was a problem, but its subcommand. But the "permission denied"
error still ends up being somewhat confusing. And in case (2), you don't
get a list of suggestions (nor should you, because we still don't know
whether "cerry-pick" exists and cannot be executed, or if there is a
broken directory in the PATH).

So we've made the situation better, but it's still way less nice than
having a fixed PATH. Which makes me wonder if this half-way effort is
worth it.

-Peff
