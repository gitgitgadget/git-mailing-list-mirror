From: Jeff King <peff@peff.net>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 18 Dec 2013 12:46:15 -0500
Message-ID: <20131218174615.GA5597@sigill.intra.peff.net>
References: <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
 <20131217140746.GB15010@thyrsus.com>
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
 <20131217210255.GA18217@thyrsus.com>
 <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com>
 <20131218002122.GA20152@thyrsus.com>
 <CANQwDwdgZUWcgyZCWoDni+e9jgQ+8j0Yn_HMxiMn5OHzsRzjwQ@mail.gmail.com>
 <20131218162710.GA3573@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 18:46:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtLCX-0004Rb-6P
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 18:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab3LRRqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 12:46:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:46764 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753242Ab3LRRqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 12:46:17 -0500
Received: (qmail 27800 invoked by uid 102); 18 Dec 2013 17:46:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Dec 2013 11:46:17 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Dec 2013 12:46:15 -0500
Content-Disposition: inline
In-Reply-To: <20131218162710.GA3573@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239460>

On Wed, Dec 18, 2013 at 11:27:10AM -0500, Eric S. Raymond wrote:

> For use in reposurgeon I have defined a generic cross-VCS reference to
> commit I call an "action stamp"; it consists of an RFC3339 date followed by 
> a committer email address. Here's an example:
> 
> 	 2013-02-06T09:35:10Z!esr@thyrsus.com
> 
> In any VCS with changesets (git, Subversion, bzr, Mercurial) this
> almost always suffices to uniquely identify a commit. The "almost" is
> because in these systems it is possible for a user to do multiple commits
> in the same second.

FWIW, this has quite a few collisions in git.git:

  $ git log --format='%ct %ce' | sort | uniq -c | sort -rn | head
     22 1172221032 normalperson@yhbt.net
     22 1172221031 normalperson@yhbt.net
     22 1172221029 normalperson@yhbt.net
     21 1190197351 gitster@pobox.com
     21 1172221030 normalperson@yhbt.net
     20 1190197350 gitster@pobox.com
     17 1172221033 normalperson@yhbt.net
     15 1263457676 gitster@pobox.com
     15 1193717011 gitster@pobox.com
     14 1367447590 gitster@pobox.com

In git, it may happen quite a bit during "git am" or "git rebase", in
which a large number of commits are replayed in a tight loop. You can
use the author timestamp instead, but it also collides (try "%at %ae" in
the above command instead).

> And now you know why I wish git had subsecond timestamp resolution!  If it
> did, uniqueness of these in a git stream could be guaranteed.

It's still not guaranteed. Even with sufficient resolution that no two
operations could possibly complete in the same time unit, clocks do not
always march forward. They get reset, they may skew from machine to
machine, the same operation may happen on different machines, etc. The
probability of such collisions is significantly reduced, though, if only
because the extra precision adds an essentially random factor.

But in some cases you might even see the same commit "replayed" on top
of different parts of the graph, or affecting different paths (e.g., by
filter-branch). I.e., no matter what your precision, multiple hacked-up
views of the changeset will still always have that same timestamp.

-Peff
