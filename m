Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748D5C07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiIWS6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiIWS63 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:58:29 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26A8122A5C
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:58:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 741AB152692;
        Fri, 23 Sep 2022 14:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OsREo0aNgfP5vjnb14Xw9NOiMw71gze+ED+s+d
        ZjrcI=; b=g/CyosvvbIXWJfrWt3EmsopCA0rXiBeMrVGbZ0cpsc33yPb7dTgtfK
        O4vWi8MMNRQoyANBMB/rYEeYHBwyyepAFub+XFHq/T9jl2g+1xYckuSdYo9kbuAA
        siK3kK2c6rzRR00eqaLKH5O/F0tpoFL3rpUe8FeBtYDaK31cPOKx0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AD08152691;
        Fri, 23 Sep 2022 14:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF70315268E;
        Fri, 23 Sep 2022 14:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
References: <20220922232947.631309-1-calvinwan@google.com>
        <20220922232947.631309-2-calvinwan@google.com>
Date:   Fri, 23 Sep 2022 11:58:23 -0700
In-Reply-To: <20220922232947.631309-2-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 22 Sep 2022 23:29:44 +0000")
Message-ID: <xmqqy1u9uddc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B39650D8-3B71-11ED-A942-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> run_processes_parallel periodically collects output from its child
> processes, prints it, and then resets the buffers for each child.
> Add run_processes_parallel_pipe_output variable so output can be
> collected and fed to task_finished. When set, the function referenced
> by task_finished should parse the output of each child process.

I am puzzled.

 * Why are we configuring an API behaviour via a global variable in
   21st century?

 * The name "task_finished" is mentioned, but it is unclear what it
   is.  Is it one of the parameters to run_process_parallel()?

 * Is the effect of the new feature that task_finished callback is
   called with the output, in addition to the normal output?  I am
   not sure why it is called "pipe".  The task_finished callback may
   be free to fork a child and send the received output from the
   task to that child over the pipe, but that is what a client code
   could do and is inappropriate to base the name of the mechanism,
   isn't it?

> @@ -1770,10 +1771,12 @@ int run_processes_parallel(int n,
>  	int output_timeout = 100;
>  	int spawn_cap = 4;
>  	int ungroup = run_processes_parallel_ungroup;
> +	int pipe_output = run_processes_parallel_pipe_output;
>  	struct parallel_processes pp;
>  
>  	/* unset for the next API user */
>  	run_processes_parallel_ungroup = 0;
> +	run_processes_parallel_pipe_output = 0;
>  
>  	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
>  		ungroup);
> @@ -1800,7 +1803,8 @@ int run_processes_parallel(int n,
>  				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
>  		} else {
>  			pp_buffer_stderr(&pp, output_timeout);
> -			pp_output(&pp);
> +			if (!pipe_output)
> +				pp_output(&pp);

So, we do not send the output from the child to the regular output
channel when pipe_output is in effect.  OK.

>  		}
>  		code = pp_collect_finished(&pp);
>  		if (code) {

And no other code changes?  This is quite different from what I
expected from reading the proposed log message.

Am I correct to say that under this new mode, we no longer flush any
output while the child task is running (due to the change in the
above hunk to omit calls to pp_output() during the run) and instead
keep accumulating in the strbuf, until the child task finishes, at
which time pp_collect_finished() will call task_finished callback.

Even though the callback usually consumes the last piece of the
output since the last pp_output() call made during the normal
execution of the run_processes_parallel() loop, because we omitted
these calls, we have full output from the child task accumulated in
the children[].err strbuf.  We may still not output .err for real,
as we may not be the output_owner, in which case we may only append
to .buffered_output member.

I am puzzled simply because, if the above summary is correct, I do
not see how a word "pipe" have a chance to come into the picture.

I can sort of see that in this mode, we would end up buffering the
entire output from each child task into one strbuf each, and can
avoid stalling the child tasks waiting for their turn to see their
output pipes drained.  But is this a reasonable thing to do?  How do
we control the memory consumption to avoid having to spool unbounded
amount of output from child tasks in core, or do we have a good
reason to believe that we do not have to bother?

Thanks.

