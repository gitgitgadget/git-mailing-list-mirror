From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Fri, 21 Aug 2015 12:45:28 -0700
Message-ID: <CAGZ79kZrcPAAt+miHDGQp=052S-q=JaKvvLgKHaPG+G6cDjBtg@mail.gmail.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
	<1440121237-24576-2-git-send-email-sbeller@google.com>
	<xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 21:45:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSsFp-0006Ma-R8
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 21:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbbHUTp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 15:45:29 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36411 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbHUTp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 15:45:28 -0400
Received: by ykfw73 with SMTP id w73so81010602ykf.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pSKXc0LJslpX6E4OWxuolc0jz1E4A4UylYJErGMuhI0=;
        b=FeH3jXGob9Ypqjx1r/bNDgKCJRECMfU1qVjgi0PN5r3luPxyqln4vzVJIbe7xXcdpr
         EhE7PpVxUbWPT0/w8pK09QpgCJYihf6Oo1XfHDTAtgNkfkueMNCVX2polfanqyNlCCkV
         qNq9z9dZZ28YkYE5gRcNGHMBbQjpvX4YuKryU8xGnQGfVqWxVNo35zpKQptCZ6HHB54m
         YdGD774vHkj/Ljw/0i9TEtaB3Pi8ongkSMk5uruCvaxci6beuCAbO2NLQXHCAL1cswE8
         ovIna34d3KmhANgv2jfmMz493/QqBNcw637UlXDpgbAqFzBt98Uk4EF3UG5wU2bQ47mZ
         Hshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pSKXc0LJslpX6E4OWxuolc0jz1E4A4UylYJErGMuhI0=;
        b=hSKvuyILbfMLAmmBVnui85PGy2rSQVzeDENgoyy8ncnkBsmjL5YbERoe4ByFJbrvef
         clJ5NGQocprsOrjAugCkeBHIVq6KxIel5O8ee0BTbdbNLhx6jTvFJg9//R+w7x/nsnw1
         E4cW9YHQ/BDo4cdmNhbj/e89j41Cr6ssd9Zv7Rn/ByGPgg91lyxYy+DRASLf7Oc0dsgF
         /qPxOG2ziH2BFUm5RmkxDonTiOtfJx3/nTBKZPgrLmy8yIT9rSyNm/jjQvkJ7zlntyfU
         WMZKAAxX6i39TEKIXCb5i6PUkbiHksMefy+yYiZ+o6ZZuMaAxeWxLT8o1FQNDQIFGEcd
         Jn3A==
X-Gm-Message-State: ALoCoQlIa26XPdz1laYuaCw/XJCLqO06SrZngpE4kowBI1n5EkM4SfOVU8bLi7NDVJo4qphvpXMK
X-Received: by 10.170.205.151 with SMTP id w145mr14123176yke.56.1440186328091;
 Fri, 21 Aug 2015 12:45:28 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 21 Aug 2015 12:45:28 -0700 (PDT)
In-Reply-To: <xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276324>

