Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00245C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 16:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbiE0Q7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 12:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiE0Q67 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 12:58:59 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4570B122B57
        for <git@vger.kernel.org>; Fri, 27 May 2022 09:58:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AADC019A670;
        Fri, 27 May 2022 12:58:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=crGnyGFWE2jd
        z0DxfbTxVgeMgdGdAffeAc/6bOTd9cY=; b=WlMIj3vFJ8q7yHg8XNFD3a+/cfM1
        BZZ3HIJl6K7X/PwxoRb3iT4Il3y74YTAqSDtzBcBGkivlIffVCbDdWY5t8QRi5TP
        vYOuXrcMVz+zo2cNZEUh/ZloCIGEy/h3FjyFn2GVygGrFtXYZUdGOir4dIfwJIkZ
        YESNagArvR79H2M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2AAC19A66F;
        Fri, 27 May 2022 12:58:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3609B19A66E;
        Fri, 27 May 2022 12:58:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] run-command: add an "ungroup" option to
 run_process_parallel()
References: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
        <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com>
        <patch-v3-1.2-aabd99de680-20220527T090618Z-avarab@gmail.com>
Date:   Fri, 27 May 2022 09:58:52 -0700
In-Reply-To: <patch-v3-1.2-aabd99de680-20220527T090618Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 27 May
 2022 11:14:30
        +0200")
Message-ID: <xmqqee0e52ur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 49CE6B22-DDDE-11EC-8AA0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/run-command.c b/run-command.c
> index a8501e38ceb..b5ede8655d3 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1468,9 +1468,10 @@ int pipe_command(struct child_process *cmd,
>  enum child_state {
>  	GIT_CP_FREE,
>  	GIT_CP_WORKING,
> -	GIT_CP_WAIT_CLEANUP,
> +	GIT_CP_WAIT_CLEANUP, /* only for !ungroup */
>  };
> =20
> +int run_processes_parallel_ungroup;

A few comments on these below.

> @@ -1537,7 +1539,7 @@ static void pp_init(struct parallel_processes *pp=
,
>  		    get_next_task_fn get_next_task,
>  		    start_failure_fn start_failure,
>  		    task_finished_fn task_finished,
> -		    void *data)
> +		    void *data,  const int ungroup)

It is unusual in this codebase to pass "const" non-pointer as a
parameter, but OK.

> @@ -1591,7 +1599,8 @@ static void pp_cleanup(struct parallel_processes =
*pp)
>  	 * When get_next_task added messages to the buffer in its last
>  	 * iteration, the buffered output is non empty.
>  	 */
> -	strbuf_write(&pp->buffered_output, stderr);
> +	if (!pp->ungroup)
> +		strbuf_write(&pp->buffered_output, stderr);

Micronit.  If buffered_output is empty, whether it is because we are
in the ungroup mode and haven't buffered anything there, or because
our subprocess didn't emit anything, we do not have to do this write.
So it looks to me that it would be conceptually much cleaner to do

	if (pp->buffered_output.len)
		strbuf_write(&pp->buffered_output, stderr);

or just to let the strbuf_write() worry about it, as this is an I/O
codepath and the overhead of a no-op function call may be negligible.

Or is there a reason to believe that pp->buffered_output is in an
undefined state when in the ungroup mode?  If so, we probably should
fix that.  The fewer special rules like "in X mode, members Y, Z and
W are left uninitialized so do not even look at them", the better
off we will be, especially when Y, Z and W have their own natural
"initialized and untouched" state.  Allow users of Y to decide how
they do things with Y without having to worry about X that they do
not have to worry about when doing their job.

>  	strbuf_release(&pp->buffered_output);

And this unconditinal call indicates buffered_output is never in an
undefined state and it is safe to call _release even in the ungroup
mode.

