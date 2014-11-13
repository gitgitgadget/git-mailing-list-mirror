From: Jeff King <peff@peff.net>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Thu, 13 Nov 2014 15:15:42 -0500
Message-ID: <20141113201542.GC3869@peff.net>
References: <20141113111444.GA15503@aepfle.de>
 <20141113154457.GA31624@aepfle.de>
 <20141113160325.GA24351@paksenarrion.iveqy.com>
 <CALKQrgeZYs9A-GZLuRczwzRWWapmfrjFvcvR8GN+YNKxajjDRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, Olaf Hering <olaf@aepfle.de>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 21:15:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp0o1-0000T0-Fl
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 21:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934045AbaKMUPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 15:15:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:40068 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933146AbaKMUPo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 15:15:44 -0500
Received: (qmail 14006 invoked by uid 102); 13 Nov 2014 20:15:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 14:15:44 -0600
Received: (qmail 30838 invoked by uid 107); 13 Nov 2014 20:15:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 15:15:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 15:15:42 -0500
Content-Disposition: inline
In-Reply-To: <CALKQrgeZYs9A-GZLuRczwzRWWapmfrjFvcvR8GN+YNKxajjDRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 05:08:19PM +0100, Johan Herland wrote:

> Can you not do this much simpler with --reference? Like this:
> 
>   $ git clone --bare git://host/repo.git repo-master
>   $ git clone -b branchA --reference repo-master git://host/repo.git
> repo-branchA
>   $ git clone -b branchB --reference repo-master git://host/repo.git
> repo-branchB
> 
> All three repos now push/pull directly to/from git://host/repo.git,
> but repo-branchA and repo-branchB reference objects from within the
> bare repo-master. You have to make use to never delete objects from
> repo-master

I think the "never delete" part is why we usually warn people off of
using alternates. I think at the least you would have to "git config
gc.auto 0" in the bare repository (otherwise your nightly fetches risk
pruning). Of course you'd probably want to repack eventually for
performance reasons. So maybe setting gc.pruneExpire is a better option
(to something like "20.years.ago").

> If you want to prevent the repos growing in size, you must devise a
> way to add new objects into repo-master before repo-branchA|B. (e.g. a
> nightly cron-job in repo-master that fetches from origin), so that
> when repo-branchA|B pulls, they will find most objects are already
> present in repo-master.

You can also fetch from the children into repo-master periodically.
Like:

  cd repo-master &&
  for i in branchA branchB; do
    git fetch ../$i +refs/*:refs/remotes/$i/*
  done

after which it is actually safe to run "git gc" in the master (assuming
there isn't simultaneous activity in the children). This is how we
manage fork networks on GitHub (we take in objects to individual forks
via push, and then migrate them to the master repo via fetch).

-Peff
