From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] grep multithreading and scaling
Date: Fri, 2 Dec 2011 12:34:00 -0500
Message-ID: <20111202173400.GC23447@sigill.intra.peff.net>
References: <201111291507.04754.trast@student.ethz.ch>
 <cover.1322830368.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Eric Herman <eric@freesa.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 02 18:34:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWX04-0001aq-KC
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 18:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240Ab1LBReG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 12:34:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39048
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757236Ab1LBReD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 12:34:03 -0500
Received: (qmail 8355 invoked by uid 107); 2 Dec 2011 17:40:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Dec 2011 12:40:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Dec 2011 12:34:00 -0500
Content-Disposition: inline
In-Reply-To: <cover.1322830368.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186231>

On Fri, Dec 02, 2011 at 02:07:45PM +0100, Thomas Rast wrote:

> where I put the --cached originally because that makes it independent
> of the worktree (which in the very first measurements I still had
> wiped, as I tend to do for this repo; I checked it out again after
> that).  This in fact gives me (~/g/git-grep --cached
> INITRAMFS_ROOT_UID, leaving aside -W; best of 10):
> 
>   THREADS=8:   2.88user 0.21system 0:02.94elapsed
>   THREADS=4:   2.89user 0.29system 0:02.99elapsed
>   THREADS=2:   2.83user 0.36system 0:02.87elapsed
>   NO_PTHREADS: 2.16user 0.08system 0:02.25elapsed
> 
> Uhuh.  Doesn't scale so well after all.  But removing the --cached, as
> most people probably would:
> 
>   THREADS=8:   0.19user 0.32system 0:00.16elapsed
>   THREADS=4:   0.16user 0.34system 0:00.17elapsed
>   THREADS=2:   0.18user 0.32system 0:00.26elapsed
>   NO_PTHREADS: 0.12user 0.17system 0:00.31elapsed
> 
> So I conclude that during any grep that cannot use the worktree,
> having any threads hurts.

Wow, that's horrible. Leaving aside the parallelism, it's just terrible
that reading from the cache is 20 times slower than the worktree. I get
similar results on my quad-core machine.

A quick perf run shows most of the time is spent inflating objects. The
diff code has a sneaky trick to re-use worktree files when we know they
are stat-clean (in diff's case it is to avoid writing a tempfile). I
wonder if we should use the same trick here.

It would hurt the cold cache case, though, as the compressed versions
require fewer disk accesses, of course.

-Peff

PS I suspect your timings are somewhat affected by the simplicity of the
   regex you are asking for. The time to inflate the blobs dominates,
   because the search is just a memmem(). On my quad-core w/
   hyperthreading (i.e., 8 apparent cores):

   [no caching, simple regex; we get some parallelism, but the regex
    task is just not that intensive]
   $ /usr/bin/time git grep INITRAMFS_ROOT_UID >/dev/null
   0.42user 0.45system 0:00.15elapsed 578%CPU

   [no caching, harder regex; we get much higher CPU utilization]
   $ /usr/bin/time git grep 'a.*b' >/dev/null
   14.68user 0.50system 0:02.00elapsed 758%CPU

   [with caching, simple regex; we get almost _no_ parallelism because
    all of our time is spent deflating under a lock, and the regex task
    takes very little time]
   $ /usr/bin/time git grep --cached INITRAMFS_ROOT_UID >/dev/null
   7.64user 0.41system 0:07.61elapsed 105%CPU

   [with caching, harder regex; not as much parallelism as we hoped for,
    but still much more than before. Because there is actually work to
    parallelize in the regex]
   $ /usr/bin/time git grep --cached 'a.*b' >/dev/null
   23.46user 0.47system 0:08.42elapsed 284%CPU

   So I think there is value in parallelizing even --cached greps. But
   we could do so much better if blob inflation could be done in
   parallel.
