From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Fri, 21 Aug 2015 16:40:09 -0700
Message-ID: <CAGZ79kbhRQ0SmSu6xiij6Gxdrtfh02knexz6+CNjihY4xbC83w@mail.gmail.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
	<1440121237-24576-2-git-send-email-sbeller@google.com>
	<xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
	<20150821194454.GB26466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 22 01:40:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSvvU-0004KY-3I
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 01:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbbHUXkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 19:40:35 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34289 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbbHUXkK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 19:40:10 -0400
Received: by ykdt205 with SMTP id t205so86412609ykd.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 16:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UzE39B3wiE59CnB1HtUjctPUfdhudSDamINgSQ6/3wQ=;
        b=NCs1nPgFDBlEc2k+FRGusFEeH5lfxMPhoo1cWoN1o+4qK+aXuPdTdm6SeGsgB/K1RB
         TDaGLRIp2aNNbexjBlrAGABrUJN+ZEdp0M9gdnBocPLGBe/mhzrTQObn324TmIIaRe3j
         fLr+8Z+ILq5eb/4+e+5xTXlOvYh8WOj60NXw0YvWvfbOmTco9lGzH7W3lng3FIliUPZ8
         J1fgVJdv53rUjCcAwW7BmPXXPCBxfUwuXv5DongGlpgfxXy7dW2YHTsRHK8L4JgARrq5
         0BTI+iDq45AhJep/LkNOnLgR8J05orKYcdSqJGpu3L8iZAAGIQTdztMmW8jZRcmiTTFY
         m//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UzE39B3wiE59CnB1HtUjctPUfdhudSDamINgSQ6/3wQ=;
        b=aMGLaIcsRiUXtJ819G2MvNI/noKCT9rF9jkZEmEEp9PDL6It2vRAXJInVWrld+0zTB
         IqLthCWPuL4L0mxrSgM1zr+qq1/EwigMuZ2T/GIE0H4KGdUJKY4WE2G6LYu04jE7LZE5
         yYsWWEqC0DavvUExuAG6mMaoVVp8zfVVqzLJcv95b8qpHJmGToy6K7SgXrgmbQcocdat
         MDYtMn2Oitwg7xM500CIU1W3UEuWFq8U8lCJZFBUDFZc89++63dHcwaFzWRA3Gxl25yB
         ynTVs1nYBwe3rgrGQkYQEVf1pW2KB/OTdRwgbZybSYtWxxEok2u/jR7vC01cEOcAQ1li
         Eikg==
X-Gm-Message-State: ALoCoQnPJ/wKQpFMase81z2YEYkR0z7IHISMXRQ4Bq3AnvE1YSW60e3DGM6ZS1Dcqh2AXJcVUY56
X-Received: by 10.170.135.138 with SMTP id b132mr14977468ykc.16.1440200409862;
 Fri, 21 Aug 2015 16:40:09 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 21 Aug 2015 16:40:09 -0700 (PDT)
In-Reply-To: <20150821194454.GB26466@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276342>

On Fri, Aug 21, 2015 at 12:44 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 21, 2015 at 12:05:13PM -0700, Junio C Hamano wrote:
>
>> The primary reason I suspect is because you sent to a wrong set of
>> people.  Submodule folks have largely been working in the scripted
>> ones, and may not necessarily be the ones who are most familiar with
>> the run-command infrastructure.
>>
>> "shortlog --no-merges" tells me that the obvious suspects are j6t
>> and peff.
>
> No good deed goes unpunished. ;)
>
> Before even looking at the implementation, my first question would be
> whether this pattern is applicable in several places in git (i.e., is it
> worth the extra complexity of abstracting out in the first place). I
> think there are a few task-queue patterns already in git; for example
> the delta search in pack-objects. Is the interface given here sufficient
> to convert pack-objects? Is the result nicer to read? Is it as
> efficient?

I have converted index-pack threading now, and it looks quite easy:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3f10840..159ee36 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,6 +11,7 @@
 #include "exec_cmd.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "run-command.h"

 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>]
[--verify] [--strict] (<pack-file> | --stdin [--fix-thin]
[<pack-file>])";
@@ -1075,7 +1076,7 @@ static void resolve_base(struct object_entry *obj)
 }

 #ifndef NO_PTHREADS
-static void *threaded_second_pass(void *data)
+static int threaded_second_pass(struct task_queue *tq, void *data)
 {
        set_thread_data(data);
        for (;;) {
@@ -1096,7 +1097,7 @@ static void *threaded_second_pass(void *data)

                resolve_base(&objects[i]);
        }
-       return NULL;
+       return 0;
 }
 #endif

@@ -1195,18 +1196,18 @@ static void resolve_deltas(void)
                                          nr_ref_deltas + nr_ofs_deltas);

 #ifndef NO_PTHREADS
-       nr_dispatched = 0;
        if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
+               nr_dispatched = 0;
                init_thread();
-               for (i = 0; i < nr_threads; i++) {
-                       int ret = pthread_create(&thread_data[i].thread, NULL,
-                                                threaded_second_pass,
thread_data + i);
-                       if (ret)
-                               die(_("unable to create thread: %s"),
-                                   strerror(ret));
-               }
+
+               tq = create_task_queue(nr_threads);
+
                for (i = 0; i < nr_threads; i++)
-                       pthread_join(thread_data[i].thread, NULL);
+                       add_task(tq, threaded_second_pass, thread_data + i);
+
+               if (finish_task_queue(tq))
+                       die("Not all threads have finished");
+
                cleanup_thread();
                return;
        }
