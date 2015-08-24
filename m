From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Mon, 24 Aug 2015 14:22:33 -0700
Message-ID: <xmqqvbc42xgm.fsf@gitster.dls.corp.google.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
	<1440121237-24576-2-git-send-email-sbeller@google.com>
	<xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
	<20150821194454.GB26466@sigill.intra.peff.net>
	<CAGZ79kbhRQ0SmSu6xiij6Gxdrtfh02knexz6+CNjihY4xbC83w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 23:22:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTzCT-0000IU-C2
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 23:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbbHXVWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 17:22:36 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33724 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbbHXVWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 17:22:35 -0400
Received: by pacti10 with SMTP id ti10so32471944pac.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hj5tGNqCjk20b8IIiwSzyejHScrjo52kSgomHXLnUmc=;
        b=lYQT/44Bf7ewV3/5CyEqFg7wfA8Oo/9hNSdnCcWRrs6HhC4E1yLSFfgoalwvzDDK+v
         T5j5XBog50rVidhptgfIdswkqpKV9sFAROhWmEMWn9Ce73SFYmaIomjTecmWhLeO/1p0
         /fO8i3v+W7BtmikRFI11mx9iSCvFY6U6P+q5aJY2l81HcWFYjJWtkt47MUl9jRlp49oa
         XORZsQ3SI1VDDg0rUhH2iEUv5axsEwNblNMbwinrsD5m2/4Fxt1slVIIj4ytUnoYFStk
         k1Dn2Aosoc2Rb7WlhmvqTJStLn3CZoKT4N4fwLJKinMw4Ipsszl6VoU+WEkdq2yaj94Z
         KE/g==
X-Received: by 10.66.191.196 with SMTP id ha4mr49353293pac.119.1440451355061;
        Mon, 24 Aug 2015 14:22:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id vv2sm15543045pab.21.2015.08.24.14.22.34
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 14:22:34 -0700 (PDT)
In-Reply-To: <CAGZ79kbhRQ0SmSu6xiij6Gxdrtfh02knexz6+CNjihY4xbC83w@mail.gmail.com>
	(Stefan Beller's message of "Fri, 21 Aug 2015 16:40:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276487>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 3f10840..159ee36 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -11,6 +11,7 @@
>  #include "exec_cmd.h"
>  #include "streaming.h"
>  #include "thread-utils.h"
> +#include "run-command.h"
>
>  static const char index_pack_usage[] =
>  "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>]
> [--verify] [--strict] (<pack-file> | --stdin [--fix-thin]
> [<pack-file>])";
> @@ -1075,7 +1076,7 @@ static void resolve_base(struct object_entry *obj)
>  }
>
>  #ifndef NO_PTHREADS
> -static void *threaded_second_pass(void *data)
> +static int threaded_second_pass(struct task_queue *tq, void *data)
>  {
>         set_thread_data(data);
>         for (;;) {
> @@ -1096,7 +1097,7 @@ static void *threaded_second_pass(void *data)
>
>                 resolve_base(&objects[i]);
>         }
> -       return NULL;
> +       return 0;
>  }
>  #endif
>
> @@ -1195,18 +1196,18 @@ static void resolve_deltas(void)
>                                           nr_ref_deltas + nr_ofs_deltas);
>
>  #ifndef NO_PTHREADS
> -       nr_dispatched = 0;
>         if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
> +               nr_dispatched = 0;
>                 init_thread();
> -               for (i = 0; i < nr_threads; i++) {
> -                       int ret = pthread_create(&thread_data[i].thread, NULL,
> -                                                threaded_second_pass,
> thread_data + i);
> -                       if (ret)
> -                               die(_("unable to create thread: %s"),
> -                                   strerror(ret));
> -               }
> +
> +               tq = create_task_queue(nr_threads);
> +
>                 for (i = 0; i < nr_threads; i++)
> -                       pthread_join(thread_data[i].thread, NULL);
> +                       add_task(tq, threaded_second_pass, thread_data + i);
> +
> +               if (finish_task_queue(tq))
> +                       die("Not all threads have finished");
> +
>                 cleanup_thread();
>                 return;
>         }

This looks quite straight-forward, but that is not too surprising,
as the "dispatcher" side naturally should have a similar logic to
manage threads by creating and joining them ;-)

> @@ -1075,28 +1067,24 @@ static void resolve_base(struct object_entry *obj)
>  }
>
>  #ifndef NO_PTHREADS
> -static void *threaded_second_pass(void *data)
> +static int threaded_second_pass(struct task_queue *tq, void *data)
>  {
> - set_thread_data(data);
> - for (;;) {
> - int i;
> - counter_lock();
> - display_progress(progress, nr_resolved_deltas);
> - counter_unlock();
> - work_lock();
> - while (nr_dispatched < nr_objects &&
> -       is_delta_type(objects[nr_dispatched].type))
> - nr_dispatched++;
> - if (nr_dispatched >= nr_objects) {
> - work_unlock();
> - break;
> - }
> - i = nr_dispatched++;
> - work_unlock();
> + if (!get_thread_data()) {
> + struct thread_local *t = xmalloc(sizeof(*t));
> + t->pack_fd = open(curr_pack, O_RDONLY);
> + if (t->pack_fd == -1)
> + die_errno(_("unable to open %s"), curr_pack);
>
> - resolve_base(&objects[i]);
> + set_thread_data(t);
> + /* TODO: I haven't figured out where to free this memory */

Sorry but it is hard to grok what is going on in the code with
squished indentation.

> Why did I not pick upload-pack?
> ========================
>
> I could not spot easily how to make it a typical queuing problem.
> We start in the threads, and once in a while we're like: "Uhg, this
> thread has more load than the other, let's shove a bit over there"
>
> So what we would need there is splitting the work in smallest chunks
> from the beginning and just load it into the queue via add_task

... or a way for the overload and tasks to communicate with each
other and rebalance.  If I am not mistaken, it has a big negative
consequence for pack-objects to split the work to too small a chunk,
as the chunk boundary also becomes boundary of find delta bases.
