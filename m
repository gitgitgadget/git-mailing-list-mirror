Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C6EC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbiEXTpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiEXTpl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:45:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F26898A
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:45:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 387EE1269E6;
        Tue, 24 May 2022 15:45:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5a/nSa7aqEZAIqsXAMt3Nd67Dyq0+lW0cPgsdb
        HGn9w=; b=Ip12EgS3Kh7c7666zH5SmQym7CDArBR7XricDw0H31j8LHR26XP3+B
        V2KsVpdgMNtVPTHqHul2De5BcKWSE/Vl0UQJ0rtbsR0K775GR1IrVCWf71W/3M34
        OKo1Y9jApgSpJGjgtmPV4FsvjRlazRT8rw4crQb03sR/qL0iWp68g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E2871269E5;
        Tue, 24 May 2022 15:45:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 93C671269E4;
        Tue, 24 May 2022 15:45:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Goss Geppert <gg.oss.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        christian w <usebees@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/2] dir: consider worktree config in path recursion
References: <20220505203234.21586-1-ggossdev@gmail.com>
        <20220510171527.25778-1-ggossdev@gmail.com>
        <20220510171527.25778-2-ggossdev@gmail.com>
        <xmqq7d6sm3e0.fsf@gitster.g>
        <CABPp-BGXRzYCvyM38dEUvQ125+VtRu++7L9UiRz98u+1=Lov7A@mail.gmail.com>
Date:   Tue, 24 May 2022 12:45:37 -0700
In-Reply-To: <CABPp-BGXRzYCvyM38dEUvQ125+VtRu++7L9UiRz98u+1=Lov7A@mail.gmail.com>
        (Elijah Newren's message of "Tue, 24 May 2022 07:29:09 -0700")
Message-ID: <xmqqilpuhfz2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 163D9BB6-DB9A-11EC-BF1F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, May 11, 2022 at 9:37 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Goss Geppert <gg.oss.dev@gmail.com> writes:
>>
>> > diff --git a/dir.c b/dir.c
>> > index f2b0f24210..a1886e61a3 100644
>> > --- a/dir.c
>> > +++ b/dir.c
>> > @@ -1893,9 +1893,31 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>>
> [...]
>>
>> > +                     real_gitdir = real_pathdup(the_repository->gitdir, 0);
>>
>> This function is repeatedly called during the traversal.
>>
>> How expensive is it to keep calling real_pathdup() on the constant
>> the_repository->gitdir just in case it might be the same as our true
>> GIT_DIR?
>
> I agree that treat_directory is called many times, but this
> real_pathdup() call is inside the "if (nested_repo)" block, so this
> new real_pathdup() invocation should occur very seldom.  Or are you
> worried about cases where users have *very* large numbers of bare
> repositories nested under the working directory?

No.  I wasn't worried about anything in particular.  I just wanted
to get the feel of how deep a thought the patch was backed by by
spot checking what was and what was not taken into account when
designing the change.

I do not care too much when there are very large numbers of things
that cause this codepath to be exercised.  Strange situations can be
left for later optimization only when they turn up in the real world
and prove to be a problem.

By the way, where is a bare repository involved?  did you mean
non-bare aka worktree-full repository?
