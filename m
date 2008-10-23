From: Jeff King <peff@peff.net>
Subject: Re: git performance
Date: Thu, 23 Oct 2008 12:39:12 -0400
Message-ID: <20081023163912.GA11489@coredump.intra.peff.net>
References: <000801c93483$2fdad340$8f9079c0$@com> <20081022203624.GA4585@coredump.intra.peff.net> <000901c93490$e0c40ed0$a24c2c70$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Edward Ned Harvey <git@nedharvey.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 18:40:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt3Ej-0003rd-Ul
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 18:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747AbYJWQjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 12:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755292AbYJWQjQ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 12:39:16 -0400
Received: from peff.net ([208.65.91.99]:4151 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812AbYJWQjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 12:39:15 -0400
Received: (qmail 10544 invoked by uid 111); 23 Oct 2008 16:39:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 23 Oct 2008 12:39:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Oct 2008 12:39:12 -0400
Content-Disposition: inline
In-Reply-To: <000901c93490$e0c40ed0$a24c2c70$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98975>

On Wed, Oct 22, 2008 at 05:55:14PM -0400, Edward Ned Harvey wrote:

> I'm talking about 40-50,000 files, on multi-user production linux,
> which means the cache is never warm, except when I'm benchmarking.

Well, if you have a cold cache it's going to take longer. :) You should
probably benchmark if you want to know exactly how long.

> Specifically RHEL 4 with the files on NFS mount.  Cold cache "svn st"
> takes ~10 mins.  Warm cache 20-30 sec.  Surprisingly to me,

Wow, that is awful. For comparison, "git status" from a cold on the
kernel repo takes me 17 seconds. From a warm cache, less than half a
second.

Yes, the cold cache case would probably be better with inotify, but
compared to svn, that's screaming fast. I haven't used perforce. If your
bottleneck really is stat'ing the tree, then yes, something that avoided
that might perform better (but weigh that particular optimization
against other things which might be slower).

> Out of curiosity, what are they talking about, when they say "git is
> fast?"

Well, there are the numbers above. When comparing to SVN or (god forbid)
CVS, there are order of magnitude speedups for most common operations.

>  Just the fact that it's all local disk, or is there more to it
> than that?  I could see - git would probably outperform perforce for

The things that generally make git fast are:

  - using a compact on-disk structure (including zlib and aggressive
    delta-finding) to keep your cache warm (and when it's not warm, to
    get data off the disk as quickly as possible)

  - the content-addressable nature of objects means we can just look at
    the data we need to solve a problem. For example,
    getting the history between point A and point B is "O(the number of
    commits between A and B)", _not_ "O(the size of the repo)".
    Viewing a log without generating diffs is "O(the number of
    commits)", not "O(some combination of the number of commits and the
    number of files in each commit)". Diffing two points in history is
    "O(the size of the differences between the two points)" and is
    totally independent of the number of commits between the two points.

  - most operations are streamable. "git log >/dev/null" on the kernel
    repo (about 90,000 commits) takes 8.5 seconds on my box. But it
    starts generating output immediately, so it _feels_ instant, and the
    rest of the data is generated while I read the first commit in my
    pager.

-Peff
