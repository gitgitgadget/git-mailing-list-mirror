Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACA4C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 18:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352480AbhLASyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:54:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63887 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbhLASyi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 13:54:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F5BF156653;
        Wed,  1 Dec 2021 13:51:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yvt7a13H7e0IkNBQBjju01v+K6o4pp4PctGFSR
        rJ2jM=; b=aHsYXTAzgib95pJ7BzPjvnKj2HCx62Ldyyot8s+5B97xIdZC78t6La
        9BzNY90f7MjG6CT2fPFAmQNZKGzfa7L2n7astAN21Zb/ckpVOGfZObwEjIvJ/kLo
        R2HobtZdswNlD5mHR+gXO3+nxRtIpfAMDqG8eqSu+DvaVWqfSjq0s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47990156652;
        Wed,  1 Dec 2021 13:51:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE25715664D;
        Wed,  1 Dec 2021 13:51:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, peff@peff.net,
        avarab@gmail.com
Subject: Re: [PATCH v3 2/2] config: include file if remote URL matches a glob
References: <xmqqtug3aco7.fsf@gitster.g>
        <20211129181811.375318-1-jonathantanmy@google.com>
Date:   Wed, 01 Dec 2021 10:51:11 -0800
In-Reply-To: <20211129181811.375318-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 29 Nov 2021 10:18:11 -0800")
Message-ID: <xmqqlf1417mo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7E55EA6-52D7-11EC-9CEF-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> variables we read without the includeIf directive", with variations
>> of "condition" including
>> 
>>  - a literal X is among the values of multi-valued variable Y.
>>  - a pattern X matches one of the values of multi-valued variable Y.
>>  - a literal Y is the name of an existing configuration variable.
>>  - a pattern Y matches the name of an existing configuration variable.
> ...
> code), in this case, unless there is another use case for this, I think
> we should proceed with the use case that we know about first
> (conditional include of a file supplied by a remote repo administrator).

Doing it that way without thinking flexibility through will paint us
into a corner, from which we cannot get out of, doesn't it?

People will start asking "Why should we even have
'hasremoteurl:$URL' variant in 'includeIf' conditions, when one of
the 'variableExists:Y' and friends can express the same thing",
somebody new who is not yet in this community today will propose
deprecating hasremoteurl in favor of more generalized approach and
we have to give a sad answer "no, we earlier made a mistake of
starting with a special case variant for expediency's sake, without
thinking the general cases through.  Because existing users depend
on it, we have to support it til the end of time."

We have the same regret with "why do we need grep.extendedRegexp
when grep.patternType suffices?"  I am reluctant to see us knowingly
commit the same mistake here, unless there is a very good reason.
