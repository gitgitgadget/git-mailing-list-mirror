From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/5] submodule: helper to run foreach in parallel
Date: Tue, 25 Aug 2015 14:42:25 -0700
Message-ID: <CAGZ79kb2N_5_tJv-GURL9_ESFs=pHp=L-Mujn3Df_+-T74_9Dg@mail.gmail.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
	<1440523706-23041-4-git-send-email-sbeller@google.com>
	<xmqq7fojxeh3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 23:42:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZULzD-00074d-9G
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 23:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbbHYVm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 17:42:27 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35476 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbbHYVm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 17:42:26 -0400
Received: by qkbm65 with SMTP id m65so108583266qkb.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CtdY/iPZFOeNc2Sm+dnS741swGf4O5HOOiLO2lPWnIM=;
        b=l8+Hnw47oeNYuRpNFf7QlwMGgRCqJb/dmA9y8SlOxocTOgyFvqyhMLituMu0cgM+oT
         JAStmUBMdMVt6+Car0qnnCPw32qzZqfy5sjsZ0IZCMRHCToZkQ6jMgKFB5it6Ur4egln
         HT64H6lCwUOtCgnUzbhXLC+ARCIXkGAtit6e6WP5z3zCcXKLDxCvWl4B4jd9mzqFzX/q
         x9dves9DwwnCAl2YEaDIWe5Bz8NM18wtqroyyH/YECLrnzDmU/XfLHfKvaZi5M0dV0gO
         gJkwGxG0YtaX9YG7nermBVToezgq1OqFsbZhajOiHNQwKijZgZnCo/6m4Kdfsj26KF6n
         JGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CtdY/iPZFOeNc2Sm+dnS741swGf4O5HOOiLO2lPWnIM=;
        b=JkSVkeS2EqbULxz+GE/A8tEPsUrIV4iQIPwe/vxPUbyLxjHDc4CTFTKQRDOSOkpiOp
         zRRMv7pt5vld3o/qxWWCy03SVJlz6VeitKPMXHqchCk3/5Ufeg+C+F6LMuHu6uEW2Jd5
         7bvN2yYELCTJGIKCYMZsTAo5muBkIlxhC5ehEHJpQAzao9FEWQL3YoFYArxOVeP7v8cy
         Ky/olalbcWkjm9PRMN/BLgYou7wYmLyQAmsW3uol2UTHMUZ9nkeoE0DbGl+BC70rnPPZ
         GSavp0C/KeivXI5p8QiWDfD+h074Wiltp2lfy0So9NM3bJ8O84uphGw4xhq2cxzMJjoT
         BHXg==
X-Gm-Message-State: ALoCoQk1IiqKjYSYLOMwlXktPGreo7/6puNJPzM3cQD0XgSJMasrNr4XJrteq+PYzPrrQCqGLLni
X-Received: by 10.55.217.218 with SMTP id q87mr22147923qkl.56.1440538945266;
 Tue, 25 Aug 2015 14:42:25 -0700 (PDT)
Received: by 10.140.41.198 with HTTP; Tue, 25 Aug 2015 14:42:25 -0700 (PDT)
In-Reply-To: <xmqq7fojxeh3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276576>

On Tue, Aug 25, 2015 at 2:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This runs a command on each submodule in parallel and should eventually
>> replace `git submodule foreach`.
>>
>> There is a new option -j/--jobs (inspired by make) to specify the number
>> of parallel threads.
>>
>> The jobs=1 case needs to be special cases to exactly replicate the current
>> default behavior of `git submodule foreach` such as working stdin input.
>
> "git submodule foreach-parallel -j1" feels like a roundabout way to
> say "git submodule foreach"; "I want you to go parallel.  Oh, not
> really, I want you to do one thing at a time".

Eventually I want to drop the -parallel, such that git foreach ... will
just work as it always had, and if there is a --jobs argument we
may want to change the semantics a bit to make it work with the
piping to stdout/err.

>
> I do not think these two have to be equivalent---users who need the
> traditional one-by-one "foreach" behaviour (including the standard
> input and other aspects that are unreasonable to expect
> "foreach-parallel -jN" to replicate) can and should choose to use
> "foreach", not "foreach-parallel -j1".
>
> In any case, I do not think I saw any special casing of -j1 case that
> attempts to leave the standard input operational.  Did I miss
> something, or is the above describing what is left to do?

It is the later, I am not quite confident yet about this very patch,
but I was rather waiting for feedback what people deem is important.

>
>> For more than one job there is no input possible and the output of both
>> stdout/stderr of the command are put into the stderr in an ordered fashion,
>> i.e. the tasks to not intermingle their output in races.
>
> To rephrase what I said earlier, "for parallel version, the above
> things happen, even with numthreads==1", is perfectly fine.

