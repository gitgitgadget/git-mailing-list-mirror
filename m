Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FC2C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 00:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiAMAAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 19:00:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63983 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbiAMAAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 19:00:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C06F5100358;
        Wed, 12 Jan 2022 19:00:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cmwCJnIRFmMUH4jhiN0EexSLPA8ZASekeuz/Ky
        wLMzQ=; b=sfinB7LrJKl0Jkva58TX2prKM+dLQIjzZ8OiojZctlDQL/nGMZv2tk
        hIVJxmcOeine6NNIgfrdAP6FUFx9A/gUoIVEfdJ8rDaBBwUiMFBC287PxXmfPvI4
        WSyhFvhvqjhxtWk43wdqjLC8138CXE4ElNW3NMDq+J9LLC8ek79S4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6E54100357;
        Wed, 12 Jan 2022 19:00:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0394E100355;
        Wed, 12 Jan 2022 19:00:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmail.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/3] sparse-checkout: limit tab completion to a
 single level
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
        <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
        <aa9ea67180dd10ef8bdf17e8c23694da15828b21.1641841193.git.gitgitgadget@gmail.com>
        <0e4bb6f1-337e-38b3-75b2-fe11ff8d68b2@gmail.com>
Date:   Wed, 12 Jan 2022 16:00:34 -0800
In-Reply-To: <0e4bb6f1-337e-38b3-75b2-fe11ff8d68b2@gmail.com> (Lessley
        Dennington's message of "Wed, 12 Jan 2022 15:43:26 -0800")
Message-ID: <xmqq35lsld25.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5AE6D80-7403-11EC-A105-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lessley Dennington <lessleydennington@gmail.com> writes:

>> +     # Find possible directory completions, adding trailing '/' characters
>> +     _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
>> +         sed -e s%$%/%)"
>> +
> I am admittedly unfamiliar with the use of this format in sed expressions
> (I'm generally more accustomed to '/' instead of '%'). It's definitely
> working as it should, I'm just not quite sure of how.

The substitution operator "s" in "sed" can take any letter as the
match-replacement delimiter.  People use 's/match/replacement/'
usually because that is how textbooks teach them, but whatever
letter chosen as the delimiter, if it appears in either match or
replacement, it needs to be quoted, i.e. 's/match/replace\/ment/'.

Using a delimiter letter other than '/' relieves you from having to
quote a slash when slash is part of match-replacement.  Even though
it is more common to use a letter that is a more clearly delimiter
looking, e.g. "s|match|replace/ment|", it is not a crime to use
letters like '%' and '#', or even 's' ;-)

>> +     if [[ -n "$_tmp_completions" ]]; then
>> +         # There were some directory completions, so find ones that
>> +         # start with "$cur", the current token, and put those in COMPREPLY
>> +         local i=0 c IFS=$' \t\n'
> Does c need to be declared before the loop?
>> +         for c in $_tmp_completions; do

bash completion script runs in the same namespace as the end-user's
interactive session, so we MUST be careful not to contaminate the
namespace or clobber variable the end-user is using.  "local c" before
we use $c for our own use is a way to make sure that when this function
that says "local c" is left, the value (or non-presence) of "c" is
restored to its original value before this function was entered.

