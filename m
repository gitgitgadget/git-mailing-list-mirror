From: Jeff King <peff@peff.net>
Subject: Re: clones over rsync broken?
Date: Sat, 30 Jan 2016 00:41:41 -0500
Message-ID: <20160130054141.GB1677@sigill.intra.peff.net>
References: <20160130051133.GA21973@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:41:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPOIE-0002ls-9I
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 06:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbcA3Flp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 00:41:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:34752 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750981AbcA3Flo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 00:41:44 -0500
Received: (qmail 15313 invoked by uid 102); 30 Jan 2016 05:41:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 00:41:44 -0500
Received: (qmail 6741 invoked by uid 107); 30 Jan 2016 05:42:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 00:42:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jan 2016 00:41:41 -0500
Content-Disposition: inline
In-Reply-To: <20160130051133.GA21973@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285101>

On Sat, Jan 30, 2016 at 05:11:33AM +0000, Eric Wong wrote:

> I have not used rsync remotes in ages, but I was working on the
> patch for -4/-6 support and decided to test it against rsync.kernel.org
> 
> Cloning git.git takes forever and failed with:

No kidding. There are over 95,000 unreachable loose objects consuming a
gigabyte. The rsync transport blindly pulls all of the data over, with
no idea that it doesn't need most of it.

> $ git clone rsync://rsync.kernel.org/pub/scm/git/git.git
> Checking connectivity... fatal: bad object ecdc6d8612df80e871ed34bb6c3b01b20b0b82e6
> fatal: remote did not send all necessary objects

All those objects, and we still manage to miss one. :)

Interestingly, that object does not seem to exist at all on the remote!
I think this is the same bug as the one below. Read on...

> However, trying to clone a smaller repo like pahole.git via rsync fails
> differently; this looks more like a git bug:
> 
> $ git clone rsync://rsync.kernel.org/pub/scm/devel/pahole/pahole.git
> fatal: Multiple updates for ref 'refs/remotes/origin/master' not allowed.
> 
> Using rsync(1) manually to grab pahole.git and inspecting the bare
> repo with yields no anomalies with "git fsck --full".
> $GIT_DIR/info/refs and $GIT_DIR/packed-refs both look fine, but
> perhaps it's confused by the existence of $GIT_DIR/refs/heads/master
> as a loose ref?

Yes, that's exactly what's going on. In get_refs_via_rsync, we blindly
concatenate the list of loose refs and packed refs. But that's not
right, and never has been. If the same ref exists in both stores, the
loose ref takes precedence (that is how we can write new refs without
having to rewrite the whole packed-refs file).

So we erroneously believe that refs/heads/master exists _twice_ on the
remote, with two different values (and try to store it twice as
refs/remotes/origin/master). But we should be accepting only the loose
value.

This explains the git.git problem, too. There are two entries for
refs/heads/pu: one loose and one in packed-refs. The latter is a stale,
older value, and should never be looked at. But because pu gets rewound,
its older values are not necessarily reachable and may even have been
pruned!

So no, we do not have ecdc6d86, but neither does the upstream, and
nothing is referencing it.

It looks like this has been broken since cd547b4 (fetch/push: readd
rsync support, 2007-10-01). The fix is just to ignore packed-refs
entries which duplicate loose ones. But given the length of time this
has been broken with nobody complaining, I have to wonder if it is
simply time to retire the rsync protocol. Even if was made to work, it
is a horribly inefficient protocol.

-Peff
