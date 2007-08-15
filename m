From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: performance on repack
Date: Tue, 14 Aug 2007 21:20:46 -0400
Message-ID: <9e4733910708141820n9a09f08h6e104b7469f63375@mail.gmail.com>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
	 <20070812103338.GA7763@auto.tuwien.ac.at>
	 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
	 <20070814031236.GC27913@spearce.org>
	 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Martin Koegler" <mkoegler@auto.tuwien.ac.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 03:20:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL7Z6-0008U5-Mt
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 03:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbXHOBUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 21:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbXHOBUt
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 21:20:49 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:30232 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbXHOBUr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 21:20:47 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1593476rvb
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 18:20:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i+TTPIjv6c2JCvP0X7eOaIwt2yGTXNTIxQY+XQDZpJpr8qKqNCSsJt23ShRVnun788F540/1KVz4T/rww3Q/nKwYFtyveWN4vZbVAwYKinquG/DIzF5Y3HQWZeFqvXy7LkLK8DdPhYTimNlPfXGxpqvoI5ve4pRO96I9n9pJ6rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cxuhe56uFVI40/b16qrYaqaYNk/OlMHYw2IVQUrFMLv7DNCD1eYu0GbRBm764rPMqJc+A6ddKCO7NPF6EEl0Tn02B3fuiFr2gKS+bSX/agB+qCQepkttZmEKqRCKEo2SWVycJy4okek3E0gdpoxj5TLGU3rq7jbMOMe5ESbPghk=
Received: by 10.115.59.4 with SMTP id m4mr1443816wak.1187140846762;
        Tue, 14 Aug 2007 18:20:46 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Tue, 14 Aug 2007 18:20:46 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55870>

On 8/14/07, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 13 Aug 2007, Shawn O. Pearce wrote:
>
> > I'm not sure its that complex to run all try_delta calls of the
> > current window in parallel.  Might be a simple enough change that
> > its actually worth the extra complexity, especially with these
> > multi-core systems being so readily available.  Repacking is the
> > most CPU intensive operation Git performs, and the one that is also
> > the easiest to make parallel.
> >
> > Maybe someone else will beat me to it, but if not I might give such
> > a patch a shot in a few weeks.
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

Thread creation/destruction overhead is way too high to make these
threads for every delta.

Another strategy is to create four worker threads once when the
process is loaded. Then use synchronization primitives to feed the
threads lumps of work. The threads persist for the life of the
process.


