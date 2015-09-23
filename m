From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 06/14] run-command: add an asynchronous parallel child processor
Date: Tue, 22 Sep 2015 23:29:17 -0700
Message-ID: <xmqqeghpzm0y.fsf@gitster.mtv.corp.google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
	<1442972732-12118-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 08:29:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZedYU-0007aQ-TO
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 08:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbbIWG3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 02:29:22 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33513 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbbIWG3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 02:29:21 -0400
Received: by pacex6 with SMTP id ex6so31712802pac.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 23:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OF5ZDR7GKxNDgwJRpRYugYLGjEMJLA1x3Rhtij41RXs=;
        b=p1TmTy+CKudi2N+P7D4vKH7TGy67vVChCXB/BbgvNGlUGdxp0KTn5p7c/8IgnPkrnA
         phedaRX2KaeeYKQj/Lh7tIIMDVPRiivwwRmSIqrJ3ORLOfrI0FlFD5EYeh8j3yh4XLG7
         dMW52X35viU241VVAI91cekJT+ETtjkwoI8xtP4t/X2GThl00SbzwcENjGJPN47PQ6Bo
         Cf2+Hz7jsUuRM1wAPvJX4+INm5CAwWd6qdUBDZjTFWBfwPfTBcTRqqKLGxpd7jOmCEQg
         dU1CTZB/DYEVn6eNo0OhMoRi1pdON836o4hW0R/uPXU+0w9k4PERucPb72age7RWJq+N
         8kVA==
X-Received: by 10.69.26.161 with SMTP id iz1mr36115647pbd.17.1442989760725;
        Tue, 22 Sep 2015 23:29:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id pi9sm5710204pbb.96.2015.09.22.23.29.17
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 23:29:18 -0700 (PDT)
In-Reply-To: <1442972732-12118-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 22 Sep 2015 18:45:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278469>

Stefan Beller <sbeller@google.com> writes:

>  run-command.c          | 264 +++++++++++++++++++++++++++++++++++++++++++++++++
>  run-command.h          |  36 +++++++
>  t/t0061-run-command.sh |  20 ++++
>  test-run-command.c     |  24 +++++
>  4 files changed, 344 insertions(+)

I think we are almost there, but there were still a few more "huh?"
in this patch.

> +/* returns 1 if a process was started, 0 otherwise */

This claim is dubious.

The last four lines of this function marks the i-th slot as in_use,
and increments nr_processes, so that exit codepath clearly is about
"a process was started" and should be returning 1, but the code
returns 0, which looks incorrect.

> +static int pp_start_one(struct parallel_processes *pp)
> +{
> +	int i;
> +
> +	for (i = 0; i < pp->max_processes; i++)
> +		if (!pp->children[i].in_use)
> +			break;
> +	if (i == pp->max_processes)
> +		die("BUG: bookkeeping is hard");
> +
> +	if (!pp->get_next_task(pp->data,
> +			       &pp->children[i].process,
> +			       &pp->children[i].err))
> +		return 1;

And this one, when get_next_task() says "nothing more to do", is
clearly "we returned without starting anything", so according to the
comment it should be returning 0, but the code returns 1, which
looks incorrect.

> +	if (start_command(&pp->children[i].process))
> +		pp->start_failure(pp->data,
> +				  &pp->children[i].process,
> +				  &pp->children[i].err);

What should happen if start_failure returns without dying?
Shouldn't this function return something, without doing the
remainder of it?  i.e.

	if (start_command(...)) {
		pp->start_failur(...);
                return SOMETHING;
	}

According to the comment at the beginning, that SOMETHING ought to
be 0, because we did not spawn anything, i.e. we did not increment
nr_processes.

But don't make that change yet; I do not think it is a great
interface to say "did we or did we not add a new process?" anyway
(see below).

> +	set_nonblocking(pp->children[i].process.err);
> +
> +	pp->nr_processes++;
> +	pp->children[i].in_use = 1;
> +	pp->pfd[i].fd = pp->children[i].process.err;
> +	return 0;

And this is "we spawned" that ought to have returned 1.

Perhaps the comment at the beginning is wrong, as the code
consistently does the opposite of what the comment says.

But it does not really matter, as I do not think this should be
returning "did we or did we not start a new process?" (see below).

> +}

> +int run_processes_parallel(int n, void *data,
> +			   get_next_task_fn get_next_task,
> +			   start_failure_fn start_failure,
> +			   return_value_fn return_value)
> +{
> +	struct parallel_processes pp;
> +	pp_init(&pp, n, data, get_next_task, start_failure, return_value);
> +
> +	while (1) {
> +		while (pp.nr_processes < pp.max_processes &&
> +		       !pp_start_one(&pp))
> +			; /* nothing */
> +		if (!pp.nr_processes)
> +			break;

This inner loop is why I think "did we or did we not spawn a new
process?" is not a great interface.

The reason why it is not a great interface is because there are two
possible reasons why pp_start_one() does not spawn a new process,
and this caller wants to behave differently depending on why it did
not spawn a new process.  They are:

 * get_next_task() truly ran out of things to do.

 * get_next_task() gave us a task, but it did not start, and
   start_failure was set not to die (e.g. the function can be used
   to tell the next_task machinery that it needs to return a
   replacement task for the one that failed to run.  That way, upon
   next call to get_next_task, a replacement task can run instead of
   the old one that failed).

For the former, we want to stop looping, for the latter, we
definitely do want to keep looping, as we want to make another call
to get_next_task() to grab the replacement task for the one that
just failed.

So I think it makes more sense to define the meaning of the return
value from pp_start_one() differently from the way this patch
defines.  "Return 0 when we truly ran out of things to do, otherwise
return non-zero", for example, would make more sense.  The return
value does not tell you if the call resulted in one more process,
but that is not any loss, as you can look at pp.nr_processes
yourself if you really cared.

With that, the above caller could be updated, with optional gradual
ramp_up, like so:

	#define RAMP_UP_LIMIT 2

	while (1) {
		int ramp_up;
		int no_more_task;

		for (no_more_task = 0, ramp_up = RAMP_UP_LIMIT;
                     !no_more_task && ramp_up && pp.nr_processes < pp.max_processes;
		     ramp_up--)
			if (!pp_start_one(&pp))
				no_more_task = 1;

		if (!pp.nr_processes && no_more_task)
			break;

If you prefer to swamp the system with a thundering herd at the
beginning, you can define RAMP_UP_LIMIT to really a high value
instead, e.g. "#define RAMPUP_LIMIT pp.max_processes".  I however
would not recommend it because doing so would hurt the perceived
latency at the beginning.

After the system goes into a steady state, how you set RAMP_UP_LIMIT
would not make that much difference, as your slots should be almost
always full and you will be replenishing an open slot with a single
task as each running task finishes, and you would not be running
more than one pp_start_one() at a time anyway.

> +		pp_buffer_stderr(&pp);
> +		pp_output(&pp);
> +		pp_collect_finished(&pp);
> +	}
> +
> +	pp_cleanup(&pp);
> +
> +	return 0;
> +}
