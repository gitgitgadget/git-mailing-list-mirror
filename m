From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Sun, 9 Dec 2007 23:30:54 -0500
Message-ID: <9e4733910712092030j5cf7dfdcrb3a003fbce391422@mail.gmail.com>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 05:31:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1aIe-0006yZ-Ao
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 05:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbXLJEa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 23:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbXLJEa5
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 23:30:57 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:27973 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbXLJEa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 23:30:56 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3105863wah
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 20:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=p3L0xXCyHZVZ6wMvYVlOb+85o3pFAJZO22f6IZ7baRg=;
        b=CLxFqMdjfbWeKiAmtWG7z+ls0EQ2GqjQovLyew5q0ZOo5KfM/QsrFhYGr84YZtLHUVqfilfrcbhQFlt/fzjuiXpPIXe19eL98DmviI9aQE2MwJtQowRBEbz4bpSY+k4zuwPkoGcLqJLV3Nbbq0xfjJd911wDW+yQa6GLEtBvCVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lt4FPWV+Jj+Pu+EBRO2T4A3nKLjSfWCTbmFtTIwhGQNpY1vwjE6+pNOXLHoHaTMbmBxK1vXavxdBRyIhc4sGtYU+PUIyfVarg4gfNcDEYMNzgTzsb0iwmaMt9iN1KKOjKr+txS4RqwVXoUHjWQ3xF9GYpglr1irmPrJdKjKemvw=
Received: by 10.114.170.1 with SMTP id s1mr251804wae.1197261055023;
        Sun, 09 Dec 2007 20:30:55 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Sun, 9 Dec 2007 20:30:54 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67678>