On Fri, Aug 21, 2015 at 12:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This adds functionality to do work in parallel.
>>
>> The whole life cycle of such a thread pool would look like
>>
>>     struct task_queue * tq = create_task_queue(32); // no of threads
>>     for (...)
>>         add_task(tq, process_one_item_function, item); // non blocking
>>     ...
>>     int ret = finish_task_queue(tq); // blocks until all tasks are done
>>     if (!tq)
>>         die ("Not all items were be processed");
>>
>> The caller must take care of handling the output.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> I sent this a while ago to the list, no comments on it :(
>
> The primary reason I suspect is because you sent to a wrong set of
> people.  Submodule folks have largely been working in the scripted
> ones, and may not necessarily be the ones who are most familiar with
> the run-command infrastructure.
>
> "shortlog --no-merges" tells me that the obvious suspects are j6t
> and peff.

noted.

>
>> The core functionality stayed the same, but I hope to improved naming and
>> location of the code.
>>
>> The WIP is only for the NO_PTHREADS case.
>
>>  run-command.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>>  run-command.h |  30 +++++++++
>>  2 files changed, 230 insertions(+), 12 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index 28e1d55..4029011 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -4,6 +4,21 @@
>>  #include "sigchain.h"
>>  #include "argv-array.h"
>>
>> +#ifdef NO_PTHREADS
>> +
>> +#else
>> +
>> +#include "thread-utils.h"
>> +
>> +#include <pthread.h>
>> +#include <semaphore.h>
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +
>> +#endif
>> +
>> +#include "git-compat-util.h"
>> +
>
> This goes against the way we have been organizing the header files.
>
> http://thread.gmane.org/gmane.comp.version-control.git/276241/focus=276265

ok
>
>> @@ -668,6 +683,22 @@ int git_atexit(void (*handler)(void))
>>
>>  #endif
>>
>> +void setup_main_thread()
>
> void setup_main_thread(void)
>
>> @@ -852,3 +872,171 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
>>       close(cmd->out);
>>       return finish_command(cmd);
>>  }
>> +
>> +#ifndef NO_PTHREADS
>> +struct job_list {
>> +     int (*fct)(struct task_queue *aq, void *task);
>> +     void *task;
>> +     struct job_list *next;
>> +};
>> +#endif
>> +
>> +struct task_queue {
>> +#ifndef NO_PTHREADS
>> +     /*
>> +      * To avoid deadlocks always aquire the semaphores with lowest priority
>
> acquire.
>
>> +      * first, priorites are in descending order as listed.
>> +      *
>> +      * The `mutex` is a general purpose lock for modifying data in the async
>> +      * queue, such as adding a new task or adding a return value from
>> +      * an already run task.
>> +      *
>> +      * `workingcount` and `freecount` are opposing semaphores, the sum of
>> +      * their values should equal `max_threads` at any time while the `mutex`
>> +      * is available.
>> +      */
>> +     sem_t mutex;
>> +     sem_t workingcount;
>> +     sem_t freecount;
>> +
>> +     pthread_t *threads;
>> +     unsigned max_threads;
>> +
>> +     struct job_list *first;
>> +     struct job_list *last;
>> +#endif
>> +     int early_return;
>> +};
>> +
>> +#ifndef NO_PTHREADS
>> +
>> +static void get_task(struct task_queue *aq,
>> +                  int (**fct)(struct task_queue *aq, void *task),
>> +                  void **task,
>> +                  int *early_return)
>> +{
>> +     struct job_list *job;
>> +
>> +     sem_wait(&aq->workingcount);
>> +     sem_wait(&aq->mutex);
>> +
>> +     if (!aq->first)
>> +             die("BUG: internal error with dequeuing jobs for threads");
>> +     job = aq->first;
>> +     *fct = job->fct;
>> +     *task = job->task;
>> +     aq->early_return |= *early_return;
>> +     *early_return = aq->early_return;
>> +     aq->first = job->next;
>> +     if (!aq->first)
>> +             aq->last = NULL;
>> +
>> +     sem_post(&aq->freecount);
>> +     sem_post(&aq->mutex);
>> +
>> +     free(job);
>> +}
>> +
>> +static void* dispatcher(void *args)
>
> static void *dispatcher(....)
>
>> +{
>> +     void *task;
>> +     int (*fct)(struct task_queue *aq, void *data);
>
> s/data/task/?
>
>> +     int early_return = 0;
>> +     struct task_queue *aq = args;
>> +
>> +     get_task(aq, &fct, &task, &early_return);
>> +     while (fct || early_return != 0) {
>> +             early_return = fct(aq, task);
>> +             get_task(aq, &fct, &task, &early_return);
>> +     }
>
> If the func said "we are done, you may stop dispatching now", do you
> still want to do another get_task()?

This question shows me I messed up readability of this. `get_task` both gets
a new task as well as taking the value from early_return writing it to
aq->early_return,
such that other threads are notified.

Maybe I should do that explicitely here and not get the new task.

>
>> +     pthread_exit(0);
>> +}
>> +#endif
>> +
>> +struct task_queue *create_task_queue(unsigned max_threads)
>> +{
>> +     struct task_queue *aq = xmalloc(sizeof(*aq));
>> +
>> +#ifndef NO_PTHREADS
>> +     int i;
>> +     if (!max_threads)
>> +             aq->max_threads = online_cpus();
>> +     else
>> +             aq->max_threads = max_threads;
>> +
>> +     sem_init(&aq->mutex, 0, 1);
>> +     sem_init(&aq->workingcount, 0, 0);
>> +     sem_init(&aq->freecount, 0, aq->max_threads);
>> +     aq->threads = xmalloc(aq->max_threads * sizeof(pthread_t));
>> +
>> +     for (i = 0; i < aq->max_threads; i++)
>> +             pthread_create(&aq->threads[i], 0, &dispatcher, aq);
>> +
>> +     aq->first = NULL;
>> +     aq->last = NULL;
>
>
> Shouldn't these be initialized before letting threads call into
> dispatcher?  The workingcount semaphore that is initialized to 0 may
> prevent them from peeking into these pointers and barfing, but still...

They are initialized to NULL as the empty queue doesn't need a
container element.
Do we do queues in another way usually?

>
>> +
>> +     setup_main_thread();
>> +#endif
>> +     aq->early_return = 0;
>> +
>> +     return aq;
>> +}
