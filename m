Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0837BC71133
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 18:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjHYSFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 14:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjHYSFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 14:05:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B34D1995
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 11:05:20 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C2EE1A9B1E;
        Fri, 25 Aug 2023 14:05:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=bUfUOWkKpuTus+mMs8PDMF/WLFfN1OXGb8PuGQuM8nQ=; b=k68g
        SFgLh2dMAe1D2ZlS59Evug7sHDSpI3NKe0JKcZ0cnXCRGX6YILysN52NEVhwptwY
        iwbVclNEDOf8zfQVdC6pbra/HU7jpG2X1EkG+gxwbiJa3l39SCrmbjqJgx1bg0qT
        wk3KI4ttEwbKK2X+tuajxksNuT9CSL8Au3FV/H4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 826111A9B1C;
        Fri, 25 Aug 2023 14:05:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF4511A9B1B;
        Fri, 25 Aug 2023 14:05:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH v2 3/3] scalar reconfigure: help users remove buggy repos
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
        <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
        <7ac7311863d2e05c3dc8e26cb821fe8a7c4b6804.1692725056.git.gitgitgadget@gmail.com>
        <xmqqmsyilv3e.fsf@gitster.g>
        <f751dc4d-b605-43ef-8b73-082e8acd5914@github.com>
Date:   Fri, 25 Aug 2023 11:05:17 -0700
Message-ID: <xmqqsf8780bm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F36B7608-4371-11EE-A8C4-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 8/22/2023 3:45 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>> +		switch (discover_git_directory_reason(&commondir, &gitdir)) {
>>> +		case GIT_DIR_INVALID_OWNERSHIP:
>>> +			warning(_("repository at '%s' has different owner"), dir);
>>> +			goto loop_end;
>>> +
>>> +		case GIT_DIR_DISCOVERED:
>>> +			succeeded = 1;
>>> +			break;
>>> +
>>> +		default:
>>> +			warning(_("repository not found in '%s'"), dir);
>>> +			break;
>> 
>> Among the error cases, INVALID_OWNERSHIP is one of the possibilities
>> that merits specialized message to the end-user.  I wonder if others
>> also deserve to be explained, though.
>
> The specific choice of GIT_DIR_INVALID_OWNERSHIP is singled out
> because it's a new-ish reason and is the most confusing to users
> when things fail for this reason.
>  
>>  - HIT_CEILING and HIT_MOUNT_POINT will happen when there is no
>>    usable repository between "dir" and the specified ceiling.
>
> These are basically "didn't find a Git repo" but there are different
> reasons why Git stopped looking. I'm not sure there is something more
> valuable to indicate here than the "repository not found" message
> that already exists.

OK.  I just know that "not found" will be greeted by "stupid Git, if
you go one level up, there is a .git/ directory!", now we have many
users than we used to have and people forget what they configured.

But I think it would apply much less to users who see "repository
not found" in the "scalar reconfigure" than ones who manually
created a repository, and then forgot that they shuffled the disks
around with cross mounting.  So I agree with you that it is not
essential to mention these reasons in this codepath (and
setup_git_directory() does have a reasonable message for at least
the mount-point case that covers the more general case).

>>  - INVALID_GITFILE and INVALID_FORMAT are signs of some repository
>>    corruption.
>
> I can add a message for this kind of error, which seems helpful to
> point out to a user.

Maybe.  We can do that in a follow-up topic separately.

Thanks.
