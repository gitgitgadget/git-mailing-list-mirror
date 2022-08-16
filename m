Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827E6C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 22:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiHPWPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 18:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbiHPWPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 18:15:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2716078225
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 15:15:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E884813565E;
        Tue, 16 Aug 2022 18:15:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pYNUpUJOYXIAahSKLnucPyyu5g/MGg49NbbNLL
        KV4oU=; b=JDsC/UGhyQnBIlBuZZVIkQV/NkMe10+D7QQMGwVXKO3wpaIRaePHVd
        fiXAMQVXEnaWCbpTOJYhyNWQb3SUp1rz/eChbS3JtROexsDRcbQgN1Mb68wfBFw0
        /dT5vgPHbWbTwY6W6meCQADWfmFh+Bp34jmWlBotttrtYmWTpklJ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E07C613565D;
        Tue, 16 Aug 2022 18:15:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58029135654;
        Tue, 16 Aug 2022 18:15:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        mjcheetham@outlook.com
Subject: Re: [PATCH 1/3] scalar: enable built-in FSMonitor on `register`
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
        <62682ccf6964d6eebb67491db4a9476dbab56671.1660673269.git.gitgitgadget@gmail.com>
        <xmqq4jybud6h.fsf@gitster.g>
        <f766b31f-2f0c-316a-a445-407b8c5baddc@github.com>
Date:   Tue, 16 Aug 2022 15:15:10 -0700
In-Reply-To: <f766b31f-2f0c-316a-a445-407b8c5baddc@github.com> (Victoria Dye's
        message of "Tue, 16 Aug 2022 14:57:01 -0700")
Message-ID: <xmqqzgg3sump.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E51E864A-1DB0-11ED-84D1-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> 	/* we do not care if pipe_command() succeeds or not */
>> 	(void) pipe_command(...);
>> 
>>         /*
>>          * we check ourselves if we do have a usable daemon 
>>          * and that is the authoritative answer.  we were asked
>>          * to ensure that usable daemon exists, and we answer
>>          * if we do or don't.
>>          */
>> 	if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
>> 		res = error(...);
>> 
>> may be more true to the spirit of the code.
>
> This is an unintentional artifact of some minor refactoring of the original
> versions in 'microsoft/git'. Previously [1], there was no
> 'fsmonitor_ipc__get_state()' check before calling 'git fsmonitor--daemon
> start', so we'd expect failures whenever FSMonitor was already running. To
> avoid making that 'pipe_command()' call when FSMonitor was already running,
> I added an earlier call to 'fsmonitor_ipc__get_state()'. But, because I
> didn't remove the later check, the code now implies that 'pipe_command()'
> may give us "false negatives" (that is, fail but still manage to start the
> FSMonitor).
>
> I left the extraneous check in to be overly cautious, but realistically I
> don't actually expect 'git fsmonitor--daemon start' to give us any false
> positives or negatives. The code should reflect that:
>
> 	int res = 0;
> 	if (fsmonitor_ipc__is_supported() &&
> 	    fsmonitor_ipc__get_state() != IPC_STATE__LISTENING) {
> 		struct strbuf err = STRBUF_INIT;
> 		struct child_process cp = CHILD_PROCESS_INIT;
>
> 		/* Try to start the FSMonitor daemon */
> 		cp.git_cmd = 1;
> 		strvec_pushl(&cp.args, "fsmonitor--daemon", "start", NULL);
> 		if (pipe_command(&cp, NULL, 0, NULL, 0, &err, 0))
> 			res = error(_("could not start the FSMonitor daemon: %s"),
> 				    err.buf);
>
> 		strbuf_release(&err);
> 	}
>
> 	return res;
>
> I'll re-roll with this shortly.

OK, that is one valid way to go about it.  After I sent my review
comments, I however briefly wondered if we might *not* know if we
are already running one, there is a reliable exclusion mechansim
to prevent more than one monitor running at the same time, and we
are running pipe_command(), fully expecting that it may fail when
there is already a working one and a call to pipe_command() that
is not "checked" is just being lazy because we can afford to be
lazy here.

If that is not what is going on, then the cleaned up version I am
responding to does look more straight-forward and easy to
understand.  On the other hand, if "we can start more than we need
because we can rely on the exclusion mechanism" is what is going on,
that is fine as well, but it does need to be documented, preferrably
as in-code comment.

Thanks.
