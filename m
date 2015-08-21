From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Fri, 21 Aug 2015 12:05:13 -0700
Message-ID: <xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
	<1440121237-24576-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	hvoigt@hvoigt.net, jens.lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 21:05:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSrcz-00069f-1p
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 21:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbbHUTFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 15:05:17 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33107 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbbHUTFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 15:05:16 -0400
Received: by pacgr6 with SMTP id gr6so89596pac.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gS32IpVK8M2T80znFRAmDK6J5sYJJa4sX0SnonmG2Rw=;
        b=eTSCFrX7idcVrg1+mj5n8nB5atmKv490GVy2fWkPwzIyVKAkAtDXWpMupPYyvrETHK
         9vuucLWFhT9BgPv1KfNKrwhu3Fea05vUtbv3nQCBHUudJ5vT6w+d8ZnTpTpBMULLN5jq
         0YqnccJmj+Fj/Lg3wI0dXg6vOWfvhWD4FTET4k3jCaB9U0widu4RJ9m++JJWtCmZi2/N
         LUChH5/z0RAyimZC/vxrVfkZkqi3jSVxAuv6nl3nTn5ESuFdr3nZT92OkK77wgBV3X2u
         8d8hAItZ/zENQ7M7ZTTrnyeSdmITpMgUjKhnCq6Ib5sVGcFfxLlyac7sJ33090bGb9XA
         vWsg==
X-Received: by 10.66.119.235 with SMTP id kx11mr19574703pab.58.1440183915596;
        Fri, 21 Aug 2015 12:05:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id em1sm8636872pbd.42.2015.08.21.12.05.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 12:05:14 -0700 (PDT)
In-Reply-To: <1440121237-24576-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 20 Aug 2015 18:40:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276320>

Stefan Beller <sbeller@google.com> writes:

> This adds functionality to do work in parallel.
>
> The whole life cycle of such a thread pool would look like
>
>     struct task_queue * tq = create_task_queue(32); // no of threads
>     for (...)
>         add_task(tq, process_one_item_function, item); // non blocking
>     ...
>     int ret = finish_task_queue(tq); // blocks until all tasks are done
>     if (!tq)
>         die ("Not all items were be processed");
>
> The caller must take care of handling the output.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> I sent this a while ago to the list, no comments on it :(

The primary reason I suspect is because you sent to a wrong set of
people.  Submodule folks have largely been working in the scripted
ones, and may not necessarily be the ones who are most familiar with
the run-command infrastructure.

"shortlog --no-merges" tells me that the obvious suspects are j6t
and peff.

> The core functionality stayed the same, but I hope to improved naming and
> location of the code.
>
> The WIP is only for the NO_PTHREADS case.

>  run-command.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  run-command.h |  30 +++++++++
>  2 files changed, 230 insertions(+), 12 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 28e1d55..4029011 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -4,6 +4,21 @@
>  #include "sigchain.h"
>  #include "argv-array.h"
>  
> +#ifdef NO_PTHREADS
> +
> +#else
> +
> +#include "thread-utils.h"
> +
> +#include <pthread.h>
> +#include <semaphore.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +#endif
> +
> +#include "git-compat-util.h"
> +

This goes against the way we have been organizing the header files.

http://thread.gmane.org/gmane.comp.version-control.git/276241/focus=276265

> @@ -668,6 +683,22 @@ int git_atexit(void (*handler)(void))
>  
>  #endif
>  
> +void setup_main_thread()

void setup_main_thread(void)

> @@ -852,3 +872,171 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
>  	close(cmd->out);
>  	return finish_command(cmd);
>  }
> +
> +#ifndef NO_PTHREADS
> +struct job_list {
> +	int (*fct)(struct task_queue *aq, void *task);
> +	void *task;
> +	struct job_list *next;
> +};
> +#endif
> +
> +struct task_queue {
> +#ifndef NO_PTHREADS
> +	/*
> +	 * To avoid deadlocks always aquire the semaphores with lowest priority

acquire.

> +	 * first, priorites are in descending order as listed.
> +	 *
> +	 * The `mutex` is a general purpose lock for modifying data in the async
> +	 * queue, such as adding a new task or adding a return value from
> +	 * an already run task.
> +	 *
> +	 * `workingcount` and `freecount` are opposing semaphores, the sum of
> +	 * their values should equal `max_threads` at any time while the `mutex`
> +	 * is available.
> +	 */
> +	sem_t mutex;
> +	sem_t workingcount;
> +	sem_t freecount;
> +
> +	pthread_t *threads;
> +	unsigned max_threads;
> +
> +	struct job_list *first;
> +	struct job_list *last;
> +#endif
> +	int early_return;
> +};
> +
> +#ifndef NO_PTHREADS
> +
> +static void get_task(struct task_queue *aq,
> +		     int (**fct)(struct task_queue *aq, void *task),
> +		     void **task,
> +		     int *early_return)
> +{
> +	struct job_list *job;
> +
> +	sem_wait(&aq->workingcount);
> +	sem_wait(&aq->mutex);
> +
> +	if (!aq->first)
> +		die("BUG: internal error with dequeuing jobs for threads");
> +	job = aq->first;
> +	*fct = job->fct;
> +	*task = job->task;
> +	aq->early_return |= *early_return;
> +	*early_return = aq->early_return;
> +	aq->first = job->next;
> +	if (!aq->first)
> +		aq->last = NULL;
> +
> +	sem_post(&aq->freecount);
> +	sem_post(&aq->mutex);
> +
> +	free(job);
> +}
> +
> +static void* dispatcher(void *args)

static void *dispatcher(....)

> +{
> +	void *task;
> +	int (*fct)(struct task_queue *aq, void *data);

s/data/task/?

> +	int early_return = 0;
> +	struct task_queue *aq = args;
> +
> +	get_task(aq, &fct, &task, &early_return);
> +	while (fct || early_return != 0) {
> +		early_return = fct(aq, task);
> +		get_task(aq, &fct, &task, &early_return);
> +	}

If the func said "we are done, you may stop dispatching now", do you
still want to do another get_task()?

> +	pthread_exit(0);
> +}
> +#endif
> +
> +struct task_queue *create_task_queue(unsigned max_threads)
> +{
> +	struct task_queue *aq = xmalloc(sizeof(*aq));
> +
> +#ifndef NO_PTHREADS
> +	int i;
> +	if (!max_threads)
> +		aq->max_threads = online_cpus();
> +	else
> +		aq->max_threads = max_threads;
> +
> +	sem_init(&aq->mutex, 0, 1);
> +	sem_init(&aq->workingcount, 0, 0);
> +	sem_init(&aq->freecount, 0, aq->max_threads);
> +	aq->threads = xmalloc(aq->max_threads * sizeof(pthread_t));
> +
> +	for (i = 0; i < aq->max_threads; i++)
> +		pthread_create(&aq->threads[i], 0, &dispatcher, aq);
> +
> +	aq->first = NULL;
> +	aq->last = NULL;


Shouldn't these be initialized before letting threads call into
dispatcher?  The workingcount semaphore that is initialized to 0 may
prevent them from peeking into these pointers and barfing, but still...

> +
> +	setup_main_thread();
> +#endif
> +	aq->early_return = 0;
> +
> +	return aq;
> +}