>
> With a repo containing big blobs it is different though.  CPU usage
> firmly gets to 200% hence all cores are saturated with work.
>
> So clearly the naive approach of spawning a thread for each combination
> in the delta window doesn't work.
>
> Remains the approach of calling find_deltas() n times with 1/n of the
> delta_list, one call per thread, for the bulk of the delta search work.
> This might even be much simpler than my current patch is.  However this
> approach will require n times the memory for the delta window data.
> Thread creation overhead will occur only once.
>
> Also... read_sha1_file() is currently not thread safe, and threaded
> delta searching would requires that its usage be serialized with a
> global mutex (not done in this patch which is a bug), or ideally be made
> thread aware.
>
>
> Nicolas
>
> ---
>
> diff --git a/Makefile b/Makefile
> index 4eb4637..c3c6e68 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -122,6 +122,9 @@ all::
>  # If not set it defaults to the bare 'wish'. If it is set to the empty
>  # string then NO_TCLTK will be forced (this is used by configure script).
>  #
> +# Define THREADED_DELTA_SEARCH if you have pthreads and wish to exploit
> +# parallel delta searching when packing objects.
> +#
>
>  GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
>         @$(SHELL_PATH) ./GIT-VERSION-GEN
> @@ -662,6 +665,11 @@ ifdef NO_HSTRERROR
>         COMPAT_OBJS += compat/hstrerror.o
>  endif
>
> +ifdef THREADED_DELTA_SEARCH
> +       BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
> +       EXTLIBS += -lpthread
> +endif
> +
>  ifeq ($(TCLTK_PATH),)
>  NO_TCLTK=NoThanks
>  endif
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 5e9d1fd..142b6dd 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -15,6 +15,10 @@
>  #include "list-objects.h"
>  #include "progress.h"
>
> +#ifdef THREADED_DELTA_SEARCH
> +#include <pthread.h>
> +#endif
> +
>  static const char pack_usage[] = "\
>  git-pack-objects [{ -q | --progress | --all-progress }] \n\
>         [--max-pack-size=N] [--local] [--incremental] \n\
> @@ -1273,6 +1277,12 @@ struct unpacked {
>         void *data;
>         struct delta_index *index;
>         unsigned depth;
> +#ifdef THREADED_DELTA_SEARCH
> +       pthread_t thread;
> +       pthread_mutex_t mutex;
> +       struct unpacked *trg;
> +       unsigned trg_max_depth;
> +#endif
>  };
>
>  static int delta_cacheable(struct unpacked *trg, struct unpacked *src,
> @@ -1292,6 +1302,18 @@ static int delta_cacheable(struct unpacked *trg, struct unpacked *src,
>         return 0;
>  }
>
> +#ifdef THREADED_DELTA_SEARCH
> +#define delta_lock_init(e)     pthread_mutex_init(&(e)->mutex, NULL)
> +#define delta_lock_destroy(e)  pthread_mutex_destroy(&(e)->mutex)
> +#define delta_lock(e)          pthread_mutex_lock(&(e)->mutex)
> +#define delta_unlock(e)                pthread_mutex_unlock(&(e)->mutex)
> +#else
> +#define delta_lock_init(e)     0
> +#define delta_lock_destroy(e)  0
> +#define delta_lock(e)          0
> +#define delta_unlock(e)                0
> +#endif
> +
>  /*
>   * We search for deltas _backwards_ in a list sorted by type and
>   * by size, so that we see progressively smaller and smaller files.
> @@ -1335,6 +1357,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>                 return 0;
>
>         /* Now some size filtering heuristics. */
> +       delta_lock(trg);
>         trg_size = trg_entry->size;
>         if (!trg_entry->delta) {
>                 max_size = trg_size/2 - 20;
> @@ -1343,6 +1366,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>                 max_size = trg_entry->delta_size;
>                 ref_depth = trg->depth;
>         }
> +       delta_unlock(trg);
>         max_size = max_size * (max_depth - src->depth) /
>                                                 (max_depth - ref_depth + 1);
>         if (max_size == 0)
> @@ -1355,6 +1379,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>                 return 0;
>
>         /* Load data if not already done */
> +
> +       delta_lock(trg);
>         if (!trg->data) {
>                 trg->data = read_sha1_file(trg_entry->idx.sha1, &type, &sz);
>                 if (sz != trg_size)
> @@ -1362,6 +1388,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>                             sha1_to_hex(trg_entry->idx.sha1), sz, trg_size);
>                 window_memory_usage += sz;
>         }
> +       delta_unlock(trg);
> +
> +       delta_lock(src);
>         if (!src->data) {
>                 src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
>                 if (sz != src_size)
> @@ -1375,20 +1404,30 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>                         static int warned = 0;
>                         if (!warned++)
>                                 warning("suboptimal pack - out of memory");
> +                       delta_unlock(src);
>                         return 0;
>                 }
>                 window_memory_usage += sizeof_delta_index(src->index);
>         }
> +       delta_unlock(src);
>
>         delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
>         if (!delta_buf)
>                 return 0;
>
> +       delta_lock(trg);
>         if (trg_entry->delta_data) {
> -               /* Prefer only shallower same-sized deltas. */
> -               if (delta_size == trg_entry->delta_size &&
> -                   src->depth + 1 >= trg->depth) {
> +#ifdef THREADED_DELTA_SEARCH
> +               /* A better match might have been found in the mean time */
> +               max_size = trg_entry->delta_size * (max_depth - src->depth) /
> +                                               (max_depth - trg->depth + 1);
> +#endif
> +               /* ... also prefer only shallower same-sized deltas. */
> +               if (delta_size > max_size ||
> +                   (delta_size == trg_entry->delta_size &&
> +                    src->depth + 1 >= trg->depth)) {
>                         free(delta_buf);
> +                       delta_unlock(trg);
>                         return 0;
>                 }
>                 delta_cache_size -= trg_entry->delta_size;
> @@ -1404,9 +1443,21 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>                 delta_cache_size += trg_entry->delta_size;
>         } else
>                 free(delta_buf);
> +       delta_unlock(trg);
>         return 1;
>  }
>
> +#ifdef THREADED_DELTA_SEARCH
> +
> +static void *threaded_try_delta(void *arg)
> +{
> +       struct unpacked *src = arg;
> +       int ret = try_delta(src->trg, src, src->trg_max_depth);
> +       return (void *)ret;
> +}
> +
> +#endif
> +
>  static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
>  {
>         struct object_entry *child = me->delta_child;
> @@ -1439,19 +1490,20 @@ static void find_deltas(struct object_entry **list, int window, int depth)
>         uint32_t i = nr_objects, idx = 0, count = 0, processed = 0;
>         unsigned int array_size = window * sizeof(struct unpacked);
>         struct unpacked *array;
> -       int max_depth;
> +       int j, max_depth;
>
>         if (!nr_objects)
>                 return;
>         array = xmalloc(array_size);
>         memset(array, 0, array_size);
> +       for (j = 0; j < window; j++)
> +               delta_lock_init(&array[j]);
>         if (progress)
>                 start_progress(&progress_state, "Deltifying %u objects...", "", nr_result);
>
>         do {
>                 struct object_entry *entry = list[--i];
>                 struct unpacked *n = array + idx;
> -               int j;
>
>                 if (!entry->preferred_base)
>                         processed++;
> @@ -1494,6 +1546,38 @@ static void find_deltas(struct object_entry **list, int window, int depth)
>                                 goto next;
>                 }
>
> +#ifdef THREADED_DELTA_SEARCH
> +               /* Create all threads ... */
> +               j = window;
> +               while (--j > 0) {
> +                       int ret;
> +                       uint32_t other_idx = idx + j;
> +                       struct unpacked *m;
> +                       if (other_idx >= window)
> +                               other_idx -= window;
> +                       m = array + other_idx;
> +                       if (!m->entry)
> +                               break;
> +                       m->trg = n;
> +                       m->trg_max_depth= max_depth;
> +                       ret = pthread_create(&m->thread, NULL,
> +                                            threaded_try_delta, m);
> +                       if (ret)
> +                               die("unable to create thread: %s", strerror(ret));
> +               }
> +               /* ... then join them. */
> +               while (++j < window) {
> +                       int ret;
> +                       uint32_t other_idx = idx + j;
> +                       struct unpacked *m;
> +                       if (other_idx >= window)
> +                               other_idx -= window;
> +                       m = array + other_idx;
> +                       ret = pthread_join(m->thread, NULL);
> +                       if (ret)
> +                               die("unable to join thread: %s", strerror(ret));
> +               }
> +#else
>                 j = window;
>                 while (--j > 0) {
>                         uint32_t other_idx = idx + j;
> @@ -1506,6 +1590,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
>                         if (try_delta(n, m, max_depth) < 0)
>                                 break;
>                 }
> +#endif
>
>                 /* if we made n a delta, and if n is already at max
>                  * depth, leaving it in the window is pointless.  we
> @@ -1528,6 +1613,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
>         for (i = 0; i < window; ++i) {
>                 free_delta_index(array[i].index);
>                 free(array[i].data);
> +               delta_lock_destroy(&array[i]);
>         }
>         free(array);
>  }
>


-- 
Jon Smirl
jonsmirl@gmail.com
