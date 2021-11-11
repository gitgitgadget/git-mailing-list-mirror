Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ED6C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6D661052
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhKKWMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 17:12:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51067 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhKKWMf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 17:12:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB140E2BE0;
        Thu, 11 Nov 2021 17:09:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3LmzP+MniMLb70dsuyZtgSjp8dVYSJOPG2dGH/
        RDGTg=; b=CwDH42uZnUepSyhu7c+cRgfyIKsiMewDpk8KEhHjFEUCFVmfMALDRG
        0pCx9uoua18uVogLFhkWz9baGo9R9orGx9y4Ahe7C6W4hBhfRdJEzma/SqcX9vyk
        JNIvGuql8568wHGoFCPFCtHHoI6UIXqaSMLGRkc18bFxDcHWQ85g8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1D4CE2BDF;
        Thu, 11 Nov 2021 17:09:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9148E2BDE;
        Thu, 11 Nov 2021 17:09:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Yvon <samuelyvon9@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH] builtin-commit: re-read file index before launching editor
References: <xmqqbl2t2n2p.fsf@gitster.g>
        <20211109200123.27763-1-samuelyvon9@gmail.com>
Date:   Thu, 11 Nov 2021 14:09:43 -0800
In-Reply-To: <20211109200123.27763-1-samuelyvon9@gmail.com> (Samuel Yvon's
        message of "Tue, 9 Nov 2021 15:01:23 -0500")
Message-ID: <xmqqtugijqe0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13A6FCD6-433C-11EC-ABFD-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Yvon <samuelyvon9@gmail.com> writes:

>> I do not personally mind if we change the philosophy but because it
>> has been a longstanding designed behaviour, it may need a careful
>> transition plan.
>
> Out of curiosity, what would that involve? 

We need to make sure we do not break workflows of existing users who
relies on the current behaviour.  

As Git is widely used, it is very likely that some of the workflow
element existing users use depend on the current behaviour.  

Letting pre-commit do its thing and letting run_status() compute
"commitable" without its effect may be something they depend on.  It
is the same for any other behaviour we may be tempted to modify.  We
would be breaking Git for them by changing.

So, not breaking by not changing behaviour, if we can do so, would
be ideal.  Introducing a configuration option and hide the new and
different behaviour behind it, so that only the folks who agree to
take responsibility of adjusting to the new behaviour, would be a
good way to isolate the existing users from the change.

If we come up with a new behaviour that would make the world a
better place if adopted by everybody, we might be tempted to
eventually make it the _only_ behaviour available to everybody.  I
am not sure if it is the case here, but if it were, the transition
plan would become even more involved.  We'd need to start by warning
existing users (i.e. the code must detect a case where pre-commit
mucks with the index and having an extra "re-read index file" would
have made a difference---and tell the user that they must adjust to
the change of behaviour in the future), wait for a few years and
then flip the behaviour while removing the warning, or something
like that.


