From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: performance on repack
Date: Wed, 15 Aug 2007 11:08:38 -0400
Message-ID: <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
	 <20070812103338.GA7763@auto.tuwien.ac.at>
	 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
	 <20070814031236.GC27913@spearce.org>
	 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
	 <20070815053231.GJ27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Martin Koegler" <mkoegler@auto.tuwien.ac.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 17:08:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILKUQ-0000z3-Bj
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 17:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765129AbXHOPIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 11:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765060AbXHOPIn
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 11:08:43 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:24046 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764822AbXHOPIj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 11:08:39 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2538571wah
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 08:08:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WhLN+0XslVTxLNFui2dfEpz+c4m+Z7tDSJFutEOE/JI488C1ds7lJJ7B4YX+ghesqz6u4UqQgmuFZuh8flSfL+/dUpY1YeTsoU9BiZIQNCXNhOdN7GFbifIVpIoJLE4YzPMCVrsPuVGgAEOUjaHGRMf3KxbyPQxOh+Sp+D13YKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zm/f3K5RpIM+4+cXOGaBbc8V68FVzZm+ysdbxB/iOB2OGvyt9koT7Hdn1nTTfFC/jkyo2DkSHZv0+vJcrBMi/EC5HtuKQ61L+6+ARAYUXrXUIdxN/UtkeQwmj30hMDawKd/Jh8gyyA/Bs+s1yKWye7aMm41E2pQEXDreZUUZkHY=
Received: by 10.114.92.2 with SMTP id p2mr619181wab.1187190518354;
        Wed, 15 Aug 2007 08:08:38 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Wed, 15 Aug 2007 08:08:38 -0700 (PDT)
In-Reply-To: <20070815053231.GJ27913@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55909>

On 8/15/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > On Mon, 13 Aug 2007, Shawn O. Pearce wrote:
> Even Linux with its pretty amazing NPTL isn't up to the task.
> No threading package really is.

You need something like fibers instead of threads for task that small.

> Yea, that I agree with.  The other thing is the main thread may need
> to push a couple of windows worth of work into the threads, so that
> if this window's 1/n unit goes really fast on that thread it doesn't
> stall out waiting for the main thread to get it more data.
>
> > Also... read_sha1_file() is currently not thread safe, and threaded
> > delta searching would requires that its usage be serialized with a
> > global mutex (not done in this patch which is a bug), or ideally be made
> > thread aware.

You can avoid making all the low level calls thread safe by using the
main thread to get everything into RAM before starting to search for
the deltas. The worker threads would only deal with things completely
in memory. You may need to ref count these in-memory objects if they
are shared between worker threads. For simplicity the in-memory input
objects should be read only by the threads. The worker threads create
new structures to hand their results back to the main thread for
writing to disk.

A typical solution is to use a queue protected by locks. Main thread
faults in all the needed objects to cache. Main thread builds a queue
entry and increments reference count on all referenced objects. Main
thread uses locks to add entry to queue, while queue is locked it
removes any finished jobs. Main thread writes finished results to
disks, decrements ref counts. Cache logic can then take over about
when objects are actually deleted.

Worker threads wait on the queue. When something is placed in the
queue a waiting worker thread removes it, processes it, puts the
results in RAM, and places the object back on the finished queue. Then
waits for another object. It doesn't call into the main body of code.

Initially I would just ignore very large objects while getting the
basic code to work. After the basic code is working if a very large
object is encountered when the main thread is faulting objects in, the
main thread should just process this object on the spot using the
existing low memory code.

Hopefully the new adaptive read ahead code in the kernel will detect
the pattern of the main thread faulting objects in and make good
guesses about where to read ahead. This is key to not getting stuck
waiting on IO to complete. If not the main thread could use ADVISE to
give kernel read ahead clues about where it is going to read next.

> Yea, that's a problem.  From the Git library perspective that Luiz
> Capitulino has been working on for GSOC this summer being able to
> compile/link Git with -lpthreads and have it actually be thread
> safe would be useful.  Unfortunately its waaaay more than just
> making read_sha1_file() threadsafe.  :-/
>
> read_sha1_file() is actually a reasonably critical part of the
> major functions of Git.  Slowing that down by making it go through
> pthread_mutex_{lock,unlock} is going to hurt.  I tried something
> like the following, and its a bit slower, and really ain't a great
> multi-thread aware implementation.
>
> # unmodified v1.5.3-rc4-91-g9fa3465 from Junio
> /usr/bin/time ../rl-master/git-rev-list HEAD . >/dev/null
>         1.67 real         1.42 user         0.20 sys
>         1.65 real         1.36 user         0.17 sys
>         1.67 real         1.35 user         0.16 sys
>         1.70 real         1.35 user         0.16 sys
>         1.64 real         1.35 user         0.16 sys
>
> # v1.5.3-rc4-91-g9fa3465 + patch below
> /usr/bin/time ../rl-pthread/git-rev-list HEAD . >/dev/null
>         2.86 real         1.48 user         0.29 sys
>         1.68 real         1.37 user         0.17 sys
>         1.59 real         1.37 user         0.16 sys
>         1.66 real         1.37 user         0.17 sys
>         1.68 real         1.37 user         0.17 sys
>
> That's on Mac OS X.  I guess NPTL would probably be faster at this,
> but not so much faster as to make it not be an increase.
>
> -->8--
> diff --git a/Makefile b/Makefile
> index 4eb4637..f31811b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -710,7 +710,7 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
>  PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
>  TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
>
> -LIBS = $(GITLIBS) $(EXTLIBS)
> +LIBS = $(GITLIBS) $(EXTLIBS) -lpthread
>
>  BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
>         -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' $(COMPAT_CFLAGS)
> diff --git a/sha1_file.c b/sha1_file.c
> index aca741b..c239789 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -6,6 +6,7 @@
>   * This handles basic git sha1 object files - packing, unpacking,
>   * creation etc.
>   */
> +#include <pthread.h>
>  #include "cache.h"
>  #include "delta.h"
>  #include "pack.h"
> @@ -1862,10 +1863,12 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
>  void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
>                      unsigned long *size)
>  {
> +       static pthread_mutex_t locky = PTHREAD_MUTEX_INITIALIZER;
>         unsigned long mapsize;
>         void *map, *buf;
>         struct cached_object *co;
>
> +       pthread_mutex_lock(&locky);
>         co = find_cached_object(sha1);
>         if (co) {
>                 buf = xmalloc(co->size + 1);
> @@ -1873,20 +1876,26 @@ void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
>                 ((char*)buf)[co->size] = 0;
>                 *type = co->type;
>                 *size = co->size;
> +               pthread_mutex_unlock(&locky);
>                 return buf;
>         }
>
>         buf = read_packed_sha1(sha1, type, size);
> -       if (buf)
> +       if (buf) {
> +               pthread_mutex_unlock(&locky);
>                 return buf;
> +       }
>         map = map_sha1_file(sha1, &mapsize);
>         if (map) {
>                 buf = unpack_sha1_file(map, mapsize, type, size, sha1);
>                 munmap(map, mapsize);
> +               pthread_mutex_unlock(&locky);
>                 return buf;
>         }
>         reprepare_packed_git();
> -       return read_packed_sha1(sha1, type, size);
> +       buf = read_packed_sha1(sha1, type, size);
> +       pthread_mutex_unlock(&locky);
> +       return buf;
>  }
>
>  void *read_object_with_reference(const unsigned char *sha1,
> --
> Shawn.
>


-- 
Jon Smirl
jonsmirl@gmail.com