---
(tests pass)
This was cheating as I picked to convert index-pack as opposed to upload-pack
(index-pack is very similar to a queued workload. This was just moving
the thread
creation into the new proposed queue processor.)

I realize now this can be adapted a bit more, to show off the queue features
but would require a larger rewrite. So instead of just creating the threads and
then locking, we get rid of the worker lock like this:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3f10840..797efea 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,6 +11,7 @@
 #include "exec_cmd.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "run-command.h"

 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>]
[--verify] [--strict] (<pack-file> | --stdin [--fix-thin]
[<pack-file>])";
@@ -106,10 +107,6 @@ static pthread_mutex_t counter_mutex;
 #define counter_lock() lock_mutex(&counter_mutex)
 #define counter_unlock() unlock_mutex(&counter_mutex)

-static pthread_mutex_t work_mutex;
-#define work_lock() lock_mutex(&work_mutex)
-#define work_unlock() unlock_mutex(&work_mutex)
-
 static pthread_mutex_t deepest_delta_mutex;
 #define deepest_delta_lock() lock_mutex(&deepest_delta_mutex)
 #define deepest_delta_unlock() unlock_mutex(&deepest_delta_mutex)
@@ -140,7 +137,6 @@ static void init_thread(void)
  int i;
  init_recursive_mutex(&read_mutex);
  pthread_mutex_init(&counter_mutex, NULL);
- pthread_mutex_init(&work_mutex, NULL);
  pthread_mutex_init(&type_cas_mutex, NULL);
  if (show_stat)
  pthread_mutex_init(&deepest_delta_mutex, NULL);
@@ -163,7 +159,6 @@ static void cleanup_thread(void)
  threads_active = 0;
  pthread_mutex_destroy(&read_mutex);
  pthread_mutex_destroy(&counter_mutex);
- pthread_mutex_destroy(&work_mutex);
  pthread_mutex_destroy(&type_cas_mutex);
  if (show_stat)
  pthread_mutex_destroy(&deepest_delta_mutex);
@@ -181,9 +176,6 @@ static void cleanup_thread(void)
 #define counter_lock()
 #define counter_unlock()

-#define work_lock()
-#define work_unlock()
-
 #define deepest_delta_lock()
 #define deepest_delta_unlock()

@@ -1075,28 +1067,24 @@ static void resolve_base(struct object_entry *obj)
 }

 #ifndef NO_PTHREADS
-static void *threaded_second_pass(void *data)
+static int threaded_second_pass(struct task_queue *tq, void *data)
 {
- set_thread_data(data);
- for (;;) {
- int i;
- counter_lock();
- display_progress(progress, nr_resolved_deltas);
- counter_unlock();
- work_lock();
- while (nr_dispatched < nr_objects &&
-       is_delta_type(objects[nr_dispatched].type))
- nr_dispatched++;
- if (nr_dispatched >= nr_objects) {
- work_unlock();
- break;
- }
- i = nr_dispatched++;
- work_unlock();
+ if (!get_thread_data()) {
+ struct thread_local *t = xmalloc(sizeof(*t));
+ t->pack_fd = open(curr_pack, O_RDONLY);
+ if (t->pack_fd == -1)
+ die_errno(_("unable to open %s"), curr_pack);

- resolve_base(&objects[i]);
+ set_thread_data(t);
+ /* TODO: I haven't figured out where to free this memory */
  }
- return NULL;
+
+ resolve_base(data);
+
+ counter_lock();
+ display_progress(progress, nr_resolved_deltas);
+ counter_unlock();
+ return 0;
 }
 #endif

@@ -1195,18 +1183,21 @@ static void resolve_deltas(void)
   nr_ref_deltas + nr_ofs_deltas);

 #ifndef NO_PTHREADS
- nr_dispatched = 0;
  if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
+ struct task_queue *tq;
+
  init_thread();
- for (i = 0; i < nr_threads; i++) {
- int ret = pthread_create(&thread_data[i].thread, NULL,
- threaded_second_pass, thread_data + i);
- if (ret)
- die(_("unable to create thread: %s"),
-    strerror(ret));
- }
- for (i = 0; i < nr_threads; i++)
- pthread_join(thread_data[i].thread, NULL);
+ tq = create_task_queue(nr_threads);
+
+ for (nr_dispatched = 0; nr_dispatched < nr_objects; nr_dispatched++)
+ if (!is_delta_type(objects[nr_dispatched].type))
+ add_task(tq, threaded_second_pass, &objects[nr_dispatched]);
+
+ if (finish_task_queue(tq))
+ die("Not all threads have finished");
+
+ /* Here might be a good place to free the thread local storage caches */
+
  cleanup_thread();
  return;
  }
----

This looks very pleasant to me as we have no lock contention all the time,
with the worker lock, but the main thread can load the work queue easily
while we directly start processing in the worker threads.
This also reduces the lines of code which usually is a good sign.

However there is a memory leak in this second solution.

How do you think these two approaches look like?

(I cannot really say objectively if it's easier to read, as I wrote the code,
so of course it is easy for me)

Why did I not pick upload-pack?
========================

I could not spot easily how to make it a typical queuing problem.
We start in the threads, and once in a while we're like: "Uhg, this
thread has more load than the other, let's shove a bit over there"

So what we would need there is splitting the work in smallest chunks
from the beginning and just load it into the queue via add_task



>
> We do not need to convert all possible call-sites to the new abstracted
> code at once. But I find that converting at least _one_ is a good litmus
> test to confirm that a new interface is generally useful.
>
> -Peff
