From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Add --track option to git clone
Date: Wed, 2 Dec 2009 14:08:07 -0500
Message-ID: <20091202190807.GB30778@coredump.intra.peff.net>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net>
 <20091202192028.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Soria Parra <sn_@gmx.net>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:08:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFuYg-0002Zy-70
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbZLBTIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbZLBTIB
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:08:01 -0500
Received: from peff.net ([208.65.91.99]:44207 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690AbZLBTIA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:08:00 -0500
Received: (qmail 26952 invoked by uid 107); 2 Dec 2009 19:12:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Dec 2009 14:12:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2009 14:08:07 -0500
Content-Disposition: inline
In-Reply-To: <20091202192028.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134374>

On Wed, Dec 02, 2009 at 07:20:28PM +0900, Nanako Shiraishi wrote:

> Quoting David Soria Parra <sn_@gmx.net> writes:
> 
> > I'm aware that it's not possible to give more than one --track
> > option. Implementing the possibility to specify multiple --track option
> > would certainly a good improvment later, but would also require a lot
> > more work as far as I understand the clone code.
> 
> I'm sorry if I'm asking the obvious, but how can multiple --track 
> options be a useful future enhancement? If I understand your use 
> case correctly, it's useful when you want to work on only one 
> branch that isn't the default, and that is why you don't want to 
> get data necessary for other branches. What does it mean to give 
> two --track options? You will get one master branch that tracks
> both versions, and "git pull" will merge both branches you track?

I would find something like this useful for cloning git.git, where I
explicitly fetch maint, master, next, and pu, but none of html, man, or
todo. This makes "gitk --all" much nicer to view.

However, I don't think --track is the right term. There are really two
things happening here:

  1. Setting the fetch refspec(s).

  2. Choosing an initial branch to checkout.

We can already do (2) with "-b". But there is no way to do (1)
currently. If we are going to implement (1), I don't see a reason to be
restrictive about it. We should really accept arbitrary refspecs, and
then provide a syntax on top of that for doing both (1) and (2)
together. I am thinking something like:

  # most general case
  git clone -f 'refs/heads/subset/*:refs/remotes/origin/*' remote.git

  # expands to refs/heads/subset/*:refs/remotes/origin/*
  git clone -f 'refs/heads/subset/*' remote.git

  # expands to refs/heads/subset/*, which then expands as above
  git clone -f 'subset/*' remote.git

  # multiple -f should add multiple refspec lines
  git clone -f maint -f master -f next -f pu git.git

  # choose your favorite branch
  git clone -f maint -f master -f next -f pu -b next git.git

And for convenience of the user, you would want a way to avoid repeating
the name of the "I want to check this out" branch. So either:

  1. Add "--track foo" as a convenience wrapper for "-f foo -b foo".

  2. If no "-b" is given, the first "-f" is assumed as "-b". So "git
     clone -f foo" becomes equivalent to David's --track.

And of course the name "-f" (for --fetch, if you were wondering) is open
to suggestion.

What do you think?

-Peff
