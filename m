From: Jeff King <peff@peff.net>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 17:18:09 -0500
Message-ID: <20110310221809.GB15828@sigill.intra.peff.net>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110303185918.GA18503@sigill.intra.peff.net>
 <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
 <20110303203323.GA21102@sigill.intra.peff.net>
 <20110309174956.GA22683@sigill.intra.peff.net>
 <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net>
 <4D794531.40205@miseler.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Alexander Miseler <alexander@miseler.de>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:18:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxoBU-0000KJ-DY
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 23:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab1CJWSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 17:18:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51927
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768Ab1CJWSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 17:18:09 -0500
Received: (qmail 31608 invoked by uid 107); 10 Mar 2011 22:18:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 17:18:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 17:18:09 -0500
Content-Disposition: inline
In-Reply-To: <4D794531.40205@miseler.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168856>

On Thu, Mar 10, 2011 at 10:40:01PM +0100, Alexander Miseler wrote:

> "While git can handle arbitrary-sized binary content [...]"
> 
> This is very much not true. Git tries at many places to load the
> complete file into memory and usually fails with "out of memory" if it
> can't. With the 32bit msysGit client this places the upper file size
> limit, from purely empirical observation, at 600-700 MByte.

I think we are picking nits here. What I meant was two things:

  1. The fundamental design of git does not prevent storing
     arbitrary-sized binary data.

  2. How big a piece of data the current implementation can handle
     sanely is up to how much hardware you throw at it. On my 64-bit
     machine with 8G of RAM running Linux, I can easily work with 2
     gigabyte files. Some operations are slow, of course, but it works.

     I'm willing to accept that 32-bit msysgit has more trouble with
     a case like that.

But I think we are probably in agreement with what needs to be done to
make things better. Specifically, I am thinking of:

  1. Streaming blobs wherever possible (e.g., add, filters, textconv).

  2. Converting the diff code not to have in-memory files is probably
     going to be quite difficult. But most of these files don't have
     interesting diffs _anyway_. They're usually binary, and we don't
     generate binary diffs by default. So what we need to focus on is
     avoiding loading them when we can. Things like:

       a. Using caching textconv, and when we do run the textconv
          filter, streaming the blob to the filter.

       b. Avoid loading the whole file to check whether it is binary. We
          can already avoid this by marking it binary with
          gitattributes, but there is no reason git can't just load the
          first 4K or so to check for binary-ness, and get this
          optimization automatically. We can also consider caching
          binary-ness for large files so we don't have to look at them
          at all after the first time.

       c. Handle rename detection better. It may be a matter of saying
          "this file is too big for detection". But we may also be able
          to stream it through the spantree-hashing, and then possibly
          also cache the resultant data.

  3. The above deal with memory problems. There is also a storage
     problem. If I have a 100G repo, right now I use at least 100G in
     the .git directory and 100G in the working tree. That's a problem
     for repos of that size. If I have a storage server on the LAN and
     want to accept the latency hit, it would be nice to keep the
     commits local and the giant blobs on the server. Especially coupled
     with the optimizations in (2), we can possibly avoid even having to
     touch those blobs at all in many cases, so the latency wouldn't be
     a big deal.

  4. A related storage problem is that we put big files in packs, and
     the I/O on rewriting the pack becomes a problem. They would do
     better loose or in their own packs.

And I'm sure there are more variations on those things. Part of the
project would be identifying the problem areas.

> Even worse yet, commits consisting of smaller files but with a
> combined size over the limit will also cause out-of-memories.

That generally should work OK. The diff and packing code tries to keep
memory usage reasonable, which generally equates to two times the
largest file. If you have a test case that shows problems, there may
very well be a bug.

> Thus a main focus should be the memory problem, e.g. by using
> stream-like file handling everywhere, since not working at all is
> orders of magnitude worse than working slowly :)

Agreed. I think they are sort of the same problem. Whether it works
slowly or not at all is simply a matter of how much memory you have. ;)

> Ironically git add is one of the few things that work with large
> files, as mentioned above. Presumably the stream-oriented zlib
> enforced/encouraged a steam-like handling here :) Slow as hell though
> and of course it is usually not sensible to compress a 1.5 GByte file.

I just tried "git add" on a 2G file of random bytes. It took about a
minute or so to calculate the sha1 and compress it, but the memory usage
did jump to 2G. So we could obviously do better on the memory, and there
is almost certainly no point in zlib compressing something that big. In
my case, it was obviously just random junk. But most files of that size
are already going to have some kind of lossy compression, so we are just
wasting CPU. You can always set core.compression, but I really just want
it off for certain files.

> I'm very willing to work on this topic. Though I'm not a student and
> as a git code newbie I also don't have the skills for mentoring yet.

It's on my agenda, too. We'll see if a student steps up for the GSoC
project. But don't let that stop you if you want to take a look at it;
I'm sure there is plenty of work to go around. :)

-Peff