On 12/8/07, Nicolas Pitre <nico@cam.org> wrote:
>
> The current method consists of a master thread serving chunks of objects
> to work threads when they're done with their previous chunk.  The issue
> is to determine the best chunk size: making it too large creates poor
> load balancing, while making it too small has a negative effect on pack
> size because of the increased number of chunk boundaries and poor delta
> window utilization.
>
> This patch implements a completely different approach by initially
> splitting the work in large chunks uniformly amongst all threads, and
> whenever a thread is done then it steals half of the remaining work from
> another thread with the largest amount of unprocessed objects.
>
> This has the advantage of greatly reducing the number of chunk boundaries
> with an almost perfect load balancing.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---
>  builtin-pack-objects.c |  117 +++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 85 insertions(+), 32 deletions(-)
>
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 5002cc6..fcc1901 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1479,10 +1479,10 @@ static unsigned long free_unpacked(struct unpacked *n)
>         return freed_mem;
>  }
>
> -static void find_deltas(struct object_entry **list, unsigned list_size,
> +static void find_deltas(struct object_entry **list, unsigned *list_size,
>                         int window, int depth, unsigned *processed)
>  {
> -       uint32_t i = 0, idx = 0, count = 0;
> +       uint32_t i, idx = 0, count = 0;
>         unsigned int array_size = window * sizeof(struct unpacked);
>         struct unpacked *array;
>         unsigned long mem_usage = 0;
> @@ -1490,11 +1490,23 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
>         array = xmalloc(array_size);
>         memset(array, 0, array_size);
>
> -       do {
> -               struct object_entry *entry = list[i++];
> +       for (;;) {
> +               struct object_entry *entry = *list++;
>                 struct unpacked *n = array + idx;
>                 int j, max_depth, best_base = -1;
>
> +               progress_lock();
> +               if (!*list_size) {
> +                       progress_unlock();
> +                       break;
> +               }
> +               (*list_size)--;
> +               if (!entry->preferred_base) {
> +                       (*processed)++;
> +                       display_progress(progress_state, *processed);
> +               }
> +               progress_unlock();
> +
>                 mem_usage -= free_unpacked(n);
>                 n->entry = entry;
>
> @@ -1512,11 +1524,6 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
>                 if (entry->preferred_base)
>                         goto next;
>
> -               progress_lock();
> -               (*processed)++;
> -               display_progress(progress_state, *processed);
> -               progress_unlock();
> -
>                 /*
>                  * If the current object is at pack edge, take the depth the
>                  * objects that depend on the current object into account
> @@ -1576,7 +1583,7 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
>                         count++;
>                 if (idx >= window)
>                         idx = 0;
> -       } while (i < list_size);
> +       }
>
>         for (i = 0; i < window; ++i) {
>                 free_delta_index(array[i].index);
> @@ -1591,6 +1598,7 @@ struct thread_params {
>         pthread_t thread;
>         struct object_entry **list;
>         unsigned list_size;
> +       unsigned remaining;
>         int window;
>         int depth;
>         unsigned *processed;
> @@ -1612,10 +1620,10 @@ static void *threaded_find_deltas(void *arg)
>                 pthread_mutex_lock(&data_ready);
>                 pthread_mutex_unlock(&data_request);
>
> -               if (!me->list_size)
> +               if (!me->remaining)
>                         return NULL;
>
> -               find_deltas(me->list, me->list_size,
> +               find_deltas(me->list, &me->remaining,
>                             me->window, me->depth, me->processed);
>         }
>  }
> @@ -1624,57 +1632,102 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
>                            int window, int depth, unsigned *processed)
>  {
>         struct thread_params *target, p[delta_search_threads];
> -       int i, ret;
> -       unsigned chunk_size;
> +       int i, ret, active_threads = 0;
>
>         if (delta_search_threads <= 1) {
> -               find_deltas(list, list_size, window, depth, processed);
> +               find_deltas(list, &list_size, window, depth, processed);
>                 return;
>         }
>
>         pthread_mutex_lock(&data_provider);
>         pthread_mutex_lock(&data_ready);
>
> +       /* Start work threads. */
>         for (i = 0; i < delta_search_threads; i++) {
>                 p[i].window = window;
>                 p[i].depth = depth;
>                 p[i].processed = processed;
> +               p[i].remaining = 0;
>                 ret = pthread_create(&p[i].thread, NULL,
>                                      threaded_find_deltas, &p[i]);
>                 if (ret)
>                         die("unable to create thread: %s", strerror(ret));
> +               active_threads++;
>         }
>
> -       /* this should be auto-tuned somehow */
> -       chunk_size = window * 1000;
> +       /* Then partition the work amongst them. */
> +       for (i = 0; i < delta_search_threads; i++) {
> +               unsigned sub_size = list_size / (delta_search_threads - i);
>
> -       do {
> -               unsigned sublist_size = chunk_size;
> -               if (sublist_size > list_size)
> -                       sublist_size = list_size;
> +               pthread_mutex_lock(&data_provider);
> +               target = data_requester;
> +               if (!sub_size) {
> +                       pthread_mutex_unlock(&data_ready);
> +                       pthread_join(target->thread, NULL);
> +                       active_threads--;
> +                       continue;
> +               }
>
>                 /* try to split chunks on "path" boundaries */
> -               while (sublist_size < list_size && list[sublist_size]->hash &&
> -                      list[sublist_size]->hash == list[sublist_size-1]->hash)
> -                       sublist_size++;
> +               while (sub_size < list_size && list[sub_size]->hash &&
> +                      list[sub_size]->hash == list[sub_size-1]->hash)
> +                       sub_size++;
> +
> +               target->list = list;
> +               target->list_size = sub_size;
> +               target->remaining = sub_size;
> +               pthread_mutex_unlock(&data_ready);
>
> +               list += sub_size;
> +               list_size -= sub_size;
> +       }
> +
> +       /*
> +        * Now let's wait for work completion.  Each time a thread is done
> +        * with its work, we steal half of the remaining work from the
> +        * thread with the largest number of unprocessed objects and give
> +        * it to that newly idle thread.  This ensure good load balancing
> +        * until the remaining object list segments are simply too short
> +        * to be worth splitting anymore.
> +        */
> +       do {
> +               struct thread_params *victim = NULL;
> +               unsigned sub_size = 0;
>                 pthread_mutex_lock(&data_provider);
>                 target = data_requester;
> -               target->list = list;
> -               target->list_size = sublist_size;
> +
> +               progress_lock();
> +               for (i = 0; i < delta_search_threads; i++)
> +                       if (p[i].remaining > 2*window &&
> +                           (!victim || victim->remaining < p[i].remaining))
> +                               victim = &p[i];
> +               if (victim) {
> +                       sub_size = victim->remaining / 2;
> +                       list = victim->list + victim->list_size - sub_size;
> +                       while (sub_size && list[0]->hash &&
> +                              list[0]->hash == list[-1]->hash) {
> +                               list++;

I think you needed to copy sub_size to another variable for this loop

> +                               sub_size--;
> +                       }
> +                       target->list = list;
> +                       victim->list_size -= sub_size;
> +                       victim->remaining -= sub_size;
> +               }
> +               progress_unlock();
> +
> +               target->list_size = sub_size;
> +               target->remaining = sub_size;
>                 pthread_mutex_unlock(&data_ready);
>
> -               list += sublist_size;
> -               list_size -= sublist_size;
> -               if (!sublist_size) {
> +               if (!sub_size) {
>                         pthread_join(target->thread, NULL);
> -                       i--;
> +                       active_threads--;
>                 }
> -       } while (i);
> +       } while (active_threads);
>  }
>
>  #else
> -#define ll_find_deltas find_deltas
> +#define ll_find_deltas(l, s, w, d, p)  find_deltas(l, &s, w, d, p)
>  #endif
>
>  static void prepare_pack(int window, int depth)
> --
> 1.5.3.7.2184.ge321d-dirty
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
