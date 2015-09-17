From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] run-command: add an asynchronous parallel child processor
Date: Thu, 17 Sep 2015 14:44:29 -0700
Message-ID: <xmqqbnd0iuv6.fsf@gitster.mtv.corp.google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 23:44:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcgyr-0006aR-E4
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 23:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbbIQVod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 17:44:33 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33315 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbIQVob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 17:44:31 -0400
Received: by pacex6 with SMTP id ex6so30206225pac.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JmoTgNHRfPtwgveuHCu1W7x7HSJA/E79zXhRDkMr7hM=;
        b=iNkjBMxc46jBfhCYUGJO6zeW6Uww+vyFvOUbVrn5hu/Polzl60ewdqlPf1Pql9JKkC
         dqsFKFe+Fk4l0Fr9dylf0PcYWE9Vlg3t5zGNqu0q/D8Jmhvg7yGb1vFf1X8uiG1ui98E
         uYyz4pX4XLttpvSKYWEXeaeTR9zEDsq4mAERlNjjlF70t55u2dckhwWbMYDvU+2YYmKb
         ZaN06hqjFRrf553XduKphWyMEaoXrWxln5B+65S6FdvN1EThiYJSdzSNve7ZTPL6CX8g
         kVdzOrWABxQhxf31lfOw2G/mnj+pfMGqQF2rjKXWvr7yaRanStnuSSMtVlvvsxe2ekz0
         wdDQ==
X-Received: by 10.68.138.200 with SMTP id qs8mr2709802pbb.19.1442526271194;
        Thu, 17 Sep 2015 14:44:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id wk6sm5148890pab.30.2015.09.17.14.44.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 14:44:30 -0700 (PDT)
In-Reply-To: <1442453948-9885-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 16 Sep 2015 18:39:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278171>

Stefan Beller <sbeller@google.com> writes:

>  time -->
>  output: |---A---|   |-B-|   |----C-----------|   |-D-|   |-E-|

Be nice and distribute the line evenly around "C".  Same for thread
2 below.

