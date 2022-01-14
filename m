Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FACAC433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 19:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbiANTCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:02:33 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64572 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiANTCd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 14:02:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C353B166CE3;
        Fri, 14 Jan 2022 14:02:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tvd1m81WwNjKYRjTukTR/5IMrzR/hBK5oBupWj
        OsH64=; b=wcB3JuchLPCwzY8D72H7kysjs1gFIREdLaZkQzlTR0gkeznYxDUoMJ
        j30ri5Ln79+Rgl0r3EhXtN0PElJMGv47cz0WPsoTP/guh/09hl44B4woCI075cbU
        9wlHcoHogy4vMaRhcEOgV0jBsGtWhIgVHiq2hjKXaagSC8JSmvCws=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC08A166CE2;
        Fri, 14 Jan 2022 14:02:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1584166CE1;
        Fri, 14 Jan 2022 14:02:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Colin Kennedy <colin@mrkennedy.ca>, git@vger.kernel.org
Subject: Re: feature request: add [-f|--from <rootbranch>] to git stash branch
References: <2a4f90e9-9abb-40b6-a6f3-a676567e4fc0@www.fastmail.com>
        <851ecd86-02d0-b078-1c90-ebe75ad46926@iee.email>
Date:   Fri, 14 Jan 2022 11:02:28 -0800
In-Reply-To: <851ecd86-02d0-b078-1c90-ebe75ad46926@iee.email> (Philip Oakley's
        message of "Fri, 14 Jan 2022 14:53:51 +0000")
Message-ID: <xmqq8rvicf97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 859AA5E2-756C-11EC-915E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Hi, some minor comments, in-line.
>
> On 13/01/2022 16:29, Colin Kennedy wrote:
>> Current syntax of git stash branch is:
>>
>> branch <branchname> [<stash>]
>>
>> Proposed syntax is:
>>
>> branch <branchname> [-f|--from <rootbranch>] [<stash>]
>
> Just to say that the `-f` is typically reserved/used for the --force
> option if available.

True.

Also, a dashed option and its argument should come before the
non-dashed arguments, so if it were a good idea to introduce a new
option, it should come after "git stash branch" and "<branchname>",
not after "<branchname>".

Most importantly, this particular new option is unnecessary and
is probably unwanted.

The original "git stash branch" relieves the user from finding out
the commit where the stash was taken from, which is its value over
its long-hand equivalent, i.e.

	git checkout -b <name> refs/stash^ &&
	git stash pop

The long-hand version forces the user to know that the first parent
of the commit that represents a stash entry is the original commit
the stash entry was taken from.  With "git stash branch <name>", the
user does not need to know it.

But the --from discards the only reason why "stash branch" subcommand
needs to exist.  It would be equivalent to

	git checkout -b <name> <rootbranch> &&
	git stash pop

and it is not helping the user, unlike the original that allowed the
user to be oblivious to the internal implementation detail of a
stash entry.

Or am I failing to see some obvious improvements over the longhand?

Worse, the application and discarding of the stash entry done by the
"git stash branch" is guaranteed to apply cleanly, as we'd be
applying the stash to its exact original state.  The trees of
<rootbranch> and refs/stash^, on the other hand, can be vastly
different, and applying the stash on top of <rootbranch> commit can
fail.

In short, I am not enthused.

Thanks.
