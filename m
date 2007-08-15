From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: performance on repack
Date: Wed, 15 Aug 2007 01:32:31 -0400
Message-ID: <20070815053231.GJ27913@spearce.org>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com> <20070812103338.GA7763@auto.tuwien.ac.at> <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com> <20070814031236.GC27913@spearce.org> <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 07:32:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILBUy-0003S1-Sl
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 07:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbXHOFct (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 01:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbXHOFct
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 01:32:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48393 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbXHOFcs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 01:32:48 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ILBUd-0000aP-8H; Wed, 15 Aug 2007 01:32:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7E6C920FBAE; Wed, 15 Aug 2007 01:32:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55879>

Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 13 Aug 2007, Shawn O. Pearce wrote:
> 
> > I'm not sure its that complex to run all try_delta calls of the
> > current window in parallel.
> 
> Well, here's my quick attempt at it.  Unfortunately, performance isn't 
> as good as I'd expected, especially with relatively small blobs like 
> those found in the linux kernel repo.  It looks like the overhead of 
> thread creation/joining might be significant compared to the actual 
> delta computation.  I have a P4 with HT which might behave differently 
> from a real SMP machine, or whatever, but the CPU usage never exceeded 
> 110% according to top (sometimes it even dropped below 95%). Actually, a 
> git-repack gets much slower due to 2m27s of system time compared to 
> 0m03s without threads.  And this is with NPTL.

Yea, I'm not surprised.  This is quick and dirty but is really the
wrong approach.  The kernel is spending lots of time setting up the
thread and its stack, then scheduling it onto a CPU, only to likely
find it finish before it even yields the CPU or is interrupted off.
So I'd expect to get huge system times here.

Even Linux with its pretty amazing NPTL isn't up to the task.
No threading package really is.
 
> With a repo containing big blobs it is different though.  CPU usage 
> firmly gets to 200% hence all cores are saturated with work.

Right, that's what we want to see.  ;-)

What makes this bloody complex (yes, I just did disagree with
myself) is you need to use a pool of threads, one per core, keep
them running for the life of the delta phase (so we amortize the
thread start/stop time) and also give them large enough bursts of
data that they can almost always use their full time slice before
being interrupted by the kernel.

> Remains the approach of calling find_deltas() n times with 1/n of the 
> delta_list, one call per thread, for the bulk of the delta search work.  
> This might even be much simpler than my current patch is.  However this 
> approach will require n times the memory for the delta window data.  
> Thread creation overhead will occur only once.

Yea, that I agree with.  The other thing is the main thread may need
to push a couple of windows worth of work into the threads, so that
if this window's 1/n unit goes really fast on that thread it doesn't
stall out waiting for the main thread to get it more data.
 
> Also... read_sha1_file() is currently not thread safe, and threaded 
> delta searching would requires that its usage be serialized with a 
> global mutex (not done in this patch which is a bug), or ideally be made 
> thread aware.

Yea, that's a problem.  From the Git library perspective that Luiz
Capitulino has been working on for GSOC this summer being able to
compile/link Git with -lpthreads and have it actually be thread
safe would be useful.  Unfortunately its waaaay more than just
making read_sha1_file() threadsafe.  :-/

read_sha1_file() is actually a reasonably critical part of the
major functions of Git.  Slowing that down by making it go through
pthread_mutex_{lock,unlock} is going to hurt.  I tried something
like the following, and its a bit slower, and really ain't a great
multi-thread aware implementation.

# unmodified v1.5.3-rc4-91-g9fa3465 from Junio
/usr/bin/time ../rl-master/git-rev-list HEAD . >/dev/null
        1.67 real         1.42 user         0.20 sys
        1.65 real         1.36 user         0.17 sys
        1.67 real         1.35 user         0.16 sys
        1.70 real         1.35 user         0.16 sys
        1.64 real         1.35 user         0.16 sys

# v1.5.3-rc4-91-g9fa3465 + patch below
/usr/bin/time ../rl-pthread/git-rev-list HEAD . >/dev/null
        2.86 real         1.48 user         0.29 sys
        1.68 real         1.37 user         0.17 sys
        1.59 real         1.37 user         0.16 sys
        1.66 real         1.37 user         0.17 sys
        1.68 real         1.37 user         0.17 sys

That's on Mac OS X.  I guess NPTL would probably be faster at this,
but not so much faster as to make it not be an increase.

-->8--
diff --git a/Makefile b/Makefile
index 4eb4637..f31811b 100644
--- a/Makefile
+++ b/Makefile
@@ -710,7 +710,7 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
-LIBS = $(GITLIBS) $(EXTLIBS)
+LIBS = $(GITLIBS) $(EXTLIBS) -lpthread
 
 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
 	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' $(COMPAT_CFLAGS)
diff --git a/sha1_file.c b/sha1_file.c
index aca741b..c239789 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -6,6 +6,7 @@
  * This handles basic git sha1 object files - packing, unpacking,
  * creation etc.
  */
+#include <pthread.h>
 #include "cache.h"
 #include "delta.h"
 #include "pack.h"
@@ -1862,10 +1863,12 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
 		     unsigned long *size)
 {
+	static pthread_mutex_t locky = PTHREAD_MUTEX_INITIALIZER;
 	unsigned long mapsize;
 	void *map, *buf;
 	struct cached_object *co;
 
+	pthread_mutex_lock(&locky);
 	co = find_cached_object(sha1);
 	if (co) {
 		buf = xmalloc(co->size + 1);
@@ -1873,20 +1876,26 @@ void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
 		((char*)buf)[co->size] = 0;
 		*type = co->type;
 		*size = co->size;
+		pthread_mutex_unlock(&locky);
 		return buf;
 	}
 
 	buf = read_packed_sha1(sha1, type, size);
-	if (buf)
+	if (buf) {
+		pthread_mutex_unlock(&locky);
 		return buf;
+	}
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
 		buf = unpack_sha1_file(map, mapsize, type, size, sha1);
 		munmap(map, mapsize);
+		pthread_mutex_unlock(&locky);
 		return buf;
 	}
 	reprepare_packed_git();
-	return read_packed_sha1(sha1, type, size);
+	buf = read_packed_sha1(sha1, type, size);
+	pthread_mutex_unlock(&locky);
+	return buf;
 }
 
 void *read_object_with_reference(const unsigned char *sha1,
-- 
Shawn.