> diff --git a/run-command.c b/run-command.c
> index c892e9a..3af97ab 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -3,6 +3,7 @@
>  #include "exec_cmd.h"
>  #include "sigchain.h"
>  #include "argv-array.h"
> +#include "thread-utils.h"
>  
>  void child_process_init(struct child_process *child)
>  {
> @@ -862,3 +863,230 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
>  	close(cmd->out);
>  	return finish_command(cmd);
>  }
> +
> +struct parallel_processes {
> +	int max_number_processes;
> +	void *data;

> +	get_next_task fn;
> +	handle_child_starting_failure fn_err;
> +	handle_child_return_value fn_exit;

The 'fn' feels really misnamed, especially when compared with the
other fields.  fn_task or something, perhaps.

Also I think we call a function type we define with a name that ends
with _fn, e.g.

    typedef void (*show_commit_fn)(struct commit *, void *);
    void traverse_commit_list(struct rev_info *revs,
                              show_commit_fn show_commit,
                              show_object_fn show_object,
                              void *data)

So perhaps

	get_next_task_fn get_next_task;
        start_failure_fn start_failure;
        return_value_fn return_value;

or something like that.

> +	int nr_processes;
> +	int all_tasks_started;
> +	int foreground_child;
> +	char *slots;

What does slots[i] mean?  Whatever explanation you would use as an
answer to that question, I'd name the field after the key words used
in the explanation.  For example, if it means "children[i] is in use
with a process", then the code would be a lot happier if the field
is called in_use[] or something.

But do not just rename the field yet...

> +	struct child_process *children;
> +	struct pollfd *pfd;
> +	struct strbuf *err;

struct pollfd needs to be a contiguous array of nr_processes
elements because that is what poll(2) takes, but other per-child
fields would be easier to grasp if you did it like so:

	struct parallel_processes {
        	...
                struct {
                	int in_use;
                        struct child_process child;
                        struct strbuf err;
                        ... /* maybe other per-child field later */
		} *children;
		...
	}

> +	struct strbuf finished_children;

A strbuf that holds "finished_children"?  Does it hold "what
finished_children said"?

We care about good naming because clearly named variables and fields
make the code easier to read.

> +static void unblock_fd(int fd)

I would probably have called this "set_nonblocking()".

> +{
> +	int flags = fcntl(fd, F_GETFL);
> +	if (flags < 0) {
> +		warning("Could not get file status flags, "
> +			"output will be degraded");
> +		return;
> +	}
> +	if (fcntl(fd, F_SETFL, flags | O_NONBLOCK)) {
> +			warning("Could not set file status flags, "
> +			"output will be degraded");

The first line of "warning(" is indented one level too deep.

> +		return;
> +	}

Wouldn't it be easier to follow if you did

	fn(...)
	{
                if (flags < 0)
                        warn();
                else if (fcntrl() < 0)
                        warn();
	}

> +static void run_processes_parallel_start_new(struct parallel_processes *pp)
> +{
> +	int i;
> +	/* Start new processes. */

Drop this comment and replace it with a blank line.

> +	while (!pp->all_tasks_started
> +	       && pp->nr_processes < pp->max_number_processes) {

Remove "&& " and add " &&" at the end of the previous line.

> +		for (i = 0; i < pp->max_number_processes; i++)
> +			if (!pp->slots[i])
> +				break; /* found an empty slot */

The comment does not help us at all.  if (...) break; tells as much,
and it does not tell us what it means that slot[] being empty at all.

		for (...)
			if (!pp->children[i].in_use)
				break;

would be a lot easier to follow without any comment.

> +		if (i == pp->max_number_processes)
> +			die("BUG: bookkeeping is hard");
> +
> +		if (pp->fn(pp->data, &pp->children[i], &pp->err[i])) {

This use pattern (and the explanation in run-command.h) suggests
that the name of the field should be s/fn/more_task/; or something
along that line (and flip the return value, i.e. more_task() returns
yes if it did grab another task, no if there is no more task).

> +			pp->all_tasks_started = 1;
> +			break;
> +		}
> +		if (start_command(&pp->children[i]))
> +			pp->fn_err(pp->data, &pp->children[i], &pp->err[i]);

Can fn_err be NULL here?  Shouldn't it (to give a default behaviour
to lazy or bog-standard callers)?

> +		unblock_fd(pp->children[i].err);
> +
> +		pp->nr_processes++;
> +		pp->slots[i] = 1;
> +		pp->pfd[i].fd = pp->children[i].err;
> +	}
> +}
> +
> +static int run_processes_parallel_buffer_stderr(struct parallel_processes *pp)
> +{
> +	int i;

Have a blank line here between decls and the first statement.

> +	i = poll(pp->pfd, pp->max_number_processes, 100);

Give a symbolic constant for this 100ms, e.g. OUTPUT_POLL_INTERVAL
or something.

> +	if (i < 0) {
> +		if (errno == EINTR)
> +			/* A signal was caught; try again */
> +			return -1;
> +		else {
> +			run_processes_parallel_cleanup(pp);
> +			die_errno("poll");
> +		}
> +	}

Shouldn't this be more like

	while ((i = poll()) < 0)  {
        	if (errno == EINTR)
                	continue;
		cleanup;
		die;
	}

The caller after all was willing to wait for some time, and we were
interrupted before that time came.

> +	/* Buffer output from all pipes. */
> +	for (i = 0; i < pp->max_number_processes; i++) {
> +		if (!pp->slots[i])
> +			continue;
> +		if (pp->pfd[i].revents & POLLIN)
> +			strbuf_read_noblock(&pp->err[i], pp->children[i].err, 0);
> +		if (pp->foreground_child == i) {
> +			fputs(pp->err[i].buf, stderr);
> +			strbuf_reset(&pp->err[i]);
> +		}

Even if we own the output channel, we may not have read anything
yet---poll() may have said that pfd[i] is not ready, or
read_nonblock() may have returned EWOULDBLOCK.  Perhaps check not
just that i owns the output but err[i].len is not zero?

I think output should be done outside the loop and make the comment
before the loop match what the loop actually does.

	/* Buffer output from all pipes. */
	for (i = 0; ...) {
		if (pp->children[i].in_use && (pp->pfd[i].revents & POLLIN))
			strbuf_read_nonblock();
	}

	/* Drain the output from the owner of the output channel */
	if (pp->children[pp->output_owner].in_use &&
	    pp->children[pp->output_owner].err.len) {
	    	fputs(...);
                strbuf_reset(...);
	}

> +static void run_processes_parallel_collect_finished(struct parallel_processes *pp)
> +{
> +	int i = 0;
> +	pid_t pid;
> +	int wait_status, code;
> +	int n = pp->max_number_processes;
> +	/* Collect finished child processes. */

Drop this comment and replace it with a blank line.

> +	while (pp->nr_processes > 0) {
> +		pid = waitpid(-1, &wait_status, WNOHANG);
> +		if (pid == 0)
> +			return; /* no child finished */

Do we need that comment?

> +		if (pid < 0) {
> +			if (errno == EINTR)
> +				return; /* just try again  next time */

Can we get EINTR here (we are passing WNOHANG above)?

> +			if (errno == EINVAL || errno == ECHILD)
> +				die_errno("wait");

What should happen when we get an error not listed here?  'i' is
left as initialized to 0 and we do strbuf_read_nonblock() for the
first child (which may not even be running)?

You can sweep this bug under the rug by returning here, but I
suspect that you would just want

	if (pid < 0)
		die_errno();

And that would allow you to dedent the else clause below.

> +		} else {
> +			/* Find the finished child. */
> +			for (i = 0; i < pp->max_number_processes; i++)
> +				if (pp->slots[i] && pid == pp->children[i].pid)
> +					break;

Hmm, you are relying on the fact that a valid pid can never be 0, so
you can just use pp->children[i].child.pid to see if a "slot" is
occupied without even using pp->slots[] (or pp->children[i].in_use).

> +			if (i == pp->max_number_processes)
> +				/*
> +				 * waitpid returned another process id
> +				 * which we are not waiting for.
> +				 */
> +				return;
> +		}
> +		strbuf_read_noblock(&pp->err[i], pp->children[i].err, 0);

This is to read leftover output?

As discussed elsewhere, read_nonblock() will have to have "read
some, not necessarily to the end" semantics to serve the caller in
run_processes_parallel_buffer_stderr(), so you'd need a loop around
it here to read until you see EOF.

Or you may be able to just call strbuf_read() and the function may
do the right thing to read things through to the EOF.  It depends on
how you redo the patch [2/10].

> +		if (determine_return_value(wait_status, &code, &errno,
> +					   pp->children[i].argv[0]) < 0)
> +			error("waitpid is confused (%s)",
> +			      pp->children[i].argv[0]);
> +
> +		pp->fn_exit(pp->data, &pp->children[i], code);

You are clobbering errno by calling determine_return_value() but you
do not use the returned value anywhere.  Intended?  Or should that
be given to fn_exit() for error reporting?

> +		argv_array_clear(&pp->children[i].args);
> +		argv_array_clear(&pp->children[i].env_array);
> +
> +		pp->nr_processes--;
> +		pp->slots[i] = 0;
> +		pp->pfd[i].fd = -1;

Mental note: here the "slot" is cleared for the child 'i'.

> +		if (i != pp->foreground_child) {
> +			strbuf_addbuf(&pp->finished_children, &pp->err[i]);
> +			strbuf_reset(&pp->err[i]);

OK, so the idea is that pp->child[i].err holds the entire output for
any process that does not own the output channel until it dies, and
they are appended to pp->finished_children.  That suggests that the
name of the "finished" field should have "output" somewhere in it.

> +		} else {

Mental note: this side of if/else is what happens to the process
that used to own the output channel.

> +			fputs(pp->err[i].buf, stderr);
> +			strbuf_reset(&pp->err[i]);

... and it just flushes the final part of the output.

> +			/* Output all other finished child processes */
> +			fputs(pp->finished_children.buf, stderr);
> +			strbuf_reset(&pp->finished_children);

If there is any, that is.

> +			/*
> +			 * Pick next process to output live.
> +			 * NEEDSWORK:
> +			 * For now we pick it randomly by doing a round
> +			 * robin. Later we may want to pick the one with
> +			 * the most output or the longest or shortest
> +			 * running process time.
> +			 */
> +			for (i = 0; i < n; i++)
> +				if (pp->slots[(pp->foreground_child + i) % n])
> +					break;
> +			pp->foreground_child = (pp->foreground_child + i) % n;

... and then picks a new owner of the output channel.

Up to this point it looks sensible.

> +			fputs(pp->err[pp->foreground_child].buf, stderr);
> +			strbuf_reset(&pp->err[pp->foreground_child]);

I do not think these two lines need to be here, especially if you
follow the above advice of separating buffering and draining.

> +int run_processes_parallel(int n, void *data,
> +			   get_next_task fn,
> +			   handle_child_starting_failure fn_err,
> +			   handle_child_return_value fn_exit)
> +{
> +	struct parallel_processes pp;
> +	run_processes_parallel_init(&pp, n, data, fn, fn_err, fn_exit);
> +
> +	while (!pp.all_tasks_started || pp.nr_processes > 0) {

The former is true as long as more_task() says there may be more.
The latter is true as long as we have something already running.

In either case, we should keep collecting and spawning as needed.

> +		run_processes_parallel_start_new(&pp);

But calling start_new() unconditionally feels sloppy.  It should at
least be something like

	if (pp.nr_processes < pp.max_processes &&
	    !pp.all_task_started)
		start_new_process()

no?

> diff --git a/test-run-command.c b/test-run-command.c
> index 89c7de2..70b6c7a 100644
> --- a/test-run-command.c
> +++ b/test-run-command.c
> @@ -30,6 +50,10 @@ int main(int argc, char **argv)
>  	if (!strcmp(argv[1], "run-command"))
>  		exit(run_command(&proc));
>  
> +	if (!strcmp(argv[1], "run-command-parallel-4"))
> +		exit(run_processes_parallel(4, &proc, parallel_next,
> +					 NULL, NULL));

So not only fn_err, but fn_exit is optional.  You'd need to update
the code above to allow these.

> +
>  	fprintf(stderr, "check usage\n");
>  	return 1;
>  }

It was a fun read.  There were tons of niggles, but I didn't see
anything fundamentally unsalvageable.

Thanks.
