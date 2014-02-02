From: Jeff King <peff@peff.net>
Subject: Re: Determining update/merge/current state of a workspace
Date: Sun, 2 Feb 2014 17:44:54 -0500
Message-ID: <20140202224453.GA16196@sigill.intra.peff.net>
References: <85ppn540wi.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Sun Feb 02 23:45:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA5nI-0001QN-72
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 23:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbaBBWo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 17:44:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:43340 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752476AbaBBWo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 17:44:56 -0500
Received: (qmail 30188 invoked by uid 102); 2 Feb 2014 22:44:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 02 Feb 2014 16:44:56 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Feb 2014 17:44:54 -0500
Content-Disposition: inline
In-Reply-To: <85ppn540wi.fsf@stephe-leake.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241386>

On Sun, Feb 02, 2014 at 04:15:09PM -0600, Stephen Leake wrote:

> I always do 'fetch' and 'merge' separately, never 'pull'. So after a
> 'fetch', the DVC Emacs front end must determine what needs to happen
> next. I think there are three cases:

Doing the two steps separately is common in git, too. The cases you
mention are also something people commonly care about. Both "git
checkout" and "git status" will print out the relationship between the
current branch and its "upstream". These are sometimes referred to as
ahead/behind messages in the manual (because they are of the form "You
are N commits ahead of origin/master", etc).

> 3) fetch retrieved revisions, and there were local commits since
>    the previous fetch.
> 
>    There are two heads for the branch (the two described above), they
>    need to be merged, then the workspace updated.
> 
> I'm not sure how 'git fetch' handles case 3); I have not tested that
> case yet.

Git's fetch does not have to care about this case. It is responsible
only for updating the ref that keeps track of the remote side (e.g.,
refs/remotes/origin/master). Unlike in some other DVCSs, there is no
global concept of a "branch" in git. The ref "refs/heads/master" refers
to your local branch named "master", and the ref "refs/remotes/origin/master"
refers to some remote's branch with the same name. You can reconcile
them whenever and however you like, and do not have to do so immediately
(or at all).

> The question I have is:
> 
> What git queries can I run to determine which of the three states the
> current workspace is in?

If you want to know the relationship between two (or more) commits, you
can use `git rev-list` to enumerate them. You can use the symmetric
difference operator ("...") to walk both sides down to their merge-base.
The `--left-right` option will label them according to which side each
commit comes from. So try:

  git rev-list --left-right @{upstream}...HEAD

to see the commits, or just:

  git rev-list --left-right --count @{upstream}...HEAD

to just get the counts on each side. Note that I used "@{upstream}"
there instead of naming the branch specifically. The default remote
branch with which a local branch will merge can be configured, and does
not have to have the same name (or even be a remote branch).

> But to distinguish among the cases, I need to determine if one of these
> two revs is a child of the other or not. I don't see a git query to
> determine that directly.

I think what I gave above matches what you are looking for most
directly. But as you may have already guessed, you can also use rev-list
to find whether one rev is a child of the other (e.g., "git rev-list
--count a..b" != 0).

> I could try parsing a 'log' output; I have not investigated that.

Don't do that. As you might expect, `git log` is built on top of the
traversals done by `rev-list`. The latter is preferred as a building
block, because it is "plumbing" whose output is guaranteed not to change
in later git versions.

I hope that helps,

-Peff
