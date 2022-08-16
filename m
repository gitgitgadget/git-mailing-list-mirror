Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AFBC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 20:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbiHPUtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 16:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiHPUtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 16:49:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F855C946
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 13:49:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C02FE1347FA;
        Tue, 16 Aug 2022 16:49:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=sC0HejC+jAOlnFGQNWvALsbtu/2GYkTCGpJ8+CPIO14=; b=YP6u
        Y/3F/oW01dAeFP4Li4QcwF/5Rqz4jIXxblb4xdgN3SnF6lAY+QaC89v2tEWEMIKL
        aM8k9OIVH/ftTOtsAZeAZGPZFMevEpkNVpvF5TSlMOPr1mxMbhZJA1IP8PBZU7iG
        0pikRwwMRh9Yv+0pK9ioRd25ZWoVCp1cqdk3Jmg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B815D1347F9;
        Tue, 16 Aug 2022 16:49:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E9701347F8;
        Tue, 16 Aug 2022 16:49:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        mjcheetham@outlook.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 1/3] scalar: enable built-in FSMonitor on `register`
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
        <62682ccf6964d6eebb67491db4a9476dbab56671.1660673269.git.gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 13:49:10 -0700
Message-ID: <xmqq4jybud6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E16AB886-1DA4-11ED-8A71-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +static int start_fsmonitor_daemon(void)
> +{
> +	int res = 0;
> +	if (fsmonitor_ipc__is_supported() &&
> +	    fsmonitor_ipc__get_state() != IPC_STATE__LISTENING) {
> +		struct strbuf err = STRBUF_INIT;
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +
> +		/* Try to start the FSMonitor daemon */
> +		cp.git_cmd = 1;
> +		strvec_pushl(&cp.args, "fsmonitor--daemon", "start", NULL);
> +		if (!pipe_command(&cp, NULL, 0, NULL, 0, &err, 0)) {
> +			/* Successfully started FSMonitor */
> +			strbuf_release(&err);
> +			return 0;
> +		}
> +
> +		/* If FSMonitor really hasn't started, emit error */
> +		if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
> +			res = error(_("could not start the FSMonitor daemon: %s"),
> +				    err.buf);
> +
> +		strbuf_release(&err);
> +	}
> +
> +	return res;
> +}

This somewhat curious code structure made me look, and made me
notice that the behaviour is even more curious.  Even though
pipe_command() fails, fsmonitor_ipc__get_state() can somehow become
LISTENING, in which case we are OK?  If that is the case, a more natural
way to write it would be:

	int res = 0; /* assume success */

	if (fsmonitor_ipc__is_supported() &&
            fsmonitor_ipc__get_state() != IPC_STATE__LISTENING) {
		...
                /* 
                 * if we fail to start it ourselves, and there is no
                 * daemon listening to us, it is an error.
                 */
		if (pipe_command(...) &&
		    fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
			res = error(...);
		strbuf_release(&err);
	}
	return res;

and that would utilize "res" consistently throughout the function.

Note that (I omitted unnecessary blank lines and added necessary
ones in the above outline of the rewrite.

Stopping, stepping back a bit and rethinking, the above is not still
exactly right.  If pipe_command() could lie and say "we failed to
start" when we immediately after the failure can find a running
daemon, what guarantees us that pipe_command() does not lie in the
other direction?  So, in that sense, perhaps doing

	/* we do not care if pipe_command() succeeds or not */
	(void) pipe_command(...);

        /*
         * we check ourselves if we do have a usable daemon 
         * and that is the authoritative answer.  we were asked
         * to ensure that usable daemon exists, and we answer
         * if we do or don't.
         */
	if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
		res = error(...);

may be more true to the spirit of the code.

It also is slightly curious if the caller wants to see "success"
when fsmonitor is not supported.  I would have expected the caller
to check and refrain from calling start/stop when it is not
supported (and if there is an end-user interface to force the scalar
command to "start", complain by saying "not supported here").  But
as long as we are consistent, I guess it is OK.

The side that stops shares exactly the same two pieces of
"curiosity" and may need to be updated exactly the same way.  It
assumes that pipe_command() is unreliable and instead of reporting a
possible failure, we sweep that under the rug, with a questionable
"we do not care about pipe failing, as long as the daemon is
listening, we do not care" attitude.  And the caller does not care
"start" not stopping where it is not supported.

Thanks.
