From: Jeff King <peff@peff.net>
Subject: Re: limit memory usage on large repositories
Date: Fri, 26 Jul 2013 23:48:43 -0400
Message-ID: <20130727034843.GA20846@sigill.intra.peff.net>
References: <CAJj9RsTjp7j7Ew2pSttKRAZfZ6fLt9jL+Q_vmHQCi16FBBbK=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matt Schoen <mtschoen@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 05:48:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2vUw-000757-AF
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 05:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758422Ab3G0Dsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 23:48:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:35048 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757543Ab3G0Dsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 23:48:45 -0400
Received: (qmail 3314 invoked by uid 102); 27 Jul 2013 03:48:45 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 22:48:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 23:48:43 -0400
Content-Disposition: inline
In-Reply-To: <CAJj9RsTjp7j7Ew2pSttKRAZfZ6fLt9jL+Q_vmHQCi16FBBbK=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231226>

On Wed, Jul 10, 2013 at 05:27:57PM -0500, Matt Schoen wrote:

> I've been using git for some time now, and host my remote bare
> repositories on my shared hosting account at Dreamhost.com.  As a
> protective feature on their shared host setup, they enact a policy
> that kills processes that consume too much memory.  This happens to
> git sometimes.
> 
> By "sometimes" I mean on large repos (>~500MB), when performing
> operations like git gc and git fsck and, most annoyingly, when doing a
> clone.  It seems to happen in the pack phase, but I can't be sure
> exactly.

Do you know how they measure the memory? One of the problems we've had
at GitHub in measuring git's memory usage is that git will mmap the
fairly large packfiles. This can bloat the RSS of the git process. At
the same time, not counting the map is not quite right, either; it is
memory the process is using, but it could stand to give up some of it if
other processes needed it (and that giving up is managed by the kernel,
not by git). So you end up in a situation where you may have a large RSS
precisely _because_ there is no memory pressure on the system, which
leaves the kernel free to leave the mmap'd pages in RAM.

You can reduce the amount of memory you map at once with
core.packedGitWindowSize.

> I've messed around with the config options like pack.threads and
> pack.sizeLimit, and basically anything on the git config manpage that
> mentions memory.  I limit all of these things to 1 or 0 or 1m when
> applicable, just to be sure. To be honest, I really don't know what
> I'm doing ;)

I assume you did pack.deltaCacheSize, which can take a fair bit of
memory during packing (or cloning).

Packing itself takes up a lot, as I think we keep the whole window's
worth of objects in memory at one time (so 10 by default). If you have
large objects, that can spike your memory usage for a moment as we keep
several versions of the large object in memory at once.

If you have such large objects that don't delta well, you can use the
"nodelta" gitattribute so that git doesn't even try them.

> Oddly enough, I'm having trouble reproducing my issue with anything
> but git fsck.  Clones were failing in the past, but after a successful
> git gc, everything seems to be ok(?)

Memory usage for clone should improve after a gc, as we will mostly be
reusing deltas from disk instead of trying to find new ones between
packs.

-Peff
