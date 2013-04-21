From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Teach git to change to a given directory using -C option
Date: Sat, 20 Apr 2013 23:58:58 -0400
Message-ID: <20130421035857.GC18890@sigill.intra.peff.net>
References: <1366374108-23725-1-git-send-email-ayiehere@gmail.com>
 <20130419161250.GC14263@sigill.intra.peff.net>
 <20130420221752.GA9980@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 05:59:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTlQn-0003nd-Vj
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 05:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab3DUD7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 23:59:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:45273 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731Ab3DUD7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 23:59:00 -0400
Received: (qmail 7186 invoked by uid 102); 21 Apr 2013 03:59:06 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 20 Apr 2013 22:59:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Apr 2013 23:58:58 -0400
Content-Disposition: inline
In-Reply-To: <20130420221752.GA9980@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221889>

On Sat, Apr 20, 2013 at 03:18:38PM -0700, Jonathan Nieder wrote:

> The "sometimes you just want to pass a command to 'exec'" use case
> does not convince me.  I equally well might want to run "git" after
> another command, or run "git" if and only if a repository exists
> there, or do any number of other things.

Sure. I don't claim that it solves every problem, just that I have
wanted it in that situation before.

> So we're left with "--git-dir does not automatically append .git when
> appropriate" as the problem being solved, which is a real problem.
> Maybe that is worth fixing more directly?

I'm a little hesitant, because --git-dir is _not_ "pretend like I am in
directory X". Even though people may use it that way for bare
repositories, it explicitly does not change your working tree.

I'm not sure what rule you are proposing. If it is:

  1. When we get "--git-dir=a/b", look in "a/b/.git" (assuming a/b is
     not a repo itself).

  2. When we get "--git-dir=a/b", do the usual repo search from a/b,
     finding the first of "a/b", "a/b/.git", "a/.git".

The second one is what makes me nervous, as it seems too much like
"pretend that we are in a/b". But the first one seems kind of hack-ish.
I suppose it is similar to the enter_repo rule used to find remotes,
though, so at least there is some precedence.

> It might also be convenient to be able to do something like
> 
> 	git --git-dir=~/src/git log -- Documentation/
> 
> which this -C option makes easy.  *checks*  Actually it works without,
> but for subtle reasons.

I'm not sure what subtle reason that is. It does not seem to work for
me:

  $ (cd git && git log -- Documentation | wc -l)
  99152
  $ git --git-dir=git log -- Documentation | wc -l
  fatal: Not a git repository: 'git'
  0

A more interesting subtlety is this:

  $ git --git-dir=git/.git log -- Documentation | wc -l
  99152
  $ git --git-dir=git/.git log Documentation | wc -l
  fatal: ambiguous argument 'Documentation': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'
  0

> All that said, I don't mind -C terribly as long as it can maintain
> itself, which means including thorough documentation that covers the
> purpose and how pathname parameters and envvars interact with the new
> option and including tests under t/ to ensure it continues to work
> correctly in the future.

Yeah, I pretty much feel the same way. "git -C" is a concept that has
occurred to me several times over the years, and I always dismissed it
as "bah, you can do the same thing easily with one line of shell". It
makes sense to me because of the precedence in other programs and I
would probably use it, but I could also live without it. I do not mind
it if it is not a maintenance burden.

-Peff