> @@ -1606,6 +1615,7 @@ static void pp_cleanup(struct parallel_processes =
*pp)
>   */
>  static int pp_start_one(struct parallel_processes *pp)
>  {
> +	const int ungroup =3D pp->ungroup;
>  	int i, code;
> =20
>  	for (i =3D 0; i < pp->max_processes; i++)
> @@ -1615,24 +1625,30 @@ static int pp_start_one(struct parallel_process=
es *pp)
>  		BUG("bookkeeping is hard");
> =20
>  	code =3D pp->get_next_task(&pp->children[i].process,
> -				 &pp->children[i].err,
> +				 ungroup ? NULL : &pp->children[i].err,
>  				 pp->data,
>  				 &pp->children[i].data);

OK, any process taken from the pp struct with the ungroup bit on
does not get its output stolen.  Makes sense.

>  	if (!code) {
> -		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> -		strbuf_reset(&pp->children[i].err);
> +		if (!ungroup) {
> +			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> +			strbuf_reset(&pp->children[i].err);
> +		}
>  		return 1;
>  	}

OK.

> -	pp->children[i].process.err =3D -1;
> -	pp->children[i].process.stdout_to_stderr =3D 1;
> +	if (!ungroup) {
> +		pp->children[i].process.err =3D -1;
> +		pp->children[i].process.stdout_to_stderr =3D 1;
> +	}

OK.

>  	pp->children[i].process.no_stdin =3D 1;

This is shared between the two modes, and is unchanged from the
run_hook_ve() days.  Good.

>  	if (start_command(&pp->children[i].process)) {
> -		code =3D pp->start_failure(&pp->children[i].err,
> +		code =3D pp->start_failure(ungroup ? NULL : &pp->children[i].err,
>  					 pp->data,
>  					 pp->children[i].data);
> -		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> -		strbuf_reset(&pp->children[i].err);
> +		if (!ungroup) {
> +			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> +			strbuf_reset(&pp->children[i].err);
> +		}
>  		if (code)
>  			pp->shutdown =3D 1;
>  		return code;

OK.

> @@ -1640,14 +1656,26 @@ static int pp_start_one(struct parallel_process=
es *pp)
> =20
>  	pp->nr_processes++;
>  	pp->children[i].state =3D GIT_CP_WORKING;
> -	pp->pfd[i].fd =3D pp->children[i].process.err;
> +	if (pp->pfd)
> +		pp->pfd[i].fd =3D pp->children[i].process.err;
>  	return 0;
>  }

OK.

> +static void pp_mark_working_for_cleanup(struct parallel_processes *pp)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < pp->max_processes; i++)
> +		if (pp->children[i].state =3D=3D GIT_CP_WORKING)
> +			pp->children[i].state =3D GIT_CP_WAIT_CLEANUP;
> +}

This thing is new.  I do not see a corresponding removal of a
similar loop that used to be done unconditionally that was turned
into a call to this helper only under the non-ungroup mode, or
anything like that, so it is a bit puzzling.

