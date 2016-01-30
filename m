From: Jeff King <peff@peff.net>
Subject: Re: clones over rsync broken?
Date: Sat, 30 Jan 2016 01:30:36 -0500
Message-ID: <20160130063036.GC1677@sigill.intra.peff.net>
References: <20160130051133.GA21973@dcvr.yhbt.net>
 <20160130054141.GB1677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 07:31:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPP44-00042v-Mr
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 07:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbcA3Gak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 01:30:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:34758 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751151AbcA3Gaj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 01:30:39 -0500
Received: (qmail 18232 invoked by uid 102); 30 Jan 2016 06:30:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 01:30:39 -0500
Received: (qmail 6873 invoked by uid 107); 30 Jan 2016 06:31:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 01:31:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jan 2016 01:30:36 -0500
Content-Disposition: inline
In-Reply-To: <20160130054141.GB1677@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285102>

On Sat, Jan 30, 2016 at 12:41:41AM -0500, Jeff King wrote:

> It looks like this has been broken since cd547b4 (fetch/push: readd
> rsync support, 2007-10-01). The fix is just to ignore packed-refs
> entries which duplicate loose ones. But given the length of time this
> has been broken with nobody complaining, I have to wonder if it is
> simply time to retire the rsync protocol. Even if was made to work, it
> is a horribly inefficient protocol.

I took a look at whether there would be an easy fix. There are three
obvious ways to go about this:

  1. Use the loose/packed reading code from refs/files-backend.c.

     This would require some refactoring, as we currently assume we are
     either reading the refs for _this_ repository, or for a submodule.
     This is sort-of like reading a submodule, but I think there are a
     few rough edges.

     Worse, though, is that the upcoming pluggable refs work will
     probably require that submodules and the main repo have the same
     ref backend. I'm a little dubious of that requirement in general,
     but certainly it would be a show-stopper here.

  2. Create a "struct transport" for the tempdir holding the data we
     rsynced from the other side, and just treat it like a local repo.
     We already do something like this to handle object "alternates"
     repositories (and we run "upload-pack" on the other directory and
     parse it just like a real remote).

     Unfortunately, what we bring over in get_refs_via_pack is not
     enough for this to work. It's _just_ the refs/ directories. We can
     use "git init" to make it more like a real repo, but ultimately we
     don't have any objects, so upload-pack will complain.

     We could fix that by just rsyncing the objects down at this stage,
     too. It's not like git is careful enough to do a real "what do we
     need" walk like it does for dumb-http. But we would end up rsyncing
     even in cases where we didn't need _any_ objects, though that is
     probably a vast minority case.

  3. Just teach the local ad-hoc loose and packed readers to do the
     proper deduplication. I started on this, but then realized that we
     really do implement a from-scratch packed-refs reader here. And
     it's missing some features, like parsing peeled tags.

     So it really would want to call into the regular packed-refs
     parsing code, which requires more refactoring as in (1).

Of all of these, I think (2) is the closest to sane, because it lets
upload-pack do the heavy-lifting, meaning we can understand whatever
formats we rsync from the other side. But given that rsync is already
naive about what objects it pulls (i.e., it gets everything), I have to
really question whether there is any value in using git-over-rsync
versus just:

  rsync $src tmp/
  git clone tmp my-repo ;# will hard-link, no extra space needed!
  rm -rf $tmp

I guess that doesn't handle subsequent fetches. But
really...git-over-rsync is just an awful protocol. Nobody should be
using it. Having looked at it in more detail, I'm more in favor than
ever of removing it.

-Peff
