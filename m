From: Jeff King <peff@peff.net>
Subject: Re: I want "fast forward my workdir to upstream if it's safe"
Date: Thu, 7 May 2009 22:30:28 -0400
Message-ID: <20090508023028.GA1218@coredump.intra.peff.net>
References: <86prekfv7z.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Fri May 08 04:30:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2FrL-0007az-HX
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 04:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbZEHCa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 22:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640AbZEHCa2
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 22:30:28 -0400
Received: from peff.net ([208.65.91.99]:55977 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753582AbZEHCa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 22:30:28 -0400
Received: (qmail 15815 invoked by uid 107); 8 May 2009 02:30:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 07 May 2009 22:30:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 07 May 2009 22:30:28 -0400
Content-Disposition: inline
In-Reply-To: <86prekfv7z.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118559>

On Thu, May 07, 2009 at 02:40:00PM -0700, Randal L. Schwartz wrote:

> So, what I need is a command, likely an option to "git merge" that says "do
> everything that a git merge would do except abort if it would have been a
> merge commit".  In other words, abort if the workdir is dirty or is not a
> fast-forward update to the upstream.  Bonus if it exits non-zero if
> something went wrong.

Can you define more clearly what you want, because you are asking for
conflicting things. "abort if it would have been a merge commit" is
purely about fast forward. But it sounds like you also care about "would
merge have succeeded". So I think you are asking for:

  1. There are no local commits on the branch.

and one of:

  2a. There are no local edits.

  2b. There are no local edits in the same files as those that are
      affected by any new commits from upstream.

  2c. Any local edits you have done would not cause a conflict if merged
      with what's in upstream.

And before I discuss those further, let me address:

> Please don't tell me "use these three commands in this script".
> I want a *command* I can tell people in #git.

by saying that I don't think there is currently a single command to
cover both (1) and (2) (any of the (2) options). So we need to talk
about "use these three commands in a script" for a moment to figure out
what such a command _should_ do, and then we can talk about putting it
into a single command (and presumably making that command part of the
git distribution) that you can tell people about in #git.

Both (1) and (2) involve finding out who your upstream is. As of 1.6.3,
this is easy to do as:

  upstream=`git for-each-ref --format='%(upstream)' `git symbolic-ref HEAD`

One you have that, (1) is easy:

  test -z "`git rev-list -1 $upstream..HEAD`"

(2a) is also pretty easy:

  git diff-files --quiet && git diff-index --quiet

(2b) is a bit harder, but do-able:

  git diff-tree --name-only HEAD $upstream | sort >them
  (git diff-files --name-only; git diff-index --name-only) | sort >us
  test -z "`comm -12 us them`"

(2c) is the trickiest (and of course, therefore probably the one you
want ;) ).  I'm not sure there is a simple way to do it short of hacking
git-merge to actually try the merge and roll it back. Because you really
have to deal not just with merging actual text file content but with
custom merge drivers.

So what is it that you're looking for?

-Peff

PS I took your request at face value, but I actually think this question
shows that the asker is not using git as it was intended. Unless you are
very clueful (i.e., willing to sort out any mess caused by a failed
merge), you should almost certainly be merging with a clean working
tree. In other words, you should not be afraid of making a commit, and
_then_ merging, as you might be in a non-distributed VCS.
