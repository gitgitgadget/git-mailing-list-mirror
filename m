From: Jeff King <peff@peff.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Fri, 7 Jan 2011 00:22:07 -0500
Message-ID: <20110107052207.GA23128@sigill.intra.peff.net>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
 <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
 <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 06:22:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb4mJ-0000c2-TZ
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 06:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614Ab1AGFWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 00:22:15 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41202 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464Ab1AGFWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 00:22:14 -0500
Received: (qmail 11854 invoked by uid 111); 7 Jan 2011 05:22:11 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 07 Jan 2011 05:22:11 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jan 2011 00:22:07 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164700>

On Thu, Jan 06, 2011 at 11:33:51PM -0500, Nicolas Pitre wrote:

> Here's what I suggest:
> 
> 	cd my_project
> 	BUNDLENAME=my_project_$(date "+%s").gitbundle
> 	git bundle create $BUNDLENAME --all
> 	maketorrent-console your_favorite_tracker $BUNDLENAME
> 
> Then start seeding that bundle, and upload $BUNDLENAME.torrent as 
> bundle.torrent inside my_project.git on your server.
> 
> Now... Git clients could be improved to first check for the availability 
> of the file "bundle.torrent" on the remote side, either directly in 
> my_project.git, or through some Git protocol extension.  Or even better, 
> the torrent hash could be stored in a Git ref, such as 
> refs/bittorrent/bundle and the client could use that to retrieve the 
> bundle.torrent file through some other means.

I really like the simplicity of this idea. It could even be generalized
to handle more traditional mirrors, too. Just slice up the refs/mirrors
namespace to provide different methods of fetching some initial set of
objects. For example, upload-pack might advertise (in addition to the
usual refs):

  refs/mirrors/bundle/torrent
  refs/mirrors/bundle/http
  refs/mirrors/fetch/git
  refs/mirrors/fetch/http

and the client can decide its preferred way of getting data: a bundle by
http or by torrent, or connecting directly to some other git repository
by git protocol or http. It would fetch the appropriate ref, which would
contain a blob in some method-specific format. For torrent, it would be
a torrent file. For the others, probably a newline-delimited set of
URLs. You could also provide a torrent-magnet ref if you didn't even
want to distribute the torrent file.

And no matter what the method used, at the end you have some set of refs
and objects, and you can re-try your (now much smaller fetch). And there
are a few obvious optimizations:

  1. When you get the initial set of refs from the master, remember
     them. If the mirror actually satisfies everything you were going to
     fetch, then you don't even have to reconnect for the final fetch.

  2. You can optionally cache the mirror list, and go straight to a
     mirror for future fetches instead of checking the master. This is
     only a reasonable thing to do if the mirrors are kept up to date,
     and provide good incremental access (i.e., only actual git-protocol
     mirrors, not torrent or http file).

-Peff
