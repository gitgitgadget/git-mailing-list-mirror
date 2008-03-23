From: Jeff King <peff@peff.net>
Subject: Re: How to rewrite author history
Date: Sun, 23 Mar 2008 03:09:45 -0400
Message-ID: <20080323070944.GA17184@coredump.intra.peff.net>
References: <216e54900803210938q4981b5d1t535af419f5b15ad8@mail.gmail.com> <216e54900803210941i7fe345c2va850fa3ded8eabc8@mail.gmail.com> <2008-03-22-10-29-23+trackit+sam@rfc1149.net> <216e54900803220611v5aa5e9d5q86da249480be3c91@mail.gmail.com> <20080322165737.GB7611@coredump.intra.peff.net> <216e54900803221206l39d61bcw1c546b9812968ac0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 08:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdKLo-0001jD-Up
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 08:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbYCWHJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 03:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYCWHJt
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 03:09:49 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3846 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbYCWHJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 03:09:48 -0400
Received: (qmail 21294 invoked by uid 111); 23 Mar 2008 07:09:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 23 Mar 2008 03:09:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Mar 2008 03:09:45 -0400
Content-Disposition: inline
In-Reply-To: <216e54900803221206l39d61bcw1c546b9812968ac0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77870>

On Sat, Mar 22, 2008 at 12:06:37PM -0700, Andrew Arnott wrote:

> Thanks, Jeff.  That was very helpful.  I have published my repo online
> already, but only a couple people (if even that) have cloned it by now
> and I am prepared to email the list of interested parties letting them
> know.  About this rebasing thing, is there a better way than for them
> to just wipe their repo and clone again?  Would a simple git fetch and
> git rebase do the trick?

Short answer: if they haven't done any work on top of yours, re-cloning
is probably the simplest route.

If they do have work, then they will want to fetch and rebase. The
commands are fairly simple, but what is happening is a little tricky, so
I'll subject you to some ascii art.

  # user has commits C..D built on top of your original A..B (in the
  # diagram, "..." refers to an arbitrary number of commits)
  #
  #  A--...--B <-- origin/master
  #           \
  #            C--...--D <-- master
  git fetch

  # after the fetch, we now have the filtered A'..B' pointed to by
  # origin/master, but the reflog for origin/master points to the
  # original.
  #
  # A'--...--B' <-- origin/master
  # A--...--B <-- origin/master@{1}
  #          \
  #           C--...--D <-- master
  #
  # so now we can rebase. We want all of the commits between the
  # _original_ upstream and our current state to be rebased on top
  # of the new upstream.
  git rebase --onto origin/master origin/master@{1} master


Three things to note here.

1. This works even if C..D is empty, so it is valid even if they didn't
do any work. Though in that case, simply doing "git reset --hard
origin/master" would work just as well.

2. The annoying thing is that you have to do this for every branch. So
depending on how many branches you have and how much work they did, it
may just be simpler to export the work as patches, re-clone, and then
apply:

  git checkout master
  git format-patch origin/master >/some/path/outside/repo
  cd .. && rm -rf repo
  git clone /path/to/repo && cd repo
  git am /some/path/outside/repo

3. Since you haven't changed the trees at all, a fetch will just need to
download the new commits. Thus a fetch should be way less
network-intensive than a re-clone. Whether that matters, of course,
depends on your repo size and your users' bandwidth.

Hope that helps,
-Peff
