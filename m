From: Jeff King <peff@peff.net>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 14:23:03 -0400
Message-ID: <20140522182303.GA1167@sigill.intra.peff.net>
References: <1400775763.1933.5.camel@stross>
 <20140522164634.GB30419@sigill.intra.peff.net>
 <1400782096.18134.1.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 22 20:23:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnXe3-0005fY-JO
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 20:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbaEVSXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 14:23:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:57551 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750835AbaEVSXG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 14:23:06 -0400
Received: (qmail 14014 invoked by uid 102); 22 May 2014 18:23:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 13:23:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 14:23:03 -0400
Content-Disposition: inline
In-Reply-To: <1400782096.18134.1.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249929>

On Thu, May 22, 2014 at 02:08:16PM -0400, David Turner wrote:

> On Thu, 2014-05-22 at 12:46 -0400, Jeff King wrote:
> > On Thu, May 22, 2014 at 12:22:43PM -0400, David Turner wrote:
> >
> > > If I have a git repository with a clean working tree, and I delete the
> > > index, then I can use git reset (with no arguments) to recreate it.
> > > However, when I do recreate it, it doesn't come back the same.  I have
> > > not analyzed this in detail, but the effect is that commands like git
> > > status take much longer because they must read objects out of a pack
> > > file.  In other words, the index seems to not realize that the index (or
> > > at least most of it) represents the same state as HEAD.  If I do git
> > > reset --hard, the index is restored to the original state (it's
> > > byte-for-byte identical), and the pack file is no longer read.
> >
> > Are you sure it's reading a packfile?
>
> Well, it's calling inflate(), and strace says it is reading
> e.g. .git/objects/pack/pack-....{idx,pack}.
>
> So, I would say so.

That seems odd that we would be spending extra time there. We do
inflate() the trees in order to diff the index against HEAD, but we
shouldn't need to inflate any blobs.

Here it is for me (on linux.git):

  [before, warm cache]
  $ time perf record -q git status >/dev/null
  real    0m0.192s
  user    0m0.080s
  sys     0m0.108s

  $ perf report | grep -v '#' | head -5
     7.46%      git  [kernel.kallsyms]   [k] __d_lookup_rcu
     4.55%      git  libz.so.1.2.8       [.] inflate
     3.53%      git  libc-2.18.so        [.] __memcmp_sse4_1
     3.46%      git  [kernel.kallsyms]   [k] security_inode_getattr
     3.29%      git  git                 [.] memihash

  $ time git reset
  real    0m0.080s
  user    0m0.036s
  sys     0m0.040s

So status is pretty quick, and the time is going to lstat in the kernel,
and some tree inflation. Reset is fast, because it has nothing much to
do. Now let's kill off the index's stat cache:

  $ rm .git/index
  $ time perf record -q git reset
  real    0m0.967s
  user    0m0.780s
  sys     0m0.180s

That took a while. What was it doing?

  $ perf report | grep -v '#' | head -5
     3.23%      git  [kernel.kallsyms]   [k] copy_user_enhanced_fast_string
     1.74%      git  libcrypto.so.1.0.0  [.] 0x000000000007e010            
     1.60%      git  [kernel.kallsyms]   [k] __d_lookup_rcu                
     1.51%      git  [kernel.kallsyms]   [k] page_fault                    
     1.44%      git  libc-2.18.so        [.] __memcmp_sse4_1               

Reading files and sha1. We hash the working-tree files here (reset
doesn't technically need to refresh the index from the working tree to
copy entries from HEAD into the index, but it does it so it can do fancy
things like tell you about which files are now out-of-date).

Now how does stat fare after this?

  $ time perf record -q git status >/dev/null
  real    0m0.189s
  user    0m0.088s
  sys     0m0.096s

Looks about the same as before to me.

Note that if you use "read-tree" instead of "reset", it _just_ loads the
index, and doesn't touch the working tree. If you then run "git status",
then _that_ command has to refresh the index, and it will pay the
hashing cost. Like:

  $ rm .git/index
  $ time git read-tree HEAD
  real    0m0.084s
  user    0m0.064s
  sys     0m0.016s
  $ time git status >/dev/null
  real    0m0.833s
  user    0m0.712s
  sys     0m0.112s

All of this is behaving as I would expect. Can you show us a set of
commands that deviate from this?

-Peff
