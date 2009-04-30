From: Jeff King <peff@peff.net>
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git,
	dscms and a "whole product" approach)
Date: Thu, 30 Apr 2009 10:22:44 -0400
Message-ID: <20090430142244.GA23550@coredump.intra.peff.net>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3ocugod96.fsf@localhost.localdomain> <m3fxfqnxn5.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 16:22:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzXAA-00027t-25
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 16:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762595AbZD3OWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 10:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759665AbZD3OWx
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 10:22:53 -0400
Received: from peff.net ([208.65.91.99]:44282 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbZD3OWw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 10:22:52 -0400
Received: (qmail 19282 invoked by uid 107); 30 Apr 2009 14:23:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 30 Apr 2009 10:23:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Apr 2009 10:22:44 -0400
Content-Disposition: inline
In-Reply-To: <m3fxfqnxn5.fsf_-_@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118017>

On Thu, Apr 30, 2009 at 05:17:58AM -0700, Jakub Narebski wrote:

> This is I think quite obvious.  Accessing memory is faster than
> acessing disk, which in turn is faster than accessing network.  So if
> commit and (change)log does not require access to server via network,
> they are so much faster.

Like all generalizations, this is only mostly true. Fast network servers
with big caches can outperform disks for some loads. And in many cases
with a VCS, you are performing a query that might look over the whole
dataset, but return only a small fraction of data.

So I wouldn't rule out the possibility of a pleasant VCS experience on a
network-optimized system backed by beefy servers on a local network. I
have never used perforce, but I get the impression that it is more
optimized for such a situation. Git is really optimized for open source
projects: slow servers across high-latency, low-bandwidth links.

> es> Nah, probably not.  Lots of people have written fast software in
> es> C#, Java or Python.
> es>
> es> And lots of people have written really slow software in
> es> traditional native languages like C/C++. [...]
> 
> Well, I guess that access to low-level optimization techniques like
> mmap are important for performance.  But here I am guessing and
> speculating like Eric did; well, I am asking on a proper forum ;-)

Certainly there's algorithmic fastness that you can do in any language,
and I think git does well at that. Most operations are independent of
the total size of history (e.g., branching is O(1) and commit is
O(changed files), diff looks only at endpoints, etc). Operations which
deal only with history are independent of the size of the tree (e.g.,
"git log" and the history graph in gitk look only at commits, never at
the tree).  And when we do have to look at the tree, we can drastically
reduce our I/O by comparing hashes instead of full files.

But there are also some micro-optimizations that make a big difference
in practice. Some of them can be done in any language. For example, the
packfiles are ordered by type so that all of the commits have a nice I/O
pattern when doing a history walk.

Some other micro-optimizations are really language-specific, though. I
don't recall the numbers, but I think Linus got measurable speedups from
cutting the memory footprint of the object and commit structs (which
gave better cache usage patterns).  Git uses some variable-length fields
inside structs instead of a pointer to a separate allocated string to
give better memory access patterns. Tricks like that won't give the
order-of-magnitude speedups that algorithmic optimizations will, but 10%
here and 20% there means you can get a system that is a few times faster
than the competition. For an operation that takes 0.1s anyway, that
doesn't matter. But with current hardware and current project size, you
are often talking about dropping a 3-second operation down to 1s or
0.5s, which just feels a lot snappier.

And finally, git tries to do as little work as possible when starting a
new command, and streams output as soon as possible. Which means that in
a command-line setting, git can _feel_ snappier, because it starts
output immediately. Higher-level languages can often have a much longer
startup time, especially if they have a lot of modules to load. E.g.,:

  # does enough work to easily fill your pager
  $ time git log -100 >/dev/null
  real    0m0.011s
  user    0m0.008s
  sys     0m0.004s

  # does nothing, just starts perl and aborts with usage
  $ time git send-email >/dev/null
  real    0m0.150s
  user    0m0.104s
  sys     0m0.048s

Both are warm-cache times. C git gives you output almost instaneously,
whereas just loading perl with a modest set of modules introduces a
noticeable pause before any work is actually done. In the grand scheme
of things, .1s probably isn't relevant, but I think avoiding that delay
adds to the perception of git as fast.

> es> Or maybe Git's shortcut for handling renames is faster than doing
> es> them more correctly[2] like Bazaar does.
> es>
> es> [2] "Renaming is the killer app of distributed version control"
> es>     http://www.markshuttleworth.com/archives/123
> 
> Errr... what?

Yeah, I had the same thought. Git's rename handling is _much_ more
computationally intensive than other systems. In fact, it is one of only
two places where I have ever wanted git to be any faster (the other
being repacking of large repos).

> Eight: Git seems fast.
> ======================
> 
> Here I mean concentaring on low _latency_, which means that when git

I do think this helps (see above), but I wanted to note that it is more
than just "streaming"; I think other systems stream, as well. For
example, I am pretty sure that "cvs log" streamed (but thank god it has
been so long since I touched CVS that I can't really remember), but it
_still_ felt awfully slow.

So it is also about keeping start times low and having your data in a
format that is ready to use.

-Peff
