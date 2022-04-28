Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B2BC433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 21:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352388AbiD1VuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 17:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiD1VuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 17:50:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054884ECFB
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 14:46:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 320C817E4D6;
        Thu, 28 Apr 2022 17:46:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZpM4RY2E3h4XvxufFX4fER43Ds2o2kPWVQcJdS
        WvEkI=; b=FK/LZcoPNdVgT65gX+RxvV7JGl2Dt12wAOM78iYOnvlKrdJ00KAwGT
        uI+xhSJSipGqqqA7Jfzo3FF3LKEetp+FERUIATfjQHM59m/IVN8LPBQqSY0KUKks
        TKRbSG/rS18Ca2RNk+3ea1q6kBbb+FukDKYBPV4GICb8nGOVRD+7M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BCB717E4D5;
        Thu, 28 Apr 2022 17:46:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A263217E4D4;
        Thu, 28 Apr 2022 17:46:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] run-command: don't spam trace2_child_exit()
References: <4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com>
Date:   Thu, 28 Apr 2022 14:46:47 -0700
In-Reply-To: <4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 28 Apr 2022 13:58:10 -0700")
Message-ID: <xmqqr15gev94.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4CAF610-C73C-11EC-B0F9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> In rare cases, wait_or_whine() cannot determine a child process's exit
> status (and will return -1 in this case). This can cause Git to issue
> trace2 child_exit events despite the fact that the child is still
> running.

Rather, we do not even know if the child is still running when it
happens, right?  It is curious what "rare cases" makes the symptom
appear.  Do we know?

The patch looks OK from the "we do not know the child exited in this
case, so we shouldn't be reporting the child exit" point of view, of
course.  Having one event that started a child in the log and then
having millions of events that reports the exit of the (same) child
is way too broken.  With this change, we remove these phoney exit
events from the log.

Do we know, for such a child process that caused these millions
phoney exit events, we got a real exit event at the end?  Otherwise,
we'd still have a similar problem in the opposite direction, i.e. a
child has a start event recorded, many exit event discarded but the
log lacks the true exit event for the child, implying that the child
is still running because we failed to log its exit?

>  int finish_command_in_signal(struct child_process *cmd)
>  {
>  	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 1);
> -	trace2_child_exit(cmd, ret);
> +	if (ret != -1)
> +		trace2_child_exit(cmd, ret);
>  	return ret;
>  }

Will queue; thanks.
