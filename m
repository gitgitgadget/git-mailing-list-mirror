Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CACC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 21:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11A1610CA
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 21:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhHYVUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:20:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52302 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbhHYVUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 17:20:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66E6B142C69;
        Wed, 25 Aug 2021 17:19:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rSL0njTd4lvtACAQeppNM201lk17MItye84wER
        dE8IE=; b=rylHfzOhpK2+v8tOSaHWFt5MelUUGoGnTYBp8ycmP7su6GAC7hk6v1
        j0M9jVySod5xTbjC9JUWWn6oJo6Xw+RiUbUYXm2kNF8zMUTyR6mM5yIqFBBn0KLE
        6O+9ZOf9MoKICVzEeKCVvCZZck9faVXbSIaovet0uDn5feiK/fWjU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EE0D142C68;
        Wed, 25 Aug 2021 17:19:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 503A4142C65;
        Wed, 25 Aug 2021 17:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Yuri <yuri@rawbw.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git pull' complains that a locally resurrected directory would
 be overwritten by merge when no pulled changes are affecting that
 directory
References: <01514401-78f6-3fdc-aa74-c519fb6ab427@rawbw.com>
        <YSWXSWiDWNU93lhC@coredump.intra.peff.net>
        <CABPp-BEMXW3EOdT4jt1g63uPyZ5YuKUPfBE9BL=E66QcT5uXXA@mail.gmail.com>
Date:   Wed, 25 Aug 2021 14:19:15 -0700
In-Reply-To: <CABPp-BEMXW3EOdT4jt1g63uPyZ5YuKUPfBE9BL=E66QcT5uXXA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 25 Aug 2021 08:42:09 -0700")
Message-ID: <xmqqzgt5gr3g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AE6BF34-05EA-11EC-BB46-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ... allow if the incoming changes don't touch the same files), but
> local *staged* changes.  As per the merge manpage:
>
> """
> To avoid recording unrelated changes in the merge commit, git pull and
> git merge will also abort if there are any changes registered in the
> index relative to the HEAD commit.
> """
>
> While this particular example could theoretically be handled by the
> merge machinery without requiring the index match HEAD,...

While I do not mind seeing a patch that loosens the condition ONLY
when the merge will cleanly auto-resolve without end-user
interaction, when any paths conflict and require editing by the
end-user, it is pretty much essential to require that the index
matches HEAD to keep "git merge" usable. 

This is because the final step to conclude such an "automated
procedure cannot cleanly resolve, so the end user helps resolving
with the editor and mark the resolved paths with 'git add' or 'git
rm'" session will become very error prone if we did not have the
requirement.  Not just the user MUST remember not to use "commit -a"
or "git add" a path that was already dirty in the working tree
before the merge started (which is the consequence of the current
requirement, which allows local changes to the unrelated working
tree files), they must MUST remember to somehow EXCLUDE the changes
already registered for unrelted paths from the concluded merge.
