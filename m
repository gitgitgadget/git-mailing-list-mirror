Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC46C433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 03:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiDWD5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 23:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiDWD5P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 23:57:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365311A61F1
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 20:54:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54CF2181ACF;
        Fri, 22 Apr 2022 23:54:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=j/+kpxt3lv6qM8YtH9UUazEqm
        mSYjVZ1qVUsm+VLK5Q=; b=NMJOJcYp3V9JTCuF4K67aEj+rmMZ9bS2r5tnmTjj5
        oTSj36e82voOesYOJHHlUBgNbQ0+7d5sDycHW8+CXdWi/X2j0KaQA/Hf2z8V8TOl
        qvtYpxnBkZrmj09eI1A2Zlxz9uyMd8YEhLNa6oD9GujYNNye090nz38mgWErwO0E
        5s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41548181ACE;
        Fri, 22 Apr 2022 23:54:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AE940181ACD;
        Fri, 22 Apr 2022 23:54:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 3/6] run-command: add an "ungroup" option to
 run_process_parallel()
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <patch-3.6-d76f63c2948-20220421T122108Z-avarab@gmail.com>
Date:   Fri, 22 Apr 2022 20:54:14 -0700
Message-ID: <xmqqilr04fq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0B616924-C2B9-11EC-8E26-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -1494,6 +1494,7 @@ struct parallel_processes {
>  	struct pollfd *pfd;
> =20
>  	unsigned shutdown : 1;
> +	unsigned ungroup:1;

Match the style with the above (either with or without SP
consistently, I would choose to match existing one if I were doing
this myself).

> @@ -1537,8 +1538,9 @@ static void pp_init(struct parallel_processes *pp=
,
>  		    get_next_task_fn get_next_task,
>  		    start_failure_fn start_failure,
>  		    task_finished_fn task_finished,
> -		    void *data)
> +		    void *data, struct run_process_parallel_opts *opts)
>  {
> +	const int ungroup =3D opts->ungroup;
>  	int i;
> =20
>  	if (n < 1)
> @@ -1556,16 +1558,22 @@ static void pp_init(struct parallel_processes *=
pp,
>  	pp->start_failure =3D start_failure ? start_failure : default_start_f=
ailure;
>  	pp->task_finished =3D task_finished ? task_finished : default_task_fi=
nished;
> =20
> +	pp->ungroup =3D ungroup;
> +

OK, now this makes it clear that the new structure introduced in the
first step is about run_process_parallel() and not about trace2, so
it would probably make sense to go back to that step and throw these
*_fn callbacks and callback state to the structure, too.

>  	pp->nr_processes =3D 0;
>  	pp->output_owner =3D 0;
>  	pp->shutdown =3D 0;
>  	CALLOC_ARRAY(pp->children, n);
> -	CALLOC_ARRAY(pp->pfd, n);
> +	if (!ungroup)
> +		CALLOC_ARRAY(pp->pfd, n);

OK, we will not poll under ungroup option, so we do not need pfd[]
in that case.  It would be cleaner to clear pp->pfd =3D NULL if not
done already when ungroup is in effect.

> +
>  	strbuf_init(&pp->buffered_output, 0);
> =20
>  	for (i =3D 0; i < n; i++) {
>  		strbuf_init(&pp->children[i].err, 0);
>  		child_process_init(&pp->children[i].process);
> +		if (ungroup)
> +			continue;
>  		pp->pfd[i].events =3D POLLIN | POLLHUP;
>  		pp->pfd[i].fd =3D -1;
>  	}

This does not make practical difference _right_ _now_, but as a
general code hygiene discipline, it would be more future-proof not
to rely on "ungroup" being the _only_ thing that allows us to omit
allocating pfd.  IOW, conditional allocation of pp->pfd based on
ungroup before the loop is perfectly fine, but inside the loop, it
would be better to say "if pp->pfd is not there, no matter the
reason why pp->pfd is missing, we refrain from filling the array
because we are not polling".

		if (!pp->pfd)
			continue;

We may know that the only reason we decided not to poll is with the
ungroup bit in the current code, but we do not have to depend on the
knowledge.  The only thing we need to know, in order to refrain from
setting POLLIN/POLLHUP bits, is that we decided that we will not poll,
and the decision should be more directly found in pp->pfd than inferring
what the ungroup says.

> @@ -1576,6 +1584,7 @@ static void pp_init(struct parallel_processes *pp=
,
> =20
>  static void pp_cleanup(struct parallel_processes *pp)
>  {
> +	const int ungroup =3D pp->ungroup;
>  	int i;
> =20
>  	trace_printf("run_processes_parallel: done");
> @@ -1585,14 +1594,17 @@ static void pp_cleanup(struct parallel_processe=
s *pp)
>  	}
> =20
>  	free(pp->children);
> -	free(pp->pfd);
> +	if (!ungroup)
> +		free(pp->pfd);

Likewise, the NULLness of pp->pfd should be what matters.

>  	/*
>  	 * When get_next_task added messages to the buffer in its last
>  	 * iteration, the buffered output is non empty.
>  	 */
> -	strbuf_write(&pp->buffered_output, stderr);
> -	strbuf_release(&pp->buffered_output);
> +	if (!ungroup) {
> +		strbuf_write(&pp->buffered_output, stderr);
> +		strbuf_release(&pp->buffered_output);
> +	}

OK, this need to happen only when we are buffering.

>  	sigchain_pop_common();
>  }
> @@ -1606,6 +1618,7 @@ static void pp_cleanup(struct parallel_processes =
*pp)
>   */
>  static int pp_start_one(struct parallel_processes *pp)
>  {
> +	const int ungroup =3D pp->ungroup;
>  	int i, code;
> =20
>  	for (i =3D 0; i < pp->max_processes; i++)
> @@ -1615,24 +1628,31 @@ static int pp_start_one(struct parallel_process=
es *pp)
>  		BUG("bookkeeping is hard");
> =20
>  	code =3D pp->get_next_task(&pp->children[i].process,
> -				 &pp->children[i].err,
> +				 ungroup ? NULL : &pp->children[i].err,

OK.

>  				 pp->data,
>  				 &pp->children[i].data);
>  	if (!code) {
> -		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> -		strbuf_reset(&pp->children[i].err);
> +		if (!ungroup) {
> +			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> +			strbuf_reset(&pp->children[i].err);
> +		}
>  		return 1;
>  	}
> -	pp->children[i].process.err =3D -1;
> -	pp->children[i].process.stdout_to_stderr =3D 1;
> -	pp->children[i].process.no_stdin =3D 1;
> +
> +	if (!ungroup) {
> +		pp->children[i].process.err =3D -1;
> +		pp->children[i].process.stdout_to_stderr =3D 1;
> +		pp->children[i].process.no_stdin =3D 1;
> +	}

OK, except for .no_stdin bit.  Even before the "we started using the
parallel running API to drive hooks, losing the direct access to the
real standard output from the hooks" regression, we didn't expose the
input side to the hooks.  run_hook_ve() did set .no_stdin and I do
not think we want to change that with "--ungroup".  If there is any
reason why you needed not to keep .no_stdin bit set in the ungroup
mode, deviating from what the code before the regression did, that
needs to be explained (but I suspect this was simply a bug in this
round of the patch, not a deliberate behaviour change).

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
> @@ -1640,14 +1660,26 @@ static int pp_start_one(struct parallel_process=
es *pp)
> =20
>  	pp->nr_processes++;
>  	pp->children[i].state =3D GIT_CP_WORKING;
> -	pp->pfd[i].fd =3D pp->children[i].process.err;
> +	if (!ungroup)
> +		pp->pfd[i].fd =3D pp->children[i].process.err;
>  	return 0;
>  }
> =20
> +static void pp_mark_working_for_cleanup(struct parallel_processes *pp)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < pp->max_processes; i++)
> +		if (pp->children[i].state =3D=3D GIT_CP_WORKING)
> +			pp->children[i].state =3D GIT_CP_WAIT_CLEANUP;
> +}
> +
>  static void pp_buffer_stderr(struct parallel_processes *pp, int output=
_timeout)
>  {
>  	int i;
> =20
> +	assert(!pp->ungroup);
> +
>  	while ((i =3D poll(pp->pfd, pp->max_processes, output_timeout)) < 0) =
{
>  		if (errno =3D=3D EINTR)
>  			continue;
> @@ -1674,6 +1706,9 @@ static void pp_buffer_stderr(struct parallel_proc=
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
> @@ -1683,10 +1718,15 @@ static void pp_output(struct parallel_processes=
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
> +
>  	while (pp->nr_processes > 0) {
>  		for (i =3D 0; i < pp->max_processes; i++)
>  			if (pp->children[i].state =3D=3D GIT_CP_WAIT_CLEANUP)
> @@ -1697,8 +1737,8 @@ static int pp_collect_finished(struct parallel_pr=
ocesses *pp)
>  		code =3D finish_command(&pp->children[i].process);
> =20
>  		code =3D pp->task_finished(code,
> -					 &pp->children[i].err, pp->data,
> -					 pp->children[i].data);
> +					 ungroup ? NULL : &pp->children[i].err,
> +					 pp->data, pp->children[i].data);
> =20
>  		if (code)
>  			result =3D code;
> @@ -1707,10 +1747,13 @@ static int pp_collect_finished(struct parallel_=
processes *pp)
> =20
>  		pp->nr_processes--;
>  		pp->children[i].state =3D GIT_CP_FREE;
> -		pp->pfd[i].fd =3D -1;
> +		if (!ungroup)
> +			pp->pfd[i].fd =3D -1;
>  		child_process_init(&pp->children[i].process);
> =20
> -		if (i !=3D pp->output_owner) {
> +		if (ungroup) {
> +			/* no strbuf_*() work to do here */

Make it a habit to keep ";" semicolon when writing an empty
statement, i.e.

			; /* some comments */

This will help when other else/if body becomes shorter and we can
lose the {} around here.

I cannot quite shake the feeling that this step is doing so much
only because it wants to coax "run in parallel" infrastructure to do
what it is not suited to do, i.e. drive hooks that wants to directly
face the end-user output channel, and it might make a conceptually
cleaner fix to simply revert the root cause, but it is getting late
so...



