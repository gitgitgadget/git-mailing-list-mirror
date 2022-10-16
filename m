Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D113EC4332F
	for <git@archiver.kernel.org>; Sun, 16 Oct 2022 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJPRJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 13:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJPRJq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 13:09:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2378DFC5
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 10:09:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B881C1A91AB;
        Sun, 16 Oct 2022 13:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2uHJmzSfLB0kfusUrRD6wDnyonFtN3h0bR712j
        idZTE=; b=I04i/eSE3kV/X0w/a5go2AICKSvhG3w2d6RJPmcXjV0N8LMmUoLsj7
        C2eLrAmd05HmU2zLfO00ddhR9zBJpJW7c/kB7V7OcW1i5hwUFEordpJ7U0wDAZNl
        SoDJeuxl0EXflpxrVelm92k5VBgCewRqyDb27rzajCVEHPRt7MEhc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B14021A91AA;
        Sun, 16 Oct 2022 13:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E62501A9166;
        Sun, 16 Oct 2022 13:08:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rupinderjeet Singh <rupinderjeet47@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [suggestion] Fail cherry-pick if it overwrites untracked files
 with the matching file names
References: <CAAheMRzYX6PdWMtcB=px_kD=-gnGGHvDgvR6Jxy94JH2DpYpJw@mail.gmail.com>
        <xmqq7d11540b.fsf@gitster.g>
        <CAAheMRy+B=2tBX-Frq5-NkdQFSm4jZHhEBVTReMwfGcvHVMQgQ@mail.gmail.com>
Date:   Sun, 16 Oct 2022 10:08:18 -0700
In-Reply-To: <CAAheMRy+B=2tBX-Frq5-NkdQFSm4jZHhEBVTReMwfGcvHVMQgQ@mail.gmail.com>
        (Rupinderjeet Singh's message of "Sun, 16 Oct 2022 00:39:44 +0530")
Message-ID: <xmqqk04z4ry5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22410644-4D75-11ED-9197-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rupinderjeet Singh <rupinderjeet47@gmail.com> writes:

> Yes, thank you for being so through with the example. I understand now.
>
> I want to ask if you would suggest that local configuration (or any
> information required by the project) that is too sensitive to be
> tracked in git, should either be kept as 'untracked' files or 'outside
> of git repository'.

I think it depends on the project and participants may not have
control over it if it is ingrained in the project's build structure,
but a separate place may likely be more appropriate, as it would
reduce the chance of accidental "git add ." adding everything.

> With your explanation, am I correct to think that only the following
> kind of information is suitable to be put in .gitignore files?
> 1. that can be regenerated

Yes.

> 2. that doesn't matter when it is lost

Natural consequence of the above

> 3. that isn't used by the files tracked in git repository

I do not get this, so I decline to comment ;) Is mylib.o that is
"ignored", created from tracked mylib.c source, used by mymain.c
source that is tracked, when mymain.o would not link without what
mylib.o gives it?

Some other SCMs have an extra class "precious" to handle exactly the
case you have in mind.  You do not accidentally let "git add ." to
slurp them into the committed history, but you do want them to be
left alone.  We don't have it, and that is not because we have any
reason to be against having it.  It is just it didn't happen.

And nobody bothered to explore the ramification of adding the new
class yet.  We know about "checkout" and other mergy operations and
"add", but there probably are trickier interactions with other parts
of the existing system that somebody need to carefully go through
and make sure it does not introduce funny inconsistencies.
