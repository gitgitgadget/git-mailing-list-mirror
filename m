Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB17C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 05:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B3D60F13
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 05:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhHKFDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 01:03:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56106 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbhHKFDG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 01:03:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40DEBCD6FF;
        Wed, 11 Aug 2021 01:02:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=VL6neY6QvAXxpXvWAaBKuhQpSWPtHKAjQ0qXXXYGVBQ=; b=YNrl
        c/YnKJyuvJ91OngOTGLNLLF5taPPzZ5edka3DnTO+QhtozGv+K9PorEBMiEwNmnh
        D2aMYGTzectWszqGqfMGU0deI16q+4A4H2YIJObeR/Cc9vqdX8TU5xdS/tbXUCcj
        hTRonCN3LgVX+cUx3vhqGCzHI36+ioQMxFfwO7w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 378E2CD6FE;
        Wed, 11 Aug 2021 01:02:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B65F5CD6FC;
        Wed, 11 Aug 2021 01:02:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mahi Kolla <mahikolla@google.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4] clone: update submodule.recurse in config when using
 --recurse-submodule
References: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
        <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
        <xmqqzgtqe2w6.fsf@gitster.g>
        <CAN3QUFYPjsvBRGegO-kC7+gcFDczOqQSw-UYphnLHx=6-6kkwA@mail.gmail.com>
        <xmqqa6lpdu4z.fsf@gitster.g>
Date:   Tue, 10 Aug 2021 22:02:41 -0700
Message-ID: <xmqqbl64bmku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B6E23C4-FA61-11EB-9B1F-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Mahi Kolla <mahikolla@google.com> writes:
>
>>> Is it possible to avoid changing the behaviour unconditionally and
>>> potentially breaking existing users by making it an opt-in feature,
>>> e.g. "git clone --recurse-submodules" would work as the current
>>> users would expect, while "git clone --recurse-submodules=sticky"
>>> would set submodule.recurse to true, or something?
>>
>> As mentioned, the `submodule.recurse=true` will only apply to active
>> submodules specified by the user. Setting this config value when the
>> user runs their initial `git clone` minimizes the number of times a
>> developer must use the `--recurse-submodule` option on other commands.
>>
>> However, this is a behavior change that may be surprising for
>> developers. To ensure a smooth rollout and easy adoption, I think
>> adding a message using an `advice.*` config setting would be useful.

Let me outline some general rules on changing the behaviour of the
system used around here.

First of all, if a proposed change of behaviour is a bugfix, the
following does not apply [*1*].

When a new behaviour is made available to those who want to use it,
it starts as an opt-in feature.

 - Existing users will not be surprised by a familiar command
   suddenly changing its behaviour.  If users keep using the system
   the same way as they used it before, the system will behave the
   same way, without changing the behaviour.

 - Those who want to use the new behaviour need to do something to
   explicitly trigger it (with a command line option, configuration
   variable, a new command, etc.)

Over time, a behaviour that used to be a "new way" may just become
"one of the two ways available", and it may even turn out to be a
more desirable one between the two.  At that point, we may propose
to flip the default, with a migration plan that is carefully
designed to avoid breaking existing users.

Even if it were an *improvement* to set the configuration variable,
it is not an excuse to suddenly change the behaviour of the command
for users who do not ask.  It needs to start as an optional feature,
and if we really like it and manage to convince majority users to
also like the new way, we may even consider making it the default,
but it is way too premature to do so.

Unless we can argue that the current behaviour *is* buggy, that is.

Thanks.


[Footnote]

*1* A change that we have to say "not all users may be happy with
    this new behaviour" or "developers would be surprised by the new
    behaviour" cannot be a bugfix.