>  static void pp_buffer_stderr(struct parallel_processes *pp, int output=
_timeout)
>  {
>  	int i;
> =20
> +	assert(!pp->ungroup);
> +

Sensible.  Or even "if (pp->ungroup) BUG()".

>  	while ((i =3D poll(pp->pfd, pp->max_processes, output_timeout)) < 0) =
{
>  		if (errno =3D=3D EINTR)
>  			continue;
> @@ -1674,6 +1702,9 @@ static void pp_buffer_stderr(struct parallel_proc=
esses *pp, int output_timeout)
>  static void pp_output(struct parallel_processes *pp)
>  {
>  	int i =3D pp->output_owner;
> +
> +	assert(!pp->ungroup);
> +
>  	if (pp->children[i].state =3D=3D GIT_CP_WORKING &&
>  	    pp->children[i].err.len) {
>  		strbuf_write(&pp->children[i].err, stderr);
> @@ -1683,10 +1714,15 @@ static void pp_output(struct parallel_processes=
 *pp)
> =20
>  static int pp_collect_finished(struct parallel_processes *pp)
>  {
> +	const int ungroup =3D pp->ungroup;
>  	int i, code;
>  	int n =3D pp->max_processes;
>  	int result =3D 0;
> =20
> +	if (ungroup)
> +		for (i =3D 0; i < pp->max_processes; i++)
> +			pp->children[i].state =3D GIT_CP_WAIT_CLEANUP;

The new helper does this only for those in the WORKING state, but
this one does so unconditionally.  It's not like we leave the .state
of our subprocesses unspecified when we start them---we set to WORKING
whether we are in the ungroup mode or not.  So it is also puzzling why
we are not calling the helper function here.

By the way, if we use WAIT_CLEANUP state like this in the ungroup
mode, shouldn't we lose the "only for !ungroup" comment from the
enum definition?

> @@ -1697,8 +1733,8 @@ static int pp_collect_finished(struct parallel_pr=
ocesses *pp)
>  		code =3D finish_command(&pp->children[i].process);
> =20
>  		code =3D pp->task_finished(code,
> -					 &pp->children[i].err, pp->data,
> -					 pp->children[i].data);
> +					 ungroup ? NULL : &pp->children[i].err,
> +					 pp->data, pp->children[i].data);

OK.

> @@ -1707,10 +1743,13 @@ static int pp_collect_finished(struct parallel_=
processes *pp)
> =20
>  		pp->nr_processes--;
>  		pp->children[i].state =3D GIT_CP_FREE;
> -		pp->pfd[i].fd =3D -1;
> +		if (pp->pfd)
> +			pp->pfd[i].fd =3D -1;
>  		child_process_init(&pp->children[i].process);
> =20
> -		if (i !=3D pp->output_owner) {
> +		if (ungroup) {
> +			; /* no strbuf_*() work to do here */

Of course ;-)

> +		} else if (i !=3D pp->output_owner) {
>  			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
>  			strbuf_reset(&pp->children[i].err);
>  		} else {
> @@ -1748,8 +1787,13 @@ int run_processes_parallel(int n,
>  	int output_timeout =3D 100;
>  	int spawn_cap =3D 4;
>  	struct parallel_processes pp;
> +	const int ungroup =3D run_processes_parallel_ungroup;
> =20
> -	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
> +	/* unset for the next API user */
> +	run_processes_parallel_ungroup =3D 0;

This way, you do not have to touch existing calls to this function
that do not (yet) want to know about the ungroup mode.

That makes a confusing API, but the trade-off feels OK.

> +	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
> +		ungroup);
>  	while (1) {
>  		for (i =3D 0;
>  		    i < spawn_cap && !pp.shutdown &&
> @@ -1766,8 +1810,12 @@ int run_processes_parallel(int n,
>  		}
>  		if (!pp.nr_processes)
>  			break;
> -		pp_buffer_stderr(&pp, output_timeout);
> -		pp_output(&pp);
> +		if (ungroup) {
> +			pp_mark_working_for_cleanup(&pp);
> +		} else {
> +			pp_buffer_stderr(&pp, output_timeout);
> +			pp_output(&pp);
> +		}
>  		code =3D pp_collect_finished(&pp);
>  		if (code) {
>  			pp.shutdown =3D 1;
> diff --git a/run-command.h b/run-command.h
> index 5bd0c933e80..a44d2a6ba75 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -405,6 +405,10 @@ void check_pipe(int err);
>   * pp_cb is the callback cookie as passed to run_processes_parallel.
>   * You can store a child process specific callback cookie in pp_task_c=
b.
>   *
> + * The "struct strbuf *err" parameter is either a pointer to a string
> + * to write errors to, or NULL if the "ungroup" option was
> + * provided. See run_processes_parallel() below.
> + *
>   * Even after returning 0 to indicate that there are no more processes=
,
>   * this function will be called again until there are no more running
>   * child processes.

This comment appears just before the typedef of get_next_task_fn
function type, presumably to explain the parameters involved in
calling such a function, and it does talk about pp_cb and
pp_task_cb.  The new paragraph, however, looks out of place.  There
is no err parameter.  The existing text (before the pre-context)
mentions "preload the error channel" but it is left unclear what
that means.  Does that "err" non-parameter the new paragraph talks
about have some connection to the thing that receives the preloaded
error channel contents?  Puzzled.

> @@ -423,9 +427,9 @@ typedef int (*get_next_task_fn)(struct child_proces=
s *cp,
>   * This callback is called whenever there are problems starting
>   * a new process.
>   *
> - * You must not write to stdout or stderr in this function. Add your
> - * message to the strbuf out instead, which will be printed without
> - * messing up the output of the other parallel processes.
> + * The "struct strbuf *err" parameter is either a pointer to a string
> + * to write errors to, or NULL if the "ungroup" option was
> + * provided. See run_processes_parallel() below.

This comment is for start_failure_fn and has the same issue.  The
text removed gives a readable/understandable explanation for
developers who are writing for non-ungrouped mode, though.

>   *
>   * pp_cb is the callback cookie as passed into run_processes_parallel,
>   * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> @@ -441,9 +445,9 @@ typedef int (*start_failure_fn)(struct strbuf *out,
>  /**
>   * This callback is called on every child process that finished proces=
sing.
>   *
> - * You must not write to stdout or stderr in this function. Add your
> - * message to the strbuf out instead, which will be printed without
> - * messing up the output of the other parallel processes.
> + * The "struct strbuf *err" parameter is either a pointer to a string
> + * to write errors to, or NULL if the "ungroup" option was
> + * provided. See run_processes_parallel() below.

Ditto for task_finished_fn.

>   * pp_cb is the callback cookie as passed into run_processes_parallel,
>   * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> @@ -464,11 +468,24 @@ typedef int (*task_finished_fn)(int result,
>   *
>   * The children started via this function run in parallel. Their outpu=
t
>   * (both stdout and stderr) is routed to stderr in a manner that outpu=
t
> - * from different tasks does not interleave.
> + * from different tasks does not interleave (but see "ungroup" above).

I think you meant "below" here, not "above".

>   * start_failure_fn and task_finished_fn can be NULL to omit any
>   * special handling.
> + *
> + * If the "ungroup" option isn't specified the callbacks will get a
> + * pointer to a "struct strbuf *out", and must not write to stdout or
> + * stderr as such output will mess up the output of the other parallel
> + * processes. If "ungroup" option is specified callbacks will get a

"specified callbacks" -> "specified, callbacks"

> + * NULL "struct strbuf *out" parameter, and are responsible for
> + * emitting their own output, including dealing with any race
> + * conditions due to writing in parallel to stdout and stderr.
> + * The "ungroup" option can be enabled by setting the global
> + * "run_processes_parallel_ungroup" to "1" before invoking
> + * run_processes_parallel(), it will be set back to "0" as soon as the
> + * API reads that setting.
>   */

This new paragraph is well written.

> +extern int run_processes_parallel_ungroup;
>  int run_processes_parallel(int n,
>  			   get_next_task_fn,
>  			   start_failure_fn,

