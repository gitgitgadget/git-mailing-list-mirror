Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F7BC48BCF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 01:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11096613EC
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 01:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhFJB2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 21:28:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59609 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJB2H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 21:28:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F24213E44F;
        Wed,  9 Jun 2021 21:26:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U0NpQujQZeRSJDpi+MCVaKW0eCe7zCjxCrG+VJ
        b8XEI=; b=kla9TzTdG4I6X7ffAVpaHAgKRYJLMD3EANYjiT+emRvwTkovrnHlGb
        OX3Or6FHbHPWtDeyvREALYSbWp1TsByrqnzNW1+4pwJejgYx8p+VnaLfBcCQDw+Z
        0RqODOv7oXX8m2Cyg9aP1HJQSJcqn9Pqjrbu00yUT46x9vj8F7+zk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 778B513E44E;
        Wed,  9 Jun 2021 21:26:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8FB813E44D;
        Wed,  9 Jun 2021 21:26:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 4/4] promisor-remote: teach lazy-fetch in any repo
References: <xmqqk0n3k3g1.fsf@gitster.g>
        <20210609182008.2401762-1-jonathantanmy@google.com>
Date:   Thu, 10 Jun 2021 10:26:07 +0900
In-Reply-To: <20210609182008.2401762-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 9 Jun 2021 11:20:08 -0700")
Message-ID: <xmqq7dj2ik7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5FD2CE6-C98A-11EB-94E7-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> >> by filling appropriate environ[] array to be run in a repository
>> >> that is different from ours (which is "other repo" part of its name)
>> >> not to want to even know which repository the "other" repo is?
>> >
>> > Good point. I'll update prepare_other_repo_env() to have a gitdir
>> > parameter.
>> 
>> I actually meant that the function should take an in-core "repo"
>> structure.
>
> But that seems like we're passing much more than we need - we only need
> the git_dir. Also, there is a function that wants to pass a literal "."
> as the gitdir; if we do this, I'll have to check if there is still a
> struct repository that we can pass that will result in the same gitdir.

OK.  If the caller at the point does not have anything but git-dir,
there may not be much point in instantiating a full in-core repo
structure to pass to prepare_other_repo_env() to it.  If the helper
needs to learn more about that repository, it can go from the
git-dir and do things itself.

>> >> Object type and object sizes are something that you can
>> >> safely express in plain text, would be handy for testing, and would
>> >> not require too much extra code, I'd imagine.
>> >
>> > It would, but we can already use "git cat-file -s" (or -t) for that. The
>> > helper is meant to test a specific code path wherein we access a
>> > submodule object during a process running in the superproject.
>> 
>> I know, but can you use "git cat-file -s" to check the codepath you
>> care about?  I do not think so.  Hence the suggestion.
>
> I'm still not convinced that we'll need it in the future, but you're
> right that it is not too much trouble. I'll add it in.

As your answer to my initial question was that this is purely a
stop-gap testing measure until we get the support fully plumbed in
so that the real-world codepath can be tested end-to-end, I do not
think it matters all that much.  If it is easy to add, I suspect
that it would help to catch more bugs, but I wouldn't lose sleep if
it doesn't get added.

Thanks.
