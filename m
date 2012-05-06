From: Jeff King <peff@peff.net>
Subject: Re: How does git now about future renames during a rebase?
Date: Sun, 6 May 2012 04:52:49 -0400
Message-ID: <20120506085248.GC27878@sigill.intra.peff.net>
References: <CAH3Anro6o478A41eXcsFU7guOobQXhqq=DdpNpGWgriRVfqcZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 10:53:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQxDm-0007TY-Ef
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 10:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab2EFIw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 04:52:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59421
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369Ab2EFIw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 04:52:57 -0400
Received: (qmail 7692 invoked by uid 107); 6 May 2012 08:53:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 06 May 2012 04:53:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 May 2012 04:52:49 -0400
Content-Disposition: inline
In-Reply-To: <CAH3Anro6o478A41eXcsFU7guOobQXhqq=DdpNpGWgriRVfqcZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197158>

On Sun, May 06, 2012 at 09:41:00AM +0530, Jon Seymour wrote:

> I had a history that looked like this:
> 
> 1. some other commit
> 2. commit that moves files from one directory to a new directory
> 3. commit that edits files in the new directory.
> 
> I then did an interactive rebase to move the commit 3 before commit 2.
> 
> 1. some other commit
> 3a. commit that edits files in the new directory.
> 2a. commit that moves files from one directory to a new directory
> 
> I didn't expect this to work, but somehow git worked out that it
> needed to apply the change in 3 to the original location of the files.
> 
> How does it do this?

When you pick a commit, we actually do a merge between it and the
current HEAD, using the parent of the picked commit as a merge base. So
imagine we have this short history:

  git init repo &&
  cd repo &&
  seq 1 100 >foo && git add foo && git commit -m base &&
  git mv foo bar && git commit -m move &&
  echo 101 >>bar && git add bar && git commit -m change

I.e., a move followed by a change. And you run:

  git rebase -i HEAD~2

and swap the two commits. So afterwards we will have a change followed
by a move. What does git see?

When we pick the first commit ("change"), we end up merging with these
parameters:

  - The "ours" side is "base", with "foo" containing 1..100.
  - The "theirs" side is "change", with "foo" absent and "bar"
    containing 1..101.
  - The ancestor is "move", with "foo" absent and "bar" containing
    1..100.

So rename detection sees that our side moved bar to foo (compared to the
ancestor), and the other side added a line to bar. And it resolves by
putting the modified content into "foo". Now obviously nobody _actually_
moved bar to foo; it was quite the opposite. But that makes sense; a
cherry-pick merge like this sees the reverse of what happened between
the picked commit and the destination commit (less any changes which
have been picked already).

And then we pick the second commit ("move"), with these merge
parameters:

  - The "ours" side is now changed', "foo" containing 1..101.
  - The "theirs" side is "move", with "foo" absent and "bar" containing
    1..100.
  - The ancestor is "base", with "foo" containing 1..100.

Now it looks like their side made a move ("foo" to "bar"), and our
side modified "foo" (i.e., the opposite of the last case). So we again
resolve to put the final content in "bar".

Does that make sense?

-Peff