>
>> +     cp->no_stdin = 1;
>> +     cp->out = 0;
>> +     cp->err = -1;
>> +     cp->dir = args->path;
>> +     cp->stdout_to_stderr = 1;
>
> So the standard error and the standard output are mixed to a single
> pipe ...

I was very focused on fetch, which would report progress and
information to stderr only.

>
>> +     cp->use_shell = 1;
>> +
>> +     if (start_command(cp)) {
>> +             die("Could not start command");
>> +             for (i = 0; cp->args.argv; i++)
>> +                     fprintf(stderr, "%s\n", cp->args.argv[i]);
>> +     }
>> +
>> +     while (1) {
>> +             ssize_t len = xread(cp->err, buf, sizeof(buf));
>> +             if (len < 0)
>> +                     die("Read from child failed");
>> +             else if (len == 0)
>> +                     break;
>> +             else {
>> +                     strbuf_add(&out, buf, len);
>> +             }
>
> ... and the whole thing is accumulated in core???

The pipes have a limit, so we need to empty them to prevent back-pressure?
And because we want to have the output of one task at a time, we need to
save it up until we can put out the whole output, no?

>
>> +     }
>> +     if (finish_command(cp))
>> +             die("command died with error");
>> +
>> +     sem_wait(args->mutex);
>> +     fputs(out.buf, stderr);
>> +     sem_post(args->mutex);
>
> ... and emitted to standard error?
>
> I would have expected that the standard error would be left alone

`git fetch` which may be a good candidate for such an operation
provides progress on stderr, and we don't want to intermingle
2 different submodule fetch progress displays
("I need to work offline for a bit, so let me get all of the latest stuff,
so I'll run `git submodule foreach -j 16 -- git fetch --all" though ideally
we want to have `git fetch --recurse-submodules -j16` instead )

> (i.e. letting warnings from multiple jobs to be mixed together
> simply because everybody writes to the same file descriptor), while
> the standard output would be line-buffered, perhaps captured by the
> above loop and then emitted under mutex, or something.

>
> I think I said this earlier, but latency to the first output counts

"to the first stderr"
in this case?

So you would want one channel (stderr) for a fast reporting possibility
and another channel (stdout) for a well ordered output mode to cover
both options. And the command to be run must adhere to the our
selection of stderr for fast reporting and stdout for output to wait on.

> as an activity feedback mechanism.
>
>> +     if (module_list_compute(0, nullargv, NULL, &pathspec) < 0)
>> +             return 1;
>> +
>> +     gitmodules_config();
>> +
>> +     aq = create_task_queue(number_threads);
>> +
>> +     for (i = 0; i < ce_used; i++) {
>> +             const struct submodule *sub;
>> +             const struct cache_entry *ce = ce_entries[i];
>> +             struct submodule_args *args = malloc(sizeof(*args));
>> +
>> +             if (ce_stage(ce))
>> +                     args->sha1 = xstrdup(sha1_to_hex(null_sha1));
>> +             else
>> +                     args->sha1 = xstrdup(sha1_to_hex(ce->sha1));
>> +
>> +             strbuf_reset(&sb);
>> +             strbuf_addf(&sb, "%s/.git", ce->name);
>> +             if (!file_exists(sb.buf))
>> +                     continue;
>> +
>> +             args->path = ce->name;
>> +             sub = submodule_from_path(null_sha1, args->path);
>> +             if (!sub)
>> +                     die("No submodule mapping found in .gitmodules for path '%s'", args->path);
>> +
>> +             args->name = sub->name;
>> +             args->toplevel = xstrdup(xgetcwd());
>> +             args->cmd = argv;
>> +             args->mutex = mutex;
>> +             args->prefix = alternative_path;
>> +             add_task(aq, run_cmd_submodule, args);
>> +     }
>> +
>> +     finish_task_queue(aq, NULL);
>
> This is very nice.  Declare a task queue with N workers, throw bunch
> of task to it and then wait for all of them to complete.  Things
> can't be simpler than that ;-).  One thing that other callers of the
> mechanism might want may be to plug and unplug the task queue, but
> that can wait until the need arises.

I think a queue is the simplest thing at the moment. Eventually we
may want to have a way to specify a DAG of workers (e.g. 2 tasks reading from
files to a buffer, 4 tasks to preprocess the output from the first 2 tasks, and
then 16 tasks to do heavy workload processing, and just one thread doing the
stdout/err handling).

In the current patches the task queue is passed around and every worker thread
has access to it, in case it wants to start new tasks itself, so it
may be doable.

Why would we want to unplug the task queue from somewhere else?
