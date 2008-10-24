From: Jeff King <peff@peff.net>
Subject: Re: git performance
Date: Fri, 24 Oct 2008 10:29:48 -0400
Message-ID: <20081024142947.GB11568@coredump.intra.peff.net>
References: <000901c93490$e0c40ed0$a24c2c70$@com> <20081023163912.GA11489@coredump.intra.peff.net> <000001c9358f$232bac70$69830550$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Edward Ned Harvey <git@nedharvey.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 16:31:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtNgv-0000YH-GQ
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 16:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbYJXO3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 10:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbYJXO3w
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 10:29:52 -0400
Received: from peff.net ([208.65.91.99]:1121 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302AbYJXO3v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 10:29:51 -0400
Received: (qmail 21803 invoked by uid 111); 24 Oct 2008 14:29:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 10:29:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 10:29:48 -0400
Content-Disposition: inline
In-Reply-To: <000001c9358f$232bac70$69830550$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99041>

On Fri, Oct 24, 2008 at 12:15:19AM -0400, Edward Ned Harvey wrote:

> Feel free to forward to the list, if anyone's still talking about it.
> I already un-subscribed.

Posting is not limited to subscribers, so you can happily continue the
conversation there by cc'ing the list (and I am cc'ing the list here).

> I did my benchmarking at least two months ago, so I forgot the exact
> results now, so I ran the benchmark once just now.  I also downloaded
> git, and did "git status" for comparison.  I rebooted the system in
> between each trial run, to clear the cache.  Here's the results:

Side note: on Linux, it is much easier to clear the cache via

  echo 1 >/proc/sys/vm/drop_caches

than to reboot for each benchmark.

> Local disk mirror "time git status" on the same tree. 17,468 versioned files, so the whole tree is 30,647 including .git files
> 	0m 25s	cold cache
> 	0m 0.2s	warm cache trial 1
> 	0m 0.2s	warm cache trial 2

Hmm. That's a lot of increase in files for .git. Did you try repacking
and then running your test?

> I questioned whether svn and git were causing unnecessary overhead.

Sure, they are doing more than just walking. So there is overhead, but
it's hard to say how much is unnecessary. However, if you were working
with an unpacked git, then it may have had to open() a lot of files in
the object db (keep in mind that status doesn't just show the difference
between the working tree and the index; it shows the difference between
the index and the last commit. So maybe "git diff" would be a more
accurate comparison).

> Conclusions:  
> * For "status" operations on cold cache, large file count, Neither the
> performance of git or svn approaches the ideal.  Both are an order of
> magnitude slower than ideal, which is still assuming "ideal" requires
> walking the tree.  A better ideal avoids the need to walk the tree,
> and has near-zero total cost.

Try your git benchmark again with a packed repo, and I think you will
find it approaches the time it takes to walk the tree.

That being said, if walking the tree is unacceptable to you, then no,
current git won't work. You would need to patch it to use inotify (once
upon a time there was some discussion of this, but it never went
anywhere -- I guess most people work on machines where they can keep the
cache relatively warm).

-Peff
